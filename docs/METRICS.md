# Metric definitions

All metrics are computed in one pass. Unless stated, values are exact
(integer counts or ratios of integer counts). `nothing` marks a value that is
undefined for the data (e.g. a mean over zero reads); it is never replaced by 0.

## Conventions

- Lengths are in bases (bytes of the sequence line).
- Bases are counted case-insensitively; `U` is counted as `T`. Classes: A, C,
  G, T, N, *ambiguous* (IUPAC `RYSWKMBDHV`), *invalid* (anything else, e.g.
  `-` or `.`; invalid bytes produce a warning).
- Quality bytes are decoded with an explicit offset (33 by default, 64 on
  request). A byte below the offset or above `~` is an error. Phred scores
  range over 0–93 (offset 33).

## `ReadLength` (`:read_length`)

| Value | Definition |
|---|---|
| `total_reads`, `total_bases` | counts |
| `min_length`, `max_length`, `mean_length` | over all reads, zero-length reads included |
| `median_length` | middle value; for an even count, mean of the two middle values |
| `n50`, `n90` | **read** N50/N90: largest `L` such that reads of length `>= L` contain at least 50% (90%) of all bases. This is not assembly N50: it describes the read length distribution weighted by bases |
| `length_histogram` | `(lengths, counts)`, every distinct length, ascending |

`yield_by_length(result)` gives, for every distinct length `L` (descending),
the reads and bases in reads of length `>= L` (cumulative yield curve).
Memory: one counter per distinct length (dense array below 65,536, dictionary above).

## `BaseComposition` (`:base_composition`)

| Value | Definition |
|---|---|
| `gc_content` | `(G + C) / (A + C + G + T)` — N, ambiguous and invalid bytes excluded from both terms |
| `n_content` | `N / all bases` |
| `ambiguous_content` | non-N IUPAC codes / all bases |
| `base_counts` | `(A, C, G, T, N, ambiguous, invalid)` |
| `gc_histogram` | 101 counters: reads whose GC percentage `100 (G+C)/(A+C+G+T)`, rounded half up, is 0…100. This is a simple histogram, **not** FastQC's GC model (FastQC distributes reads over bins with a length-dependent model and fits a theoretical normal curve) |
| `reads_without_acgt` | reads with no A/C/G/T, excluded from the histogram |

## `QualityDistribution` (`:quality`)

Two averaging conventions are reported under different names:

- **Phred-space mean**: arithmetic mean of Phred scores (FastQC per-sequence quality);
- **error-probability mean**: `-10 log10(mean(10^(-Q/10)))`, the Phred value
  of the mean error probability (convention of NanoPlot/NanoStat and ONT
  basecallers). It is always `<=` the Phred-space mean. ONT basecallers may skip
  the first bases of a read when computing the read Q score; SeqQC uses all bases.

| Value | Definition |
|---|---|
| `mean_base_quality` | Phred-space mean over all bases (exact) |
| `base_error_rate`, `base_quality_from_error_rate` | mean error probability over all bases and its Phred value (from the exact Phred histogram) |
| `fraction_q20`, `fraction_q30` | bases with Phred `>= 20`, `>= 30` |
| `base_quality_histogram` | counts of Phred 0–93 |
| `mean_read_quality` | mean over reads of the per-read error-probability mean Q (each per-read value rounded to 6 decimals, so that e.g. a read of Q10 bases gives exactly 10.0 and floating-point noise does not move reads across thresholds or bins) |
| `mean_read_quality_phred` | mean over reads of the per-read Phred-space mean |
| `read_quality_of_mean_error` | `-10 log10(mean over reads of the per-read mean error probability)`: the convention of NanoPlot's `mean_qual` (nanomath `ave_qual_floats`, checked in the NanoPlot 1.47.1 sources on 2026-11-10). Always `<=` `mean_read_quality` |
| `read_quality_histogram(_phred)` | per-read values in bins of width 0.1: bin `k` (1-based index `k+1`) holds `[k/10, (k+1)/10)`. Binned, therefore approximate for quantiles; no median is derived from it |
| `reads_at_least(_phred)` | reads with per-read mean Q `>=` each threshold (default 7, 10, 12, 15, 20, 30). The Phred-space comparison is exact in integers; the error-probability comparison uses the floating-point per-read value |
| `reads_without_bases` | zero-length reads, excluded from read-level quality |

Floating-point note: read-level means are sums of per-read `Float64` values in
input order. Merging states of disjoint read sets gives the same value up to
rounding (tested with `≈`).

## `QualityVsLength` (`:quality_vs_length`)

Matrix of read counts, rows = logarithmic length bins (20 per decade, integer
lower edges `ceil(10^(k/20))`, last bin `>= 10^9`, first bin = length 0),
columns = per-read error-probability mean Q in `[j-1, j)`, `j = 1…94`.

## Why some short-read metrics do not transfer to long reads (planned modules)

Per-position modules (per-base quality/content) assume reads of similar length
aligned at their start; for reads of 1–100 kb they mix very few reads at late
positions and need bounded position bins. Duplication and overrepresented
sequences based on exact identity of whole reads are meaningless for
error-prone long reads, where two reads of the same molecule almost never
match exactly. GC distributions of long reads are much narrower (averaging over
thousands of bases) and must not be judged with short-read thresholds. These
points shape the Phase 3–4 profiles.
