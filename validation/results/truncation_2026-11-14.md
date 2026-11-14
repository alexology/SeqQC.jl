# Truncation profile validation — 2026-11-14

SeqQC 0.1.0 (development), Julia 1.13.3, Windows 11.

## DADA2.jl (`Dada2.filtered`, rmPhix = false)

`julia validation/truncation_compare.jl <DADA2.jl> sam1F sam1R sam2F sam2R`
(R dada2 1.36.0 example data, `system.file("extdata", package = "dada2")`):

```
sam1F.fastq.gz + sam1R.fastq.gz: 1500 pairs, 28896 counts identical
sam2F.fastq.gz + sam2R.fastq.gz: 1500 pairs, 28896 counts identical
syn_R1.fastq + syn_R2.fastq: 3000 pairs, 10176 counts identical
all 67968 counts identical
```

Grid: trimLeft 0/7 (R1), truncQ 2/11, minLen 20/50, maxEE
0.5/1/1.7/2/3/Inf, truncLen 0 and 20, 30, ... up to the longest read, single
and paired (all (L1, L2) combinations of the grid).

The first run found one difference: with `truncLen < trimLeft + minLen` DADA2
keeps nothing (truncation leaves fewer than minLen bases) while the profile
counted the reads passing at longer lengths. Fixed before this run.

## R dada2 1.36.0 (`filterAndTrim`, rm.phix = FALSE)

`Rscript validation/truncation_compare_r.R > counts.tsv`, then
`julia --project=. validation/truncation_compare_r.jl counts.tsv <extdata>`:

```
all 400 counts identical to R dada2
```

Grid: sam1, sam2; trimLeft 0/10; truncQ 2/11; maxEE 0.5/1/2/5/Inf; truncLen
(0,0), (240,160), (200,200), (150,120), (250,250), (30,0); single and paired.

## Example suggestion (sam1, maxEE 2, amplicon length 293)

```
truncLen = c(178, 135): 1263 of 1500 pairs kept (84.2%), overlap 20 bases
single-end R1: truncLen = 225, 1180 of 1500 reads kept (78.7%)
```
