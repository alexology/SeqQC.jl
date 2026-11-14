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

| Item | Status |
|---|---|
| Stage breakdown (decompress / FASTX / summary / metrics) and profile | done (`bench/results/phase2_2026-11-12.md`, `docs/src/ARCHITECTURE.md` §5) |
| Faster deterministic error sums (fixed point until 2026-11-13, then four Float64 accumulators) | done |
| Quality pass skipped when no metric needs it | done |
| Decompression in a separate task (`threads >= 2`) | done |
| Allocation profile per read | done: SeqQC adds none measurable; ~16 B/read inside FASTX |
| Member-parallel / BGZF inflate | **planned** (next performance step; the real ONT file is multi-member) |
| PacBio-like benchmark data | planned (no PacBio data available locally) |
| Comparison with other tools | partial: values checked against NanoPlot 1.47.1; process-level timing against FastQC 0.12.1 (`bench/results/fastqc_comparison_2026-11-12.md`; work not equivalent until Phase 3) |
| Package precompilation workload (start-up latency) | done: fresh-process run on 50,000 reads 3.24 → 0.66 s |

## Phase 3 — Illumina profile

| Item | Status |
|---|---|
| `PerPositionStats` (exact, bounded per-position quality quantiles and base counts) | done |
| `SeqQC.FastQC`: Basic Statistics, per-base quality, per-sequence quality, per-base content, per-base N, length distribution, flags | done: identical to FastQC 0.12.1 on 116 inputs (`docs/src/FASTQC.md`, `validation/results/fastqc_0.12.1_2026-11-12.md`) |
| Per-sequence GC content (FastQC GC model): counts | done (identical); flag not reproduced (fitted normal not observable in text output) |
| Overrepresented sequences incl. "Possible Source" | done (identical; contaminant list supplied by the user) |
| Adapter content | done (identical) |
| `fastqc_data.txt` / `summary.txt` writer | done (identical line by line, documented exclusions) |
| Duplication levels, k-mer content, per-tile quality | not planned (user's decision of 2026-11-13: stop after adapters/overrepresented, CLI + text, single-sample HTML) |
| `phred_offset = :auto` for SeqQC's own metrics | not planned: FastQC's guess (≥ `@` → Phred+64) misdecodes high-quality Phred+33 data; SeqQC keeps an explicit offset and reproduces the guess only in `SeqQC.FastQC` |

Original scope:

FastQC-like modules: per-base quality (bounded position bins; long reads never allocate per-position arrays proportional to the longest read without a bound), per-sequence quality, per-base content, per-sequence GC, per-base N, length distribution, duplication levels, overrepresented sequences, adapter content, k-mer enrichment. Compatibility mode with documented differences (sampling, grouping, quantiles, duplication estimation, adapter matching, thresholds). Validation against FastQC reference outputs (FastQC 0.12 with Java 21 available locally since 2026-11-12).

## Phase 4 — Long reads and BAM

- Nanopore: header metadata (`runid`, `ch`, `start_time`, `read`, `barcode`) when present; sequencing summary files; yield over time, channel statistics, pass/fail only from real labels.
- PacBio HiFi vs CLR/subreads as distinct modes; `np`, `rq`, ZMW tags only when present, with missing-data counters.
- Unaligned BAM input, then aligned BAM; CRAM only with a reliable implementation.

## Phase 5 — Parallelism

Thread-local states, chunked processing within files, multi-file execution, merge in chunk order for deterministic floating-point results, measured scaling.

## Phase 6 — Integration

| Item | Status |
|---|---|
| JSON report, versioned schema `seqqc-result` 1.0.0 (`to_json`, `write_json`, `report(result, "x.json")`) | done (`docs/src/JSON.md`) |
| Multi-sample report (`aggregate`, MultiQC-like, SeqQC results only): table, TSV, JSON, interactive HTML | done (`docs/src/MULTISAMPLE.md`) |
| Exact merging of several files into one sample | planned |
| Single-sample HTML report (`report(result, "x.html")`) | done |
| Export to MultiQC proper | not planned for now (user's decision: SeqQC has its own aggregation) |
| CLI (`seqqc analyze`, `seqqc report`, launchers) | done (`docs/src/CLI.md`) |
| Truncation profile and suggestion for DADA2 (`truncation_profile`, `suggest_truncation`, `seqqc truncation`); vsearch command not validated | done (`docs/src/TRUNCATION.md`) |
| Truncation chart in the HTML reports; profile of merged reads for vsearch | not started |

Original scope:

CLI (`seqqc analyze ...`), versioned JSON schema, HTML report with inline SVG, MultiQC integration (custom-content JSON or a documented module format; to be investigated), FastQC-compatible text only for validated modules, full documentation.

## Phase 7 — Advanced (not before the core is stable)

POD5 and signal-level QC, aligned-read QC, adaptive sampling, additional metrics.
