# SeqQC.jl roadmap

Status legend: **done** (implemented, tested, documented), **partial**,
**planned**. A feature is done only when it meets the definition of done in
`DEVELOPMENT.md`.

## Phase 1 — Foundation (current)

| Item | Status |
|---|---|
| Package structure, module, `Project.toml` | done |
| FASTQ / FASTQ.gz streaming reader (FASTX, magic-byte detection, multi-member gzip, CRLF) | done |
| Input validation with record numbers (malformed, truncated, wrong format, quality encoding) | done |
| Streaming engine with type-stable tuple of states | done |
| Metric protocol (`init_state`, `update!`, `merge!`, `finalize_metric`, traits) | done |
| Total reads/bases, read-length statistics, read N50/N90, cumulative yield | done |
| GC content, N and ambiguous content, per-read GC histogram | done |
| Base and read quality distributions (both averaging conventions), quality vs length | done |
| Head sampling (`max_reads`) recorded in settings and warnings | done |
| Unit tests with synthetic fixtures and independent reference calculations | done |
| First performance baseline (`bench/`) | done |
| Unaligned BAM (P0 in the specification) | **planned, moved to Phase 4** — no BAM reader in the depot yet; evaluate XAM.jl vs a LibDeflate-based BGZF decoder |
| FASTA input (quality-free metrics, explicit "unavailable" results) | planned |

## Phase 2 — Performance baseline

- Breakdown measured in Phase 1 (decompression / FASTX parse / summary / metrics); optimise the dominant stage first.
- Decompression in a separate task with a bounded pipe; BGZF block-parallel inflate.
- Allocation profile per read (target: zero steady-state allocations per read).
- Benchmarks on ONT, Illumina-like and PacBio-like data, compressed and plain; Julia startup and compilation reported separately.
- Comparison with other tools only on equivalent outputs (e.g. NanoStat-equivalent summary vs NanoPlot `--only-report` if available; `seqkit stats` if installed).

## Phase 3 — Illumina profile

FastQC-like modules: per-base quality (bounded position bins; long reads never allocate per-position arrays proportional to the longest read without a bound), per-sequence quality, per-base content, per-sequence GC, per-base N, length distribution, duplication levels, overrepresented sequences, adapter content, k-mer enrichment. Compatibility mode with documented differences (sampling, grouping, quantiles, duplication estimation, adapter matching, thresholds). Validation against FastQC reference outputs (FastQC must be installed; not available on this machine as of 2026-11-10).

## Phase 4 — Long reads and BAM

- Nanopore: header metadata (`runid`, `ch`, `start_time`, `read`, `barcode`) when present; sequencing summary files; yield over time, channel statistics, pass/fail only from real labels.
- PacBio HiFi vs CLR/subreads as distinct modes; `np`, `rq`, ZMW tags only when present, with missing-data counters.
- Unaligned BAM input, then aligned BAM; CRAM only with a reliable implementation.

## Phase 5 — Parallelism

Thread-local states, chunked processing within files, multi-file execution, merge in chunk order for deterministic floating-point results, measured scaling.

## Phase 6 — Integration

CLI (`seqqc analyze ...`), versioned JSON schema, HTML report with inline SVG, MultiQC integration (custom-content JSON or a documented module format; to be investigated), FastQC-compatible text only for validated modules, full documentation.

## Phase 7 — Advanced (not before the core is stable)

POD5 and signal-level QC, aligned-read QC, adaptive sampling, additional metrics.
