# Line-by-line comparison of SeqQC's fastqc_data.txt / summary.txt with FastQC's.
#
#   julia --project=. validation/fastqc_text_compare.jl <FastQC dir> <work dir> label=path ...
#
# Runs FastQC on every input, writes SeqQC's text files with the FastQC
# contaminant list of <FastQC dir>, and compares them after removing what SeqQC
# does not produce: the header line, the modules "Per tile sequence quality"
# and "Sequence Duplication Levels", and the status of "Per sequence GC
# content" (SeqQC writes NA). Every other line must be identical. Prints one
# line per input and the first differing lines.

using SeqQC
const F = SeqQC.FastQC

const SKIP_MODULES = ("Per tile sequence quality", "Sequence Duplication Levels")

function normalise(lines)
    out = String[]
    skip = false
    for l in lines[2:end]
        if startswith(l, ">>") && !startswith(l, ">>END_MODULE")
            name = split(l[3:end], '\t')[1]
            skip = name in SKIP_MODULES
            skip && continue
            name == "Per sequence GC content" && (l = ">>Per sequence GC content\t<flag>")
        elseif startswith(l, ">>END_MODULE") && skip
            skip = false
            continue
        end
        skip || push!(out, l)
    end
    return out
end

normalise_summary(lines) = [startswith(l, "PASS\tPer sequence GC") || startswith(l, "WARN\tPer sequence GC") ||
                            startswith(l, "FAIL\tPer sequence GC") || startswith(l, "NA\tPer sequence GC") ?
                            "<flag>\tPer sequence GC content" : l
                            for l in lines if !any(m -> occursin("\t" * m * "\t", l), SKIP_MODULES)]

function run_fastqc(fastqc_dir, out, path)
    cp = join([fastqc_dir, joinpath(fastqc_dir, "htsjdk.jar"), joinpath(fastqc_dir, "jbzip2-0.9.jar"),
               joinpath(fastqc_dir, "cisd-jhdf5.jar")], Sys.iswindows() ? ";" : ":")
    run(pipeline(`java -Xmx2g -Djava.awt.headless=true -cp $cp -Dfastqc.output_dir=$out -Dfastqc.unzip=true
                   -Dfastqc.quiet=true uk.ac.babraham.FastQC.FastQCApplication $path`; stdout = devnull, stderr = devnull))
    name = replace(replace(basename(path), r"\.gz$" => ""), r"\.(fastq|fq)$" => "")
    d = joinpath(out, name * "_fastqc")
    isfile(joinpath(d, "fastqc_data.txt")) || error("FastQC produced no report for $(basename(path))")
    return d
end

function main(args)
    fastqc_dir, work = args[1], args[2]
    cl = joinpath(fastqc_dir, "Configuration", "contaminant_list.txt")
    nbad = 0
    for item in args[3:end]
        k = findfirst('=', item)
        label, path = item[1:k-1], item[k+1:end]
        out = mkpath(joinpath(work, label))
        d = run_fastqc(fastqc_dir, out, path)
        r = analyze(path; metrics = F.metrics(; max_positions = 200_000, contaminants = cl), threads = 1)
        ours_data = joinpath(out, "seqqc_fastqc_data.txt"); ours_sum = joinpath(out, "seqqc_summary.txt")
        write_fastqc_data(ours_data, r; filename = basename(path))
        write_fastqc_summary(ours_sum, r; filename = basename(path))
        a, b = normalise(readlines(joinpath(d, "fastqc_data.txt"))), normalise(readlines(ours_data))
        sa, sb = normalise_summary(readlines(joinpath(d, "summary.txt"))), normalise_summary(readlines(ours_sum))
        diffs = [(i, x, y) for (i, (x, y)) in enumerate(zip(a, b)) if x != y]
        ok = isempty(diffs) && length(a) == length(b) && sa == sb
        ok || (nbad += 1)
        println("| ", label, " | ", length(a), " lines | ", ok ? "identical" : "DIFFERS", " |")
        for (i, x, y) in diffs[1:min(end, 3)]
            println("    line ", i, "\n      FastQC: ", x, "\n      SeqQC : ", y)
        end
        length(a) == length(b) || println("    line count FastQC ", length(a), " vs SeqQC ", length(b))
        sa == sb || println("    summary.txt differs")
    end
    println("\ninputs with differences: ", nbad)
end

main(ARGS)
