# Benchmark methodology

Script: `bench/run_benchmarks.jl`; results: `bench/results/` (one Markdown
file per run, with machine, versions, commands and inputs).

```
julia --project=. --threads=2 bench/run_benchmarks.jl <workdir> [label=real.fastq.gz ...]
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
| seqqc (threads=2) | `analyze(path; threads = 2)`: gzip inflated in a separate task (requires `julia --threads >= 2`; otherwise NaN) |

The first two SeqQC columns use `threads = 1`.

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
ONT-like), each plain and gzip (level 6). Real data are passed as
`label=path`, read in place, and only the label is written to the results
(no paths or sample names in the repository).

## Comparisons with other tools

Process-level comparison with FastQC 0.12.1: `bench/compare_fastqc.ps1`
(Windows PowerShell; fresh process per run, start-up included, peak working
set polled every 50 ms; FastQC success checked from its report because it
exits with code 0 on failure). Results and the non-equivalence of the work
done are described in `bench/results/fastqc_comparison_2026-11-12.md`.

```
powershell -NoProfile -ExecutionPolicy Bypass -File bench/compare_fastqc.ps1 `
    -WorkDir <dir> -FastQC D:\FastQC -Julia <julia.exe> -Reps 2 `
    -Inputs "label1=path1|label2=path2" [-SkipFastQC]
```

Only equivalent outputs may be compared in a claim about speed of the same
computation; today the comparison is "time to obtain each tool's own default
QC". Falco, fastp and LongQC are not installed; NanoPlot 1.47.1 (WSL) was used
only to check values.
