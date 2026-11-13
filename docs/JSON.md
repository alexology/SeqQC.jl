# JSON report — schema `seqqc-result` 1.0.0

```julia
report(result, "sample.json")                         # or write_json(path_or_io, result)
s = to_json(result; fastqc = true)                    # string, with FastQC-compatible tables
to_json(result; omit = ())                            # everything, raw histograms included
```

The document is produced by a small built-in writer (no JSON dependency) and
is checked against an independent parser (JSON3.jl) in the tests. Files are
written to a temporary file in the target directory and then renamed.

## Versioning

`schema_version` follows semantic versioning: adding fields is a minor change;
renaming or removing a field, or changing its type or meaning, is a major
change. Consumers should check `schema` and the major version.

## Top level

| Field | Type | Content |
|---|---|---|
| `schema` | string | `"seqqc-result"` |
| `schema_version` | string | `"1.0.0"` |
| `software` | object | `name`, `version` (SeqQC), `julia` |
| `input` | object | `path` (as given to `analyze`), `file_size` (bytes), `compression` (`"none"`, `"gzip"`), `format` (`"fastq"`), `decompression` (`"none"`, `"inline"`, `"task"`) |
| `platform` | string | analysis profile (`"generic"`) |
| `settings` | object | `phred_offset`, `max_reads` (null = all), `threads`, `decompression`, `sampling` (`"none"`, `"head"`), `quality_validated`, `metrics` (names), `definitions` (metric name → definition text) |
| `total_reads`, `total_bases` | integer | reads and bases processed |
| `warnings` | array of strings | analysis warnings |
| `metrics` | object | one object per metric, keyed by metric name; fields as in `docs/METRICS.md` |
| `fastqc` | object or null | with `fastqc = true`: `rules`, `modules` (the tables of `SeqQC.FastQC.modules`, `docs/FASTQC.md`) and `unavailable` (null, or the reason the tables could not be computed, e.g. reads longer than `max_positions`; `modules` is then null) |
| `omitted_fields` | array of strings | field names dropped at any depth (`omit` keyword) |
| `runtime` | object | `elapsed_seconds`; the only part that differs between identical runs |

## Type mapping

| Julia | JSON |
|---|---|
| `NamedTuple`, `Dict` | object (field order preserved) |
| `Vector`, `Tuple` | array |
| `Matrix` | array of rows (`m[i, :]` is element `i`) |
| `Int` | number |
| `Float64` | number, shortest representation that parses back to the same `Float64` |
| `NaN`, `±Inf` | `null` (not representable in JSON) |
| `nothing`, `missing` | `null` (undefined statistic, e.g. N50 of an empty file) |
| `Symbol` | string |
| `Bool` | `true` / `false` |

Matrices in the default metrics: `quality_vs_length.counts` (rows = length
bins, columns = quality bins), `per_position.base_counts` (rows = A, C, G, T,
U, N, other; columns = positions), `per_position.quality_quantiles` (rows =
10, 25, 50, 75, 90%).

## Size

By default `raw_quality_histograms` (94 numbers per read position, needed
only to recompute FastQC tables) is omitted. Everything else is bounded by
the number of distinct read lengths and of read positions. Measured on
2026-11-13 (minified output):

| Input | Longest read | Default metrics | `SeqQC.FastQC.metrics()` + `fastqc = true` | Same with `omit = ()` |
|---|---:|---:|---:|---:|
| Illumina-like, 1M × 150 bp | 150 | 42 kB | 0.03 MB | 0.1 MB |
| real ONT amplicons, 20,000 reads | 9,342 | 60 kB | 0.61 MB | 2.6 MB |
| real ONT amplicons, 637,924 reads | 27,294 | 85 kB | 1.6 MB | 7.4 MB |

Serialisation took at most 0.24 s (largest case).

## Aggregate document — schema `seqqc-aggregate` 1.0.0

Written by `report(set, "x.json")` / `to_json(set)` for a `SampleSet`
(`docs/MULTISAMPLE.md`): `schema`, `schema_version`, `settings`
(`low_reads_fraction`, `software`, `sample_schema_versions`), `samples`,
`sources` (input path of each sample), `table` (one array per column, `null`
for missing values; `fastqc_flags` as objects or null), `series` (the plotted
distributions on common bins: `length` with `edges`, `scale`, `fraction`,
`yield`; `read_quality`, `base_quality`, `gc` with their bins and `fraction`
matrices, samples × bins; `position_quality` with `edges`, `mean_quality`
(samples × position bins, Phred; null where not shown), `min_bases`,
`min_fraction`) and `warnings`.

## Reading reports back

`read_json(path)` parses any JSON document (strict RFC 8259, built in):
objects become `Dict{String,Any}`, numeric arrays `Vector{Int}` or
`Vector{Float64}`, other arrays `Vector{Any}`, `null` becomes `nothing`.
Integers outside the `Int64` range are read as `Float64`.
