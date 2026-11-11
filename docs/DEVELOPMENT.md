# Development log

## Definition of done

A feature is done only when its implementation exists, its tests pass, its
behaviour and error handling are documented, its scientific semantics are
validated (independent calculation or reference tool), its performance
implications are measured or explicitly unmeasured, and it is reachable through
the public API. Planned items stay "planned" in `ROADMAP.md` until then.

## Contribution rules

- Code, comments, docstrings and messages in English.
- FASTA/FASTQ parsing through FASTX.jl; replacing the parser requires a
  benchmark showing it is the bottleneck and a byte-for-byte comparison of
  results on real data.
- No silent approximation: binned, sampled or rounded values are named and
  documented as such (`docs/METRICS.md`).
- New metrics: implement the protocol in `src/core/metric.jl`, add an
  independent reference calculation to the tests and a merge test.
- Run `julia --project=. -e "using Pkg; Pkg.test()"` before reporting work.
- Real sequencing data are read in place and never copied into the repository.

## 2026-11-10 — Phase 1 (foundation)

Done:

- Package skeleton (`Project.toml`, Julia ≥ 1.10; deps FASTX 2, CodecZlibNG 0.2,
  TranscodingStreams, StringViews). No git repository and no licence yet
  (both require the owner's decision).
- IO: gzip detected from magic bytes, multi-member gzip, CRLF, format sniffing
  (FASTA and BAM rejected with explicit messages), errors with record numbers.
- Engine: single pass, shared `ReadSummary`, tuple of states, head sampling.
- Metrics: `ReadLength`, `BaseComposition`, `QualityDistribution`, `QualityVsLength`.
- Tests: 206/206 (`Pkg.test()`, Julia 1.12.2, Windows, 4 threads,
  `--check-bounds=yes`): hand-computed example, random short/variable/long reads
  against an independent implementation (crossing the 65,536 dense/sparse
  boundary), gzip vs plain vs multi-member vs CRLF, empty inputs, zero-length
  reads, a 2 Mb read, malformed and truncated inputs, Phred+64, `max_reads`,
  state merging, a custom metric, argument validation, length binning.
- Bugs found by the tests and fixed: per-read error-probability Q of an all-Q10
  read evaluated to 9.999…, moving reads below the Q10 threshold and into the
  wrong bin; per-read values are now rounded to 6 decimals (documented).
- Baseline: `bench/results/baseline_2026-11-10.md`. External check against
  NanoPlot 1.47.1 on 20,000 real ONT reads: counts, bases, median, mean, N50
  and Q-threshold counts identical. NanoPlot's `mean_qual` turned out to be a
  third averaging convention (mean of per-read error probabilities), added as
  `read_quality_of_mean_error` after reading the nanomath source.

Not done / limits:

- No online research in this session: the tool survey in `ARCHITECTURE.md`
  is from prior knowledge and must be verified before compatibility claims.
- Not tested on Julia 1.10; no Aqua/JET run yet.
- BAM (P0 in the specification) deferred: no BAM reader in the local depot.
- Median of per-read quality is not reported (only 0.1-Q bins are kept).

Next step: Phase 2 — profile `summarize!` on plain Illumina-like input, compute
quality-related summary fields only when a metric requires `:quality`, and
evaluate decompression in a separate task for gzip input; re-run the baseline.
