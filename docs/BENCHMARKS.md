# Benchmark methodology

Script: `bench/run_benchmarks.jl`; results: `bench/results/` (one Markdown
file per run, with machine, versions, commands and inputs).

```
julia --project=. --threads=1 bench/run_benchmarks.jl <workdir> [real.fastq.gz ...]
SEQQC_BENCH_REPS=2   # timed repetitions per stage (default 3)
```

## What is measured

For every input, in one Julia process:

| Stage | Meaning |
|---|---|
| decompress | read the byte stream (gzip inflate or plain read) in 1 MiB blocks; lower bound for any tool reading the same file in one thread |
| parse | FASTX record iteration with a reused record; lower bound for a FASTX-based parser |
| seqqc (default) | `analyze(path)` with the four default metrics |
| seqqc (ReadLength) | `analyze(path; metrics = [ReadLength()])` |

- Every stage is run once untimed (compilation and OS file cache), then
  `SEQQC_BENCH_REPS` times; minimum and median wall-clock times are reported.
  Timings are therefore **warm-cache, steady-state** numbers.
- Compilation is reported separately: time of the first `analyze` call on a
  one-read file after `using SeqQC`. Julia start-up (`julia` process launch and
  `using`) is not included; measure it with `time julia --project=. -e "using SeqQC"`.
- `alloc/read` = bytes allocated by one `analyze` call divided by reads
  (includes fixed per-call allocations: metric states, result).
- Peak RSS: `Sys.maxrss()` of the whole benchmark process (includes the
  synthetic-data generator), so it is an upper bound for `analyze`.
- Throughput columns are derived from the minimum `seqqc (default)` time.

## Inputs

Synthetic files are generated deterministically (seeded `Xoshiro`) in the
work directory, never in the repository: 1,000,000 reads × 150 bp
(Illumina-like), 50,000 reads with log-normal lengths (median 4 kb,
ONT-like), each plain and gzip (level 6). Real data are passed by path and
read in place.

## Comparisons with other tools

Not done in Phase 1. Only equivalent outputs will be compared (e.g. read
count, bases, N50 and mean quality versus NanoStat-like summaries), with each
tool's version, command and thread count recorded. FastQC, Falco, fastp and
LongQC are not installed on the development machine as of 2026-11-10;
NanoPlot 1.47.1 is available in WSL but always produces plots, so its run time
is not comparable with a summary-only pass.
