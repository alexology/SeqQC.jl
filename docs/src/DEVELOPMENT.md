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
  documented as such (`docs/src/METRICS.md`).
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

## 2026-11-12 — Phase 2 (performance) and first FastQC check

Done:

- Profiling of the default run (plain Illumina-like input): FASTX ~44%,
  `summarize!` ~32% (7% in `round(...; digits = 6)` alone), Phred histogram ~16%.
  Micro-benchmarks must accumulate results into a sink and run inside functions:
  two first attempts were invalid (dead-code elimination, untyped globals).
- Error probabilities in fixed point (multiples of 2^-44, Int64 chunks into
  Int128): exact, order-independent sums, 0.8 → 2 GB/s.
- Quality pass skipped when no metric requires `:quality`
  (`settings.quality_validated`).
- `round(x * 1e6) / 1e6` instead of `round(x; digits = 6)`: identical on 3.9e8
  values in [0, 93], including halfway cases.
- `BlockPipe` (`src/io/pipe.jl`): gzip inflated in a separate task for
  `threads >= 2`; new `threads` keyword, `InputInfo.decompression`,
  `settings.threads`/`settings.decompression`.
- Tests: 256/256 (`Pkg.test()`, Julia 1.12.2, 4 threads): exact fixed-point
  sums against BigFloat, order independence, chunk boundaries (2^18 + 3 and
  600,000 bases), skipped quality pass, `BlockPipe` byte-for-byte with block
  sizes 1/7/1000/1 MiB and depths 1/3, producer errors, early close with no
  pending task, identical metrics with `threads = 1` and `2`.
- Measurements: `bench/results/phase2_2026-11-12.md` (gzip Illumina-like
  −31% with `threads = 2`; ReadLength-only plain −41%; real ONT file ~1%,
  bound by single-stream inflate; the file is multi-member, ~31 MB members).
- FastQC 0.12.1 (local install, Java 21) used for the first time: %GC rules
  determined on targeted inputs (see `METRICS.md`).

Not done / limits: member-parallel inflate (next performance step);
no Julia 1.10 run, Aqua/JET not run; no speed comparison with FastQC yet
(only Basic Statistics values were compared).

Next step: Phase 3 — FastQC-like per-sequence and per-base modules with a
compatibility mode, validated module by module against FastQC 0.12.1 outputs
on synthetic and real data; or the member-parallel inflate if speed on real ONT
files is the priority.

### 2026-11-12 (later) — comparison with FastQC, start-up latency

- `bench/compare_fastqc.ps1`, `bench/seqqc_once.jl`: fresh-process timing and
  peak memory for FastQC 0.12.1 (default and reduced modules) and SeqQC
  (1 and 2 threads). Pitfalls found and handled: FastQC exits with 0 on a
  missing file (success now checked from the report and its read count);
  the juliaup `julia.exe` is a launcher, so the real `julia.exe` must be given
  to measure memory; PowerShell 5.1 formats decimals with the locale
  (invariant culture now); `.ps1` needs `-ExecutionPolicy Bypass` per process.
- Results: `bench/results/fastqc_comparison_2026-11-12.md`. SeqQC obtains its
  own (smaller) set of statistics 3.6–11× faster with less memory; the work is
  not equivalent, so no claim about language speed is made.
- PrecompileTools workload added (`src/precompile.jl`, new dependency
  PrecompileTools 1): fresh-process run 3.24 → 0.66 s on 50,000 reads.
  Tests 256/256 after the change.

## 2026-11-12 — Phase 3 (first part): FastQC-compatible modules

- Clean-room approach: FastQC (GPL-3) source not read; behaviour determined by
  black-box experiments on FastQC 0.12.1 (help pages and `limits.txt` read for
  thresholds). Experiments: fixed-length files 1–100,000 bp and bisection of the
  group-width transitions; 150 random quantile sets (750 quantiles, rank
  `floor(p n)` the only rule that fit all); pooled vs per-position averaging;
  N/U/lower-case handling; encoding guess; per-sequence binning; length-bin
  bisection for three minima; flag boundaries for every module.
- Findings that contradict or extend the help pages: per-sequence quality flags
  use ≤ (not "below"); quantiles are NaN at positions with ≤ 100 bases; grouped
  quality values are unweighted means of per-position values; U is ignored in
  content and %GC; %GC is truncated; Phred+64 is assumed when the smallest
  quality byte is ≥ 64.
- New: `PerPositionStats` (`src/metrics/positional.jl`), `SeqQC.FastQC`
  (`src/compat/fastqc.jl`), `read_quality_floor_histogram` in
  `QualityDistribution`, `validation/fastqc_compare.jl`, 28 regression fixtures
  in `test/data/fastqc/` (synthetic inputs + FastQC outputs).
- Bugs found while validating: Julia `sum` re-association changed the last bits
  of grouped means (left-to-right sum now); percentage order of operations
  `(n/tot)*100`; `replace` with several pairs is simultaneous (report names of
  `.gz` inputs in the validation script).
- Validation: 116 inputs, 3,248 comparisons, 69,158 values, all identical
  (`validation/results/fastqc_0.12.1_2026-11-12.md`). Tests 1201/1201.
- Cost (in process, 2 threads): +0.17 s on 150 Mb plain Illumina-like input,
  hidden by decompression on gzip, +1.0 s on the real ONT file; tables in
  < 0.2 s. `max_positions` default raised to 100,000 after the real ONT file
  (reads up to 27,294 bp) exceeded 10,000 and the tables correctly refused to
  run.

Not done / limits: per-sequence GC, duplication, overrepresented sequences,
adapter and k-mer content; no `fastqc_data.txt`/HTML writer; FastQC 0.12.1 on
Windows only.

Next step: per-sequence GC content and duplication/overrepresentation (each
needs its own black-box study), or the report layer (JSON first).

## 2026-11-13 — FastQC per-sequence GC content

- `SeqQC.FastQC.GCModel` (`src/compat/fastqc_gc.jl`) and `per_sequence_gc`:
  FastQC 0.12.1 GC counts reproduced bit for bit (rules in `docs/src/FASTQC.md`).
- The truncation rule needed three iterations; each wrong rule passed the
  inputs available at the time, and only real ONT reads (~2.8 kb) and a
  19,999-bp read exposed it. Lesson: single-read black-box tests must cover
  the length range of real data, not only short reads.
- Also found: FastQC prints %GC = 0 for reads without A/C/G/T (SeqQC's native
  `gc_content` stays `nothing`).
- The GC flag is not reproduced: it depends on a fitted normal distribution
  that FastQC does not write to `fastqc_data.txt`; a reconstruction from the
  SVG plot would only be approximate.
- Tests 1562/1562 (38 FastQC fixtures, now including the GC table).

## 2026-11-13 — JSON report (Phase 6, first item)

- `src/reports/json.jl`: own JSON writer (no runtime dependency), schema
  `seqqc-result` 1.0.0 documented in `docs/src/JSON.md`; `to_json`,
  `write_json` (IO or path; temporary file + rename), `report(result, path)`
  (`.json`; other extensions raise an error).
- Decisions: NaN/Inf → null; matrices as arrays of rows; Float64 written with
  the shortest round-trip representation; raw per-position histograms omitted
  by default and listed in `omitted_fields`; wall-clock time isolated under
  `runtime` so the rest is reproducible; FastQC tables on request.
- Tests 1592/1592: the document is parsed with JSON3 (test-only dependency)
  and compared with the result, including escaping of quotes, backslashes,
  control characters and non-ASCII text, null for undefined statistics,
  omission, determinism, atomic writes.
- Sizes measured on real ONT data (`docs/src/JSON.md`).
- Tooling pitfall of this session: a stray `cat > file` at the start of a
  shell command waited for stdin and silently blocked the run for 20 minutes.

## 2026-11-13 — Multi-sample reports (`aggregate`)

- User's decisions: SeqQC gets its own MultiQC-like function (no MultiQC.jl,
  no MultiQC export), limited to SeqQC results, minimal interactivity; sample
  naming left to the developer (rules in `docs/src/MULTISAMPLE.md`).
- New: `src/reports/jsonread.jl` (strict reader), `src/reports/aggregate.jl`
  (`SampleSet`, `aggregate`, `sample_name`, `write_table`, aggregate JSON
  `seqqc-aggregate` 1.0.0), `src/reports/html.jl` (inline SVG, ≤ 8 samples
  lines with the validated categorical palette, > 8 heatmaps; sortable and
  filterable table, highlight, tooltips; light/dark).
- Palette validated with the dataviz skill's validator, run in headless Chrome
  (Node is not installed): all checks pass in both modes; three light-mode
  colours need relief, provided by the table.
- `to_json(...; fastqc = true)` no longer fails when FastQC tables cannot be
  computed (a real sample had a 176,636-bp read in its first 50,000 reads):
  `fastqc.modules = null`, `fastqc.unavailable` = reason.
- Real-data check: 95 ONT samples (first 50,000 reads each) analysed in 102 s,
  aggregated in 6.6 s, HTML 3.7 s / 2.2 MB, inspected as screenshots; the
  page showed at a glance a group of samples with different quality and GC.
  Interaction checked with scripted events in headless Chrome.
- Bugs found on the way: heatmap row labels overlapping (now every k-th row);
  empty leading bins (trimmed); a closure in `_charts` assigned `b` and
  overwrote the enclosing variable (fixed with `local`); JSON reader at
  5.6 MB/s → 24 MB/s after removing per-number string allocation, the
  aliasing check of `String(view(...))`, and boxing in numeric arrays.
- Tests 1677/1677 (JSON reader against JSON3 incl. invalid inputs, typed
  arrays, aggregation from objects and directories, naming rules, TSV/JSON,
  HTML escaping of hostile sample names, heatmap mode).
- Pitfall: `python -m http.server` binds to all interfaces by default and
  triggered a Windows firewall prompt; local helper servers must use
  `--bind 127.0.0.1`.
- Same day, at the user's request: "Quality by position" chart in the
  aggregate page (pooled mean Phred per bin of positions; positions covered by
  fewer than max(100, 1% of reads) bases hidden). Real data: quality stays at
  Q35–38 up to the ~2.8-kb amplicon length and drops in the tails; the
  short-read sample of the deviating group stops early. Tests 1793/1793
  (bin means checked against an independent pooled calculation).

## 2026-11-13 — Adapters, overrepresented sequences, text outputs, CLI, single-sample HTML

User's scope: these three items, then stop extending FastQC compatibility.

- Adapter Content (`src/compat/fastqc_adapter.jl`): rules from 18 designed
  inputs (exact/case-insensitive first occurrence, cumulative over all reads,
  rows to max−11 with `base_groups(max−11)`, group means, `(100n)/total`).
  Cost: a Dict lookup per base made it +11.5 s on the real ONT file; a
  2^24-bit prefilter removed it (now hidden by decompression).
- Overrepresented (`src/compat/fastqc_overrep.jl`): 50-base upper-cased keys,
  100,000 distinct-key limit (bisected), Java HashMap order + stable sort
  (6/6 designed inputs), contaminant windows reconstructed in four rounds of
  experiments (left-to-right windows closed at the 2nd mismatch; length to the
  last match with the mismatch still counted; ≥ min(20, length) matches; no
  search under 8 bases); 300/300 rows identical incl. 53 real ONT rows.
  FastQC's contaminant list is not copied into the repository; tests use a
  two-entry excerpt of public Illumina primers.
- Text outputs (`src/reports/fastqc_text.jl`): Java `Double.toString`
  emulation, "Total Bases" truncation (124/124), empty-table headers.
- CLI (`src/cli.jl`, `bin/seqqc.jl`, `bin/seqqc`, `bin/seqqc.cmd`) and
  single-sample HTML (`src/reports/html_single.jl`).
- Tests 3012/3012: 50 FastQC fixtures compared module by module and line by
  line as text, CLI exit codes and outputs, HTML pages.
- Bugs found on the way: empty-adapter-table header; NaN axis for constant
  values; Julia `sum` (earlier) — all covered by tests.
- Final validation: a full run over 199 inputs found 230 differing values in
  five all-A files (PolyA): FastQC searches a read only once a read longer
  than the adapter has been seen (an order effect, confirmed with four
  designed files). After the fix: 8,557 comparisons / 258,535 values and
  199/199 text files identical (`validation/results/fastqc_0.12.1_final_2026-11-13.md`).
  Tests 3150/3150. Lesson: the first fix ("skip reads not longer than the
  adapter") passed the failing files but broke another one; only the full
  re-run showed it.

## 2026-11-13 — Fixes after an external review (Julia 1.13.3)

The review reproduced five problems (all tests passing); each is now covered
by a regression test (4102/4102):

1. CLI: `a/x.fastq`, `b/x.fastq` and `a_x.fastq` produced two JSON reports
   (two names became `a_x`) with exit code 0. Output names are now made
   unique (`a_x_2`) with a note.
2. Single-sample HTML with FastQC metrics failed on an empty input
   (`BoundsError` drawing a chart without positions); the page now says that
   there are no positions.
3. `FastQC.length_distribution` required `PerPositionStats` and refused
   truncated positions although it uses only `ReadLength`; the truncation
   check now applies only to the per-base modules (encoding, per-sequence
   quality and basic statistics also include the pooled bases).
4. Merging `PerPositionStats` states analysed with different Phred offsets
   mixed raw bytes of different meaning (two Q40 reads gave Q55.5); it now
   raises `ArgumentError`.
5. The fixed-point error table made a read of Q67 bases 66.999999 (below a
   Q67 threshold); error sums now use correctly rounded `Float64` values with
   four accumulators in a fixed order, and every score 0–93 round-trips
   exactly (also on 1,000,000-base reads).

## 2026-11-14 — Truncation profiles for DADA2 and vsearch

`truncation_profile`, `kept_reads`, `suggest_truncation`,
`truncation_commands`, `report(s, "x.json"/"x.tsv")` and `seqqc truncation`
(`docs/src/TRUNCATION.md`). For each read and maxEE threshold the passing
truncation lengths form one interval, so one histogram of the largest passing
length (two-dimensional for pairs) gives exact counts for every truncLen in
one pass.

Validation: 67,968 counts identical to DADA2.jl `filtered` (R dada2 example
data and a synthetic pair with low qualities, N and short reads) and 400
identical to R dada2 1.36 `filterAndTrim`
(`validation/results/truncation_2026-11-14.md`). The first comparison found
one bug: with `truncLen < trimLeft + minLen` DADA2 keeps nothing, while the
profile counted the reads passing at longer lengths.

The suggestion rule (most retained bases for single-end; most pairs with the
required overlap for pairs) is a heuristic; the vsearch command has not been
run against vsearch.

Same day, on request: HTML page for a suggestion (`report(s, "x.html")`,
`seqqc truncation -o x.html`). Single-end: reads kept and retained bases by
`truncLen`, one line per maxEE. Paired-end: pairs kept along the overlap
constraint and a heatmap over (R1, R2) truncation lengths with the
constraint line. Palette, styles and tooltips of the existing reports; the
line charts gained an optional dashed marker. Checked visually in headless
Chrome on the R dada2 example data.
