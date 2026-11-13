# One complete SeqQC run in a fresh process, for process-level comparisons with
# other tools (includes Julia start-up, package loading and compilation).
#   julia --project=. --threads=T bench/seqqc_once.jl <fastq> <threads>
using SeqQC
r = analyze(ARGS[1]; threads = parse(Int, ARGS[2]))
println(r.total_reads, "\t", r.total_bases, "\t", r.gc_content)
