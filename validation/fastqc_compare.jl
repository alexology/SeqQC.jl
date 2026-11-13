# Module-by-module comparison of SeqQC.FastQC with FastQC outputs.
#
#   julia --project=. validation/fastqc_compare.jl <FastQC dir> <work dir> [--max-positions=N] label=path ...
#
# Runs FastQC (java on PATH, options of its launcher) on every input with
# extraction enabled, parses fastqc_data.txt and compares labels, values and
# pass/warn/fail flags with SeqQC.FastQC. Numbers printed by FastQC (Java
# Double.toString) are parsed and compared with SeqQC's Float64 values:
# "identical" = equal bit for bit (NaN equals NaN), "within 1e-9" = relative
# difference at most 1e-9, otherwise the number of differing values and the
# largest difference are reported. Only labels are printed, never paths.

using SeqQC
const F = SeqQC.FastQC

function run_fastqc(fastqc_dir, out, path)
    cp = join([fastqc_dir, joinpath(fastqc_dir, "htsjdk.jar"), joinpath(fastqc_dir, "jbzip2-0.9.jar"),
               joinpath(fastqc_dir, "cisd-jhdf5.jar")], Sys.iswindows() ? ";" : ":")
    cmd = `java -Xmx2g -XX:+ExitOnOutOfMemoryError -Djava.awt.headless=true -cp $cp
           -Dfastqc.output_dir=$out -Dfastqc.unzip=true -Dfastqc.quiet=true
           uk.ac.babraham.FastQC.FastQCApplication $path`
    run(pipeline(cmd; stdout = devnull, stderr = devnull))
    # sequential: replace() with several pairs applies them simultaneously
    name = replace(replace(basename(path), r"\.gz$" => ""), r"\.(fastq|fq)$" => "")
    data = joinpath(out, name * "_fastqc", "fastqc_data.txt")
    isfile(data) || error("FastQC produced no report for $(basename(path)) (it exits with 0 on failure)")
    return data
end

function parse_modules(file)
    mods = Dict{String,Tuple{Symbol,Vector{Vector{String}}}}()
    name = ""
    for line in eachline(file)
        if startswith(line, ">>END_MODULE")
            name = ""
        elseif startswith(line, ">>")
            parts = split(line[3:end], '\t')
            name = parts[1]
            mods[name] = (Symbol(parts[2]), Vector{String}[])
        elseif !isempty(name) && !startswith(line, "#")
            push!(mods[name][2], split(line, '\t'))
        end
    end
    return mods
end

parsenum(s) = s == "NaN" ? NaN : parse(Float64, s)

# Compares a vector of FastQC strings with SeqQC values.
function cmp_values(theirs::Vector{<:AbstractString}, ours)
    length(theirs) == length(ours) || return (status = "length $(length(theirs)) vs $(length(ours))", n = 0, bad = -1, maxdiff = NaN)
    bad = 0
    near = 0
    maxdiff = 0.0
    for (t, o) in zip(theirs, ours)
        if o isa AbstractString
            t == o || (bad += 1)
            continue
        end
        x = parsenum(t)
        y = Float64(o)
        (isnan(x) && isnan(y)) && continue
        x === y && continue
        d = abs(x - y)
        maxdiff = max(maxdiff, d)
        if d <= 1e-9 * max(1.0, abs(x))
            near += 1
        else
            bad += 1
        end
    end
    status = bad > 0 ? "DIFFERS" : near > 0 ? "within 1e-9" : "identical"
    return (status = status, n = length(theirs), bad = bad, maxdiff = maxdiff)
end

const CONTAMINANTS = Ref{Any}(nothing)

function compare(label, path, data; max_positions)
    r = analyze(path; metrics = F.metrics(; max_positions, contaminants = CONTAMINANTS[]), threads = 1)
    m = parse_modules(data)
    rows = Tuple{String,String,Any}[]
    add(mod, what, c) = push!(rows, (mod, what, c))

    bs = Dict(row[1] => row[2] for row in m["Basic Statistics"][2])
    ours = F.basic_statistics(r)
    add("Basic Statistics", "Encoding", cmp_values([bs["Encoding"]], [ours.encoding]))
    add("Basic Statistics", "Total Sequences", cmp_values([bs["Total Sequences"]], [ours.total_sequences]))
    add("Basic Statistics", "Sequence length", cmp_values([bs["Sequence length"]], [ours.sequence_length]))
    add("Basic Statistics", "%GC", cmp_values([bs["%GC"]], [ours.percent_gc]))

    function table(modname, ours, cols)
        haskey(m, modname) || return add(modname, "module", (status = "absent in FastQC", n = 0, bad = 0, maxdiff = NaN))
        t = m[modname][2]
        for (j, (colname, vals)) in enumerate(cols)
            add(modname, colname, cmp_values([row[j] for row in t], vals))
        end
    end
    q = F.per_base_quality(r)
    table("Per base sequence quality", q, [("Base", q.base), ("Mean", q.mean), ("Median", q.median),
          ("Lower Quartile", q.lower_quartile), ("Upper Quartile", q.upper_quartile),
          ("10th Percentile", q.percentile_10), ("90th Percentile", q.percentile_90)])
    s = F.per_sequence_quality(r)
    table("Per sequence quality scores", s, [("Quality", string.(s.quality)), ("Count", s.count)])
    c = F.per_base_content(r)
    table("Per base sequence content", c, [("Base", c.base), ("G", c.G), ("A", c.A), ("T", c.T), ("C", c.C)])
    n = F.per_base_n(r)
    table("Per base N content", n, [("Base", n.base), ("N-Count", n.n_count)])
    ov = F.overrepresented(r)
    if haskey(m, "Overrepresented sequences")
        cols = [("Sequence", ov.sequence), ("Count", ov.count), ("Percentage", ov.percentage)]
        ov.possible_source === nothing || push!(cols, ("Possible Source", ov.possible_source))
        table("Overrepresented sequences", ov, cols)
    end
    ad = F.adapter_content(r)
    table("Adapter Content", ad, [("Position", ad.position); [(n, v) for (n, v) in zip(ad.names, ad.values)]])
    gcm = F.per_sequence_gc(r)
    table("Per sequence GC content", gcm, [("GC Content", string.(gcm.gc_content)), ("Count", gcm.count)])
    l = F.length_distribution(r)
    table("Sequence Length Distribution", l, [("Length", l.length), ("Count", l.count)])

    fl = F.flags(r)
    for (modname, key) in (("Basic Statistics", :basic_statistics), ("Per base sequence quality", :per_base_quality),
                           ("Per sequence quality scores", :per_sequence_quality),
                           ("Per base sequence content", :per_base_content), ("Per base N content", :per_base_n_content),
                           ("Sequence Length Distribution", :sequence_length_distribution),
                           ("Adapter Content", :adapter_content),
                           ("Overrepresented sequences", :overrepresented_sequences))
        haskey(m, modname) || continue
        theirs = m[modname][1]
        add(modname, "flag", (status = theirs == fl[key] ? "identical" : "DIFFERS ($(theirs) vs $(fl[key]))",
                              n = 1, bad = theirs == fl[key] ? 0 : 1, maxdiff = NaN))
    end
    return r, rows
end

function main(args)
    length(args) >= 3 || error("usage: fastqc_compare.jl <FastQC dir> <work dir> [--max-positions=N] label=path ...")
    fastqc_dir, work = args[1], args[2]
    max_positions = 10_000
    inputs = String[]
    for a in args[3:end]
        if startswith(a, "--max-positions=")
            max_positions = parse(Int, split(a, '=')[2])
        else
            push!(inputs, a)
        end
    end
    mkpath(work)
    cl = joinpath(fastqc_dir, "Configuration", "contaminant_list.txt")
    isfile(cl) && (CONTAMINANTS[] = cl)
    total_bad = 0
    println("| input | module | column | result | values | differing | max abs diff |")
    println("|---|---|---|---|---:|---:|---:|")
    for item in inputs
        k = findfirst('=', item)
        label, path = item[1:k-1], item[k+1:end]
        out = mkpath(joinpath(work, label))
        data = run_fastqc(fastqc_dir, out, path)
        r, rows = compare(label, path, data; max_positions)
        for (mod, col, c) in rows
            total_bad += max(c.bad, 0) + (c.bad < 0)
            md = isnan(c.maxdiff) || c.maxdiff == 0 ? "" : string(round(c.maxdiff; sigdigits = 3))
            println("| $label | $mod | $col | $(c.status) | $(c.n) | $(max(c.bad, 0)) | $md |")
        end
        flush(stdout)
    end
    println("\nTotal differing values: ", total_bad)
end

main(ARGS)
