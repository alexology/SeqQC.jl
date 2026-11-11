# Phase 1 performance baseline.
#
# Usage (from the package directory):
#   julia --project=. bench/run_benchmarks.jl <workdir> [real.fastq.gz ...]
#
# Synthetic inputs are generated in <workdir> (never inside the repository).
# For every input the script times, in the same process:
#   decompress : reading the (decompressed) byte stream only
#   parse      : FASTX record iteration only (reused record)
#   seqqc      : analyze() with the default metrics
#   seqqc_len  : analyze() with ReadLength only
# Each stage is run once to compile, then `REPS` timed runs; the minimum and
# the median are reported. Results are written as Markdown to stdout.

using SeqQC
using FASTX: FASTQ
using CodecZlibNG: GzipDecompressorStream, GzipCompressorStream
using TranscodingStreams: NoopStream
using Random
using Statistics: median
using Dates

const REPS = parse(Int, get(ENV, "SEQQC_BENCH_REPS", "3"))

function open_stream(f, path)
    raw = open(path)
    gz = read(raw, 2) == UInt8[0x1f, 0x8b]
    seekstart(raw)
    s = gz ? GzipDecompressorStream(raw) : NoopStream(raw)
    try
        f(s)
    finally
        close(s)
    end
end

function stage_decompress(path)
    buf = Vector{UInt8}(undef, 1 << 20)
    n = 0
    open_stream(path) do s
        while !eof(s)
            n += readbytes!(s, buf)
        end
    end
    return n
end

function stage_parse(path)
    n = 0
    open_stream(path) do s
        reader = FASTQ.Reader(s; copy = false)
        for rec in reader
            n += FASTQ.seqsize(rec)
        end
    end
    return n
end

stage_seqqc(path) = analyze(path).total_bases
stage_seqqc_len(path) = analyze(path; metrics = [ReadLength()]).total_bases

function timeit(f, path)
    f(path)                                     # compile / warm the file cache
    ts = Float64[]
    for _ in 1:REPS
        GC.gc()
        push!(ts, @elapsed f(path))
    end
    return minimum(ts), median(ts)
end

# --- synthetic data -------------------------------------------------------

function write_fastq(path, rng, nreads, lenfun; gz)
    io = open(path, "w")
    out = gz ? GzipCompressorStream(io; level = 6) : io
    bases = codeunits("ACGT")
    seq = UInt8[]
    qual = UInt8[]
    for i in 1:nreads
        len = lenfun(rng)
        resize!(seq, len)
        resize!(qual, len)
        @inbounds for j in 1:len
            seq[j] = bases[rand(rng, 1:4)]
            qual[j] = UInt8(33 + clamp(round(Int, 25 + 8 * randn(rng)), 2, 41))
        end
        write(out, "@read_", string(i), " runid=synthetic ch=", string(rand(rng, 1:512)), "\n")
        write(out, seq, "\n+\n", qual, "\n")
    end
    close(out)
    gz && close(io)
    return path
end

function synthetic_inputs(dir)
    rng = Xoshiro(42)
    files = String[]
    ill = (rng) -> 150
    ont = (rng) -> max(1, round(Int, exp(log(4000) + 0.8 * randn(rng))))
    for (name, n, f) in (("illumina_like_1M_150bp", 1_000_000, ill), ("ont_like_50k_lognormal", 50_000, ont))
        for gz in (false, true)
            p = joinpath(dir, name * (gz ? ".fastq.gz" : ".fastq"))
            isfile(p) || write_fastq(p, Xoshiro(hash(name)), n, f; gz)
            push!(files, p)
        end
    end
    return files
end

# --- main -------------------------------------------------------------------

function main(args)
    isempty(args) && error("usage: julia --project=. bench/run_benchmarks.jl <workdir> [real.fastq.gz ...]")
    dir = args[1]
    mkpath(dir)
    t_first = @elapsed begin
        tiny = joinpath(dir, "tiny.fq")
        write(tiny, "@a\nACGT\n+\nIIII\n")
        analyze(tiny)
    end
    files = vcat(synthetic_inputs(dir), args[2:end])

    println("# SeqQC Phase 1 baseline\n")
    println("- date: ", Dates.format(now(), "yyyy-mm-dd HH:MM"))
    println("- SeqQC ", SeqQC.VERSION_STRING, ", Julia ", VERSION, ", threads ", Threads.nthreads())
    println("- CPU: ", Sys.cpu_info()[1].model, " (", Sys.CPU_THREADS, " logical cores); RAM ",
            round(Sys.total_memory() / 2^30; digits = 1), " GiB; ", Sys.KERNEL, " ", Sys.MACHINE)
    println("- first analyze() call on a 1-read file (compilation, after `using`): ", round(t_first; digits = 2), " s")
    println("- timed runs per stage: ", REPS, " (after one warm-up run); times in seconds, min / median\n")
    println("| input | size MB | reads | bases | decompress | parse (FASTX) | seqqc (default) | seqqc (ReadLength) | reads/s | Mbases/s | input MB/s | alloc/read (B) |")
    println("|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|")
    for p in files
        r = analyze(p)
        mb = filesize(p) / 1e6
        d = timeit(stage_decompress, p)
        q = timeit(stage_parse, p)
        s = timeit(stage_seqqc, p)
        l = timeit(stage_seqqc_len, p)
        alloc = @allocated analyze(p)
        f(x) = string(round(x[1]; digits = 2), " / ", round(x[2]; digits = 2))
        println("| ", basename(p), " | ", round(mb; digits = 1), " | ", r.total_reads, " | ", r.total_bases,
                " | ", f(d), " | ", f(q), " | ", f(s), " | ", f(l),
                " | ", round(Int, r.total_reads / s[1]), " | ", round(r.total_bases / s[1] / 1e6; digits = 1),
                " | ", round(mb / s[1]; digits = 1), " | ", round(alloc / max(1, r.total_reads); digits = 1), " |")
        flush(stdout)
    end
    println("\n- peak RSS of the benchmark process: ", round(Sys.maxrss() / 2^20; digits = 1), " MiB")
end

main(ARGS)
