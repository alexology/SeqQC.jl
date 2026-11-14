# Command-line interface: `seqqc analyze ...`, `seqqc report ...` and
# `seqqc truncation ...`.
# `main(args)` returns the exit code (0 success, 1 some input failed, 2 usage
# error) so it can be tested without starting a process.

const CLI_USAGE = """
seqqc $(VERSION_STRING) — streaming QC of sequencing reads

Usage:
  seqqc analyze [options] FILE...      analyse FASTQ / FASTQ.gz files
  seqqc report [options] DIR|JSON...   multi-sample report from saved SeqQC JSON reports
  seqqc truncation [options] R1 [R2]   suggest DADA2 truncLen / maxEE (single- or paired-end)
  seqqc --help | --version

analyze options:
  -o, --output DIR        output directory (created if missing; default: current directory)
  -t, --threads N         threads (needs julia -t N or more; default: Julia's thread count)
      --phred-offset N    33 (default) or 64
      --max-reads N       analyse only the first N records of each file (head sampling)
      --fastqc            also compute FastQC-compatible modules and write
                          <sample>_fastqc_data.txt and <sample>_summary.txt
      --contaminants FILE contaminant list for "Possible Source" (with --fastqc;
                          e.g. <FastQC>/Configuration/contaminant_list.txt)
      --fastqc-header     write "##FastQC<TAB>0.12.1" as first line of fastqc_data.txt
      --max-positions N   per-position statistics limit (default 100000)
      --html              also write a single-sample HTML report per input
      --no-report         do not write the multi-sample report
  -q, --quiet             only errors
  -v, --verbose           one line per input with timing

report options:
  -o, --output FILE       HTML file to write (default: seqqc_report.html); .tsv and .json
                          with the same name are written next to it
  -q, --quiet

truncation options (filter defaults = DADA2 filterAndTrim; docs/src/TRUNCATION.md):
      --amplicon-length N sequenced fragment length, R1 start to R2 start (required for pairs)
      --min-overlap N     overlap required between R1 and R2 (default 20)
      --max-ee X          maxEE of the suggestion (default 2; 0.5, 1, 2, 3, 5, Inf are profiled)
      --trim-left N[,M]   trimLeft (one value, or R1,R2; default 0)
      --trunc-q N         truncQ (default 2)
      --max-n N           maxN (default 0)
      --min-len N         minLen (default 20)
      --min-trunc-len N   do not suggest a truncLen below N
      --phred-offset N    33 (default) or 64
      --max-reads N       use only the first N reads (pairs)
  -o, --output FILE       also write the suggestion as .json, .tsv or .html (repeatable)
  -q, --quiet

Outputs of analyze, per input: <sample>.seqqc.json (always), FastQC text files
(--fastqc), <sample>.html (--html); then seqqc_report.html/.tsv/.json for all
inputs. Sample names: file name without extensions; colliding names get the
parent directory as a prefix.
"""

struct _CLIError <: Exception
    msg::String
end

function _parse_options(args, spec)
    opts = Dict{String,Any}()
    files = String[]
    i = 1
    while i <= length(args)
        a = args[i]
        if startswith(a, "-") && a != "-"
            key, val = occursin('=', a) ? split(a, '='; limit = 2) : (a, nothing)
            key = get(spec.aliases, key, key)
            if key in spec.flags
                val === nothing || throw(_CLIError("option $(key) takes no value"))
                opts[key] = true
            elseif key in spec.values
                if val === nothing
                    i += 1
                    i <= length(args) || throw(_CLIError("option $(key) needs a value"))
                    val = args[i]
                end
                opts[key] = String(val)
            else
                throw(_CLIError("unknown option $(a)"))
            end
        else
            push!(files, a)
        end
        i += 1
    end
    return opts, files
end

function _int_option(opts, key, default; min = typemin(Int))
    haskey(opts, key) || return default
    v = tryparse(Int, opts[key])
    (v === nothing || v < min) && throw(_CLIError("$(key) must be an integer >= $(min), got $(repr(opts[key]))"))
    return v
end

_say(quiet, args...) = quiet || println(stdout, args...)
_err(args...) = println(stderr, "error: ", args...)

# File-safe output names (the "/" of a directory prefix becomes "_"). Names that
# still collide after that (a/x.fastq and a_x.fastq both give "a_x") get "_2",
# "_3", ... in input order, with a note on stderr, so no report is overwritten.
function _output_names(files; io = stderr)
    base = replace.(_names(files, nothing), "/" => "_")
    taken = Set{String}()
    out = String[]
    for (f, n) in zip(files, base)
        name = n
        k = 1
        while name in taken || (name != n && name in base)
            k += 1
            name = string(n, "_", k)
        end
        name == n || println(io, "note: output name of ", f, " is ", name, " (", n, " is already used)")
        push!(taken, name)
        push!(out, name)
    end
    return out
end

function _cli_analyze(args)
    spec = (aliases = Dict("-o" => "--output", "-t" => "--threads", "-q" => "--quiet", "-v" => "--verbose"),
            flags = Set(["--fastqc", "--fastqc-header", "--html", "--no-report", "--quiet", "--verbose"]),
            values = Set(["--output", "--threads", "--phred-offset", "--max-reads", "--contaminants", "--max-positions"]))
    opts, files = _parse_options(args, spec)
    isempty(files) && throw(_CLIError("analyze needs at least one input file"))
    quiet = get(opts, "--quiet", false)
    verbose = get(opts, "--verbose", false) && !quiet
    outdir = get(opts, "--output", ".")
    threads = _int_option(opts, "--threads", Threads.nthreads(); min = 1)
    offset = _int_option(opts, "--phred-offset", 33)
    offset in (33, 64) || throw(_CLIError("--phred-offset must be 33 or 64"))
    maxreads = haskey(opts, "--max-reads") ? _int_option(opts, "--max-reads", 0; min = 0) : nothing
    maxpos = _int_option(opts, "--max-positions", 100_000; min = 1)
    fastqc = get(opts, "--fastqc", false)
    contam = get(opts, "--contaminants", nothing)
    contam === nothing || fastqc || throw(_CLIError("--contaminants requires --fastqc"))
    contam === nothing || isfile(contam) || throw(_CLIError("contaminant list not found: $(contam)"))
    threads > Threads.nthreads() && !quiet &&
        println(stderr, "note: --threads $(threads) but Julia was started with $(Threads.nthreads()) thread(s); ",
                "start it with -t $(threads)")
    mkpath(outdir)
    metrics = fastqc ? vcat(AbstractQCMetric[BaseComposition(), QualityVsLength()],
                            FastQC.metrics(; max_positions = maxpos, contaminants = contam)) : default_metrics()
    names = _output_names(files)
    failed = 0
    results = QCResult[]
    for (f, name) in zip(files, names)
        t = @elapsed try
            r = analyze(f; metrics, phred_offset = offset, max_reads = maxreads, threads)
            write_json(joinpath(outdir, name * ".seqqc.json"), r; fastqc)
            if fastqc
                try
                    write_fastqc_data(joinpath(outdir, name * "_fastqc_data.txt"), r;
                                      fastqc_header = get(opts, "--fastqc-header", false))
                    write_fastqc_summary(joinpath(outdir, name * "_summary.txt"), r)
                catch err
                    err isa ArgumentError || rethrow()
                    _err(f, ": FastQC text files not written: ", err.msg)
                    failed += 1
                end
            end
            get(opts, "--html", false) && report(r, joinpath(outdir, name * ".html"))
            push!(results, r)
            for w in r.warnings
                quiet || println(stderr, "warning: ", f, ": ", w)
            end
        catch err
            (err isa SeqQCInputError || err isa ArgumentError || err isa SystemError) || rethrow()
            _err(sprint(showerror, err))
            failed += 1
        end
        verbose && println(stdout, name, ": ", round(t; digits = 2), " s")
    end
    if !get(opts, "--no-report", false) && !isempty(results)
        s = aggregate(results)
        base = joinpath(outdir, "seqqc_report")
        report(s, base * ".html"); report(s, base * ".tsv"); report(s, base * ".json")
    end
    _say(quiet, length(results), " of ", length(files), " input(s) analysed; outputs in ", abspath(outdir))
    return failed == 0 ? 0 : 1
end

function _cli_truncation(args)
    spec = (aliases = Dict("-o" => "--output", "-q" => "--quiet"), flags = Set(["--quiet"]),
            values = Set(["--output", "--amplicon-length", "--min-overlap", "--max-ee", "--trim-left", "--trunc-q",
                          "--max-n", "--min-len", "--min-trunc-len", "--phred-offset", "--max-reads"]))
    outputs = String[]
    rest = String[]
    i = 1
    while i <= length(args)                                   # -o may be repeated
        if args[i] in ("-o", "--output") && i < length(args)
            push!(outputs, args[i + 1]); i += 2
        elseif startswith(args[i], "--output=")
            push!(outputs, args[i][10:end]); i += 1
        else
            push!(rest, args[i]); i += 1
        end
    end
    opts, files = _parse_options(rest, spec)
    length(files) in (1, 2) || throw(_CLIError("truncation needs one FASTQ file (single-end) or two (R1 R2)"))
    for o in outputs
        lowercase(splitext(o)[2]) in (".json", ".tsv", ".html") || throw(_CLIError("--output must end in .json, .tsv or .html: $(o)"))
    end
    tl = split(get(opts, "--trim-left", "0"), ',')
    trim = tryparse.(Int, tl)
    (any(isnothing, trim) || any(<(0), trim) || length(trim) > length(files)) &&
        throw(_CLIError("--trim-left must be N or N,M (non-negative integers, one per file)"))
    trim_left = length(trim) == 1 ? trim[1] : Tuple(trim)
    ee = tryparse(Float64, get(opts, "--max-ee", "2"))
    ee === nothing && throw(_CLIError("--max-ee must be a number"))
    amp = haskey(opts, "--amplicon-length") ? _int_option(opts, "--amplicon-length", 0; min = 1) : nothing
    length(files) == 2 && amp === nothing && throw(_CLIError("paired-end input needs --amplicon-length"))
    s = suggest_truncation(files...; amplicon_length = amp, min_overlap = _int_option(opts, "--min-overlap", 20; min = 0),
                           max_ee = ee, min_trunc_len = _int_option(opts, "--min-trunc-len", 0; min = 0),
                           trim_left,
                           trunc_q = _int_option(opts, "--trunc-q", 2; min = 0),
                           max_n = _int_option(opts, "--max-n", 0; min = 0),
                           min_len = _int_option(opts, "--min-len", 20; min = 1),
                           phred_offset = _int_option(opts, "--phred-offset", 33),
                           max_reads = haskey(opts, "--max-reads") ? _int_option(opts, "--max-reads", 0; min = 0) : nothing)
    get(opts, "--quiet", false) || (show(stdout, MIME"text/plain"(), s); println(stdout))
    foreach(o -> report(s, o), outputs)
    return 0
end

function _cli_report(args)
    spec = (aliases = Dict("-o" => "--output", "-q" => "--quiet"), flags = Set(["--quiet"]), values = Set(["--output"]))
    opts, inputs = _parse_options(args, spec)
    isempty(inputs) && throw(_CLIError("report needs a directory or JSON files"))
    out = get(opts, "--output", "seqqc_report.html")
    endswith(lowercase(out), ".html") || throw(_CLIError("--output must be an .html file"))
    s = aggregate(inputs)
    report(s, out)
    base = out[1:end-5]
    report(s, base * ".tsv"); report(s, base * ".json")
    _say(get(opts, "--quiet", false), length(s), " sample(s); report written to ", abspath(out))
    return 0
end

"""
    SeqQC.main(args::Vector{String}) -> Int

Entry point of the `seqqc` command line (`bin/seqqc.jl`); returns the exit
code. Run `seqqc --help` for the options.
"""
function main(args::AbstractVector{<:AbstractString} = ARGS)
    try
        if isempty(args) || args[1] in ("-h", "--help", "help")
            print(stdout, CLI_USAGE)
            return isempty(args) ? 2 : 0
        elseif args[1] in ("-V", "--version")
            println(stdout, "seqqc ", VERSION_STRING)
            return 0
        elseif args[1] == "analyze"
            return _cli_analyze(args[2:end])
        elseif args[1] == "report"
            return _cli_report(args[2:end])
        elseif args[1] == "truncation"
            return _cli_truncation(args[2:end])
        else
            throw(_CLIError("unknown command $(repr(args[1])) (expected analyze, report or truncation)"))
        end
    catch err
        if err isa _CLIError
            _err(err.msg)
            println(stderr, "run `seqqc --help` for usage")
            return 2
        elseif err isa ArgumentError || err isa SeqQCInputError
            _err(sprint(showerror, err))
            return 1
        end
        rethrow()
    end
end
