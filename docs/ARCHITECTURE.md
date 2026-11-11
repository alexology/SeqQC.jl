# SeqQC.jl architecture

Status: 0.1.0-DEV (Phase 1). This document describes what exists and the design
it is meant to grow into; planned parts are marked **planned**.

## 1. Goals and constraints

- Single streaming pass, bounded memory, exact statistics unless a metric
  explicitly declares sampling or binning.
- Metrics are independent, mergeable accumulators; the engine knows nothing
  about individual metrics.
- Parsing, analysis and reporting are separate layers. Results are plain Julia
  data (`QCResult` with `NamedTuple` metric results); reports (JSON, HTML,
  MultiQC, FastQC-like) are **planned** consumers of `QCResult` only.
- Deterministic results: integer accumulators everywhere possible;
  floating-point sums are accumulated in a fixed order.

## 2. Prior art (survey)

Summary of the documented behaviour of established tools, **from the
maintainers' documentation as known to the author; not re-verified online in
this session** (no network research was performed in Phase 1). Each point must
be checked against the current upstream documentation/source before it is used
for a compatibility claim (tracked in `ROADMAP.md`).

| Tool | Language / licence | Relevant design points |
|---|---|---|
| FastQC | Java, GPL-3 | Modules per-base quality, per-sequence quality, per-base content, per-sequence GC (with a theoretical normal fit), N content, length distribution, duplication (tracks the first 100,000 distinct sequences; long reads truncated for this module), overrepresented sequences, adapter content, k-mer content (off by default in recent versions). Positions beyond 9 grouped in bins for long reads unless `--nogroup`. Pass/warn/fail thresholds in `limits.txt`. |
| Falco | C++, GPL-3 | Re-implementation of FastQC aimed at FastQC-compatible output with higher speed. |
| fastp | C++, MIT | QC plus trimming/filtering, JSON + HTML output, duplication estimated with hashing, overrepresentation on sampled reads; multithreaded. |
| NanoPlot / NanoStat | Python, GPL-3 | Long-read summaries: N50, mean/median length and quality; mean read quality computed through error probabilities, not as an arithmetic mean of Phred scores; plots of length vs quality and yield over time from sequencing summaries. NanoPlot 1.47.1 is installed in WSL (`~/miniforge3/envs/nanoplot`). |
| LongQC | Python | Long-read QC including coverage-free estimates from read overlaps (minimap2-based). Licence to verify. |
| PacBio tools | various | HiFi/CCS BAM carry per-read tags such as `np` (number of passes) and `rq` (predicted accuracy); subread BAM carry ZMW/hole numbers. Exact tag sets differ between chemistries and software versions, so none may be assumed. |

Consequences for SeqQC:

- read quality is reported under **both** conventions, with explicit names
  (`mean_read_quality` = error-probability mean, `mean_read_quality_phred` =
  Phred-space mean);
- FastQC-like modules will live in an Illumina profile with a documented
  compatibility mode; no compatibility is claimed before validation against
  reference FastQC outputs;
- no code is copied from these tools; algorithms are re-implemented from
  their documented definitions. GPL-3 sources (FastQC, Falco, NanoPlot) must
  not be translated into this package unless its licence is chosen
  accordingly (the licence of SeqQC.jl is not yet defined).

## 3. Julia ecosystem

Packages present in the local depot (versions checked on 2026-11-10):

| Need | Package | Decision |
|---|---|---|
| FASTQ parsing | FASTX 2.2.0 (MIT) | **Used.** Automa-generated validated parser; a reused `Record` with `copy = false` and `StringView` accessors give zero-copy byte views of sequence and quality. The suite convention is to read FASTA/FASTQ with FASTX; a hand-written parser is only acceptable after it is benchmarked as a bottleneck *and* validated against FASTX on real data. |
| gzip | CodecZlibNG 0.2 (zlib-ng) + TranscodingStreams 0.11 | **Used.** Multi-member gzip supported (tested). |
| BGZF/BAM | XAM.jl (not installed), LibDeflate (installed) | **Planned (P0/P1).** Unaligned BAM is P0 in the roadmap but not implemented in Phase 1. Options: XAM.jl, or a small BGZF + BAM record decoder on LibDeflate. To be decided after measuring XAM. |
| Plots | Plots/Makie (heavy) | **Not used.** HTML reports will embed SVG produced by the report layer, keeping the analysis path free of plotting dependencies. |
| JSON | JSON3 (installed) | **Planned** for the report layer, possibly as a package extension. |

## 4. Layers

```
src/
  io/input.jl          InputInfo, SeqQCInputError, open_reads (gzip/plain, format sniffing)
  core/read.jl         ReadView, ReadSummary, byte class tables, summarize!
  core/metric.jl       AbstractQCMetric protocol and traits
  core/engine.jl       analyze, _stream!, default_metrics, warnings
  core/result.jl       QCResult, property forwarding, text display
  metrics/*.jl         ReadLength, BaseComposition, QualityDistribution, QualityVsLength
  platforms/           planned: Illumina, Nanopore, PacBio HiFi, PacBio CLR profiles
  reports/             planned: JSON, HTML, MultiQC, FastQC-like text
```

### IO

`open_reads(f, path)` sniffs gzip from the magic bytes (`1f 8b`), never from
the extension, and the format from the first decompressed byte: `@` FASTQ,
`>` FASTA (rejected for now), `B` inside gzip (BAM, rejected for now).
Parser and decompression errors are wrapped in `SeqQCInputError` with the
1-based record number. Truncation exactly at a record boundary of an
uncompressed file cannot be detected by any parser; truncated gzip streams are
detected by the decompressor.

### Engine

```
for each record (FASTX, reused Record):
    seq, qual = zero-copy byte views
    summarize!(summary, seq, qual)     # one pass over seq, one over qual; validates quality bytes
    for each metric state (Tuple, unrolled at compile time):
        update!(state, ReadView(seq, qual, offset, summary, record))
```

- The tuple of states makes the per-read dispatch static: `_stream!` is a
  function barrier specialised on the tuple of state types.
- `ReadSummary` is computed once per read and shared: base-class counts
  (packed 8-bit lanes in a `UInt64`, flushed every 255 bases), integer Phred
  sum, error-probability sum (table lookup), min/max Phred, per-read
  error-probability mean Q. Quality bytes outside `offset..'~'` raise an error;
  there is no silent guessing of the encoding.
- Memory: bounded by the metric states plus one record buffer; no per-position
  arrays. `ReadLength` grows with the number of distinct lengths (exact).

### Metric protocol

`init_state`, `update!`, `Base.merge!`, `finalize_metric`, `metric_name`, plus
traits `requirements` (`:sequence`, `:quality`, `:identifier`; checked against
what the input format provides before any read is processed),
`memory_complexity`, `definition` (stored in `result.settings.definitions`).
Custom metrics are plain Julia types implementing these methods (tested).

Parallel reduction contract: `merge!` of the states of two disjoint read sets
equals a single pass over their union. Integer accumulators merge exactly;
floating-point read-level sums (`sum_read_q`) may differ by rounding, and the
merge order will be fixed (by chunk index) when threads are added so that
results remain deterministic for a given thread count and chunking.

### Results

`QCResult` holds input description, platform, settings (offset, sampling,
metric names and definitions), totals, metric results, warnings, software
versions and elapsed time. Metric values are reachable directly
(`result.n50`) when the name is unique across metrics, otherwise an
`ArgumentError` names the candidates.

## 5. Performance design (to be driven by measurement)

Phase 1 baseline in `bench/results/`. Points to investigate in Phase 2, in this
order, only where measurements show a bottleneck:

1. gzip decompression (single-threaded zlib-ng): decompress in a separate task
   feeding a bounded pipe (pattern already used by PrimerDemux.jl), or BGZF
   block-parallel inflate with LibDeflate when the input is BGZF;
2. FASTX record parsing cost versus the summary pass;
3. the error-probability sum is a serial floating-point chain; splitting it
   into several accumulators changes rounding and must stay deterministic;
4. chunked multi-threading within a file (parse in one task, analyse chunks
   in workers with thread-local states, merge in chunk order) and across files.

## 6. Platform profiles (planned)

A profile is a list of metrics plus defaults and interpretation thresholds; it
never changes the definition of a shared metric. Illumina: FastQC-like
positional modules with bounded position bins. Nanopore: run metadata parsed
from read headers (`runid`, `ch`, `start_time`, `read`) only when present,
sequencing-summary files as a separate input. PacBio: HiFi and CLR/subreads as
distinct modes; BAM tags read only when present, with explicit missing-data
counters.
