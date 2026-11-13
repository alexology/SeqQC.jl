# SeqQC.jl vs FastQC 0.12.1 — process-level comparison (2026-11-12)

Machine: Intel Core i7-9750H (6 cores / 12 threads), 15.8 GiB RAM, Windows 11, local SSD.
Software: FastQC 0.12.1 on OpenJDK 21.0.3 (Temurin), JVM options of the FastQC launcher
(`-Xmx512m -XX:+ExitOnOutOfMemoryError -Djava.awt.headless=true`); SeqQC 0.1.0-DEV on
Julia 1.12.2 (real `julia.exe`, not the juliaup launcher).
Script: `bench/compare_fastqc.ps1` (2 runs per configuration, sequential, nothing else running).
Inputs: the synthetic files of `docs/BENCHMARKS.md`, a 50,000-read synthetic file with N/IUPAC/
lower-case bases (30–250 bp), and the real ONT amplicon file of the other result files (label only).

## What is compared — the work is NOT equivalent

- Every run is a fresh process; times include JVM or Julia start-up, class loading / package
  loading and JIT / compilation. This is what a user waits for on the command line.
- **FastQC does more work**: its default run computes 11 modules (per-base quality and content,
  duplication, overrepresented sequences, adapter content, …) and writes an HTML report with
  plots and a zip. SeqQC computes its four default metrics (length statistics and histogram,
  base composition and per-read GC histogram, base/read quality distributions, quality vs
  length) and writes nothing.
- "Reduced modules": FastQC with a limits file that sets `ignore 1` for every module except
  per-sequence quality, per-sequence GC and length distribution (Basic Statistics is always
  on) — the closest FastQC counterpart of SeqQC. The ignored modules disappear from the report,
  but the run time does not change measurably; whether FastQC still computes them was not
  investigated (FastQC source not read).
- FastQC exits with code 0 even when it fails (checked with a missing file); runs were counted
  as successful only when the report existed, and the "reads" column comes from its report.
  Both tools report the same number of reads on every input.
- Peak memory: largest working set seen every 50 ms (Windows `PeakWorkingSet64`).

## Results (minimum wall-clock time of 2 runs; seconds; peak memory MB)

SeqQC rows "precompiled" were measured after adding a PrecompileTools workload (same day,
same machine); the older rows are kept to show the start-up cost without it.

| input | FastQC default | FastQC reduced | SeqQC 1 thread (before) | SeqQC 1 thread (precompiled) | SeqQC threads=2 (precompiled) |
|---|---:|---:|---:|---:|---:|
| mixed_50k.fastq (50,000 × 30–250 bp, 13 MB) | 2.33 (346)¹ | 2.36 (318)¹ | 3.24 (317)¹ | 0.66 (240) | 0.66 (242) |
| illumina_like_1M_150bp.fastq.gz (164 MB) | 9.40 (339) | 9.39 (319) | 4.64 (317) | 2.08 (255) | 1.77 (287) |
| illumina_like_1M_150bp.fastq (340 MB) | 7.40 (349) | 7.39 (319) | 3.85 (317) | 1.26 (256) | 1.25 (258) |
| ont_like_50k_lognormal.fastq.gz (279 MB, 275 Mb) | 27.53 (628) | 26.51 (626) | 5.06 (317) | 2.59 (242) | 2.36 (273) |
| real_ont_amplicons.fastq.gz (1.67 GB, 1.59 Gb) | 78.83 (382) | 77.91 (365) | 15.99 (317) | 13.95 (250) | 12.37 (282) |

¹ single run (smoke test of the script).

Ratio FastQC reduced / SeqQC precompiled (1 thread; threads=2): mixed 3.6× (3.6×),
Illumina-like gzip 4.5× (5.3×), Illumina-like plain 5.9× (5.9×), ONT-like gzip 10.2× (11.2×),
real ONT 5.6× (6.3×).

## Interpretation and limits

- On this machine SeqQC returns its (smaller) set of statistics 3.6–11× faster than FastQC
  returns its report, with less peak memory (240–290 MB vs 318–628 MB). Because the work
  differs, this is **not** evidence that Julia is faster than Java for the same algorithm.
- A fair module-for-module comparison needs the FastQC-like modules of Phase 3 (per-base
  statistics, duplication, overrepresentation, adapters) and FastQC's report writing excluded
  or matched.
- SeqQC's peak memory is dominated by the Julia runtime and compiled code (~240 MB even for the
  13 MB file); its analysis state is a few MB.
- The PrecompileTools workload removed about 2.5 s of compilation from every fresh SeqQC
  process (mixed_50k: 3.24 → 0.66 s).
- FastQC's slowest case is long reads (ONT-like: 27 s for 275 Mb), presumably its per-position
  modules; not investigated.
- One machine, two runs per configuration, warm OS file cache after the first run.
