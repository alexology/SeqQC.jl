# FastQC compatibility (`SeqQC.FastQC`)

Reference: **FastQC 0.12.1** (Java 21). The behaviour below was determined by
black-box experiments: synthetic inputs designed to separate alternative
definitions, run through FastQC, and compared with candidate rules. FastQC's
source code (GPL-3) was not read or translated; its help pages and default
`limits.txt` were read for the documented thresholds. Every rule is backed by
the regression fixtures in `test/data/fastqc/` (synthetic inputs plus the
`fastqc_data.txt` FastQC wrote for them) and by `validation/fastqc_compare.jl`.

```julia
r = analyze("reads.fastq.gz"; metrics = SeqQC.FastQC.metrics())
SeqQC.FastQC.modules(r)
```

## Supported modules and validation status

| FastQC module | SeqQC function | Status |
|---|---|---|
| Basic Statistics (Encoding, Total Sequences, Sequence length, %GC) | `basic_statistics` | identical; Total Bases is given as an exact integer (FastQC prints it rounded with units); "Sequences flagged as poor quality" not reproduced |
| Per base sequence quality | `per_base_quality` | identical (bit for bit) |
| Per sequence quality scores | `per_sequence_quality` | identical |
| Per base sequence content | `per_base_content` | identical (bit for bit) |
| Per base N content | `per_base_n` | identical (bit for bit) |
| Sequence Length Distribution | `length_distribution` | identical, labels included |
| Per sequence GC content (counts) | `per_sequence_gc` (metric `GCModel`) | identical (bit for bit); its pass/warn/fail flag is **not reproduced** (it depends on FastQC's fitted normal distribution, absent from the text output) |
| pass/warn/fail of the six modules above | `flags` | identical |
| Adapter Content (table and flag) | `adapter_content` (metric `AdapterContent`) | identical |
| Overrepresented sequences (table, flag, "Possible Source") | `overrepresented` (metric `Overrepresented`) | identical; "Possible Source" needs a contaminant list (FastQC's own is not shipped with SeqQC) |
| `fastqc_data.txt`, `summary.txt` | `write_fastqc_data`, `write_fastqc_summary` | identical line by line, except the header line (`##SeqQC ...` unless `fastqc_header = true`), the modules not computed, and the per-sequence GC status (`NA`) |
| Sequence Duplication Levels, Overrepresented sequences, Adapter Content, Kmer Content, Per tile sequence quality | — | **not implemented** |

"Identical" means: on every validation input every printed value equals
SeqQC's `Float64` exactly after parsing (NaN = NaN), every label and count is
equal, and every flag is equal. Validation inputs and results:
`validation/results/fastqc_0.12.1_final_2026-11-13.md` (199 inputs, all modules and text; earlier runs:
`fastqc_0.12.1_2026-11-13.md`, `fastqc_0.12.1_2026-11-12.md`).

## Rules determined

**Encoding.** Phred+64 when the smallest quality byte in the file is ≥ 64
(`@`), otherwise Phred+33. Printed names: `Sanger / Illumina 1.9` (33),
`Illumina 1.3` (smallest byte 65), `Illumina 1.5` (64 or ≥ 66). Consequence:
a file whose qualities are all ≥ `@` (e.g. a few reads of `IIII`) is decoded
by FastQC as Phred+64 (Q40 becomes Q9). SeqQC's own metrics always use the
explicit `phred_offset`; only the `SeqQC.FastQC` views apply FastQC's guess.

**Position groups** (all per-base modules). Maximum read length `L`:
- `L ≤ 75`: one group per position;
- otherwise positions 1–9 singly, then groups aligned to multiples of `S`
  starting at 10 (`10–(S−1)` when `S > 10`), the last one truncated at `L`,
  where `S` is the smallest of 2, 5, 10, 20, 50, 100, … with `L − 9 ≤ 65 S`.
  Bisected transitions: 76→2, 140→5, 335→10, 660→20, 1310→50, 3260→100,
  6510→200, 13010→500, 32510→1000, 65010→2000, 130010→5000, 325010→10000.

**Per base sequence quality.** Per position: mean Phred score; quantile `p`
(10, 25, 50, 75, 90%) = value of rank `floor(p n)` (1-based) among the `n`
sorted scores, computed **only when `n > 100`** (otherwise NaN; with ≤ 100
reads FastQC prints NaN for every quantile). Per group: the **unweighted mean
of the per-position values** (positions are not pooled: positions with 210 ×
Q40 and 150 × Q0 give mean and median 20, not 23.3 and 40); quantiles average
only the positions with `n > 100`, NaN if none. Means are summed left to right
(Julia's `sum` re-associates and differs in the last bits). Rank rule checked
on 750 quantiles of 150 random inputs (no other tested rule fit all).

**Per base sequence content.** Pooled counts over the group; G, A, T, C
case-insensitive; N, **U** and IUPAC codes ignored; percentage computed as
`(n / total) × 100` (this order reproduces FastQC's last bits); NaN when the
group has no G/A/T/C.

**Per base N content.** Pooled: `(N / all bases) × 100`, all bytes in the
denominator.

**Per sequence quality scores.** Reads counted by the **integer part** of
their mean Phred score (30.5 → 30, 10.75 → 10); rows from the lowest to the
highest observed value, zeros included.

**Sequence Length Distribution.** Width `S` = smallest of 1, 2, 5, 10, … with
`max − max(min, 1) ≤ 51 S − 3` (depends only on the range; bisected for
minima 1, 200 and 1000 up to width 2000). Bins `[kS, (k+1)S − 1]` from
`floor(min/S) S` to the bin containing `max`, empty bins included. Labels:
single numbers when `S = 1`; the last label ends at `max + 1` when that is
smaller than the bin end (FastQC labelling quirk; counts unaffected).

**%GC (Basic Statistics).** Integer part of `100 (G+C)/(A+C+G+T)`,
case-insensitive, N, U and IUPAC codes ignored; 0 when there is no A/C/G/T.

**Per sequence GC content.** Each read contributes fractional weights:
- the read is truncated: lengths 100–999 to a multiple of 100, lengths ≥ 1,000
  to a multiple of 1,000 (150 → 100, 250 → 200, 2,850 → 2,000, 19,999 →
  19,000, 100,500 → 100,000); shorter reads are used whole;
- `c` = G + C (case-insensitive) in the truncated read; N, U and IUPAC codes
  count in the length but never as G/C (S and W included); a read of only N
  has `c = 0`;
- for length `L`, GC count `c` claims the percentage bins from
  `round(100 (c − 0.5) / L)` to `round(100 (c + 0.5) / L)` (Java rounding,
  `floor(x + 0.5)`), clipped to 0–100; each claimed bin receives
  `1 / (number of GC counts of length L claiming it)` — e.g. 0.5 at shared
  edges, 1/21 for 2,000-bp reads;
- weights are summed read by read in input order (needed for identical
  last bits); zero-length reads contribute nothing.

Evidence: 346 files with one or two reads (all `c` for `L ≤ 20`, selected
`c` for lengths 37–123,456, deterministic placement of G/C before and after
the truncation point, N/U/IUPAC/lower-case cases), plus the multi-read
validation inputs. The truncation rule was found in three steps: "multiple
of 100" fitted all reads ≤ 1,099 bp but not real ONT reads (~2.8 kb);
"leading digit" fitted 2,850 and 10,050 but not 19,999; the final rule fits
every input.

**Flags** (default thresholds, `limits.txt`):

| Module | warn | fail | note |
|---|---|---|---|
| Per base sequence quality | any lower quartile < 10 or median < 25 | < 5 or < 20 | NaN never triggers |
| Per sequence quality scores | mode ≤ 27 | mode ≤ 20 | **≤**, although the help page says "below"; mode = most frequent integer mean, lowest on ties |
| Per base sequence content | max(|A−T|, |G−C|) > 10 in any group | > 20 | on floating-point percentages: 27.5 − 17.5 evaluates to 10.000000000000004 and warns, 30 − 20 = 10 does not |
| Per base N content | any group > 5% | > 20% | |
| Sequence Length Distribution | lengths differ | a zero-length read | |

**Adapter Content.** For each adapter of the list (default: FastQC's six
12-mers), the first exact, case-insensitive occurrence in each read counts at
its start position; the value at a position is `100 n / reads` (computed as
`(100 n) / total`, unlike the `(n / total) · 100` of the other modules) where
`n` = reads with an occurrence starting at or before it, over **all** reads.
Order effect: reads are searched only once a read **longer** than the
adapter has been seen earlier in the file (or is the current read), so a
12-base read equal to the adapter counts only if a longer read came before it
(found in the final validation with reads of only A, then confirmed with four
designed files). Rows: positions `1 … max_length − 11`, grouped with
`base_groups(max_length − 11)` (so 150-bp reads use width 2, not 5); a
group's value is the mean of its positions. Flags: warn > 5, fail > 10; an
empty table (no read of 12 bases) is flagged warn. Unverified: the row count
for custom adapters of a length other than 12.

**Overrepresented sequences.** Key = first 50 bases, upper-cased (N kept). A
new key is tracked only while fewer than **100,000 distinct** keys are
tracked (not the first 100,000 reads: a sequence first seen after read
100,000 is counted if the limit is not reached; 99,999 vs 100,000 checked);
tracked keys are counted to the end. Reported: `(count / reads) · 100 > 0.1`.
Order: the iteration order of a `java.util.HashMap` holding all tracked keys
(Java `String.hashCode`, spread `h ^ (h >>> 16)`, capacity from the default
growth rule, insertion order within a bucket), then a stable sort by
decreasing count — determined from the outputs and checked on six inputs
designed so that first/last occurrence and alphabetical order all differ.
Flags: warn if anything is reported, fail if any percentage > 1.

"Possible Source": the sequence and its reverse complement are compared with
every contaminant on every diagonal (ungapped). Scanning left to right, the
second mismatch closes a window: its length runs to the **last matching
base** while its mismatch count stays 1 (a FastQC quirk: mismatches at 41 and
42 give "97% over 40bp"); scanning restarts after that mismatch. The last
window of a diagonal also ends at its last matching base. A window needs at
least `min(20, sequence length)` matching bases; sequences shorter than 8
bases are never searched. Best hit: longest window, then more matches, then
the first contaminant in the list. Text: `name (⌊100·matches/length⌋% over
<length>bp)`, or `No Hit`. Evidence: 54 designed sequences (internal, edge,
1–3 mismatches at chosen positions incl. adjacent ones, 4–25-bp sequences,
reverse complement, sequences shared by several contaminants) and 300 rows of
the validation inputs, including 53 rows of real ONT reads.

## Text outputs

`write_fastqc_data` / `write_fastqc_summary` (CLI: `seqqc analyze --fastqc`)
reproduce FastQC's layout: module order, column headers, integer vs Java
double columns (`21.0`; scientific notation below 10⁻³ and from 10⁷, e.g.
`6.666666666666666E-4`), "Total Bases" with one decimal **truncated**
(`1,999` → `1.9 kbp`; 124 cases), no header row for an empty Overrepresented
or Adapter table, "Sequences flagged as poor quality" 0, "File type"
"Conventional base calls". Not written: Per tile sequence quality and
Sequence Duplication Levels; the per-sequence GC status is `NA`. Without a
contaminant list "Possible Source" reads "Not computed (no contaminant
list)".

## Differences from SeqQC's own metrics

| Quantity | SeqQC native | FastQC |
|---|---|---|
| Phred offset | explicit (`phred_offset`) | guessed from the smallest byte |
| GC content | fraction, U counted as T | integer part of a percentage, U ignored |
| Per-position quantiles | defined for any `n ≥ 1` (same rank rule) | only for `n > 100` |
| Grouped positions | per-position values available | unweighted mean of per-position values |
| Read quality | three named averages (`docs/METRICS.md`) | integer part of the Phred-space mean |

## Limits

- Validated on Windows with FastQC 0.12.1 only; other versions may differ.
- Per-base modules need `PerPositionStats(max_positions)` ≥ the longest read
  (default 100,000; memory ≈ 0.8 kB per position up to the longest read). For longer reads the
  functions raise an error instead of returning partial tables.
- Not implemented: Sequence Duplication Levels, Kmer Content, Per tile
  sequence quality, and the Per sequence GC flag.
- `Overrepresented` cannot be merged across chunks or files (the tracked
  sequences depend on read order); `merge!` raises an error.
- Java `HashMap` buckets holding 8 or more keys are converted to trees, whose
  iteration order was not studied; it can only affect the order of equal
  counts, with 100,000 keys spread over 262,144 buckets.
- Per-position modules are of limited use for long reads, where late
  positions are covered by few reads (`docs/METRICS.md`).
