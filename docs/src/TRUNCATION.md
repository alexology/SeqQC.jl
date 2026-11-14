# Truncation for DADA2 and vsearch

Amplicon pipelines cut reads where their quality drops: DADA2's
`filterAndTrim(truncLen = ..., maxEE = ...)` and vsearch's
`--fastq_trunclen` / `--fastq_maxee`. Picking the cut point by eye from a
quality plot is the usual practice. SeqQC counts instead how many reads, or
read pairs, DADA2's filter keeps at every truncation length, and proposes a
length with a stated rule.

```julia
using SeqQC
p = truncation_profile("S1_R1.fastq.gz", "S1_R2.fastq.gz")   # one pass, both files
kept_reads(p, (240, 160), 2.0)        # pairs kept by truncLen = c(240, 160), maxEE = 2
s = suggest_truncation(p; amplicon_length = 292)
s.trunc_len, s.max_ee, s.kept, s.fraction
truncation_commands(s).dada2_r        # ready-to-use filterAndTrim(...) call
report(s, "S1.truncation.html")       # charts; or .json / .tsv
```

```
seqqc truncation S1_R1.fastq.gz S1_R2.fastq.gz --amplicon-length 292 -o S1.truncation.html
```

## What is counted

The profile applies DADA2's read filter (R dada2 1.36 `fastqFilter`, ported
by DADA2.jl) to each read, in this order:

1. remove the first `trimLeft` bases;
2. truncate before the first base with quality ≤ `truncQ`;
3. `truncLen` (measured on the raw read, ignored when ≤ `trimLeft`): discard
   reads shorter than `truncLen` after step 2, truncate the others;
4. discard reads with fewer than `minLen` bases left;
5. discard reads with more than `maxN` N;
6. discard reads whose expected errors Σ 10^(−Q/10) exceed `maxEE`.

For pairs, a pair is kept only when both reads pass (R1 and R2 must list the
reads in the same order; identifiers are checked, ignoring `/1` and `/2`).
Defaults: `trim_left = 0`, `trunc_q = 2`, `max_n = 0`, `min_len = 20` (as in
`filterAndTrim`); thresholds `max_ee = [0.5, 1, 2, 3, 5, Inf]`. R's default
`maxEE` is `Inf`; DADA2.jl's is 2.

Not modelled: `rm.phix` (with PhiX in the data DADA2 keeps fewer reads than
predicted), `trimRight`, `maxLen`, `minQ`, and the primer removal done by
other tools before DADA2.

### How it is exact in one pass

Expected errors and N counts only grow as a read gets longer, so for one read
and one `maxEE` the truncation lengths at which it passes form one interval
from `trimLeft + minLen` to a largest length `Lmax`. SeqQC stores one `Lmax`
per read and threshold in a histogram; the reads kept at length `L` are the
reads with `Lmax ≥ L` (a suffix sum). For pairs the histogram is
two-dimensional, `(Lmax₁, Lmax₂)`, and the pairs kept at `(L1, L2)` are a
two-dimensional suffix sum. Memory: `max_positions² × thresholds` integers for
pairs (default `max_positions = 600`, about 17 MB), one column per threshold
for single-end reads.

## The suggestion

- **Single-end**: the `truncLen` that maximises the retained bases, reads kept
  × (`truncLen` − `trimLeft`); ties go to the longer truncation.
  `min_trunc_len` excludes lengths shorter than the analysis needs.
- **Paired-end**: the `(L1, L2)` that keeps the most pairs subject to
  `L1 + L2 ≥ amplicon_length + min_overlap`; ties go to the larger
  `L1 + L2`, then to the longer R1. `amplicon_length` is the length of the
  sequenced fragment from the first base of R1 to the first base of R2,
  primers included if they are in the reads (for the 515F/806R V4 region of
  16S with primers in the reads: about 292). `mergePairs` needs 12
  overlapping bases; the default `min_overlap = 20` leaves a margin for
  biological length variation.

`max_ee` (default 2) selects the reported choice; `alternatives` lists the best
choice for every threshold of the profile, so the trade-off between stricter
filtering and fewer reads is visible.

Warnings are added when fewer than 90% of the reads of a file have the most
frequent length (primer-trimmed reads, variable amplicons such as ITS:
`truncLen` discards every read shorter than it, and `truncLen = 0` with
`maxEE` alone is often better), when fewer than half the reads or pairs are
kept, and when reads are longer than `max_positions`.

The read counts are exact; the rule is a heuristic. It knows nothing about
the error model DADA2 learns afterwards, about chimeras, or about the
amplicon's real length distribution, so check `alternatives` and the quality
plots before using it blindly.

## Commands

`truncation_commands(s)` returns:

- `dada2_r`: `filterAndTrim(fwd, filtF, rev, filtR, truncLen = c(L1, L2), trimLeft = ..., truncQ = ..., maxN = ..., maxEE = c(e, e), minLen = ..., rm.phix = TRUE, compress = TRUE)`;
- `dada2_jl`: the same with DADA2.jl's `FilterOptions` for each read;
- `vsearch`: single-end only, `vsearch --fastq_filter ... --fastq_truncqual --fastq_trunclen --fastq_maxns --fastq_maxee --fastq_minlen`.
  **Not validated against vsearch** (it is not installed on the development
  machine). With `trimLeft > 0` check whether `--fastq_trunclen` counts the
  stripped bases. For pairs vsearch merges first (`--fastq_mergepairs`) and
  filters the merged reads, which this profile does not describe; the
  command is then only a comment.

File names in the commands are placeholders.

## Output files

`report(s, "x.json")`: schema `seqqc-truncation` 1.0.0 with the files, the
filter settings, the longest read and the modal-length fraction of each file,
the rule, the suggestion, the alternatives, the reads kept without
truncation, the commands and the warnings.

`report(s, "x.html")`: a self-contained page (same style as the other SeqQC
reports, light and dark theme, tooltips) with

- single-end: reads kept by `truncLen`, one line per `maxEE`, and the
  retained bases (reads kept × (`truncLen` − `trimLeft`), relative to the
  maximum), the suggestion marked by a dashed line;
- paired-end: pairs kept along the overlap constraint (each R1 length with the
  shortest R2 length giving `min_overlap`), one line per `maxEE`, and a
  heatmap of the pairs kept over both truncation lengths for the chosen
  `maxEE` (at most 50 × 50 cells, sampled every few bp for long reads), with
  the line `L1 + L2 = amplicon_length + min_overlap`, cells below it faded,
  and the suggestion as a dot;
- tiles with the suggestion, the table of alternatives (with the reads kept
  without `truncLen`), the commands and the warnings.

`report(s, "x.tsv")`: single-end, one row per `truncLen` with one column of
reads kept per threshold (`kept_ee0.5`, `kept_ee1`, ...); paired-end, one row
per R1 length with the shortest R2 length giving the required overlap.

## Validation

`validation/truncation_compare.jl` compares `kept_reads` with DADA2.jl's
`filtered` (rmPhix = false), read by read, on the example data shipped with R
dada2 (`sam1F/R`, `sam2F/R`, 1,500 pairs each) and on a synthetic pair of
files with low qualities, Q ≤ 2, N and short reads: trimLeft 0/7, truncQ 2/11,
minLen 20/50, maxEE 0.5/1/1.7/2/3/Inf and all truncation lengths in steps of
10, single-end and paired. `validation/truncation_compare_r.R` and
`truncation_compare_r.jl` compare with R dada2 1.36 `filterAndTrim`
(rm.phix = FALSE). Results on 2026-11-14: 67,968 counts identical to
DADA2.jl, 400 identical to R dada2
(`validation/results/truncation_2026-11-14.md`).
