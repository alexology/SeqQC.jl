# Multi-sample reports (`aggregate`)

SeqQC's MultiQC-like function: it puts the results of many samples side by
side in one summary table and one self-contained HTML page. Unlike MultiQC it
reads **only SeqQC results** (decision of 2026-11-13); parsing the outputs of
other tools is out of scope.

```julia
using SeqQC

# 1. analyse each sample and keep its JSON report (interchange format)
for f in readdir("reads"; join = true)
    endswith(f, ".fastq.gz") || continue
    r = analyze(f; metrics = vcat(default_metrics(), [PerPositionStats(), SeqQC.FastQC.GCModel()]))
    report(r, joinpath("qc", sample_name(f) * ".seqqc.json"); fastqc = true)
end

# 2. aggregate (from the directory, or from QCResult objects directly)
s = aggregate("qc")
report(s, "multiqc_like.html")      # interactive, self-contained page
report(s, "summary.tsv")            # one row per sample
report(s, "summary.json")           # schema seqqc-aggregate 1.0.0
```

The HTML can be regenerated from the saved JSON files at any time without
re-reading the FASTQ files.

## Inputs

`aggregate(inputs; names = nothing, low_reads_fraction = 0.1)` accepts any
mix of `QCResult` objects, SeqQC JSON files and directories. In a directory,
every `*.json` file whose `schema` is `seqqc-result` (version 1.x) is used, in
natural order (`barcode2` before `barcode10`); other JSON files are skipped
with a note in `warnings`. A newer major schema version raises an error.
When `QCResult`s analysed with the metrics of `SeqQC.FastQC` are passed, their
FastQC flags are included automatically.

Samples are **compared, never merged**: two files of the same sample are two
rows. Merging the reads of several files into one sample needs a single
analysis over all of them (planned: exact merging of metric states).

## Sample names

1. Default: the input file name without compression (`.gz`, `.bgz`, `.bz2`,
   `.xz`, `.zst`), `.json`, `.seqqc` and `.fastq`/`.fq` extensions
   (`sample_name("run/ONT_barcode01.fastq.gz") == "ONT_barcode01"`). For JSON
   reports the name comes from the FASTQ path stored in the report.
2. Names that collide get their parent directory as a prefix
   (`barcode01/reads`, `barcode02/reads`), the common layout of ONT output.
3. `names = [...]` (input order) replaces all names; `names = Dict(path =>
   name)` replaces some of them, the others keep the default of rules 1–2.
4. Names that still collide raise an error listing them.

## Summary table

Columns: reads, bases, minimum/median/mean/maximum length, read N50, GC %,
N %, mean base quality (Phred), mean read quality (error-probability mean),
% reads with mean quality ≥ Q20, % bases ≥ Q30, number of warnings, and
FastQC flags when the reports contain them (`fastqc = true`). Definitions:
`docs/src/METRICS.md`; a metric missing from a sample's analysis is an empty cell.

`warnings` lists every per-sample warning (prefixed by the sample name), the
skipped files, and samples with fewer reads than `low_reads_fraction` × the
median (only with ≥ 3 samples). The low-reads rule is a configurable
heuristic, not a FastQC flag.

## Charts

Five distributions, each as a **fraction** of the sample's reads or bases so
samples of different depth are comparable: read length (linear bins up to
1 kb, logarithmic bins of 20 per decade beyond), cumulative yield (fraction of
bases in reads at least as long as each bin), mean read quality (1-Q bins),
base quality, per-read GC. Leading and trailing bins that are empty in every
sample are trimmed.

**Quality by position** (requires `PerPositionStats` in the analyses): mean
Phred score of the bases at each read position, on common linear bins of
positions (width 1, 2, 5, 10, … chosen for at most 150 bins). A bin pools the
bases of its positions (Σ mean·bases / Σ bases: the exact mean of those
bases). In each sample, positions covered by fewer than max(100, 1% of the
sample's reads) bases are not shown, so the sparse tails of a few very long
reads do not dominate; for samples analysed without `PerPositionStats` the
row is empty. Quality axes start near the lowest value (a zero baseline would
flatten the lines); quality heatmaps run from the lowest to the highest value
observed, shown in the legend.

- Up to 8 samples: line charts, one categorical colour per sample (validated
  palette, fixed order: a sample keeps its colour when others are filtered),
  legend, crosshair tooltip listing every visible sample at the pointer.
- More than 8 samples: heatmaps (samples × bins, sequential blue scale from 0
  to the chart's maximum; legend ramp), cell tooltips, every k-th row labelled
  (full names in tooltips and in the table).

Interaction (plain JavaScript embedded in the page, no external resources):
sortable table (click a header), text filter on sample names (hides rows and
their lines/heatmap rows), click on a row, legend entry or heatmap row to
highlight a sample in all charts, "Clear selection". Light and dark themes
follow the system setting. All values shown in tooltips are also in the
table, the TSV and the JSON.

## Performance (measured 2026-11-13)

95 real ONT amplicon samples (first 50,000 reads each, 138 MB of JSON
reports including per-position statistics up to 100,000 positions):
`aggregate` 6.6 s (mostly JSON parsing at ~24 MB/s), HTML 3.7 s, page size
2.2 MB. Producing the 95 JSON reports took 102 s (2 threads).

## Limits

- Only SeqQC results; no MultiQC output parsing or export (yet).
- No merging of samples across files.
- The low-reads heuristic is the only cross-sample check.
- Interaction checked with scripted events in headless Chrome (filter,
  selection, clear, sort, tooltips of both chart kinds); no screen-reader audit.
