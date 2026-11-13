# SeqQC.FastQC vs FastQC 0.12.1 — final validation of 2026-11-13

Commands (FastQC 0.12.1, OpenJDK 21.0.3, Windows 11; SeqQC 0.1.0-DEV, Julia 1.12.2):

```
julia --project=. validation/fastqc_compare.jl      <FastQC dir> <work> --max-positions=200000 label=path ...
julia --project=. validation/fastqc_text_compare.jl <FastQC dir> <work> label=path ...
```

Both use FastQC's own contaminant list for "Possible Source" (read from the FastQC installation, not
stored here). 199 inputs: every designed experiment file of `docs/src/FASTQC.md` (grouping, quantiles,
encodings, length bins, flags, GC model, adapters incl. read-order effects, overrepresented sequences
incl. the 100,000-distinct limit with 150,000-read files, tie order and contaminant windows), the
`maxlen<L>` files at every grouping transition up to 65,010 bp, `mixed` (50,000 reads with N/IUPAC/U/
lower case), the Illumina-like 1M × 150 bp files (plain and gzip), the ONT-like 50,000 long reads and
the first 20,000 reads of the real ONT amplicon file (not stored).

**Results**

- Modules (Basic Statistics, Per base sequence quality, Per sequence quality scores, Per base sequence
  content, Per sequence GC content counts, Per base N content, Sequence Length Distribution,
  Overrepresented sequences incl. Possible Source, Adapter Content) and their flags (all but the
  per-sequence GC flag): **8,557 comparisons, 258,535 values, 0 differences**, none needing the 1e-9
  tolerance.
- Text: `fastqc_data.txt` and `summary.txt` written by SeqQC identical line by line to FastQC's for
  **199 of 199 inputs**, after removing only the header line, the two modules SeqQC does not compute
  (Per tile sequence quality, Sequence Duplication Levels) and the per-sequence GC status.

History of this run: a first full run found 230 differing values in 5 files of reads made only of A
(PolyA adapter); the rule behind it (FastQC searches a read only once a read longer than the adapter
has been seen) was isolated with four designed files, implemented, and the full validation repeated.

## Module comparison table

| input | module | column | result | values | differing | max abs diff |
|---|---|---|---|---:|---:|---:|
| maxlen13009 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen13009 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen13009 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen13009 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen13009 | Per base sequence quality | Base | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence quality | Mean | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence quality | Median | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence quality | Lower Quartile | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence quality | Upper Quartile | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence quality | 10th Percentile | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence quality | 90th Percentile | identical | 75 | 0 |  |
| maxlen13009 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen13009 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen13009 | Per base sequence content | Base | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence content | G | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence content | A | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence content | T | identical | 75 | 0 |  |
| maxlen13009 | Per base sequence content | C | identical | 75 | 0 |  |
| maxlen13009 | Per base N content | Base | identical | 75 | 0 |  |
| maxlen13009 | Per base N content | N-Count | identical | 75 | 0 |  |
| maxlen13009 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen13009 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen13009 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen13009 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen13009 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen13009 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen13009 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen13009 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen13009 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen13009 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen13009 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen13009 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen13009 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen13009 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen13009 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen13009 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen13009 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen13009 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen13009 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen13009 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen13009 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen13009 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen13009 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen13010 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen13010 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen13010 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen13010 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen13010 | Per base sequence quality | Base | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence quality | Mean | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence quality | Median | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence quality | Lower Quartile | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence quality | Upper Quartile | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence quality | 10th Percentile | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence quality | 90th Percentile | identical | 36 | 0 |  |
| maxlen13010 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen13010 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen13010 | Per base sequence content | Base | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence content | G | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence content | A | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence content | T | identical | 36 | 0 |  |
| maxlen13010 | Per base sequence content | C | identical | 36 | 0 |  |
| maxlen13010 | Per base N content | Base | identical | 36 | 0 |  |
| maxlen13010 | Per base N content | N-Count | identical | 36 | 0 |  |
| maxlen13010 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen13010 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen13010 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen13010 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen13010 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen13010 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen13010 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen13010 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen13010 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen13010 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen13010 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen13010 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen13010 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen13010 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen13010 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen13010 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen13010 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen13010 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen13010 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen13010 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen13010 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen13010 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen13010 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen1309 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen1309 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen1309 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen1309 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen1309 | Per base sequence quality | Base | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence quality | Mean | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence quality | Median | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence quality | Lower Quartile | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence quality | Upper Quartile | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence quality | 10th Percentile | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence quality | 90th Percentile | identical | 75 | 0 |  |
| maxlen1309 | Per sequence quality scores | Quality | identical | 3 | 0 |  |
| maxlen1309 | Per sequence quality scores | Count | identical | 3 | 0 |  |
| maxlen1309 | Per base sequence content | Base | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence content | G | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence content | A | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence content | T | identical | 75 | 0 |  |
| maxlen1309 | Per base sequence content | C | identical | 75 | 0 |  |
| maxlen1309 | Per base N content | Base | identical | 75 | 0 |  |
| maxlen1309 | Per base N content | N-Count | identical | 75 | 0 |  |
| maxlen1309 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen1309 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen1309 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen1309 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen1309 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen1309 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen1309 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen1309 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen1309 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen1309 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen1309 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen1309 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen1309 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen1309 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen1309 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen1309 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen1309 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen1309 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen1309 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen1309 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen1309 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen1309 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen1309 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen1310 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen1310 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen1310 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen1310 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen1310 | Per base sequence quality | Base | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence quality | Mean | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence quality | Median | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence quality | Lower Quartile | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence quality | Upper Quartile | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence quality | 10th Percentile | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence quality | 90th Percentile | identical | 36 | 0 |  |
| maxlen1310 | Per sequence quality scores | Quality | identical | 3 | 0 |  |
| maxlen1310 | Per sequence quality scores | Count | identical | 3 | 0 |  |
| maxlen1310 | Per base sequence content | Base | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence content | G | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence content | A | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence content | T | identical | 36 | 0 |  |
| maxlen1310 | Per base sequence content | C | identical | 36 | 0 |  |
| maxlen1310 | Per base N content | Base | identical | 36 | 0 |  |
| maxlen1310 | Per base N content | N-Count | identical | 36 | 0 |  |
| maxlen1310 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen1310 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen1310 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen1310 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen1310 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen1310 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen1310 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen1310 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen1310 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen1310 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen1310 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen1310 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen1310 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen1310 | Sequence Length Distribution | Length | identical | 33 | 0 |  |
| maxlen1310 | Sequence Length Distribution | Count | identical | 33 | 0 |  |
| maxlen1310 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen1310 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen1310 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen1310 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen1310 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen1310 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen1310 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen1310 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen139 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen139 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen139 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen139 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen139 | Per base sequence quality | Base | identical | 74 | 0 |  |
| maxlen139 | Per base sequence quality | Mean | identical | 74 | 0 |  |
| maxlen139 | Per base sequence quality | Median | identical | 74 | 0 |  |
| maxlen139 | Per base sequence quality | Lower Quartile | identical | 74 | 0 |  |
| maxlen139 | Per base sequence quality | Upper Quartile | identical | 74 | 0 |  |
| maxlen139 | Per base sequence quality | 10th Percentile | identical | 74 | 0 |  |
| maxlen139 | Per base sequence quality | 90th Percentile | identical | 74 | 0 |  |
| maxlen139 | Per sequence quality scores | Quality | identical | 10 | 0 |  |
| maxlen139 | Per sequence quality scores | Count | identical | 10 | 0 |  |
| maxlen139 | Per base sequence content | Base | identical | 74 | 0 |  |
| maxlen139 | Per base sequence content | G | identical | 74 | 0 |  |
| maxlen139 | Per base sequence content | A | identical | 74 | 0 |  |
| maxlen139 | Per base sequence content | T | identical | 74 | 0 |  |
| maxlen139 | Per base sequence content | C | identical | 74 | 0 |  |
| maxlen139 | Per base N content | Base | identical | 74 | 0 |  |
| maxlen139 | Per base N content | N-Count | identical | 74 | 0 |  |
| maxlen139 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen139 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen139 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen139 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen139 | Adapter Content | Position | identical | 69 | 0 |  |
| maxlen139 | Adapter Content | Illumina Universal Adapter | identical | 69 | 0 |  |
| maxlen139 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 69 | 0 |  |
| maxlen139 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 69 | 0 |  |
| maxlen139 | Adapter Content | Nextera Transposase Sequence | identical | 69 | 0 |  |
| maxlen139 | Adapter Content | PolyA | identical | 69 | 0 |  |
| maxlen139 | Adapter Content | PolyG | identical | 69 | 0 |  |
| maxlen139 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen139 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen139 | Sequence Length Distribution | Length | identical | 36 | 0 |  |
| maxlen139 | Sequence Length Distribution | Count | identical | 36 | 0 |  |
| maxlen139 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen139 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen139 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen139 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen139 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen139 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen139 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen139 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen140 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen140 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen140 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen140 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen140 | Per base sequence quality | Base | identical | 36 | 0 |  |
| maxlen140 | Per base sequence quality | Mean | identical | 36 | 0 |  |
| maxlen140 | Per base sequence quality | Median | identical | 36 | 0 |  |
| maxlen140 | Per base sequence quality | Lower Quartile | identical | 36 | 0 |  |
| maxlen140 | Per base sequence quality | Upper Quartile | identical | 36 | 0 |  |
| maxlen140 | Per base sequence quality | 10th Percentile | identical | 36 | 0 |  |
| maxlen140 | Per base sequence quality | 90th Percentile | identical | 36 | 0 |  |
| maxlen140 | Per sequence quality scores | Quality | identical | 8 | 0 |  |
| maxlen140 | Per sequence quality scores | Count | identical | 8 | 0 |  |
| maxlen140 | Per base sequence content | Base | identical | 36 | 0 |  |
| maxlen140 | Per base sequence content | G | identical | 36 | 0 |  |
| maxlen140 | Per base sequence content | A | identical | 36 | 0 |  |
| maxlen140 | Per base sequence content | T | identical | 36 | 0 |  |
| maxlen140 | Per base sequence content | C | identical | 36 | 0 |  |
| maxlen140 | Per base N content | Base | identical | 36 | 0 |  |
| maxlen140 | Per base N content | N-Count | identical | 36 | 0 |  |
| maxlen140 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen140 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen140 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen140 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen140 | Adapter Content | Position | identical | 69 | 0 |  |
| maxlen140 | Adapter Content | Illumina Universal Adapter | identical | 69 | 0 |  |
| maxlen140 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 69 | 0 |  |
| maxlen140 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 69 | 0 |  |
| maxlen140 | Adapter Content | Nextera Transposase Sequence | identical | 69 | 0 |  |
| maxlen140 | Adapter Content | PolyA | identical | 69 | 0 |  |
| maxlen140 | Adapter Content | PolyG | identical | 69 | 0 |  |
| maxlen140 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen140 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen140 | Sequence Length Distribution | Length | identical | 36 | 0 |  |
| maxlen140 | Sequence Length Distribution | Count | identical | 36 | 0 |  |
| maxlen140 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen140 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen140 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen140 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen140 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen140 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen140 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen140 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen32509 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen32509 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen32509 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen32509 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen32509 | Per base sequence quality | Base | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence quality | Mean | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence quality | Median | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence quality | Lower Quartile | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence quality | Upper Quartile | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence quality | 10th Percentile | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence quality | 90th Percentile | identical | 75 | 0 |  |
| maxlen32509 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen32509 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen32509 | Per base sequence content | Base | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence content | G | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence content | A | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence content | T | identical | 75 | 0 |  |
| maxlen32509 | Per base sequence content | C | identical | 75 | 0 |  |
| maxlen32509 | Per base N content | Base | identical | 75 | 0 |  |
| maxlen32509 | Per base N content | N-Count | identical | 75 | 0 |  |
| maxlen32509 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen32509 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen32509 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen32509 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen32509 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen32509 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen32509 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen32509 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen32509 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen32509 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen32509 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen32509 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen32509 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen32509 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen32509 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen32509 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen32509 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen32509 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen32509 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen32509 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen32509 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen32509 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen32509 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen32510 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen32510 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen32510 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen32510 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen32510 | Per base sequence quality | Base | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence quality | Mean | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence quality | Median | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence quality | Lower Quartile | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence quality | Upper Quartile | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence quality | 10th Percentile | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence quality | 90th Percentile | identical | 42 | 0 |  |
| maxlen32510 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen32510 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen32510 | Per base sequence content | Base | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence content | G | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence content | A | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence content | T | identical | 42 | 0 |  |
| maxlen32510 | Per base sequence content | C | identical | 42 | 0 |  |
| maxlen32510 | Per base N content | Base | identical | 42 | 0 |  |
| maxlen32510 | Per base N content | N-Count | identical | 42 | 0 |  |
| maxlen32510 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen32510 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen32510 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen32510 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen32510 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen32510 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen32510 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen32510 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen32510 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen32510 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen32510 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen32510 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen32510 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen32510 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen32510 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen32510 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen32510 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen32510 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen32510 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen32510 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen32510 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen32510 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen32510 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen3259 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen3259 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen3259 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen3259 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen3259 | Per base sequence quality | Base | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence quality | Mean | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence quality | Median | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence quality | Lower Quartile | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence quality | Upper Quartile | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence quality | 10th Percentile | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence quality | 90th Percentile | identical | 75 | 0 |  |
| maxlen3259 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen3259 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen3259 | Per base sequence content | Base | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence content | G | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence content | A | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence content | T | identical | 75 | 0 |  |
| maxlen3259 | Per base sequence content | C | identical | 75 | 0 |  |
| maxlen3259 | Per base N content | Base | identical | 75 | 0 |  |
| maxlen3259 | Per base N content | N-Count | identical | 75 | 0 |  |
| maxlen3259 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen3259 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen3259 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen3259 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen3259 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen3259 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen3259 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen3259 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen3259 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen3259 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen3259 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen3259 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen3259 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen3259 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen3259 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen3259 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen3259 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen3259 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen3259 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen3259 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen3259 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen3259 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen3259 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen3260 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen3260 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen3260 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen3260 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen3260 | Per base sequence quality | Base | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence quality | Mean | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence quality | Median | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence quality | Lower Quartile | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence quality | Upper Quartile | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence quality | 10th Percentile | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence quality | 90th Percentile | identical | 42 | 0 |  |
| maxlen3260 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen3260 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen3260 | Per base sequence content | Base | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence content | G | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence content | A | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence content | T | identical | 42 | 0 |  |
| maxlen3260 | Per base sequence content | C | identical | 42 | 0 |  |
| maxlen3260 | Per base N content | Base | identical | 42 | 0 |  |
| maxlen3260 | Per base N content | N-Count | identical | 42 | 0 |  |
| maxlen3260 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen3260 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen3260 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen3260 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen3260 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen3260 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen3260 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen3260 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen3260 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen3260 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen3260 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen3260 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen3260 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen3260 | Sequence Length Distribution | Length | identical | 33 | 0 |  |
| maxlen3260 | Sequence Length Distribution | Count | identical | 33 | 0 |  |
| maxlen3260 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen3260 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen3260 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen3260 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen3260 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen3260 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen3260 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen3260 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen334 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen334 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen334 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen334 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen334 | Per base sequence quality | Base | identical | 74 | 0 |  |
| maxlen334 | Per base sequence quality | Mean | identical | 74 | 0 |  |
| maxlen334 | Per base sequence quality | Median | identical | 74 | 0 |  |
| maxlen334 | Per base sequence quality | Lower Quartile | identical | 74 | 0 |  |
| maxlen334 | Per base sequence quality | Upper Quartile | identical | 74 | 0 |  |
| maxlen334 | Per base sequence quality | 10th Percentile | identical | 74 | 0 |  |
| maxlen334 | Per base sequence quality | 90th Percentile | identical | 74 | 0 |  |
| maxlen334 | Per sequence quality scores | Quality | identical | 5 | 0 |  |
| maxlen334 | Per sequence quality scores | Count | identical | 5 | 0 |  |
| maxlen334 | Per base sequence content | Base | identical | 74 | 0 |  |
| maxlen334 | Per base sequence content | G | identical | 74 | 0 |  |
| maxlen334 | Per base sequence content | A | identical | 74 | 0 |  |
| maxlen334 | Per base sequence content | T | identical | 74 | 0 |  |
| maxlen334 | Per base sequence content | C | identical | 74 | 0 |  |
| maxlen334 | Per base N content | Base | identical | 74 | 0 |  |
| maxlen334 | Per base N content | N-Count | identical | 74 | 0 |  |
| maxlen334 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen334 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen334 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen334 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen334 | Adapter Content | Position | identical | 72 | 0 |  |
| maxlen334 | Adapter Content | Illumina Universal Adapter | identical | 72 | 0 |  |
| maxlen334 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 72 | 0 |  |
| maxlen334 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 72 | 0 |  |
| maxlen334 | Adapter Content | Nextera Transposase Sequence | identical | 72 | 0 |  |
| maxlen334 | Adapter Content | PolyA | identical | 72 | 0 |  |
| maxlen334 | Adapter Content | PolyG | identical | 72 | 0 |  |
| maxlen334 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen334 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen334 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen334 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen334 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen334 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen334 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen334 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen334 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen334 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen334 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen334 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen335 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen335 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen335 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen335 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen335 | Per base sequence quality | Base | identical | 42 | 0 |  |
| maxlen335 | Per base sequence quality | Mean | identical | 42 | 0 |  |
| maxlen335 | Per base sequence quality | Median | identical | 42 | 0 |  |
| maxlen335 | Per base sequence quality | Lower Quartile | identical | 42 | 0 |  |
| maxlen335 | Per base sequence quality | Upper Quartile | identical | 42 | 0 |  |
| maxlen335 | Per base sequence quality | 10th Percentile | identical | 42 | 0 |  |
| maxlen335 | Per base sequence quality | 90th Percentile | identical | 42 | 0 |  |
| maxlen335 | Per sequence quality scores | Quality | identical | 5 | 0 |  |
| maxlen335 | Per sequence quality scores | Count | identical | 5 | 0 |  |
| maxlen335 | Per base sequence content | Base | identical | 42 | 0 |  |
| maxlen335 | Per base sequence content | G | identical | 42 | 0 |  |
| maxlen335 | Per base sequence content | A | identical | 42 | 0 |  |
| maxlen335 | Per base sequence content | T | identical | 42 | 0 |  |
| maxlen335 | Per base sequence content | C | identical | 42 | 0 |  |
| maxlen335 | Per base N content | Base | identical | 42 | 0 |  |
| maxlen335 | Per base N content | N-Count | identical | 42 | 0 |  |
| maxlen335 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen335 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen335 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen335 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen335 | Adapter Content | Position | identical | 72 | 0 |  |
| maxlen335 | Adapter Content | Illumina Universal Adapter | identical | 72 | 0 |  |
| maxlen335 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 72 | 0 |  |
| maxlen335 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 72 | 0 |  |
| maxlen335 | Adapter Content | Nextera Transposase Sequence | identical | 72 | 0 |  |
| maxlen335 | Adapter Content | PolyA | identical | 72 | 0 |  |
| maxlen335 | Adapter Content | PolyG | identical | 72 | 0 |  |
| maxlen335 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen335 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen335 | Sequence Length Distribution | Length | identical | 35 | 0 |  |
| maxlen335 | Sequence Length Distribution | Count | identical | 35 | 0 |  |
| maxlen335 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen335 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen335 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen335 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen335 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen335 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen335 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen335 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen65009 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen65009 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen65009 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen65009 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen65009 | Per base sequence quality | Base | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence quality | Mean | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence quality | Median | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence quality | Lower Quartile | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence quality | Upper Quartile | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence quality | 10th Percentile | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence quality | 90th Percentile | identical | 75 | 0 |  |
| maxlen65009 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen65009 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen65009 | Per base sequence content | Base | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence content | G | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence content | A | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence content | T | identical | 75 | 0 |  |
| maxlen65009 | Per base sequence content | C | identical | 75 | 0 |  |
| maxlen65009 | Per base N content | Base | identical | 75 | 0 |  |
| maxlen65009 | Per base N content | N-Count | identical | 75 | 0 |  |
| maxlen65009 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen65009 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen65009 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen65009 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen65009 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen65009 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen65009 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen65009 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen65009 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen65009 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen65009 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen65009 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen65009 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen65009 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen65009 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen65009 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen65009 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen65009 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen65009 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen65009 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen65009 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen65009 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen65009 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen65010 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen65010 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen65010 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen65010 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen65010 | Per base sequence quality | Base | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence quality | Mean | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence quality | Median | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence quality | Lower Quartile | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence quality | Upper Quartile | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence quality | 10th Percentile | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence quality | 90th Percentile | identical | 42 | 0 |  |
| maxlen65010 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen65010 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen65010 | Per base sequence content | Base | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence content | G | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence content | A | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence content | T | identical | 42 | 0 |  |
| maxlen65010 | Per base sequence content | C | identical | 42 | 0 |  |
| maxlen65010 | Per base N content | Base | identical | 42 | 0 |  |
| maxlen65010 | Per base N content | N-Count | identical | 42 | 0 |  |
| maxlen65010 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen65010 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen65010 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen65010 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen65010 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen65010 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen65010 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen65010 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen65010 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen65010 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen65010 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen65010 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen65010 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen65010 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen65010 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen65010 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen65010 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen65010 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen65010 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen65010 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen65010 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen65010 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen65010 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen6509 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen6509 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen6509 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen6509 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen6509 | Per base sequence quality | Base | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence quality | Mean | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence quality | Median | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence quality | Lower Quartile | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence quality | Upper Quartile | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence quality | 10th Percentile | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence quality | 90th Percentile | identical | 75 | 0 |  |
| maxlen6509 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen6509 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen6509 | Per base sequence content | Base | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence content | G | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence content | A | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence content | T | identical | 75 | 0 |  |
| maxlen6509 | Per base sequence content | C | identical | 75 | 0 |  |
| maxlen6509 | Per base N content | Base | identical | 75 | 0 |  |
| maxlen6509 | Per base N content | N-Count | identical | 75 | 0 |  |
| maxlen6509 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen6509 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen6509 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen6509 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen6509 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen6509 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen6509 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen6509 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen6509 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen6509 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen6509 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen6509 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen6509 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen6509 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen6509 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen6509 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen6509 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen6509 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen6509 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen6509 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen6509 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen6509 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen6509 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen6510 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen6510 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen6510 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen6510 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen6510 | Per base sequence quality | Base | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence quality | Mean | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence quality | Median | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence quality | Lower Quartile | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence quality | Upper Quartile | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence quality | 10th Percentile | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence quality | 90th Percentile | identical | 42 | 0 |  |
| maxlen6510 | Per sequence quality scores | Quality | identical | 2 | 0 |  |
| maxlen6510 | Per sequence quality scores | Count | identical | 2 | 0 |  |
| maxlen6510 | Per base sequence content | Base | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence content | G | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence content | A | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence content | T | identical | 42 | 0 |  |
| maxlen6510 | Per base sequence content | C | identical | 42 | 0 |  |
| maxlen6510 | Per base N content | Base | identical | 42 | 0 |  |
| maxlen6510 | Per base N content | N-Count | identical | 42 | 0 |  |
| maxlen6510 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen6510 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen6510 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen6510 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen6510 | Adapter Content | Position | identical | 74 | 0 |  |
| maxlen6510 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| maxlen6510 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| maxlen6510 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| maxlen6510 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| maxlen6510 | Adapter Content | PolyA | identical | 74 | 0 |  |
| maxlen6510 | Adapter Content | PolyG | identical | 74 | 0 |  |
| maxlen6510 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen6510 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen6510 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen6510 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen6510 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen6510 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen6510 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen6510 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen6510 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen6510 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen6510 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen6510 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen659 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen659 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen659 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen659 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen659 | Per base sequence quality | Base | identical | 74 | 0 |  |
| maxlen659 | Per base sequence quality | Mean | identical | 74 | 0 |  |
| maxlen659 | Per base sequence quality | Median | identical | 74 | 0 |  |
| maxlen659 | Per base sequence quality | Lower Quartile | identical | 74 | 0 |  |
| maxlen659 | Per base sequence quality | Upper Quartile | identical | 74 | 0 |  |
| maxlen659 | Per base sequence quality | 10th Percentile | identical | 74 | 0 |  |
| maxlen659 | Per base sequence quality | 90th Percentile | identical | 74 | 0 |  |
| maxlen659 | Per sequence quality scores | Quality | identical | 4 | 0 |  |
| maxlen659 | Per sequence quality scores | Count | identical | 4 | 0 |  |
| maxlen659 | Per base sequence content | Base | identical | 74 | 0 |  |
| maxlen659 | Per base sequence content | G | identical | 74 | 0 |  |
| maxlen659 | Per base sequence content | A | identical | 74 | 0 |  |
| maxlen659 | Per base sequence content | T | identical | 74 | 0 |  |
| maxlen659 | Per base sequence content | C | identical | 74 | 0 |  |
| maxlen659 | Per base N content | Base | identical | 74 | 0 |  |
| maxlen659 | Per base N content | N-Count | identical | 74 | 0 |  |
| maxlen659 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen659 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen659 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen659 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen659 | Adapter Content | Position | identical | 73 | 0 |  |
| maxlen659 | Adapter Content | Illumina Universal Adapter | identical | 73 | 0 |  |
| maxlen659 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 73 | 0 |  |
| maxlen659 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 73 | 0 |  |
| maxlen659 | Adapter Content | Nextera Transposase Sequence | identical | 73 | 0 |  |
| maxlen659 | Adapter Content | PolyA | identical | 73 | 0 |  |
| maxlen659 | Adapter Content | PolyG | identical | 73 | 0 |  |
| maxlen659 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen659 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen659 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen659 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen659 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen659 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen659 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen659 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen659 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen659 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen659 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen659 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen660 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen660 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen660 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen660 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen660 | Per base sequence quality | Base | identical | 43 | 0 |  |
| maxlen660 | Per base sequence quality | Mean | identical | 43 | 0 |  |
| maxlen660 | Per base sequence quality | Median | identical | 43 | 0 |  |
| maxlen660 | Per base sequence quality | Lower Quartile | identical | 43 | 0 |  |
| maxlen660 | Per base sequence quality | Upper Quartile | identical | 43 | 0 |  |
| maxlen660 | Per base sequence quality | 10th Percentile | identical | 43 | 0 |  |
| maxlen660 | Per base sequence quality | 90th Percentile | identical | 43 | 0 |  |
| maxlen660 | Per sequence quality scores | Quality | identical | 4 | 0 |  |
| maxlen660 | Per sequence quality scores | Count | identical | 4 | 0 |  |
| maxlen660 | Per base sequence content | Base | identical | 43 | 0 |  |
| maxlen660 | Per base sequence content | G | identical | 43 | 0 |  |
| maxlen660 | Per base sequence content | A | identical | 43 | 0 |  |
| maxlen660 | Per base sequence content | T | identical | 43 | 0 |  |
| maxlen660 | Per base sequence content | C | identical | 43 | 0 |  |
| maxlen660 | Per base N content | Base | identical | 43 | 0 |  |
| maxlen660 | Per base N content | N-Count | identical | 43 | 0 |  |
| maxlen660 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen660 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen660 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen660 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen660 | Adapter Content | Position | identical | 73 | 0 |  |
| maxlen660 | Adapter Content | Illumina Universal Adapter | identical | 73 | 0 |  |
| maxlen660 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 73 | 0 |  |
| maxlen660 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 73 | 0 |  |
| maxlen660 | Adapter Content | Nextera Transposase Sequence | identical | 73 | 0 |  |
| maxlen660 | Adapter Content | PolyA | identical | 73 | 0 |  |
| maxlen660 | Adapter Content | PolyG | identical | 73 | 0 |  |
| maxlen660 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen660 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen660 | Sequence Length Distribution | Length | identical | 34 | 0 |  |
| maxlen660 | Sequence Length Distribution | Count | identical | 34 | 0 |  |
| maxlen660 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen660 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen660 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen660 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen660 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen660 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen660 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen660 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen75 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen75 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen75 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen75 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen75 | Per base sequence quality | Base | identical | 75 | 0 |  |
| maxlen75 | Per base sequence quality | Mean | identical | 75 | 0 |  |
| maxlen75 | Per base sequence quality | Median | identical | 75 | 0 |  |
| maxlen75 | Per base sequence quality | Lower Quartile | identical | 75 | 0 |  |
| maxlen75 | Per base sequence quality | Upper Quartile | identical | 75 | 0 |  |
| maxlen75 | Per base sequence quality | 10th Percentile | identical | 75 | 0 |  |
| maxlen75 | Per base sequence quality | 90th Percentile | identical | 75 | 0 |  |
| maxlen75 | Per sequence quality scores | Quality | identical | 8 | 0 |  |
| maxlen75 | Per sequence quality scores | Count | identical | 8 | 0 |  |
| maxlen75 | Per base sequence content | Base | identical | 75 | 0 |  |
| maxlen75 | Per base sequence content | G | identical | 75 | 0 |  |
| maxlen75 | Per base sequence content | A | identical | 75 | 0 |  |
| maxlen75 | Per base sequence content | T | identical | 75 | 0 |  |
| maxlen75 | Per base sequence content | C | identical | 75 | 0 |  |
| maxlen75 | Per base N content | Base | identical | 75 | 0 |  |
| maxlen75 | Per base N content | N-Count | identical | 75 | 0 |  |
| maxlen75 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen75 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen75 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen75 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen75 | Adapter Content | Position | identical | 64 | 0 |  |
| maxlen75 | Adapter Content | Illumina Universal Adapter | identical | 64 | 0 |  |
| maxlen75 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 64 | 0 |  |
| maxlen75 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 64 | 0 |  |
| maxlen75 | Adapter Content | Nextera Transposase Sequence | identical | 64 | 0 |  |
| maxlen75 | Adapter Content | PolyA | identical | 64 | 0 |  |
| maxlen75 | Adapter Content | PolyG | identical | 64 | 0 |  |
| maxlen75 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen75 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen75 | Sequence Length Distribution | Length | identical | 39 | 0 |  |
| maxlen75 | Sequence Length Distribution | Count | identical | 39 | 0 |  |
| maxlen75 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen75 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen75 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen75 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen75 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen75 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen75 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen75 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| maxlen76 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| maxlen76 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| maxlen76 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| maxlen76 | Basic Statistics | %GC | identical | 1 | 0 |  |
| maxlen76 | Per base sequence quality | Base | identical | 43 | 0 |  |
| maxlen76 | Per base sequence quality | Mean | identical | 43 | 0 |  |
| maxlen76 | Per base sequence quality | Median | identical | 43 | 0 |  |
| maxlen76 | Per base sequence quality | Lower Quartile | identical | 43 | 0 |  |
| maxlen76 | Per base sequence quality | Upper Quartile | identical | 43 | 0 |  |
| maxlen76 | Per base sequence quality | 10th Percentile | identical | 43 | 0 |  |
| maxlen76 | Per base sequence quality | 90th Percentile | identical | 43 | 0 |  |
| maxlen76 | Per sequence quality scores | Quality | identical | 10 | 0 |  |
| maxlen76 | Per sequence quality scores | Count | identical | 10 | 0 |  |
| maxlen76 | Per base sequence content | Base | identical | 43 | 0 |  |
| maxlen76 | Per base sequence content | G | identical | 43 | 0 |  |
| maxlen76 | Per base sequence content | A | identical | 43 | 0 |  |
| maxlen76 | Per base sequence content | T | identical | 43 | 0 |  |
| maxlen76 | Per base sequence content | C | identical | 43 | 0 |  |
| maxlen76 | Per base N content | Base | identical | 43 | 0 |  |
| maxlen76 | Per base N content | N-Count | identical | 43 | 0 |  |
| maxlen76 | Overrepresented sequences | Sequence | identical | 150 | 0 |  |
| maxlen76 | Overrepresented sequences | Count | identical | 150 | 0 |  |
| maxlen76 | Overrepresented sequences | Percentage | identical | 150 | 0 |  |
| maxlen76 | Overrepresented sequences | Possible Source | identical | 150 | 0 |  |
| maxlen76 | Adapter Content | Position | identical | 65 | 0 |  |
| maxlen76 | Adapter Content | Illumina Universal Adapter | identical | 65 | 0 |  |
| maxlen76 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 65 | 0 |  |
| maxlen76 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 65 | 0 |  |
| maxlen76 | Adapter Content | Nextera Transposase Sequence | identical | 65 | 0 |  |
| maxlen76 | Adapter Content | PolyA | identical | 65 | 0 |  |
| maxlen76 | Adapter Content | PolyG | identical | 65 | 0 |  |
| maxlen76 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| maxlen76 | Per sequence GC content | Count | identical | 101 | 0 |  |
| maxlen76 | Sequence Length Distribution | Length | identical | 39 | 0 |  |
| maxlen76 | Sequence Length Distribution | Count | identical | 39 | 0 |  |
| maxlen76 | Basic Statistics | flag | identical | 1 | 0 |  |
| maxlen76 | Per base sequence quality | flag | identical | 1 | 0 |  |
| maxlen76 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| maxlen76 | Per base sequence content | flag | identical | 1 | 0 |  |
| maxlen76 | Per base N content | flag | identical | 1 | 0 |  |
| maxlen76 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| maxlen76 | Adapter Content | flag | identical | 1 | 0 |  |
| maxlen76 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b2_content | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b2_content | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b2_content | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b2_content | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b2_content | Per base sequence quality | Base | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence quality | Mean | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence quality | Median | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence quality | Lower Quartile | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence quality | Upper Quartile | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence quality | 10th Percentile | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence quality | 90th Percentile | identical | 2 | 0 |  |
| fqc_b2_content | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b2_content | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b2_content | Per base sequence content | Base | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence content | G | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence content | A | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence content | T | identical | 2 | 0 |  |
| fqc_b2_content | Per base sequence content | C | identical | 2 | 0 |  |
| fqc_b2_content | Per base N content | Base | identical | 2 | 0 |  |
| fqc_b2_content | Per base N content | N-Count | identical | 2 | 0 |  |
| fqc_b2_content | Overrepresented sequences | Sequence | identical | 4 | 0 |  |
| fqc_b2_content | Overrepresented sequences | Count | identical | 4 | 0 |  |
| fqc_b2_content | Overrepresented sequences | Percentage | identical | 4 | 0 |  |
| fqc_b2_content | Overrepresented sequences | Possible Source | identical | 4 | 0 |  |
| fqc_b2_content | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b2_content | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b2_content | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b2_content | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b2_content | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b2_content | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b2_content | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b2_content | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b2_content | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b2_content | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b2_content | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b2_content | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b2_content | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b2_content | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b2_content | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b2_content | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b2_content | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b2_content | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b2_content | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b2_group | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b2_group | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b2_group | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b2_group | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b2_group | Per base sequence quality | Base | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence quality | Mean | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence quality | Median | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence quality | Lower Quartile | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence quality | Upper Quartile | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence quality | 10th Percentile | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence quality | 90th Percentile | identical | 45 | 0 |  |
| fqc_b2_group | Per sequence quality scores | Quality | identical | 4 | 0 |  |
| fqc_b2_group | Per sequence quality scores | Count | identical | 4 | 0 |  |
| fqc_b2_group | Per base sequence content | Base | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence content | G | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence content | A | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence content | T | identical | 45 | 0 |  |
| fqc_b2_group | Per base sequence content | C | identical | 45 | 0 |  |
| fqc_b2_group | Per base N content | Base | identical | 45 | 0 |  |
| fqc_b2_group | Per base N content | N-Count | identical | 45 | 0 |  |
| fqc_b2_group | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b2_group | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b2_group | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b2_group | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b2_group | Adapter Content | Position | identical | 69 | 0 |  |
| fqc_b2_group | Adapter Content | Illumina Universal Adapter | identical | 69 | 0 |  |
| fqc_b2_group | Adapter Content | Illumina Small RNA 3' Adapter | identical | 69 | 0 |  |
| fqc_b2_group | Adapter Content | Illumina Small RNA 5' Adapter | identical | 69 | 0 |  |
| fqc_b2_group | Adapter Content | Nextera Transposase Sequence | identical | 69 | 0 |  |
| fqc_b2_group | Adapter Content | PolyA | identical | 69 | 0 |  |
| fqc_b2_group | Adapter Content | PolyG | identical | 69 | 0 |  |
| fqc_b2_group | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b2_group | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b2_group | Sequence Length Distribution | Length | identical | 36 | 0 |  |
| fqc_b2_group | Sequence Length Distribution | Count | identical | 36 | 0 |  |
| fqc_b2_group | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b2_group | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b2_group | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b2_group | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b2_group | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b2_group | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b2_group | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b2_group | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b2_groupn | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b2_groupn | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b2_groupn | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b2_groupn | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b2_groupn | Per base sequence quality | Base | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence quality | Mean | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence quality | Median | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence quality | Lower Quartile | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence quality | Upper Quartile | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence quality | 10th Percentile | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence quality | 90th Percentile | identical | 45 | 0 |  |
| fqc_b2_groupn | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b2_groupn | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b2_groupn | Per base sequence content | Base | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence content | G | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence content | A | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence content | T | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base sequence content | C | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base N content | Base | identical | 45 | 0 |  |
| fqc_b2_groupn | Per base N content | N-Count | identical | 45 | 0 |  |
| fqc_b2_groupn | Overrepresented sequences | Sequence | identical | 3 | 0 |  |
| fqc_b2_groupn | Overrepresented sequences | Count | identical | 3 | 0 |  |
| fqc_b2_groupn | Overrepresented sequences | Percentage | identical | 3 | 0 |  |
| fqc_b2_groupn | Overrepresented sequences | Possible Source | identical | 3 | 0 |  |
| fqc_b2_groupn | Adapter Content | Position | identical | 69 | 0 |  |
| fqc_b2_groupn | Adapter Content | Illumina Universal Adapter | identical | 69 | 0 |  |
| fqc_b2_groupn | Adapter Content | Illumina Small RNA 3' Adapter | identical | 69 | 0 |  |
| fqc_b2_groupn | Adapter Content | Illumina Small RNA 5' Adapter | identical | 69 | 0 |  |
| fqc_b2_groupn | Adapter Content | Nextera Transposase Sequence | identical | 69 | 0 |  |
| fqc_b2_groupn | Adapter Content | PolyA | identical | 69 | 0 |  |
| fqc_b2_groupn | Adapter Content | PolyG | identical | 69 | 0 |  |
| fqc_b2_groupn | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b2_groupn | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b2_groupn | Sequence Length Distribution | Length | identical | 36 | 0 |  |
| fqc_b2_groupn | Sequence Length Distribution | Count | identical | 36 | 0 |  |
| fqc_b2_groupn | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b2_groupn | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b2_groupn | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b2_groupn | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b2_groupn | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b2_groupn | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b2_groupn | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b2_groupn | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b2_seqq | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b2_seqq | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b2_seqq | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b2_seqq | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b2_seqq | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b2_seqq | Per sequence quality scores | Quality | identical | 40 | 0 |  |
| fqc_b2_seqq | Per sequence quality scores | Count | identical | 40 | 0 |  |
| fqc_b2_seqq | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b2_seqq | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b2_seqq | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b2_seqq | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b2_seqq | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b2_seqq | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b2_seqq | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b2_seqq | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b2_seqq | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b2_seqq | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b2_seqq | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b2_seqq | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b2_seqq | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b2_seqq | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b2_seqq | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b2_seqq | Sequence Length Distribution | Length | identical | 3 | 0 |  |
| fqc_b2_seqq | Sequence Length Distribution | Count | identical | 3 | 0 |  |
| fqc_b2_seqq | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b2_seqq | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b2_seqq | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b2_seqq | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b2_seqq | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b2_seqq | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b2_seqq | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b2_seqq | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b3_enc_59 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b3_enc_59 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_59 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_59 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_59 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b3_enc_59 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b3_enc_59 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b3_enc_59 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_enc_59 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_enc_59 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_59 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b3_enc_63 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b3_enc_63 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_63 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_63 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_63 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b3_enc_63 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b3_enc_63 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b3_enc_63 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_enc_63 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_enc_63 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_63 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b3_enc_64 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b3_enc_64 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_64 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_64 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_64 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b3_enc_64 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b3_enc_64 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b3_enc_64 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_enc_64 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_enc_64 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_64 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b3_enc_65 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b3_enc_65 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_65 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_65 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_65 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b3_enc_65 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b3_enc_65 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b3_enc_65 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_enc_65 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_enc_65 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_65 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b3_enc_66 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b3_enc_66 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_66 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_66 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_66 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b3_enc_66 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b3_enc_66 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b3_enc_66 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_enc_66 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_enc_66 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_66 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b3_enc_74 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b3_enc_74 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_74 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_74 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b3_enc_74 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b3_enc_74 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b3_enc_74 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b3_enc_74 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_enc_74 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_enc_74 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_enc_74 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_len_long | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_len_long | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_len_long | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_len_long | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_len_long | Per base sequence quality | Base | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence quality | Mean | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence quality | Median | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence quality | Lower Quartile | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence quality | Upper Quartile | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence quality | 10th Percentile | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence quality | 90th Percentile | identical | 59 | 0 |  |
| fqc_b3_len_long | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_len_long | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_len_long | Per base sequence content | Base | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence content | G | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence content | A | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence content | T | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base sequence content | C | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base N content | Base | identical | 59 | 0 |  |
| fqc_b3_len_long | Per base N content | N-Count | identical | 59 | 0 |  |
| fqc_b3_len_long | Overrepresented sequences | Sequence | identical | 7 | 0 |  |
| fqc_b3_len_long | Overrepresented sequences | Count | identical | 7 | 0 |  |
| fqc_b3_len_long | Overrepresented sequences | Percentage | identical | 7 | 0 |  |
| fqc_b3_len_long | Overrepresented sequences | Possible Source | identical | 7 | 0 |  |
| fqc_b3_len_long | Adapter Content | Position | identical | 59 | 0 |  |
| fqc_b3_len_long | Adapter Content | Illumina Universal Adapter | identical | 59 | 0 |  |
| fqc_b3_len_long | Adapter Content | Illumina Small RNA 3' Adapter | identical | 59 | 0 |  |
| fqc_b3_len_long | Adapter Content | Illumina Small RNA 5' Adapter | identical | 59 | 0 |  |
| fqc_b3_len_long | Adapter Content | Nextera Transposase Sequence | identical | 59 | 0 |  |
| fqc_b3_len_long | Adapter Content | PolyA | identical | 59 | 0 |  |
| fqc_b3_len_long | Adapter Content | PolyG | identical | 59 | 0 |  |
| fqc_b3_len_long | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_len_long | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_len_long | Sequence Length Distribution | Length | identical | 50 | 0 |  |
| fqc_b3_len_long | Sequence Length Distribution | Count | identical | 50 | 0 |  |
| fqc_b3_len_long | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_len_long | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_len_long | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_len_long | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_len_long | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_len_long | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_len_long | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_len_long | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_len_mid | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_len_mid | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_len_mid | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_len_mid | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_len_mid | Per base sequence quality | Base | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence quality | Mean | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence quality | Median | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence quality | Lower Quartile | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence quality | Upper Quartile | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence quality | 10th Percentile | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence quality | 90th Percentile | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_len_mid | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_len_mid | Per base sequence content | Base | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence content | G | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence content | A | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence content | T | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base sequence content | C | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base N content | Base | identical | 68 | 0 |  |
| fqc_b3_len_mid | Per base N content | N-Count | identical | 68 | 0 |  |
| fqc_b3_len_mid | Overrepresented sequences | Sequence | identical | 19 | 0 |  |
| fqc_b3_len_mid | Overrepresented sequences | Count | identical | 19 | 0 |  |
| fqc_b3_len_mid | Overrepresented sequences | Percentage | identical | 19 | 0 |  |
| fqc_b3_len_mid | Overrepresented sequences | Possible Source | identical | 19 | 0 |  |
| fqc_b3_len_mid | Adapter Content | Position | identical | 65 | 0 |  |
| fqc_b3_len_mid | Adapter Content | Illumina Universal Adapter | identical | 65 | 0 |  |
| fqc_b3_len_mid | Adapter Content | Illumina Small RNA 3' Adapter | identical | 65 | 0 |  |
| fqc_b3_len_mid | Adapter Content | Illumina Small RNA 5' Adapter | identical | 65 | 0 |  |
| fqc_b3_len_mid | Adapter Content | Nextera Transposase Sequence | identical | 65 | 0 |  |
| fqc_b3_len_mid | Adapter Content | PolyA | identical | 65 | 0 |  |
| fqc_b3_len_mid | Adapter Content | PolyG | identical | 65 | 0 |  |
| fqc_b3_len_mid | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_len_mid | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_len_mid | Sequence Length Distribution | Length | identical | 28 | 0 |  |
| fqc_b3_len_mid | Sequence Length Distribution | Count | identical | 28 | 0 |  |
| fqc_b3_len_mid | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_len_mid | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_len_mid | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_len_mid | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_len_mid | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_len_mid | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_len_mid | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_len_mid | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_len_small | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_len_small | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_len_small | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_len_small | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_len_small | Per base sequence quality | Base | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence quality | Mean | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence quality | Median | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| fqc_b3_len_small | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_len_small | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_len_small | Per base sequence content | Base | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence content | G | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence content | A | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence content | T | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base sequence content | C | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base N content | Base | identical | 60 | 0 |  |
| fqc_b3_len_small | Per base N content | N-Count | identical | 60 | 0 |  |
| fqc_b3_len_small | Overrepresented sequences | Sequence | identical | 50 | 0 |  |
| fqc_b3_len_small | Overrepresented sequences | Count | identical | 50 | 0 |  |
| fqc_b3_len_small | Overrepresented sequences | Percentage | identical | 50 | 0 |  |
| fqc_b3_len_small | Overrepresented sequences | Possible Source | identical | 50 | 0 |  |
| fqc_b3_len_small | Adapter Content | Position | identical | 49 | 0 |  |
| fqc_b3_len_small | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| fqc_b3_len_small | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| fqc_b3_len_small | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| fqc_b3_len_small | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| fqc_b3_len_small | Adapter Content | PolyA | identical | 49 | 0 |  |
| fqc_b3_len_small | Adapter Content | PolyG | identical | 49 | 0 |  |
| fqc_b3_len_small | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_len_small | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_len_small | Sequence Length Distribution | Length | identical | 31 | 0 |  |
| fqc_b3_len_small | Sequence Length Distribution | Count | identical | 31 | 0 |  |
| fqc_b3_len_small | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_len_small | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_len_small | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_len_small | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_len_small | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_len_small | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_len_small | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_len_small | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_len_two | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_len_two | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_len_two | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_len_two | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_len_two | Per base sequence quality | Base | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence quality | Mean | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence quality | Median | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| fqc_b3_len_two | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_len_two | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_len_two | Per base sequence content | Base | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence content | G | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence content | A | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence content | T | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base sequence content | C | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base N content | Base | identical | 38 | 0 |  |
| fqc_b3_len_two | Per base N content | N-Count | identical | 38 | 0 |  |
| fqc_b3_len_two | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b3_len_two | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b3_len_two | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b3_len_two | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b3_len_two | Adapter Content | Position | identical | 74 | 0 |  |
| fqc_b3_len_two | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| fqc_b3_len_two | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| fqc_b3_len_two | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| fqc_b3_len_two | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| fqc_b3_len_two | Adapter Content | PolyA | identical | 74 | 0 |  |
| fqc_b3_len_two | Adapter Content | PolyG | identical | 74 | 0 |  |
| fqc_b3_len_two | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_len_two | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_len_two | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| fqc_b3_len_two | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| fqc_b3_len_two | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_len_two | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_len_two | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_len_two | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_len_two | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_len_two | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_len_two | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_len_two | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_nan | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_nan | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_nan | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_nan | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_nan | Per base sequence quality | Base | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence quality | Mean | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence quality | Median | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence quality | Lower Quartile | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence quality | Upper Quartile | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence quality | 10th Percentile | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence quality | 90th Percentile | identical | 45 | 0 |  |
| fqc_b3_nan | Per sequence quality scores | Quality | identical | 5 | 0 |  |
| fqc_b3_nan | Per sequence quality scores | Count | identical | 5 | 0 |  |
| fqc_b3_nan | Per base sequence content | Base | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence content | G | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence content | A | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence content | T | identical | 45 | 0 |  |
| fqc_b3_nan | Per base sequence content | C | identical | 45 | 0 |  |
| fqc_b3_nan | Per base N content | Base | identical | 45 | 0 |  |
| fqc_b3_nan | Per base N content | N-Count | identical | 45 | 0 |  |
| fqc_b3_nan | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b3_nan | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b3_nan | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b3_nan | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b3_nan | Adapter Content | Position | identical | 69 | 0 |  |
| fqc_b3_nan | Adapter Content | Illumina Universal Adapter | identical | 69 | 0 |  |
| fqc_b3_nan | Adapter Content | Illumina Small RNA 3' Adapter | identical | 69 | 0 |  |
| fqc_b3_nan | Adapter Content | Illumina Small RNA 5' Adapter | identical | 69 | 0 |  |
| fqc_b3_nan | Adapter Content | Nextera Transposase Sequence | identical | 69 | 0 |  |
| fqc_b3_nan | Adapter Content | PolyA | identical | 69 | 0 |  |
| fqc_b3_nan | Adapter Content | PolyG | identical | 69 | 0 |  |
| fqc_b3_nan | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_nan | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_nan | Sequence Length Distribution | Length | identical | 36 | 0 |  |
| fqc_b3_nan | Sequence Length Distribution | Count | identical | 36 | 0 |  |
| fqc_b3_nan | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_nan | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_nan | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_nan | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_nan | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_nan | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_nan | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_nan | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b3_u | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b3_u | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b3_u | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b3_u | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b3_u | Per base sequence quality | Base | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence quality | Mean | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence quality | Median | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence quality | Lower Quartile | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence quality | Upper Quartile | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence quality | 10th Percentile | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence quality | 90th Percentile | identical | 3 | 0 |  |
| fqc_b3_u | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b3_u | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b3_u | Per base sequence content | Base | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence content | G | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence content | A | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence content | T | identical | 3 | 0 |  |
| fqc_b3_u | Per base sequence content | C | identical | 3 | 0 |  |
| fqc_b3_u | Per base N content | Base | identical | 3 | 0 |  |
| fqc_b3_u | Per base N content | N-Count | identical | 3 | 0 |  |
| fqc_b3_u | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b3_u | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b3_u | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b3_u | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b3_u | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b3_u | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b3_u | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b3_u | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b3_u | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b3_u | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b3_u | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b3_u | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b3_u | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b3_u | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b3_u | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b3_u | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b3_u | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b3_u | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b3_u | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b3_u | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b3_u | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b3_u | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b3_u | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b7_mode19 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b7_mode19 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b7_mode19 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b7_mode19 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b7_mode19 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per sequence quality scores | Quality | identical | 20 | 0 |  |
| fqc_b7_mode19 | Per sequence quality scores | Count | identical | 20 | 0 |  |
| fqc_b7_mode19 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b7_mode19 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b7_mode19 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b7_mode19 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b7_mode19 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b7_mode19 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b7_mode19 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b7_mode19 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b7_mode19 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode19 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode19 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b7_mode19 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b7_mode19 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b7_mode19 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b7_mode19 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b7_mode19 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b7_mode19 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b7_mode19 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b7_mode19 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b7_mode19 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b7_mode19 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b7_mode19 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b7_mode19 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b7_mode19 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b7_mode19 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b7_mode20 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b7_mode20 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b7_mode20 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b7_mode20 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b7_mode20 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per sequence quality scores | Quality | identical | 21 | 0 |  |
| fqc_b7_mode20 | Per sequence quality scores | Count | identical | 21 | 0 |  |
| fqc_b7_mode20 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b7_mode20 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b7_mode20 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b7_mode20 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b7_mode20 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b7_mode20 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b7_mode20 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b7_mode20 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b7_mode20 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode20 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode20 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b7_mode20 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b7_mode20 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b7_mode20 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b7_mode20 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b7_mode20 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b7_mode20 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b7_mode20 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b7_mode20 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b7_mode20 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b7_mode20 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b7_mode20 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b7_mode20 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b7_mode20 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b7_mode20 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b7_mode21 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b7_mode21 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b7_mode21 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b7_mode21 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b7_mode21 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per sequence quality scores | Quality | identical | 22 | 0 |  |
| fqc_b7_mode21 | Per sequence quality scores | Count | identical | 22 | 0 |  |
| fqc_b7_mode21 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b7_mode21 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b7_mode21 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b7_mode21 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b7_mode21 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b7_mode21 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b7_mode21 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b7_mode21 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b7_mode21 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode21 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode21 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b7_mode21 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b7_mode21 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b7_mode21 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b7_mode21 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b7_mode21 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b7_mode21 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b7_mode21 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b7_mode21 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b7_mode21 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b7_mode21 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b7_mode21 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b7_mode21 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b7_mode21 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b7_mode21 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b7_mode26 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b7_mode26 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b7_mode26 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b7_mode26 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b7_mode26 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per sequence quality scores | Quality | identical | 27 | 0 |  |
| fqc_b7_mode26 | Per sequence quality scores | Count | identical | 27 | 0 |  |
| fqc_b7_mode26 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b7_mode26 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b7_mode26 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b7_mode26 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b7_mode26 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b7_mode26 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b7_mode26 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b7_mode26 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b7_mode26 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode26 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode26 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b7_mode26 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b7_mode26 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b7_mode26 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b7_mode26 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b7_mode26 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b7_mode26 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b7_mode26 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b7_mode26 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b7_mode26 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b7_mode26 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b7_mode26 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b7_mode26 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b7_mode26 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b7_mode26 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b7_mode27 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b7_mode27 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b7_mode27 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b7_mode27 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b7_mode27 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per sequence quality scores | Quality | identical | 28 | 0 |  |
| fqc_b7_mode27 | Per sequence quality scores | Count | identical | 28 | 0 |  |
| fqc_b7_mode27 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b7_mode27 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b7_mode27 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b7_mode27 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b7_mode27 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b7_mode27 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b7_mode27 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b7_mode27 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b7_mode27 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode27 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode27 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b7_mode27 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b7_mode27 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b7_mode27 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b7_mode27 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b7_mode27 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b7_mode27 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b7_mode27 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b7_mode27 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b7_mode27 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b7_mode27 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b7_mode27 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b7_mode27 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b7_mode27 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b7_mode27 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b7_mode28 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b7_mode28 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b7_mode28 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b7_mode28 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b7_mode28 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per sequence quality scores | Quality | identical | 29 | 0 |  |
| fqc_b7_mode28 | Per sequence quality scores | Count | identical | 29 | 0 |  |
| fqc_b7_mode28 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b7_mode28 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b7_mode28 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b7_mode28 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b7_mode28 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b7_mode28 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b7_mode28 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b7_mode28 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b7_mode28 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode28 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b7_mode28 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b7_mode28 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b7_mode28 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b7_mode28 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b7_mode28 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b7_mode28 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b7_mode28 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b7_mode28 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b7_mode28 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b7_mode28 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b7_mode28 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b7_mode28 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b7_mode28 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b7_mode28 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b7_mode28 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Overrepresented sequences | Sequence | identical | 4 | 0 |  |
| fqc_b8_ct10_100 | Overrepresented sequences | Count | identical | 4 | 0 |  |
| fqc_b8_ct10_100 | Overrepresented sequences | Percentage | identical | 4 | 0 |  |
| fqc_b8_ct10_100 | Overrepresented sequences | Possible Source | identical | 4 | 0 |  |
| fqc_b8_ct10_100 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_ct10_100 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_ct10_100 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct10_100 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct10_100 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_ct10_100 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_ct10_100 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_ct10_100 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_ct10_100 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_ct10_100 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_100 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Overrepresented sequences | Sequence | identical | 4 | 0 |  |
| fqc_b8_ct10_200 | Overrepresented sequences | Count | identical | 4 | 0 |  |
| fqc_b8_ct10_200 | Overrepresented sequences | Percentage | identical | 4 | 0 |  |
| fqc_b8_ct10_200 | Overrepresented sequences | Possible Source | identical | 4 | 0 |  |
| fqc_b8_ct10_200 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_ct10_200 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_ct10_200 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct10_200 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct10_200 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_ct10_200 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_ct10_200 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_ct10_200 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_ct10_200 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_ct10_200 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_200 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Overrepresented sequences | Sequence | identical | 4 | 0 |  |
| fqc_b8_ct10_40 | Overrepresented sequences | Count | identical | 4 | 0 |  |
| fqc_b8_ct10_40 | Overrepresented sequences | Percentage | identical | 4 | 0 |  |
| fqc_b8_ct10_40 | Overrepresented sequences | Possible Source | identical | 4 | 0 |  |
| fqc_b8_ct10_40 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_ct10_40 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_ct10_40 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct10_40 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct10_40 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_ct10_40 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_ct10_40 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_ct10_40 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_ct10_40 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_ct10_40 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_ct10_40 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Overrepresented sequences | Sequence | identical | 4 | 0 |  |
| fqc_b8_ct20_100 | Overrepresented sequences | Count | identical | 4 | 0 |  |
| fqc_b8_ct20_100 | Overrepresented sequences | Percentage | identical | 4 | 0 |  |
| fqc_b8_ct20_100 | Overrepresented sequences | Possible Source | identical | 4 | 0 |  |
| fqc_b8_ct20_100 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_ct20_100 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_ct20_100 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct20_100 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct20_100 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_ct20_100 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_ct20_100 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_ct20_100 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_ct20_100 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_ct20_100 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_100 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Overrepresented sequences | Sequence | identical | 4 | 0 |  |
| fqc_b8_ct20_200 | Overrepresented sequences | Count | identical | 4 | 0 |  |
| fqc_b8_ct20_200 | Overrepresented sequences | Percentage | identical | 4 | 0 |  |
| fqc_b8_ct20_200 | Overrepresented sequences | Possible Source | identical | 4 | 0 |  |
| fqc_b8_ct20_200 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_ct20_200 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_ct20_200 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct20_200 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_ct20_200 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_ct20_200 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_ct20_200 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_ct20_200 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_ct20_200 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_ct20_200 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_ct20_200 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_lq10 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_lq10 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_lq10 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_lq10 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_lq10 | Per base sequence quality | Base | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence quality | Mean | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence quality | Median | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence quality | Lower Quartile | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence quality | Upper Quartile | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence quality | 10th Percentile | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence quality | 90th Percentile | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per sequence quality scores | Quality | identical | 11 | 0 |  |
| fqc_b8_lq10 | Per sequence quality scores | Count | identical | 11 | 0 |  |
| fqc_b8_lq10 | Per base sequence content | Base | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence content | G | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence content | A | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence content | T | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base sequence content | C | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base N content | Base | identical | 2 | 0 |  |
| fqc_b8_lq10 | Per base N content | N-Count | identical | 2 | 0 |  |
| fqc_b8_lq10 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b8_lq10 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b8_lq10 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b8_lq10 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b8_lq10 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_lq10 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_lq10 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_lq10 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_lq10 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_lq10 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_lq10 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_lq10 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_lq10 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_lq10 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_lq10 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_lq10 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_lq10 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_lq10 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_lq10 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_lq10 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_lq10 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_lq10 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_lq10 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_lq11 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_lq11 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_lq11 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_lq11 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_lq11 | Per base sequence quality | Base | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence quality | Mean | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence quality | Median | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence quality | Lower Quartile | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence quality | Upper Quartile | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence quality | 10th Percentile | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence quality | 90th Percentile | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per sequence quality scores | Quality | identical | 11 | 0 |  |
| fqc_b8_lq11 | Per sequence quality scores | Count | identical | 11 | 0 |  |
| fqc_b8_lq11 | Per base sequence content | Base | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence content | G | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence content | A | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence content | T | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base sequence content | C | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base N content | Base | identical | 2 | 0 |  |
| fqc_b8_lq11 | Per base N content | N-Count | identical | 2 | 0 |  |
| fqc_b8_lq11 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b8_lq11 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b8_lq11 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b8_lq11 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b8_lq11 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_lq11 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_lq11 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_lq11 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_lq11 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_lq11 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_lq11 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_lq11 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_lq11 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_lq11 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_lq11 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_lq11 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_lq11 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_lq11 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_lq11 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_lq11 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_lq11 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_lq11 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_lq11 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_lq5 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_lq5 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_lq5 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_lq5 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_lq5 | Per base sequence quality | Base | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence quality | Mean | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence quality | Median | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence quality | Lower Quartile | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence quality | Upper Quartile | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence quality | 10th Percentile | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence quality | 90th Percentile | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per sequence quality scores | Quality | identical | 14 | 0 |  |
| fqc_b8_lq5 | Per sequence quality scores | Count | identical | 14 | 0 |  |
| fqc_b8_lq5 | Per base sequence content | Base | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence content | G | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence content | A | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence content | T | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base sequence content | C | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base N content | Base | identical | 2 | 0 |  |
| fqc_b8_lq5 | Per base N content | N-Count | identical | 2 | 0 |  |
| fqc_b8_lq5 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b8_lq5 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b8_lq5 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b8_lq5 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b8_lq5 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_lq5 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_lq5 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_lq5 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_lq5 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_lq5 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_lq5 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_lq5 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_lq5 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_lq5 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_lq5 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_lq5 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_lq5 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_lq5 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_lq5 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_lq5 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_lq5 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_lq5 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_lq5 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_lq6 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_lq6 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_lq6 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_lq6 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_lq6 | Per base sequence quality | Base | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence quality | Mean | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence quality | Median | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence quality | Lower Quartile | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence quality | Upper Quartile | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence quality | 10th Percentile | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence quality | 90th Percentile | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per sequence quality scores | Quality | identical | 13 | 0 |  |
| fqc_b8_lq6 | Per sequence quality scores | Count | identical | 13 | 0 |  |
| fqc_b8_lq6 | Per base sequence content | Base | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence content | G | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence content | A | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence content | T | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base sequence content | C | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base N content | Base | identical | 2 | 0 |  |
| fqc_b8_lq6 | Per base N content | N-Count | identical | 2 | 0 |  |
| fqc_b8_lq6 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b8_lq6 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b8_lq6 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b8_lq6 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b8_lq6 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_lq6 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_lq6 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_lq6 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_lq6 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_lq6 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_lq6 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_lq6 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_lq6 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_lq6 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_lq6 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_lq6 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_lq6 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_lq6 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_lq6 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_lq6 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_lq6 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_lq6 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_lq6 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_med20 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_med20 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_med20 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_med20 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_med20 | Per base sequence quality | Base | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence quality | Mean | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence quality | Median | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence quality | Lower Quartile | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence quality | Upper Quartile | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence quality | 10th Percentile | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence quality | 90th Percentile | identical | 2 | 0 |  |
| fqc_b8_med20 | Per sequence quality scores | Quality | identical | 11 | 0 |  |
| fqc_b8_med20 | Per sequence quality scores | Count | identical | 11 | 0 |  |
| fqc_b8_med20 | Per base sequence content | Base | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence content | G | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence content | A | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence content | T | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base sequence content | C | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base N content | Base | identical | 2 | 0 |  |
| fqc_b8_med20 | Per base N content | N-Count | identical | 2 | 0 |  |
| fqc_b8_med20 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b8_med20 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b8_med20 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b8_med20 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b8_med20 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_med20 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_med20 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_med20 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_med20 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_med20 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_med20 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_med20 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_med20 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_med20 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_med20 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_med20 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_med20 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_med20 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_med20 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_med20 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_med20 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_med20 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_med20 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_med21 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_med21 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_med21 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_med21 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_med21 | Per base sequence quality | Base | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence quality | Mean | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence quality | Median | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence quality | Lower Quartile | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence quality | Upper Quartile | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence quality | 10th Percentile | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence quality | 90th Percentile | identical | 2 | 0 |  |
| fqc_b8_med21 | Per sequence quality scores | Quality | identical | 11 | 0 |  |
| fqc_b8_med21 | Per sequence quality scores | Count | identical | 11 | 0 |  |
| fqc_b8_med21 | Per base sequence content | Base | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence content | G | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence content | A | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence content | T | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base sequence content | C | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base N content | Base | identical | 2 | 0 |  |
| fqc_b8_med21 | Per base N content | N-Count | identical | 2 | 0 |  |
| fqc_b8_med21 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b8_med21 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b8_med21 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b8_med21 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b8_med21 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_med21 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_med21 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_med21 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_med21 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_med21 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_med21 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_med21 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_med21 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_med21 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_med21 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_med21 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_med21 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_med21 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_med21 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_med21 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_med21 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_med21 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_med21 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_med25 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_med25 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_med25 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_med25 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_med25 | Per base sequence quality | Base | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence quality | Mean | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence quality | Median | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence quality | Lower Quartile | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence quality | Upper Quartile | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence quality | 10th Percentile | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence quality | 90th Percentile | identical | 2 | 0 |  |
| fqc_b8_med25 | Per sequence quality scores | Quality | identical | 9 | 0 |  |
| fqc_b8_med25 | Per sequence quality scores | Count | identical | 9 | 0 |  |
| fqc_b8_med25 | Per base sequence content | Base | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence content | G | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence content | A | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence content | T | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base sequence content | C | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base N content | Base | identical | 2 | 0 |  |
| fqc_b8_med25 | Per base N content | N-Count | identical | 2 | 0 |  |
| fqc_b8_med25 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b8_med25 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b8_med25 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b8_med25 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b8_med25 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_med25 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_med25 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_med25 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_med25 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_med25 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_med25 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_med25 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_med25 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_med25 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_med25 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_med25 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_med25 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_med25 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_med25 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_med25 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_med25 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_med25 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_med25 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_med26 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_med26 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_med26 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_med26 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_med26 | Per base sequence quality | Base | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence quality | Mean | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence quality | Median | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence quality | Lower Quartile | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence quality | Upper Quartile | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence quality | 10th Percentile | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence quality | 90th Percentile | identical | 2 | 0 |  |
| fqc_b8_med26 | Per sequence quality scores | Quality | identical | 8 | 0 |  |
| fqc_b8_med26 | Per sequence quality scores | Count | identical | 8 | 0 |  |
| fqc_b8_med26 | Per base sequence content | Base | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence content | G | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence content | A | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence content | T | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base sequence content | C | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base N content | Base | identical | 2 | 0 |  |
| fqc_b8_med26 | Per base N content | N-Count | identical | 2 | 0 |  |
| fqc_b8_med26 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b8_med26 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b8_med26 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b8_med26 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b8_med26 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_med26 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_med26 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_med26 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_med26 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_med26 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_med26 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_med26 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_med26 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_med26 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_med26 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_med26 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_med26 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_med26 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_med26 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_med26 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_med26 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_med26 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_med26 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b8_n20_100 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b8_n20_100 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b8_n20_100 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b8_n20_100 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_n20_100 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_n20_100 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_n20_100 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_n20_100 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_n20_100 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_n20_100 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_n20_100 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_n20_100 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_n20_100 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_n20_100 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b8_n20_200 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b8_n20_200 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b8_n20_200 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b8_n20_200 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_n20_200 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_n20_200 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_n20_200 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_n20_200 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_n20_200 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_n20_200 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_n20_200 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_n20_200 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_n20_200 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_n20_200 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b8_n21_100 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b8_n21_100 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b8_n21_100 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b8_n21_100 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_n21_100 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_n21_100 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_n21_100 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_n21_100 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_n21_100 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_n21_100 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_n21_100 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_n21_100 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_n21_100 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_n21_100 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b8_n5_100 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b8_n5_100 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b8_n5_100 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b8_n5_100 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_n5_100 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_n5_100 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_n5_100 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_n5_100 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_n5_100 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_n5_100 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_n5_100 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_n5_100 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_n5_100 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_n5_100 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b8_n5_200 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b8_n5_200 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b8_n5_200 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b8_n5_200 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_n5_200 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_n5_200 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_n5_200 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_n5_200 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_n5_200 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_n5_200 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_n5_200 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_n5_200 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_n5_200 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_n5_200 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence quality | Base | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence quality | Mean | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence quality | Median | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence quality | Lower Quartile | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence quality | Upper Quartile | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence quality | 10th Percentile | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence quality | 90th Percentile | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence content | Base | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence content | G | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence content | A | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence content | T | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence content | C | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base N content | Base | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base N content | N-Count | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| fqc_b8_n6_100 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| fqc_b8_n6_100 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| fqc_b8_n6_100 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| fqc_b8_n6_100 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b8_n6_100 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b8_n6_100 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b8_n6_100 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b8_n6_100 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b8_n6_100 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b8_n6_100 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b8_n6_100 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b8_n6_100 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b8_n6_100 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b8_n6_100 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per sequence quality scores | Quality | identical | 31 | 0 |  |
| fqc_b9_tie15_30 | Per sequence quality scores | Count | identical | 31 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b9_tie15_30 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b9_tie15_30 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b9_tie15_30 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b9_tie15_30 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b9_tie15_30 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b9_tie15_30 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b9_tie15_30 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b9_tie15_30 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b9_tie15_30 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b9_tie15_30 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b9_tie15_30 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per sequence quality scores | Quality | identical | 36 | 0 |  |
| fqc_b9_tie25_35 | Per sequence quality scores | Count | identical | 36 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b9_tie25_35 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b9_tie25_35 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b9_tie25_35 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b9_tie25_35 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b9_tie25_35 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b9_tie25_35 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b9_tie25_35 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b9_tie25_35 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b9_tie25_35 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b9_tie25_35 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b9_tie25_35 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Basic Statistics | %GC | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence quality | Base | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence quality | Mean | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence quality | Median | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence quality | Lower Quartile | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence quality | Upper Quartile | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence quality | 10th Percentile | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence quality | 90th Percentile | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per sequence quality scores | Quality | identical | 31 | 0 |  |
| fqc_b9_tie30_15 | Per sequence quality scores | Count | identical | 31 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence content | Base | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence content | G | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence content | A | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence content | T | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence content | C | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base N content | Base | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Per base N content | N-Count | identical | 4 | 0 |  |
| fqc_b9_tie30_15 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Adapter Content | Position | identical | 0 | 0 |  |
| fqc_b9_tie30_15 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| fqc_b9_tie30_15 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| fqc_b9_tie30_15 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| fqc_b9_tie30_15 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| fqc_b9_tie30_15 | Adapter Content | PolyA | identical | 0 | 0 |  |
| fqc_b9_tie30_15 | Adapter Content | PolyG | identical | 0 | 0 |  |
| fqc_b9_tie30_15 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| fqc_b9_tie30_15 | Per sequence GC content | Count | identical | 101 | 0 |  |
| fqc_b9_tie30_15 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Basic Statistics | flag | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence quality | flag | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Per base sequence content | flag | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Per base N content | flag | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Adapter Content | flag | identical | 1 | 0 |  |
| fqc_b9_tie30_15 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_allN | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_allN | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_allN | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_allN | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_allN | Per base sequence quality | Base | identical | 10 | 0 |  |
| gc2_allN | Per base sequence quality | Mean | identical | 10 | 0 |  |
| gc2_allN | Per base sequence quality | Median | identical | 10 | 0 |  |
| gc2_allN | Per base sequence quality | Lower Quartile | identical | 10 | 0 |  |
| gc2_allN | Per base sequence quality | Upper Quartile | identical | 10 | 0 |  |
| gc2_allN | Per base sequence quality | 10th Percentile | identical | 10 | 0 |  |
| gc2_allN | Per base sequence quality | 90th Percentile | identical | 10 | 0 |  |
| gc2_allN | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_allN | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_allN | Per base sequence content | Base | identical | 10 | 0 |  |
| gc2_allN | Per base sequence content | G | identical | 10 | 0 |  |
| gc2_allN | Per base sequence content | A | identical | 10 | 0 |  |
| gc2_allN | Per base sequence content | T | identical | 10 | 0 |  |
| gc2_allN | Per base sequence content | C | identical | 10 | 0 |  |
| gc2_allN | Per base N content | Base | identical | 10 | 0 |  |
| gc2_allN | Per base N content | N-Count | identical | 10 | 0 |  |
| gc2_allN | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_allN | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_allN | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_allN | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_allN | Adapter Content | Position | identical | 0 | 0 |  |
| gc2_allN | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| gc2_allN | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| gc2_allN | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| gc2_allN | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| gc2_allN | Adapter Content | PolyA | identical | 0 | 0 |  |
| gc2_allN | Adapter Content | PolyG | identical | 0 | 0 |  |
| gc2_allN | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_allN | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_allN | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_allN | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_allN | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_allN | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_allN | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_allN | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_allN | Per base N content | flag | identical | 1 | 0 |  |
| gc2_allN | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_allN | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_allN | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_end150 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_end150 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_end150 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_end150 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_end150 | Per base sequence quality | Base | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence quality | Mean | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence quality | Median | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| gc2_end150 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_end150 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_end150 | Per base sequence content | Base | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence content | G | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence content | A | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence content | T | identical | 38 | 0 |  |
| gc2_end150 | Per base sequence content | C | identical | 38 | 0 |  |
| gc2_end150 | Per base N content | Base | identical | 38 | 0 |  |
| gc2_end150 | Per base N content | N-Count | identical | 38 | 0 |  |
| gc2_end150 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_end150 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_end150 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_end150 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_end150 | Adapter Content | Position | identical | 74 | 0 |  |
| gc2_end150 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| gc2_end150 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| gc2_end150 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| gc2_end150 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| gc2_end150 | Adapter Content | PolyA | identical | 74 | 0 |  |
| gc2_end150 | Adapter Content | PolyG | identical | 74 | 0 |  |
| gc2_end150 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_end150 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_end150 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_end150 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_end150 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_end150 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_end150 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_end150 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_end150 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_end150 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_end150 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_end150 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_first100_30 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_first100_30 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_first100_30 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_first100_30 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_first100_30 | Per base sequence quality | Base | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence quality | Median | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| gc2_first100_30 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_first100_30 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_first100_30 | Per base sequence content | Base | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence content | G | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence content | A | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence content | T | identical | 60 | 0 |  |
| gc2_first100_30 | Per base sequence content | C | identical | 60 | 0 |  |
| gc2_first100_30 | Per base N content | Base | identical | 60 | 0 |  |
| gc2_first100_30 | Per base N content | N-Count | identical | 60 | 0 |  |
| gc2_first100_30 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_first100_30 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_first100_30 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_first100_30 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_first100_30 | Adapter Content | Position | identical | 59 | 0 |  |
| gc2_first100_30 | Adapter Content | Illumina Universal Adapter | identical | 59 | 0 |  |
| gc2_first100_30 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 59 | 0 |  |
| gc2_first100_30 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 59 | 0 |  |
| gc2_first100_30 | Adapter Content | Nextera Transposase Sequence | identical | 59 | 0 |  |
| gc2_first100_30 | Adapter Content | PolyA | identical | 59 | 0 |  |
| gc2_first100_30 | Adapter Content | PolyG | identical | 59 | 0 |  |
| gc2_first100_30 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_first100_30 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_first100_30 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_first100_30 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_first100_30 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_first100_30 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_first100_30 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_first100_30 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_first100_30 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_first100_30 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_first100_30 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_first100_30 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_iupac10 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_iupac10 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_iupac10 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_iupac10 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_iupac10 | Per base sequence quality | Base | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence quality | Mean | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence quality | Median | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence quality | Lower Quartile | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence quality | Upper Quartile | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence quality | 10th Percentile | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence quality | 90th Percentile | identical | 10 | 0 |  |
| gc2_iupac10 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_iupac10 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_iupac10 | Per base sequence content | Base | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence content | G | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence content | A | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence content | T | identical | 10 | 0 |  |
| gc2_iupac10 | Per base sequence content | C | identical | 10 | 0 |  |
| gc2_iupac10 | Per base N content | Base | identical | 10 | 0 |  |
| gc2_iupac10 | Per base N content | N-Count | identical | 10 | 0 |  |
| gc2_iupac10 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_iupac10 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_iupac10 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_iupac10 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_iupac10 | Adapter Content | Position | identical | 0 | 0 |  |
| gc2_iupac10 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| gc2_iupac10 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| gc2_iupac10 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| gc2_iupac10 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| gc2_iupac10 | Adapter Content | PolyA | identical | 0 | 0 |  |
| gc2_iupac10 | Adapter Content | PolyG | identical | 0 | 0 |  |
| gc2_iupac10 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_iupac10 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_iupac10 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_iupac10 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_iupac10 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_iupac10 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_iupac10 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_iupac10 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_iupac10 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_iupac10 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_iupac10 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_iupac10 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_len200_gc100 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_len200_gc100 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_len200_gc100 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_len200_gc100 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_len200_gc100 | Per base sequence quality | Base | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence quality | Mean | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence quality | Median | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence quality | Lower Quartile | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence quality | Upper Quartile | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence quality | 10th Percentile | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence quality | 90th Percentile | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_len200_gc100 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_len200_gc100 | Per base sequence content | Base | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence content | G | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence content | A | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence content | T | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base sequence content | C | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base N content | Base | identical | 48 | 0 |  |
| gc2_len200_gc100 | Per base N content | N-Count | identical | 48 | 0 |  |
| gc2_len200_gc100 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_len200_gc100 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_len200_gc100 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_len200_gc100 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_len200_gc100 | Adapter Content | Position | identical | 45 | 0 |  |
| gc2_len200_gc100 | Adapter Content | Illumina Universal Adapter | identical | 45 | 0 |  |
| gc2_len200_gc100 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 45 | 0 |  |
| gc2_len200_gc100 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 45 | 0 |  |
| gc2_len200_gc100 | Adapter Content | Nextera Transposase Sequence | identical | 45 | 0 |  |
| gc2_len200_gc100 | Adapter Content | PolyA | identical | 45 | 0 |  |
| gc2_len200_gc100 | Adapter Content | PolyG | identical | 45 | 0 |  |
| gc2_len200_gc100 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_len200_gc100 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_len200_gc100 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_len200_gc100 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_len200_gc100 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_len200_gc100 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_len200_gc100 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_len200_gc100 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_len200_gc100 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_len200_gc100 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_len200_gc100 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_len200_gc100 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_len250 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_len250 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_len250 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_len250 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_len250 | Per base sequence quality | Base | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence quality | Mean | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence quality | Median | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence quality | Lower Quartile | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence quality | Upper Quartile | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence quality | 10th Percentile | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence quality | 90th Percentile | identical | 58 | 0 |  |
| gc2_len250 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_len250 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_len250 | Per base sequence content | Base | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence content | G | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence content | A | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence content | T | identical | 58 | 0 |  |
| gc2_len250 | Per base sequence content | C | identical | 58 | 0 |  |
| gc2_len250 | Per base N content | Base | identical | 58 | 0 |  |
| gc2_len250 | Per base N content | N-Count | identical | 58 | 0 |  |
| gc2_len250 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_len250 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_len250 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_len250 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_len250 | Adapter Content | Position | identical | 55 | 0 |  |
| gc2_len250 | Adapter Content | Illumina Universal Adapter | identical | 55 | 0 |  |
| gc2_len250 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 55 | 0 |  |
| gc2_len250 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 55 | 0 |  |
| gc2_len250 | Adapter Content | Nextera Transposase Sequence | identical | 55 | 0 |  |
| gc2_len250 | Adapter Content | PolyA | identical | 55 | 0 |  |
| gc2_len250 | Adapter Content | PolyG | identical | 55 | 0 |  |
| gc2_len250 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_len250 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_len250 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_len250 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_len250 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_len250 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_len250 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_len250 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_len250 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_len250 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_len250 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_len250 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_len99_c33 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_len99_c33 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_len99_c33 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_len99_c33 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_len99_c33 | Per base sequence quality | Base | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence quality | Mean | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence quality | Median | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence quality | Lower Quartile | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence quality | Upper Quartile | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence quality | 10th Percentile | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence quality | 90th Percentile | identical | 54 | 0 |  |
| gc2_len99_c33 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_len99_c33 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_len99_c33 | Per base sequence content | Base | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence content | G | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence content | A | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence content | T | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base sequence content | C | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base N content | Base | identical | 54 | 0 |  |
| gc2_len99_c33 | Per base N content | N-Count | identical | 54 | 0 |  |
| gc2_len99_c33 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_len99_c33 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_len99_c33 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_len99_c33 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_len99_c33 | Adapter Content | Position | identical | 49 | 0 |  |
| gc2_len99_c33 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| gc2_len99_c33 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| gc2_len99_c33 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| gc2_len99_c33 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| gc2_len99_c33 | Adapter Content | PolyA | identical | 49 | 0 |  |
| gc2_len99_c33 | Adapter Content | PolyG | identical | 49 | 0 |  |
| gc2_len99_c33 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_len99_c33 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_len99_c33 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_len99_c33 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_len99_c33 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_len99_c33 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_len99_c33 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_len99_c33 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_len99_c33 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_len99_c33 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_len99_c33 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_len99_c33 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_lower10 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_lower10 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_lower10 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_lower10 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_lower10 | Per base sequence quality | Base | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence quality | Mean | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence quality | Median | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence quality | Lower Quartile | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence quality | Upper Quartile | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence quality | 10th Percentile | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence quality | 90th Percentile | identical | 10 | 0 |  |
| gc2_lower10 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_lower10 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_lower10 | Per base sequence content | Base | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence content | G | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence content | A | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence content | T | identical | 10 | 0 |  |
| gc2_lower10 | Per base sequence content | C | identical | 10 | 0 |  |
| gc2_lower10 | Per base N content | Base | identical | 10 | 0 |  |
| gc2_lower10 | Per base N content | N-Count | identical | 10 | 0 |  |
| gc2_lower10 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_lower10 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_lower10 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_lower10 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_lower10 | Adapter Content | Position | identical | 0 | 0 |  |
| gc2_lower10 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| gc2_lower10 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| gc2_lower10 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| gc2_lower10 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| gc2_lower10 | Adapter Content | PolyA | identical | 0 | 0 |  |
| gc2_lower10 | Adapter Content | PolyG | identical | 0 | 0 |  |
| gc2_lower10 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_lower10 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_lower10 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_lower10 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_lower10 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_lower10 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_lower10 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_lower10 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_lower10 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_lower10 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_lower10 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_lower10 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_mid | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_mid | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_mid | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_mid | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_mid | Per base sequence quality | Base | identical | 38 | 0 |  |
| gc2_mid | Per base sequence quality | Mean | identical | 38 | 0 |  |
| gc2_mid | Per base sequence quality | Median | identical | 38 | 0 |  |
| gc2_mid | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| gc2_mid | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| gc2_mid | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| gc2_mid | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| gc2_mid | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_mid | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_mid | Per base sequence content | Base | identical | 38 | 0 |  |
| gc2_mid | Per base sequence content | G | identical | 38 | 0 |  |
| gc2_mid | Per base sequence content | A | identical | 38 | 0 |  |
| gc2_mid | Per base sequence content | T | identical | 38 | 0 |  |
| gc2_mid | Per base sequence content | C | identical | 38 | 0 |  |
| gc2_mid | Per base N content | Base | identical | 38 | 0 |  |
| gc2_mid | Per base N content | N-Count | identical | 38 | 0 |  |
| gc2_mid | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_mid | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_mid | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_mid | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_mid | Adapter Content | Position | identical | 74 | 0 |  |
| gc2_mid | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| gc2_mid | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| gc2_mid | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| gc2_mid | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| gc2_mid | Adapter Content | PolyA | identical | 74 | 0 |  |
| gc2_mid | Adapter Content | PolyG | identical | 74 | 0 |  |
| gc2_mid | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_mid | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_mid | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_mid | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_mid | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_mid | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_mid | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_mid | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_mid | Per base N content | flag | identical | 1 | 0 |  |
| gc2_mid | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_mid | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_mid | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_n10 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_n10 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_n10 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_n10 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_n10 | Per base sequence quality | Base | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence quality | Mean | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence quality | Median | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence quality | Lower Quartile | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence quality | Upper Quartile | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence quality | 10th Percentile | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence quality | 90th Percentile | identical | 10 | 0 |  |
| gc2_n10 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_n10 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_n10 | Per base sequence content | Base | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence content | G | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence content | A | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence content | T | identical | 10 | 0 |  |
| gc2_n10 | Per base sequence content | C | identical | 10 | 0 |  |
| gc2_n10 | Per base N content | Base | identical | 10 | 0 |  |
| gc2_n10 | Per base N content | N-Count | identical | 10 | 0 |  |
| gc2_n10 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_n10 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_n10 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_n10 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_n10 | Adapter Content | Position | identical | 0 | 0 |  |
| gc2_n10 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| gc2_n10 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| gc2_n10 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| gc2_n10 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| gc2_n10 | Adapter Content | PolyA | identical | 0 | 0 |  |
| gc2_n10 | Adapter Content | PolyG | identical | 0 | 0 |  |
| gc2_n10 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_n10 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_n10 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_n10 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_n10 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_n10 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_n10 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_n10 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_n10 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_n10 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_n10 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_n10 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_n_first | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_n_first | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_n_first | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_n_first | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_n_first | Per base sequence quality | Base | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence quality | Mean | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence quality | Median | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| gc2_n_first | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_n_first | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_n_first | Per base sequence content | Base | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence content | G | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence content | A | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence content | T | identical | 38 | 0 |  |
| gc2_n_first | Per base sequence content | C | identical | 38 | 0 |  |
| gc2_n_first | Per base N content | Base | identical | 38 | 0 |  |
| gc2_n_first | Per base N content | N-Count | identical | 38 | 0 |  |
| gc2_n_first | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_n_first | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_n_first | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_n_first | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_n_first | Adapter Content | Position | identical | 74 | 0 |  |
| gc2_n_first | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| gc2_n_first | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| gc2_n_first | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| gc2_n_first | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| gc2_n_first | Adapter Content | PolyA | identical | 74 | 0 |  |
| gc2_n_first | Adapter Content | PolyG | identical | 74 | 0 |  |
| gc2_n_first | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_n_first | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_n_first | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_n_first | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_n_first | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_n_first | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_n_first | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_n_first | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_n_first | Per base N content | flag | identical | 1 | 0 |  |
| gc2_n_first | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_n_first | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_n_first | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_start150 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_start150 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_start150 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_start150 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_start150 | Per base sequence quality | Base | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence quality | Mean | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence quality | Median | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| gc2_start150 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_start150 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_start150 | Per base sequence content | Base | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence content | G | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence content | A | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence content | T | identical | 38 | 0 |  |
| gc2_start150 | Per base sequence content | C | identical | 38 | 0 |  |
| gc2_start150 | Per base N content | Base | identical | 38 | 0 |  |
| gc2_start150 | Per base N content | N-Count | identical | 38 | 0 |  |
| gc2_start150 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_start150 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_start150 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_start150 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_start150 | Adapter Content | Position | identical | 74 | 0 |  |
| gc2_start150 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| gc2_start150 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| gc2_start150 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| gc2_start150 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| gc2_start150 | Adapter Content | PolyA | identical | 74 | 0 |  |
| gc2_start150 | Adapter Content | PolyG | identical | 74 | 0 |  |
| gc2_start150 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_start150 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_start150 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_start150 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_start150 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_start150 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_start150 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_start150 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_start150 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_start150 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_start150 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_start150 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc2_u10 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc2_u10 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc2_u10 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc2_u10 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc2_u10 | Per base sequence quality | Base | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence quality | Mean | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence quality | Median | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence quality | Lower Quartile | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence quality | Upper Quartile | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence quality | 10th Percentile | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence quality | 90th Percentile | identical | 10 | 0 |  |
| gc2_u10 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc2_u10 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc2_u10 | Per base sequence content | Base | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence content | G | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence content | A | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence content | T | identical | 10 | 0 |  |
| gc2_u10 | Per base sequence content | C | identical | 10 | 0 |  |
| gc2_u10 | Per base N content | Base | identical | 10 | 0 |  |
| gc2_u10 | Per base N content | N-Count | identical | 10 | 0 |  |
| gc2_u10 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc2_u10 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc2_u10 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc2_u10 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc2_u10 | Adapter Content | Position | identical | 0 | 0 |  |
| gc2_u10 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| gc2_u10 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| gc2_u10 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| gc2_u10 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| gc2_u10 | Adapter Content | PolyA | identical | 0 | 0 |  |
| gc2_u10 | Adapter Content | PolyG | identical | 0 | 0 |  |
| gc2_u10 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc2_u10 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc2_u10 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc2_u10 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc2_u10 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc2_u10 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc2_u10 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc2_u10 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc2_u10 | Per base N content | flag | identical | 1 | 0 |  |
| gc2_u10 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc2_u10 | Adapter Content | flag | identical | 1 | 0 |  |
| gc2_u10 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Per base sequence quality | Base | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence quality | Mean | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence quality | Median | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence quality | Lower Quartile | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence quality | Upper Quartile | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence quality | 10th Percentile | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence quality | 90th Percentile | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Per base sequence content | Base | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence content | G | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence content | A | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence content | T | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base sequence content | C | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base N content | Base | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Per base N content | N-Count | identical | 66 | 0 |  |
| gc4_p_2800_2800 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| gc4_p_2800_2800 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| gc4_p_2800_2800 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| gc4_p_2800_2800 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| gc4_p_2800_2800 | Adapter Content | Position | identical | 65 | 0 |  |
| gc4_p_2800_2800 | Adapter Content | Illumina Universal Adapter | identical | 65 | 0 |  |
| gc4_p_2800_2800 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 65 | 0 |  |
| gc4_p_2800_2800 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 65 | 0 |  |
| gc4_p_2800_2800 | Adapter Content | Nextera Transposase Sequence | identical | 65 | 0 |  |
| gc4_p_2800_2800 | Adapter Content | PolyA | identical | 65 | 0 |  |
| gc4_p_2800_2800 | Adapter Content | PolyG | identical | 65 | 0 |  |
| gc4_p_2800_2800 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc4_p_2800_2800 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc4_p_2800_2800 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Per base N content | flag | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Adapter Content | flag | identical | 1 | 0 |  |
| gc4_p_2800_2800 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Per base sequence quality | Base | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence quality | Mean | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence quality | Median | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence quality | Lower Quartile | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence quality | Upper Quartile | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence quality | 10th Percentile | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence quality | 90th Percentile | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Per base sequence content | Base | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence content | G | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence content | A | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence content | T | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base sequence content | C | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base N content | Base | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Per base N content | N-Count | identical | 67 | 0 |  |
| gc4_p_2800_2850 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| gc4_p_2800_2850 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| gc4_p_2800_2850 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| gc4_p_2800_2850 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| gc4_p_2800_2850 | Adapter Content | Position | identical | 66 | 0 |  |
| gc4_p_2800_2850 | Adapter Content | Illumina Universal Adapter | identical | 66 | 0 |  |
| gc4_p_2800_2850 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 66 | 0 |  |
| gc4_p_2800_2850 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 66 | 0 |  |
| gc4_p_2800_2850 | Adapter Content | Nextera Transposase Sequence | identical | 66 | 0 |  |
| gc4_p_2800_2850 | Adapter Content | PolyA | identical | 66 | 0 |  |
| gc4_p_2800_2850 | Adapter Content | PolyG | identical | 66 | 0 |  |
| gc4_p_2800_2850 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc4_p_2800_2850 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc4_p_2800_2850 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| gc4_p_2800_2850 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| gc4_p_2800_2850 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Per base N content | flag | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Adapter Content | flag | identical | 1 | 0 |  |
| gc4_p_2800_2850 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Per base sequence quality | Base | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence quality | Mean | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence quality | Median | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence quality | Lower Quartile | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence quality | Upper Quartile | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence quality | 10th Percentile | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence quality | 90th Percentile | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Per base sequence content | Base | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence content | G | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence content | A | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence content | T | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base sequence content | C | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base N content | Base | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Per base N content | N-Count | identical | 67 | 0 |  |
| gc4_p_2850_2800 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| gc4_p_2850_2800 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| gc4_p_2850_2800 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| gc4_p_2850_2800 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| gc4_p_2850_2800 | Adapter Content | Position | identical | 66 | 0 |  |
| gc4_p_2850_2800 | Adapter Content | Illumina Universal Adapter | identical | 66 | 0 |  |
| gc4_p_2850_2800 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 66 | 0 |  |
| gc4_p_2850_2800 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 66 | 0 |  |
| gc4_p_2850_2800 | Adapter Content | Nextera Transposase Sequence | identical | 66 | 0 |  |
| gc4_p_2850_2800 | Adapter Content | PolyA | identical | 66 | 0 |  |
| gc4_p_2850_2800 | Adapter Content | PolyG | identical | 66 | 0 |  |
| gc4_p_2850_2800 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc4_p_2850_2800 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc4_p_2850_2800 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| gc4_p_2850_2800 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| gc4_p_2850_2800 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Per base N content | flag | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Adapter Content | flag | identical | 1 | 0 |  |
| gc4_p_2850_2800 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc4_s2800 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc4_s2800 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc4_s2800 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc4_s2800 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc4_s2800 | Per base sequence quality | Base | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence quality | Mean | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence quality | Median | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence quality | Lower Quartile | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence quality | Upper Quartile | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence quality | 10th Percentile | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence quality | 90th Percentile | identical | 66 | 0 |  |
| gc4_s2800 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc4_s2800 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc4_s2800 | Per base sequence content | Base | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence content | G | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence content | A | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence content | T | identical | 66 | 0 |  |
| gc4_s2800 | Per base sequence content | C | identical | 66 | 0 |  |
| gc4_s2800 | Per base N content | Base | identical | 66 | 0 |  |
| gc4_s2800 | Per base N content | N-Count | identical | 66 | 0 |  |
| gc4_s2800 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc4_s2800 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc4_s2800 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc4_s2800 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc4_s2800 | Adapter Content | Position | identical | 65 | 0 |  |
| gc4_s2800 | Adapter Content | Illumina Universal Adapter | identical | 65 | 0 |  |
| gc4_s2800 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 65 | 0 |  |
| gc4_s2800 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 65 | 0 |  |
| gc4_s2800 | Adapter Content | Nextera Transposase Sequence | identical | 65 | 0 |  |
| gc4_s2800 | Adapter Content | PolyA | identical | 65 | 0 |  |
| gc4_s2800 | Adapter Content | PolyG | identical | 65 | 0 |  |
| gc4_s2800 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc4_s2800 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc4_s2800 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc4_s2800 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc4_s2800 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc4_s2800 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc4_s2800 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc4_s2800 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc4_s2800 | Per base N content | flag | identical | 1 | 0 |  |
| gc4_s2800 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc4_s2800 | Adapter Content | flag | identical | 1 | 0 |  |
| gc4_s2800 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc4_s2800b | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc4_s2800b | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc4_s2800b | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc4_s2800b | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc4_s2800b | Per base sequence quality | Base | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence quality | Mean | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence quality | Median | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence quality | Lower Quartile | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence quality | Upper Quartile | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence quality | 10th Percentile | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence quality | 90th Percentile | identical | 66 | 0 |  |
| gc4_s2800b | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc4_s2800b | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc4_s2800b | Per base sequence content | Base | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence content | G | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence content | A | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence content | T | identical | 66 | 0 |  |
| gc4_s2800b | Per base sequence content | C | identical | 66 | 0 |  |
| gc4_s2800b | Per base N content | Base | identical | 66 | 0 |  |
| gc4_s2800b | Per base N content | N-Count | identical | 66 | 0 |  |
| gc4_s2800b | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc4_s2800b | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc4_s2800b | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc4_s2800b | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc4_s2800b | Adapter Content | Position | identical | 65 | 0 |  |
| gc4_s2800b | Adapter Content | Illumina Universal Adapter | identical | 65 | 0 |  |
| gc4_s2800b | Adapter Content | Illumina Small RNA 3' Adapter | identical | 65 | 0 |  |
| gc4_s2800b | Adapter Content | Illumina Small RNA 5' Adapter | identical | 65 | 0 |  |
| gc4_s2800b | Adapter Content | Nextera Transposase Sequence | identical | 65 | 0 |  |
| gc4_s2800b | Adapter Content | PolyA | identical | 65 | 0 |  |
| gc4_s2800b | Adapter Content | PolyG | identical | 65 | 0 |  |
| gc4_s2800b | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc4_s2800b | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc4_s2800b | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc4_s2800b | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc4_s2800b | Basic Statistics | flag | identical | 1 | 0 |  |
| gc4_s2800b | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc4_s2800b | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc4_s2800b | Per base sequence content | flag | identical | 1 | 0 |  |
| gc4_s2800b | Per base N content | flag | identical | 1 | 0 |  |
| gc4_s2800b | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc4_s2800b | Adapter Content | flag | identical | 1 | 0 |  |
| gc4_s2800b | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc4_s2850 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc4_s2850 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc4_s2850 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc4_s2850 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc4_s2850 | Per base sequence quality | Base | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence quality | Mean | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence quality | Median | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence quality | Lower Quartile | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence quality | Upper Quartile | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence quality | 10th Percentile | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence quality | 90th Percentile | identical | 67 | 0 |  |
| gc4_s2850 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc4_s2850 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc4_s2850 | Per base sequence content | Base | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence content | G | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence content | A | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence content | T | identical | 67 | 0 |  |
| gc4_s2850 | Per base sequence content | C | identical | 67 | 0 |  |
| gc4_s2850 | Per base N content | Base | identical | 67 | 0 |  |
| gc4_s2850 | Per base N content | N-Count | identical | 67 | 0 |  |
| gc4_s2850 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc4_s2850 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc4_s2850 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc4_s2850 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc4_s2850 | Adapter Content | Position | identical | 66 | 0 |  |
| gc4_s2850 | Adapter Content | Illumina Universal Adapter | identical | 66 | 0 |  |
| gc4_s2850 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 66 | 0 |  |
| gc4_s2850 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 66 | 0 |  |
| gc4_s2850 | Adapter Content | Nextera Transposase Sequence | identical | 66 | 0 |  |
| gc4_s2850 | Adapter Content | PolyA | identical | 66 | 0 |  |
| gc4_s2850 | Adapter Content | PolyG | identical | 66 | 0 |  |
| gc4_s2850 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc4_s2850 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc4_s2850 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc4_s2850 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc4_s2850 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc4_s2850 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc4_s2850 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc4_s2850 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc4_s2850 | Per base N content | flag | identical | 1 | 0 |  |
| gc4_s2850 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc4_s2850 | Adapter Content | flag | identical | 1 | 0 |  |
| gc4_s2850 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc5_L1000 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc5_L1000 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc5_L1000 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc5_L1000 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc5_L1000 | Per base sequence quality | Base | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence quality | Median | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| gc5_L1000 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc5_L1000 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc5_L1000 | Per base sequence content | Base | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence content | G | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence content | A | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence content | T | identical | 60 | 0 |  |
| gc5_L1000 | Per base sequence content | C | identical | 60 | 0 |  |
| gc5_L1000 | Per base N content | Base | identical | 60 | 0 |  |
| gc5_L1000 | Per base N content | N-Count | identical | 60 | 0 |  |
| gc5_L1000 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc5_L1000 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc5_L1000 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc5_L1000 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc5_L1000 | Adapter Content | Position | identical | 59 | 0 |  |
| gc5_L1000 | Adapter Content | Illumina Universal Adapter | identical | 59 | 0 |  |
| gc5_L1000 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 59 | 0 |  |
| gc5_L1000 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 59 | 0 |  |
| gc5_L1000 | Adapter Content | Nextera Transposase Sequence | identical | 59 | 0 |  |
| gc5_L1000 | Adapter Content | PolyA | identical | 59 | 0 |  |
| gc5_L1000 | Adapter Content | PolyG | identical | 59 | 0 |  |
| gc5_L1000 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc5_L1000 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc5_L1000 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc5_L1000 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc5_L1000 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc5_L1000 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc5_L1000 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc5_L1000 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc5_L1000 | Per base N content | flag | identical | 1 | 0 |  |
| gc5_L1000 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc5_L1000 | Adapter Content | flag | identical | 1 | 0 |  |
| gc5_L1000 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc5_L100500 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc5_L100500 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc5_L100500 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc5_L100500 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc5_L100500 | Per base sequence quality | Base | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence quality | Median | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| gc5_L100500 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc5_L100500 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc5_L100500 | Per base sequence content | Base | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence content | G | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence content | A | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence content | T | identical | 60 | 0 |  |
| gc5_L100500 | Per base sequence content | C | identical | 60 | 0 |  |
| gc5_L100500 | Per base N content | Base | identical | 60 | 0 |  |
| gc5_L100500 | Per base N content | N-Count | identical | 60 | 0 |  |
| gc5_L100500 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc5_L100500 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc5_L100500 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc5_L100500 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc5_L100500 | Adapter Content | Position | identical | 60 | 0 |  |
| gc5_L100500 | Adapter Content | Illumina Universal Adapter | identical | 60 | 0 |  |
| gc5_L100500 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 60 | 0 |  |
| gc5_L100500 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 60 | 0 |  |
| gc5_L100500 | Adapter Content | Nextera Transposase Sequence | identical | 60 | 0 |  |
| gc5_L100500 | Adapter Content | PolyA | identical | 60 | 0 |  |
| gc5_L100500 | Adapter Content | PolyG | identical | 60 | 0 |  |
| gc5_L100500 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc5_L100500 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc5_L100500 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc5_L100500 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc5_L100500 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc5_L100500 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc5_L100500 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc5_L100500 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc5_L100500 | Per base N content | flag | identical | 1 | 0 |  |
| gc5_L100500 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc5_L100500 | Adapter Content | flag | identical | 1 | 0 |  |
| gc5_L100500 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc5_L19999 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc5_L19999 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc5_L19999 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc5_L19999 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc5_L19999 | Per base sequence quality | Base | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence quality | Mean | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence quality | Median | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence quality | Lower Quartile | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence quality | Upper Quartile | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence quality | 10th Percentile | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence quality | 90th Percentile | identical | 49 | 0 |  |
| gc5_L19999 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc5_L19999 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc5_L19999 | Per base sequence content | Base | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence content | G | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence content | A | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence content | T | identical | 49 | 0 |  |
| gc5_L19999 | Per base sequence content | C | identical | 49 | 0 |  |
| gc5_L19999 | Per base N content | Base | identical | 49 | 0 |  |
| gc5_L19999 | Per base N content | N-Count | identical | 49 | 0 |  |
| gc5_L19999 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc5_L19999 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc5_L19999 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc5_L19999 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc5_L19999 | Adapter Content | Position | identical | 49 | 0 |  |
| gc5_L19999 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| gc5_L19999 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| gc5_L19999 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| gc5_L19999 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| gc5_L19999 | Adapter Content | PolyA | identical | 49 | 0 |  |
| gc5_L19999 | Adapter Content | PolyG | identical | 49 | 0 |  |
| gc5_L19999 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc5_L19999 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc5_L19999 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc5_L19999 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc5_L19999 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc5_L19999 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc5_L19999 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc5_L19999 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc5_L19999 | Per base N content | flag | identical | 1 | 0 |  |
| gc5_L19999 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc5_L19999 | Adapter Content | flag | identical | 1 | 0 |  |
| gc5_L19999 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc5_L2999 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc5_L2999 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc5_L2999 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc5_L2999 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc5_L2999 | Per base sequence quality | Base | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence quality | Mean | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence quality | Median | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence quality | Lower Quartile | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence quality | Upper Quartile | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence quality | 10th Percentile | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence quality | 90th Percentile | identical | 69 | 0 |  |
| gc5_L2999 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc5_L2999 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc5_L2999 | Per base sequence content | Base | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence content | G | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence content | A | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence content | T | identical | 69 | 0 |  |
| gc5_L2999 | Per base sequence content | C | identical | 69 | 0 |  |
| gc5_L2999 | Per base N content | Base | identical | 69 | 0 |  |
| gc5_L2999 | Per base N content | N-Count | identical | 69 | 0 |  |
| gc5_L2999 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc5_L2999 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc5_L2999 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc5_L2999 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc5_L2999 | Adapter Content | Position | identical | 69 | 0 |  |
| gc5_L2999 | Adapter Content | Illumina Universal Adapter | identical | 69 | 0 |  |
| gc5_L2999 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 69 | 0 |  |
| gc5_L2999 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 69 | 0 |  |
| gc5_L2999 | Adapter Content | Nextera Transposase Sequence | identical | 69 | 0 |  |
| gc5_L2999 | Adapter Content | PolyA | identical | 69 | 0 |  |
| gc5_L2999 | Adapter Content | PolyG | identical | 69 | 0 |  |
| gc5_L2999 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc5_L2999 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc5_L2999 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc5_L2999 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc5_L2999 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc5_L2999 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc5_L2999 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc5_L2999 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc5_L2999 | Per base N content | flag | identical | 1 | 0 |  |
| gc5_L2999 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc5_L2999 | Adapter Content | flag | identical | 1 | 0 |  |
| gc5_L2999 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc5_L3000 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc5_L3000 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc5_L3000 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc5_L3000 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc5_L3000 | Per base sequence quality | Base | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence quality | Mean | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence quality | Median | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence quality | Lower Quartile | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence quality | Upper Quartile | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence quality | 10th Percentile | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence quality | 90th Percentile | identical | 70 | 0 |  |
| gc5_L3000 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc5_L3000 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc5_L3000 | Per base sequence content | Base | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence content | G | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence content | A | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence content | T | identical | 70 | 0 |  |
| gc5_L3000 | Per base sequence content | C | identical | 70 | 0 |  |
| gc5_L3000 | Per base N content | Base | identical | 70 | 0 |  |
| gc5_L3000 | Per base N content | N-Count | identical | 70 | 0 |  |
| gc5_L3000 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc5_L3000 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc5_L3000 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc5_L3000 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc5_L3000 | Adapter Content | Position | identical | 69 | 0 |  |
| gc5_L3000 | Adapter Content | Illumina Universal Adapter | identical | 69 | 0 |  |
| gc5_L3000 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 69 | 0 |  |
| gc5_L3000 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 69 | 0 |  |
| gc5_L3000 | Adapter Content | Nextera Transposase Sequence | identical | 69 | 0 |  |
| gc5_L3000 | Adapter Content | PolyA | identical | 69 | 0 |  |
| gc5_L3000 | Adapter Content | PolyG | identical | 69 | 0 |  |
| gc5_L3000 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc5_L3000 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc5_L3000 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc5_L3000 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc5_L3000 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc5_L3000 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc5_L3000 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc5_L3000 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc5_L3000 | Per base N content | flag | identical | 1 | 0 |  |
| gc5_L3000 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc5_L3000 | Adapter Content | flag | identical | 1 | 0 |  |
| gc5_L3000 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc5_L999 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc5_L999 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc5_L999 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc5_L999 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc5_L999 | Per base sequence quality | Base | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence quality | Mean | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence quality | Median | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence quality | Lower Quartile | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence quality | Upper Quartile | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence quality | 10th Percentile | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence quality | 90th Percentile | identical | 59 | 0 |  |
| gc5_L999 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc5_L999 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc5_L999 | Per base sequence content | Base | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence content | G | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence content | A | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence content | T | identical | 59 | 0 |  |
| gc5_L999 | Per base sequence content | C | identical | 59 | 0 |  |
| gc5_L999 | Per base N content | Base | identical | 59 | 0 |  |
| gc5_L999 | Per base N content | N-Count | identical | 59 | 0 |  |
| gc5_L999 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc5_L999 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc5_L999 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc5_L999 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc5_L999 | Adapter Content | Position | identical | 59 | 0 |  |
| gc5_L999 | Adapter Content | Illumina Universal Adapter | identical | 59 | 0 |  |
| gc5_L999 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 59 | 0 |  |
| gc5_L999 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 59 | 0 |  |
| gc5_L999 | Adapter Content | Nextera Transposase Sequence | identical | 59 | 0 |  |
| gc5_L999 | Adapter Content | PolyA | identical | 59 | 0 |  |
| gc5_L999 | Adapter Content | PolyG | identical | 59 | 0 |  |
| gc5_L999 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc5_L999 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc5_L999 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc5_L999 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc5_L999 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc5_L999 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc5_L999 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc5_L999 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc5_L999 | Per base N content | flag | identical | 1 | 0 |  |
| gc5_L999 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc5_L999 | Adapter Content | flag | identical | 1 | 0 |  |
| gc5_L999 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc5_L9999 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc5_L9999 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc5_L9999 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc5_L9999 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc5_L9999 | Per base sequence quality | Base | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence quality | Mean | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence quality | Median | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence quality | Lower Quartile | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence quality | Upper Quartile | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence quality | 10th Percentile | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence quality | 90th Percentile | identical | 59 | 0 |  |
| gc5_L9999 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc5_L9999 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc5_L9999 | Per base sequence content | Base | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence content | G | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence content | A | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence content | T | identical | 59 | 0 |  |
| gc5_L9999 | Per base sequence content | C | identical | 59 | 0 |  |
| gc5_L9999 | Per base N content | Base | identical | 59 | 0 |  |
| gc5_L9999 | Per base N content | N-Count | identical | 59 | 0 |  |
| gc5_L9999 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc5_L9999 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc5_L9999 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc5_L9999 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc5_L9999 | Adapter Content | Position | identical | 59 | 0 |  |
| gc5_L9999 | Adapter Content | Illumina Universal Adapter | identical | 59 | 0 |  |
| gc5_L9999 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 59 | 0 |  |
| gc5_L9999 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 59 | 0 |  |
| gc5_L9999 | Adapter Content | Nextera Transposase Sequence | identical | 59 | 0 |  |
| gc5_L9999 | Adapter Content | PolyA | identical | 59 | 0 |  |
| gc5_L9999 | Adapter Content | PolyG | identical | 59 | 0 |  |
| gc5_L9999 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc5_L9999 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc5_L9999 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc5_L9999 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc5_L9999 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc5_L9999 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc5_L9999 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc5_L9999 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc5_L9999 | Per base N content | flag | identical | 1 | 0 |  |
| gc5_L9999 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc5_L9999 | Adapter Content | flag | identical | 1 | 0 |  |
| gc5_L9999 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc6_L100 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc6_L100 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc6_L100 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc6_L100 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc6_L100 | Per base sequence quality | Base | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence quality | Mean | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence quality | Median | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence quality | Lower Quartile | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence quality | Upper Quartile | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence quality | 10th Percentile | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence quality | 90th Percentile | identical | 55 | 0 |  |
| gc6_L100 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc6_L100 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc6_L100 | Per base sequence content | Base | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence content | G | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence content | A | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence content | T | identical | 55 | 0 |  |
| gc6_L100 | Per base sequence content | C | identical | 55 | 0 |  |
| gc6_L100 | Per base N content | Base | identical | 55 | 0 |  |
| gc6_L100 | Per base N content | N-Count | identical | 55 | 0 |  |
| gc6_L100 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc6_L100 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc6_L100 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc6_L100 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc6_L100 | Adapter Content | Position | identical | 49 | 0 |  |
| gc6_L100 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| gc6_L100 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| gc6_L100 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| gc6_L100 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| gc6_L100 | Adapter Content | PolyA | identical | 49 | 0 |  |
| gc6_L100 | Adapter Content | PolyG | identical | 49 | 0 |  |
| gc6_L100 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc6_L100 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc6_L100 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc6_L100 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc6_L100 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc6_L100 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc6_L100 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc6_L100 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc6_L100 | Per base N content | flag | identical | 1 | 0 |  |
| gc6_L100 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc6_L100 | Adapter Content | flag | identical | 1 | 0 |  |
| gc6_L100 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc6_L1000 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc6_L1000 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc6_L1000 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc6_L1000 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc6_L1000 | Per base sequence quality | Base | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence quality | Median | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| gc6_L1000 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc6_L1000 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc6_L1000 | Per base sequence content | Base | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence content | G | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence content | A | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence content | T | identical | 60 | 0 |  |
| gc6_L1000 | Per base sequence content | C | identical | 60 | 0 |  |
| gc6_L1000 | Per base N content | Base | identical | 60 | 0 |  |
| gc6_L1000 | Per base N content | N-Count | identical | 60 | 0 |  |
| gc6_L1000 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc6_L1000 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc6_L1000 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc6_L1000 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc6_L1000 | Adapter Content | Position | identical | 59 | 0 |  |
| gc6_L1000 | Adapter Content | Illumina Universal Adapter | identical | 59 | 0 |  |
| gc6_L1000 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 59 | 0 |  |
| gc6_L1000 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 59 | 0 |  |
| gc6_L1000 | Adapter Content | Nextera Transposase Sequence | identical | 59 | 0 |  |
| gc6_L1000 | Adapter Content | PolyA | identical | 59 | 0 |  |
| gc6_L1000 | Adapter Content | PolyG | identical | 59 | 0 |  |
| gc6_L1000 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc6_L1000 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc6_L1000 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc6_L1000 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc6_L1000 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc6_L1000 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc6_L1000 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc6_L1000 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc6_L1000 | Per base N content | flag | identical | 1 | 0 |  |
| gc6_L1000 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc6_L1000 | Adapter Content | flag | identical | 1 | 0 |  |
| gc6_L1000 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc6_L123456 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc6_L123456 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc6_L123456 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc6_L123456 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc6_L123456 | Per base sequence quality | Base | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence quality | Mean | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence quality | Median | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence quality | Lower Quartile | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence quality | Upper Quartile | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence quality | 10th Percentile | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence quality | 90th Percentile | identical | 71 | 0 |  |
| gc6_L123456 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc6_L123456 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc6_L123456 | Per base sequence content | Base | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence content | G | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence content | A | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence content | T | identical | 71 | 0 |  |
| gc6_L123456 | Per base sequence content | C | identical | 71 | 0 |  |
| gc6_L123456 | Per base N content | Base | identical | 71 | 0 |  |
| gc6_L123456 | Per base N content | N-Count | identical | 71 | 0 |  |
| gc6_L123456 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc6_L123456 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc6_L123456 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc6_L123456 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc6_L123456 | Adapter Content | Position | identical | 71 | 0 |  |
| gc6_L123456 | Adapter Content | Illumina Universal Adapter | identical | 71 | 0 |  |
| gc6_L123456 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 71 | 0 |  |
| gc6_L123456 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 71 | 0 |  |
| gc6_L123456 | Adapter Content | Nextera Transposase Sequence | identical | 71 | 0 |  |
| gc6_L123456 | Adapter Content | PolyA | identical | 71 | 0 |  |
| gc6_L123456 | Adapter Content | PolyG | identical | 71 | 0 |  |
| gc6_L123456 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc6_L123456 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc6_L123456 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc6_L123456 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc6_L123456 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc6_L123456 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc6_L123456 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc6_L123456 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc6_L123456 | Per base N content | flag | identical | 1 | 0 |  |
| gc6_L123456 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc6_L123456 | Adapter Content | flag | identical | 1 | 0 |  |
| gc6_L123456 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc6_L1999 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc6_L1999 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc6_L1999 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc6_L1999 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc6_L1999 | Per base sequence quality | Base | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence quality | Mean | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence quality | Median | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence quality | Lower Quartile | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence quality | Upper Quartile | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence quality | 10th Percentile | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence quality | 90th Percentile | identical | 49 | 0 |  |
| gc6_L1999 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc6_L1999 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc6_L1999 | Per base sequence content | Base | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence content | G | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence content | A | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence content | T | identical | 49 | 0 |  |
| gc6_L1999 | Per base sequence content | C | identical | 49 | 0 |  |
| gc6_L1999 | Per base N content | Base | identical | 49 | 0 |  |
| gc6_L1999 | Per base N content | N-Count | identical | 49 | 0 |  |
| gc6_L1999 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc6_L1999 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc6_L1999 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc6_L1999 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc6_L1999 | Adapter Content | Position | identical | 49 | 0 |  |
| gc6_L1999 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| gc6_L1999 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| gc6_L1999 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| gc6_L1999 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| gc6_L1999 | Adapter Content | PolyA | identical | 49 | 0 |  |
| gc6_L1999 | Adapter Content | PolyG | identical | 49 | 0 |  |
| gc6_L1999 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc6_L1999 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc6_L1999 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc6_L1999 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc6_L1999 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc6_L1999 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc6_L1999 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc6_L1999 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc6_L1999 | Per base N content | flag | identical | 1 | 0 |  |
| gc6_L1999 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc6_L1999 | Adapter Content | flag | identical | 1 | 0 |  |
| gc6_L1999 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc6_L54321 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc6_L54321 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc6_L54321 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc6_L54321 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc6_L54321 | Per base sequence quality | Base | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence quality | Mean | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence quality | Median | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence quality | Lower Quartile | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence quality | Upper Quartile | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence quality | 10th Percentile | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence quality | 90th Percentile | identical | 64 | 0 |  |
| gc6_L54321 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc6_L54321 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc6_L54321 | Per base sequence content | Base | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence content | G | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence content | A | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence content | T | identical | 64 | 0 |  |
| gc6_L54321 | Per base sequence content | C | identical | 64 | 0 |  |
| gc6_L54321 | Per base N content | Base | identical | 64 | 0 |  |
| gc6_L54321 | Per base N content | N-Count | identical | 64 | 0 |  |
| gc6_L54321 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc6_L54321 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc6_L54321 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc6_L54321 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc6_L54321 | Adapter Content | Position | identical | 64 | 0 |  |
| gc6_L54321 | Adapter Content | Illumina Universal Adapter | identical | 64 | 0 |  |
| gc6_L54321 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 64 | 0 |  |
| gc6_L54321 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 64 | 0 |  |
| gc6_L54321 | Adapter Content | Nextera Transposase Sequence | identical | 64 | 0 |  |
| gc6_L54321 | Adapter Content | PolyA | identical | 64 | 0 |  |
| gc6_L54321 | Adapter Content | PolyG | identical | 64 | 0 |  |
| gc6_L54321 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc6_L54321 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc6_L54321 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc6_L54321 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc6_L54321 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc6_L54321 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc6_L54321 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc6_L54321 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc6_L54321 | Per base N content | flag | identical | 1 | 0 |  |
| gc6_L54321 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc6_L54321 | Adapter Content | flag | identical | 1 | 0 |  |
| gc6_L54321 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| gc6_L9876 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| gc6_L9876 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| gc6_L9876 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| gc6_L9876 | Basic Statistics | %GC | identical | 1 | 0 |  |
| gc6_L9876 | Per base sequence quality | Base | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence quality | Mean | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence quality | Median | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence quality | Lower Quartile | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence quality | Upper Quartile | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence quality | 10th Percentile | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence quality | 90th Percentile | identical | 59 | 0 |  |
| gc6_L9876 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| gc6_L9876 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| gc6_L9876 | Per base sequence content | Base | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence content | G | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence content | A | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence content | T | identical | 59 | 0 |  |
| gc6_L9876 | Per base sequence content | C | identical | 59 | 0 |  |
| gc6_L9876 | Per base N content | Base | identical | 59 | 0 |  |
| gc6_L9876 | Per base N content | N-Count | identical | 59 | 0 |  |
| gc6_L9876 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| gc6_L9876 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| gc6_L9876 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| gc6_L9876 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| gc6_L9876 | Adapter Content | Position | identical | 59 | 0 |  |
| gc6_L9876 | Adapter Content | Illumina Universal Adapter | identical | 59 | 0 |  |
| gc6_L9876 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 59 | 0 |  |
| gc6_L9876 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 59 | 0 |  |
| gc6_L9876 | Adapter Content | Nextera Transposase Sequence | identical | 59 | 0 |  |
| gc6_L9876 | Adapter Content | PolyA | identical | 59 | 0 |  |
| gc6_L9876 | Adapter Content | PolyG | identical | 59 | 0 |  |
| gc6_L9876 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| gc6_L9876 | Per sequence GC content | Count | identical | 101 | 0 |  |
| gc6_L9876 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| gc6_L9876 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| gc6_L9876 | Basic Statistics | flag | identical | 1 | 0 |  |
| gc6_L9876 | Per base sequence quality | flag | identical | 1 | 0 |  |
| gc6_L9876 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| gc6_L9876 | Per base sequence content | flag | identical | 1 | 0 |  |
| gc6_L9876 | Per base N content | flag | identical | 1 | 0 |  |
| gc6_L9876 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| gc6_L9876 | Adapter Content | flag | identical | 1 | 0 |  |
| gc6_L9876 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad1_a1 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad1_a1 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad1_a1 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad1_a1 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad1_a1 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad1_a1 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad1_a1 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad1_a1 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence content | G | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence content | A | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence content | T | identical | 60 | 0 |  |
| ad1_a1 | Per base sequence content | C | identical | 60 | 0 |  |
| ad1_a1 | Per base N content | Base | identical | 60 | 0 |  |
| ad1_a1 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad1_a1 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad1_a1 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad1_a1 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad1_a1 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad1_a1 | Adapter Content | Position | identical | 49 | 0 |  |
| ad1_a1 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad1_a1 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad1_a1 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad1_a1 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad1_a1 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad1_a1 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad1_a1 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad1_a1 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad1_a1 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad1_a1 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad1_a1 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad1_a1 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad1_a1 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad1_a1 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad1_a1 | Per base N content | flag | identical | 1 | 0 |  |
| ad1_a1 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad1_a1 | Adapter Content | flag | identical | 1 | 0 |  |
| ad1_a1 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad1_a2 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad1_a2 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad1_a2 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad1_a2 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad1_a2 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad1_a2 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad1_a2 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad1_a2 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence content | G | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence content | A | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence content | T | identical | 60 | 0 |  |
| ad1_a2 | Per base sequence content | C | identical | 60 | 0 |  |
| ad1_a2 | Per base N content | Base | identical | 60 | 0 |  |
| ad1_a2 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad1_a2 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad1_a2 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad1_a2 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad1_a2 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad1_a2 | Adapter Content | Position | identical | 49 | 0 |  |
| ad1_a2 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad1_a2 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad1_a2 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad1_a2 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad1_a2 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad1_a2 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad1_a2 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad1_a2 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad1_a2 | Sequence Length Distribution | Length | identical | 31 | 0 |  |
| ad1_a2 | Sequence Length Distribution | Count | identical | 31 | 0 |  |
| ad1_a2 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad1_a2 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad1_a2 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad1_a2 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad1_a2 | Per base N content | flag | identical | 1 | 0 |  |
| ad1_a2 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad1_a2 | Adapter Content | flag | identical | 1 | 0 |  |
| ad1_a2 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad1_a3 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad1_a3 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad1_a3 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad1_a3 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad1_a3 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad1_a3 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad1_a3 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad1_a3 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence content | G | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence content | A | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence content | T | identical | 60 | 0 |  |
| ad1_a3 | Per base sequence content | C | identical | 60 | 0 |  |
| ad1_a3 | Per base N content | Base | identical | 60 | 0 |  |
| ad1_a3 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad1_a3 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad1_a3 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad1_a3 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad1_a3 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad1_a3 | Adapter Content | Position | identical | 49 | 0 |  |
| ad1_a3 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad1_a3 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad1_a3 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad1_a3 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad1_a3 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad1_a3 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad1_a3 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad1_a3 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad1_a3 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad1_a3 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad1_a3 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad1_a3 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad1_a3 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad1_a3 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad1_a3 | Per base N content | flag | identical | 1 | 0 |  |
| ad1_a3 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad1_a3 | Adapter Content | flag | identical | 1 | 0 |  |
| ad1_a3 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad1_a4 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad1_a4 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad1_a4 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad1_a4 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad1_a4 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad1_a4 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad1_a4 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad1_a4 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence content | G | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence content | A | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence content | T | identical | 60 | 0 |  |
| ad1_a4 | Per base sequence content | C | identical | 60 | 0 |  |
| ad1_a4 | Per base N content | Base | identical | 60 | 0 |  |
| ad1_a4 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad1_a4 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad1_a4 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad1_a4 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad1_a4 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad1_a4 | Adapter Content | Position | identical | 49 | 0 |  |
| ad1_a4 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad1_a4 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad1_a4 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad1_a4 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad1_a4 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad1_a4 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad1_a4 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad1_a4 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad1_a4 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad1_a4 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad1_a4 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad1_a4 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad1_a4 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad1_a4 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad1_a4 | Per base N content | flag | identical | 1 | 0 |  |
| ad1_a4 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad1_a4 | Adapter Content | flag | identical | 1 | 0 |  |
| ad1_a4 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad1_a5 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad1_a5 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad1_a5 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad1_a5 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad1_a5 | Per base sequence quality | Base | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence quality | Mean | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence quality | Median | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| ad1_a5 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad1_a5 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad1_a5 | Per base sequence content | Base | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence content | G | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence content | A | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence content | T | identical | 38 | 0 |  |
| ad1_a5 | Per base sequence content | C | identical | 38 | 0 |  |
| ad1_a5 | Per base N content | Base | identical | 38 | 0 |  |
| ad1_a5 | Per base N content | N-Count | identical | 38 | 0 |  |
| ad1_a5 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad1_a5 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad1_a5 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad1_a5 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad1_a5 | Adapter Content | Position | identical | 74 | 0 |  |
| ad1_a5 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| ad1_a5 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| ad1_a5 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| ad1_a5 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| ad1_a5 | Adapter Content | PolyA | identical | 74 | 0 |  |
| ad1_a5 | Adapter Content | PolyG | identical | 74 | 0 |  |
| ad1_a5 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad1_a5 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad1_a5 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad1_a5 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad1_a5 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad1_a5 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad1_a5 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad1_a5 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad1_a5 | Per base N content | flag | identical | 1 | 0 |  |
| ad1_a5 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad1_a5 | Adapter Content | flag | identical | 1 | 0 |  |
| ad1_a5 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad1_a6 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad1_a6 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad1_a6 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad1_a6 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad1_a6 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad1_a6 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad1_a6 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad1_a6 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence content | G | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence content | A | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence content | T | identical | 60 | 0 |  |
| ad1_a6 | Per base sequence content | C | identical | 60 | 0 |  |
| ad1_a6 | Per base N content | Base | identical | 60 | 0 |  |
| ad1_a6 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad1_a6 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad1_a6 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad1_a6 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad1_a6 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad1_a6 | Adapter Content | Position | identical | 49 | 0 |  |
| ad1_a6 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad1_a6 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad1_a6 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad1_a6 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad1_a6 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad1_a6 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad1_a6 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad1_a6 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad1_a6 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad1_a6 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad1_a6 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad1_a6 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad1_a6 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad1_a6 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad1_a6 | Per base N content | flag | identical | 1 | 0 |  |
| ad1_a6 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad1_a6 | Adapter Content | flag | identical | 1 | 0 |  |
| ad1_a6 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad1_a7 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad1_a7 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad1_a7 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad1_a7 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad1_a7 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad1_a7 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad1_a7 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad1_a7 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence content | G | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence content | A | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence content | T | identical | 60 | 0 |  |
| ad1_a7 | Per base sequence content | C | identical | 60 | 0 |  |
| ad1_a7 | Per base N content | Base | identical | 60 | 0 |  |
| ad1_a7 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad1_a7 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad1_a7 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad1_a7 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad1_a7 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad1_a7 | Adapter Content | Position | identical | 49 | 0 |  |
| ad1_a7 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad1_a7 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad1_a7 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad1_a7 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad1_a7 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad1_a7 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad1_a7 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad1_a7 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad1_a7 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad1_a7 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad1_a7 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad1_a7 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad1_a7 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad1_a7 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad1_a7 | Per base N content | flag | identical | 1 | 0 |  |
| ad1_a7 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad1_a7 | Adapter Content | flag | identical | 1 | 0 |  |
| ad1_a7 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad1_a8 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad1_a8 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad1_a8 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad1_a8 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad1_a8 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad1_a8 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad1_a8 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad1_a8 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence content | G | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence content | A | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence content | T | identical | 60 | 0 |  |
| ad1_a8 | Per base sequence content | C | identical | 60 | 0 |  |
| ad1_a8 | Per base N content | Base | identical | 60 | 0 |  |
| ad1_a8 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad1_a8 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad1_a8 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad1_a8 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad1_a8 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad1_a8 | Adapter Content | Position | identical | 49 | 0 |  |
| ad1_a8 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad1_a8 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad1_a8 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad1_a8 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad1_a8 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad1_a8 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad1_a8 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad1_a8 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad1_a8 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad1_a8 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad1_a8 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad1_a8 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad1_a8 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad1_a8 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad1_a8 | Per base N content | flag | identical | 1 | 0 |  |
| ad1_a8 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad1_a8 | Adapter Content | flag | identical | 1 | 0 |  |
| ad1_a8 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b1 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b1 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b1 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b1 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b1 | Per base sequence quality | Base | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence quality | Mean | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence quality | Median | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| ad2_b1 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b1 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b1 | Per base sequence content | Base | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence content | G | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence content | A | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence content | T | identical | 38 | 0 |  |
| ad2_b1 | Per base sequence content | C | identical | 38 | 0 |  |
| ad2_b1 | Per base N content | Base | identical | 38 | 0 |  |
| ad2_b1 | Per base N content | N-Count | identical | 38 | 0 |  |
| ad2_b1 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad2_b1 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad2_b1 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad2_b1 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad2_b1 | Adapter Content | Position | identical | 74 | 0 |  |
| ad2_b1 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| ad2_b1 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| ad2_b1 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| ad2_b1 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| ad2_b1 | Adapter Content | PolyA | identical | 74 | 0 |  |
| ad2_b1 | Adapter Content | PolyG | identical | 74 | 0 |  |
| ad2_b1 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b1 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b1 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad2_b1 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad2_b1 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b1 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b1 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b1 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b1 | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b1 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b1 | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b1 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b2 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b2 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b2 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b2 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b2 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad2_b2 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b2 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b2 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence content | G | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence content | A | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence content | T | identical | 60 | 0 |  |
| ad2_b2 | Per base sequence content | C | identical | 60 | 0 |  |
| ad2_b2 | Per base N content | Base | identical | 60 | 0 |  |
| ad2_b2 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad2_b2 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad2_b2 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad2_b2 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad2_b2 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad2_b2 | Adapter Content | Position | identical | 59 | 0 |  |
| ad2_b2 | Adapter Content | Illumina Universal Adapter | identical | 59 | 0 |  |
| ad2_b2 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 59 | 0 |  |
| ad2_b2 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 59 | 0 |  |
| ad2_b2 | Adapter Content | Nextera Transposase Sequence | identical | 59 | 0 |  |
| ad2_b2 | Adapter Content | PolyA | identical | 59 | 0 |  |
| ad2_b2 | Adapter Content | PolyG | identical | 59 | 0 |  |
| ad2_b2 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b2 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b2 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad2_b2 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad2_b2 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b2 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b2 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b2 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b2 | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b2 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b2 | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b2 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b3 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b3 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b3 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b3 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b3 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad2_b3 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b3 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b3 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence content | G | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence content | A | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence content | T | identical | 60 | 0 |  |
| ad2_b3 | Per base sequence content | C | identical | 60 | 0 |  |
| ad2_b3 | Per base N content | Base | identical | 60 | 0 |  |
| ad2_b3 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad2_b3 | Overrepresented sequences | Sequence | identical | 300 | 0 |  |
| ad2_b3 | Overrepresented sequences | Count | identical | 300 | 0 |  |
| ad2_b3 | Overrepresented sequences | Percentage | identical | 300 | 0 |  |
| ad2_b3 | Overrepresented sequences | Possible Source | identical | 300 | 0 |  |
| ad2_b3 | Adapter Content | Position | identical | 49 | 0 |  |
| ad2_b3 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad2_b3 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad2_b3 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad2_b3 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad2_b3 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad2_b3 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad2_b3 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b3 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b3 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad2_b3 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad2_b3 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b3 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b3 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b3 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b3 | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b3 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b3 | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b3 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b4f | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b4f | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b4f | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b4f | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b4f | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad2_b4f | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b4f | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b4f | Per base sequence content | Base | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence content | G | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence content | A | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence content | T | identical | 60 | 0 |  |
| ad2_b4f | Per base sequence content | C | identical | 60 | 0 |  |
| ad2_b4f | Per base N content | Base | identical | 60 | 0 |  |
| ad2_b4f | Per base N content | N-Count | identical | 60 | 0 |  |
| ad2_b4f | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad2_b4f | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad2_b4f | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad2_b4f | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad2_b4f | Adapter Content | Position | identical | 49 | 0 |  |
| ad2_b4f | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad2_b4f | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad2_b4f | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad2_b4f | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad2_b4f | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad2_b4f | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad2_b4f | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b4f | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b4f | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad2_b4f | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad2_b4f | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b4f | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b4f | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b4f | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b4f | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b4f | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b4f | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b4f | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b4f2 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b4f2 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b4f2 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b4f2 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b4f2 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad2_b4f2 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b4f2 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b4f2 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence content | G | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence content | A | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence content | T | identical | 60 | 0 |  |
| ad2_b4f2 | Per base sequence content | C | identical | 60 | 0 |  |
| ad2_b4f2 | Per base N content | Base | identical | 60 | 0 |  |
| ad2_b4f2 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad2_b4f2 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad2_b4f2 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad2_b4f2 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad2_b4f2 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad2_b4f2 | Adapter Content | Position | identical | 49 | 0 |  |
| ad2_b4f2 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad2_b4f2 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad2_b4f2 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad2_b4f2 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad2_b4f2 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad2_b4f2 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad2_b4f2 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b4f2 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b4f2 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad2_b4f2 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad2_b4f2 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b4f2 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b4f2 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b4f2 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b4f2 | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b4f2 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b4f2 | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b4f2 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b4w | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b4w | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b4w | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b4w | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b4w | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad2_b4w | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b4w | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b4w | Per base sequence content | Base | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence content | G | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence content | A | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence content | T | identical | 60 | 0 |  |
| ad2_b4w | Per base sequence content | C | identical | 60 | 0 |  |
| ad2_b4w | Per base N content | Base | identical | 60 | 0 |  |
| ad2_b4w | Per base N content | N-Count | identical | 60 | 0 |  |
| ad2_b4w | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad2_b4w | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad2_b4w | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad2_b4w | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad2_b4w | Adapter Content | Position | identical | 49 | 0 |  |
| ad2_b4w | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad2_b4w | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad2_b4w | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad2_b4w | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad2_b4w | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad2_b4w | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad2_b4w | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b4w | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b4w | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad2_b4w | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad2_b4w | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b4w | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b4w | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b4w | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b4w | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b4w | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b4w | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b4w | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b4w2 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b4w2 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b4w2 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b4w2 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b4w2 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad2_b4w2 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b4w2 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b4w2 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence content | G | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence content | A | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence content | T | identical | 60 | 0 |  |
| ad2_b4w2 | Per base sequence content | C | identical | 60 | 0 |  |
| ad2_b4w2 | Per base N content | Base | identical | 60 | 0 |  |
| ad2_b4w2 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad2_b4w2 | Overrepresented sequences | Sequence | identical | 200 | 0 |  |
| ad2_b4w2 | Overrepresented sequences | Count | identical | 200 | 0 |  |
| ad2_b4w2 | Overrepresented sequences | Percentage | identical | 200 | 0 |  |
| ad2_b4w2 | Overrepresented sequences | Possible Source | identical | 200 | 0 |  |
| ad2_b4w2 | Adapter Content | Position | identical | 49 | 0 |  |
| ad2_b4w2 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad2_b4w2 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad2_b4w2 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad2_b4w2 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad2_b4w2 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad2_b4w2 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad2_b4w2 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b4w2 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b4w2 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad2_b4w2 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad2_b4w2 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b4w2 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b4w2 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b4w2 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b4w2 | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b4w2 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b4w2 | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b4w2 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b5 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b5 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b5 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b5 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b5 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad2_b5 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b5 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b5 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence content | G | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence content | A | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence content | T | identical | 60 | 0 |  |
| ad2_b5 | Per base sequence content | C | identical | 60 | 0 |  |
| ad2_b5 | Per base N content | Base | identical | 60 | 0 |  |
| ad2_b5 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad2_b5 | Overrepresented sequences | Sequence | identical | 197 | 0 |  |
| ad2_b5 | Overrepresented sequences | Count | identical | 197 | 0 |  |
| ad2_b5 | Overrepresented sequences | Percentage | identical | 197 | 0 |  |
| ad2_b5 | Overrepresented sequences | Possible Source | identical | 197 | 0 |  |
| ad2_b5 | Adapter Content | Position | identical | 49 | 0 |  |
| ad2_b5 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad2_b5 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad2_b5 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad2_b5 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad2_b5 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad2_b5 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad2_b5 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b5 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b5 | Sequence Length Distribution | Length | identical | 27 | 0 |  |
| ad2_b5 | Sequence Length Distribution | Count | identical | 27 | 0 |  |
| ad2_b5 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b5 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b5 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b5 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b5 | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b5 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b5 | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b5 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b6 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b6 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b6 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b6 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b6 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ad2_b6 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b6 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b6 | Per base sequence content | Base | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence content | G | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence content | A | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence content | T | identical | 60 | 0 |  |
| ad2_b6 | Per base sequence content | C | identical | 60 | 0 |  |
| ad2_b6 | Per base N content | Base | identical | 60 | 0 |  |
| ad2_b6 | Per base N content | N-Count | identical | 60 | 0 |  |
| ad2_b6 | Overrepresented sequences | Sequence | identical | 70 | 0 |  |
| ad2_b6 | Overrepresented sequences | Count | identical | 70 | 0 |  |
| ad2_b6 | Overrepresented sequences | Percentage | identical | 70 | 0 |  |
| ad2_b6 | Overrepresented sequences | Possible Source | identical | 70 | 0 |  |
| ad2_b6 | Adapter Content | Position | identical | 49 | 0 |  |
| ad2_b6 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ad2_b6 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ad2_b6 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ad2_b6 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ad2_b6 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ad2_b6 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ad2_b6 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b6 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b6 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad2_b6 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad2_b6 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b6 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b6 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b6 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b6 | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b6 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b6 | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b6 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad2_b7 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad2_b7 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad2_b7 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad2_b7 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad2_b7 | Per base sequence quality | Base | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence quality | Mean | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence quality | Median | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence quality | Lower Quartile | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence quality | Upper Quartile | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence quality | 10th Percentile | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence quality | 90th Percentile | identical | 11 | 0 |  |
| ad2_b7 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad2_b7 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad2_b7 | Per base sequence content | Base | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence content | G | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence content | A | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence content | T | identical | 11 | 0 |  |
| ad2_b7 | Per base sequence content | C | identical | 11 | 0 |  |
| ad2_b7 | Per base N content | Base | identical | 11 | 0 |  |
| ad2_b7 | Per base N content | N-Count | identical | 11 | 0 |  |
| ad2_b7 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ad2_b7 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ad2_b7 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ad2_b7 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ad2_b7 | Adapter Content | Position | identical | 0 | 0 |  |
| ad2_b7 | Adapter Content | Illumina Universal Adapter | identical | 0 | 0 |  |
| ad2_b7 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 0 | 0 |  |
| ad2_b7 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 0 | 0 |  |
| ad2_b7 | Adapter Content | Nextera Transposase Sequence | identical | 0 | 0 |  |
| ad2_b7 | Adapter Content | PolyA | identical | 0 | 0 |  |
| ad2_b7 | Adapter Content | PolyG | identical | 0 | 0 |  |
| ad2_b7 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad2_b7 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad2_b7 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ad2_b7 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ad2_b7 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad2_b7 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad2_b7 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad2_b7 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad2_b7 | Per base N content | flag | identical | 1 | 0 |  |
| ad2_b7 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad2_b7 | Adapter Content | flag | identical | 1 | 0 |  |
| ad2_b7 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad3_len12 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad3_len12 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad3_len12 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad3_len12 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad3_len12 | Per base sequence quality | Base | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence quality | Mean | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence quality | Median | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence quality | Lower Quartile | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence quality | Upper Quartile | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence quality | 10th Percentile | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence quality | 90th Percentile | identical | 30 | 0 |  |
| ad3_len12 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad3_len12 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad3_len12 | Per base sequence content | Base | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence content | G | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence content | A | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence content | T | identical | 30 | 0 |  |
| ad3_len12 | Per base sequence content | C | identical | 30 | 0 |  |
| ad3_len12 | Per base N content | Base | identical | 30 | 0 |  |
| ad3_len12 | Per base N content | N-Count | identical | 30 | 0 |  |
| ad3_len12 | Overrepresented sequences | Sequence | identical | 91 | 0 |  |
| ad3_len12 | Overrepresented sequences | Count | identical | 91 | 0 |  |
| ad3_len12 | Overrepresented sequences | Percentage | identical | 91 | 0 |  |
| ad3_len12 | Overrepresented sequences | Possible Source | identical | 91 | 0 |  |
| ad3_len12 | Adapter Content | Position | identical | 19 | 0 |  |
| ad3_len12 | Adapter Content | Illumina Universal Adapter | identical | 19 | 0 |  |
| ad3_len12 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 19 | 0 |  |
| ad3_len12 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 19 | 0 |  |
| ad3_len12 | Adapter Content | Nextera Transposase Sequence | identical | 19 | 0 |  |
| ad3_len12 | Adapter Content | PolyA | identical | 19 | 0 |  |
| ad3_len12 | Adapter Content | PolyG | identical | 19 | 0 |  |
| ad3_len12 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad3_len12 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad3_len12 | Sequence Length Distribution | Length | identical | 19 | 0 |  |
| ad3_len12 | Sequence Length Distribution | Count | identical | 19 | 0 |  |
| ad3_len12 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad3_len12 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad3_len12 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad3_len12 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad3_len12 | Per base N content | flag | identical | 1 | 0 |  |
| ad3_len12 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad3_len12 | Adapter Content | flag | identical | 1 | 0 |  |
| ad3_len12 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad3_len13_end | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad3_len13_end | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad3_len13_end | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad3_len13_end | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad3_len13_end | Per base sequence quality | Base | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence quality | Mean | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence quality | Median | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence quality | Lower Quartile | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence quality | Upper Quartile | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence quality | 10th Percentile | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence quality | 90th Percentile | identical | 30 | 0 |  |
| ad3_len13_end | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad3_len13_end | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad3_len13_end | Per base sequence content | Base | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence content | G | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence content | A | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence content | T | identical | 30 | 0 |  |
| ad3_len13_end | Per base sequence content | C | identical | 30 | 0 |  |
| ad3_len13_end | Per base N content | Base | identical | 30 | 0 |  |
| ad3_len13_end | Per base N content | N-Count | identical | 30 | 0 |  |
| ad3_len13_end | Overrepresented sequences | Sequence | identical | 91 | 0 |  |
| ad3_len13_end | Overrepresented sequences | Count | identical | 91 | 0 |  |
| ad3_len13_end | Overrepresented sequences | Percentage | identical | 91 | 0 |  |
| ad3_len13_end | Overrepresented sequences | Possible Source | identical | 91 | 0 |  |
| ad3_len13_end | Adapter Content | Position | identical | 19 | 0 |  |
| ad3_len13_end | Adapter Content | Illumina Universal Adapter | identical | 19 | 0 |  |
| ad3_len13_end | Adapter Content | Illumina Small RNA 3' Adapter | identical | 19 | 0 |  |
| ad3_len13_end | Adapter Content | Illumina Small RNA 5' Adapter | identical | 19 | 0 |  |
| ad3_len13_end | Adapter Content | Nextera Transposase Sequence | identical | 19 | 0 |  |
| ad3_len13_end | Adapter Content | PolyA | identical | 19 | 0 |  |
| ad3_len13_end | Adapter Content | PolyG | identical | 19 | 0 |  |
| ad3_len13_end | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad3_len13_end | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad3_len13_end | Sequence Length Distribution | Length | identical | 18 | 0 |  |
| ad3_len13_end | Sequence Length Distribution | Count | identical | 18 | 0 |  |
| ad3_len13_end | Basic Statistics | flag | identical | 1 | 0 |  |
| ad3_len13_end | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad3_len13_end | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad3_len13_end | Per base sequence content | flag | identical | 1 | 0 |  |
| ad3_len13_end | Per base N content | flag | identical | 1 | 0 |  |
| ad3_len13_end | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad3_len13_end | Adapter Content | flag | identical | 1 | 0 |  |
| ad3_len13_end | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad3_len13_start | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad3_len13_start | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad3_len13_start | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad3_len13_start | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad3_len13_start | Per base sequence quality | Base | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence quality | Mean | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence quality | Median | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence quality | Lower Quartile | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence quality | Upper Quartile | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence quality | 10th Percentile | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence quality | 90th Percentile | identical | 30 | 0 |  |
| ad3_len13_start | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad3_len13_start | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad3_len13_start | Per base sequence content | Base | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence content | G | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence content | A | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence content | T | identical | 30 | 0 |  |
| ad3_len13_start | Per base sequence content | C | identical | 30 | 0 |  |
| ad3_len13_start | Per base N content | Base | identical | 30 | 0 |  |
| ad3_len13_start | Per base N content | N-Count | identical | 30 | 0 |  |
| ad3_len13_start | Overrepresented sequences | Sequence | identical | 91 | 0 |  |
| ad3_len13_start | Overrepresented sequences | Count | identical | 91 | 0 |  |
| ad3_len13_start | Overrepresented sequences | Percentage | identical | 91 | 0 |  |
| ad3_len13_start | Overrepresented sequences | Possible Source | identical | 91 | 0 |  |
| ad3_len13_start | Adapter Content | Position | identical | 19 | 0 |  |
| ad3_len13_start | Adapter Content | Illumina Universal Adapter | identical | 19 | 0 |  |
| ad3_len13_start | Adapter Content | Illumina Small RNA 3' Adapter | identical | 19 | 0 |  |
| ad3_len13_start | Adapter Content | Illumina Small RNA 5' Adapter | identical | 19 | 0 |  |
| ad3_len13_start | Adapter Content | Nextera Transposase Sequence | identical | 19 | 0 |  |
| ad3_len13_start | Adapter Content | PolyA | identical | 19 | 0 |  |
| ad3_len13_start | Adapter Content | PolyG | identical | 19 | 0 |  |
| ad3_len13_start | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad3_len13_start | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad3_len13_start | Sequence Length Distribution | Length | identical | 18 | 0 |  |
| ad3_len13_start | Sequence Length Distribution | Count | identical | 18 | 0 |  |
| ad3_len13_start | Basic Statistics | flag | identical | 1 | 0 |  |
| ad3_len13_start | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad3_len13_start | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad3_len13_start | Per base sequence content | flag | identical | 1 | 0 |  |
| ad3_len13_start | Per base N content | flag | identical | 1 | 0 |  |
| ad3_len13_start | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad3_len13_start | Adapter Content | flag | identical | 1 | 0 |  |
| ad3_len13_start | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad4_after_12 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad4_after_12 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad4_after_12 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad4_after_12 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad4_after_12 | Per base sequence quality | Base | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence quality | Mean | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence quality | Median | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence quality | Lower Quartile | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence quality | Upper Quartile | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence quality | 10th Percentile | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence quality | 90th Percentile | identical | 30 | 0 |  |
| ad4_after_12 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad4_after_12 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad4_after_12 | Per base sequence content | Base | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence content | G | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence content | A | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence content | T | identical | 30 | 0 |  |
| ad4_after_12 | Per base sequence content | C | identical | 30 | 0 |  |
| ad4_after_12 | Per base N content | Base | identical | 30 | 0 |  |
| ad4_after_12 | Per base N content | N-Count | identical | 30 | 0 |  |
| ad4_after_12 | Overrepresented sequences | Sequence | identical | 91 | 0 |  |
| ad4_after_12 | Overrepresented sequences | Count | identical | 91 | 0 |  |
| ad4_after_12 | Overrepresented sequences | Percentage | identical | 91 | 0 |  |
| ad4_after_12 | Overrepresented sequences | Possible Source | identical | 91 | 0 |  |
| ad4_after_12 | Adapter Content | Position | identical | 19 | 0 |  |
| ad4_after_12 | Adapter Content | Illumina Universal Adapter | identical | 19 | 0 |  |
| ad4_after_12 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 19 | 0 |  |
| ad4_after_12 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 19 | 0 |  |
| ad4_after_12 | Adapter Content | Nextera Transposase Sequence | identical | 19 | 0 |  |
| ad4_after_12 | Adapter Content | PolyA | identical | 19 | 0 |  |
| ad4_after_12 | Adapter Content | PolyG | identical | 19 | 0 |  |
| ad4_after_12 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad4_after_12 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad4_after_12 | Sequence Length Distribution | Length | identical | 19 | 0 |  |
| ad4_after_12 | Sequence Length Distribution | Count | identical | 19 | 0 |  |
| ad4_after_12 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad4_after_12 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad4_after_12 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad4_after_12 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad4_after_12 | Per base N content | flag | identical | 1 | 0 |  |
| ad4_after_12 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad4_after_12 | Adapter Content | flag | identical | 1 | 0 |  |
| ad4_after_12 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad4_after_13 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad4_after_13 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad4_after_13 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad4_after_13 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad4_after_13 | Per base sequence quality | Base | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence quality | Mean | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence quality | Median | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence quality | Lower Quartile | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence quality | Upper Quartile | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence quality | 10th Percentile | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence quality | 90th Percentile | identical | 30 | 0 |  |
| ad4_after_13 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad4_after_13 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad4_after_13 | Per base sequence content | Base | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence content | G | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence content | A | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence content | T | identical | 30 | 0 |  |
| ad4_after_13 | Per base sequence content | C | identical | 30 | 0 |  |
| ad4_after_13 | Per base N content | Base | identical | 30 | 0 |  |
| ad4_after_13 | Per base N content | N-Count | identical | 30 | 0 |  |
| ad4_after_13 | Overrepresented sequences | Sequence | identical | 91 | 0 |  |
| ad4_after_13 | Overrepresented sequences | Count | identical | 91 | 0 |  |
| ad4_after_13 | Overrepresented sequences | Percentage | identical | 91 | 0 |  |
| ad4_after_13 | Overrepresented sequences | Possible Source | identical | 91 | 0 |  |
| ad4_after_13 | Adapter Content | Position | identical | 19 | 0 |  |
| ad4_after_13 | Adapter Content | Illumina Universal Adapter | identical | 19 | 0 |  |
| ad4_after_13 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 19 | 0 |  |
| ad4_after_13 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 19 | 0 |  |
| ad4_after_13 | Adapter Content | Nextera Transposase Sequence | identical | 19 | 0 |  |
| ad4_after_13 | Adapter Content | PolyA | identical | 19 | 0 |  |
| ad4_after_13 | Adapter Content | PolyG | identical | 19 | 0 |  |
| ad4_after_13 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad4_after_13 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad4_after_13 | Sequence Length Distribution | Length | identical | 19 | 0 |  |
| ad4_after_13 | Sequence Length Distribution | Count | identical | 19 | 0 |  |
| ad4_after_13 | Basic Statistics | flag | identical | 1 | 0 |  |
| ad4_after_13 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad4_after_13 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad4_after_13 | Per base sequence content | flag | identical | 1 | 0 |  |
| ad4_after_13 | Per base N content | flag | identical | 1 | 0 |  |
| ad4_after_13 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad4_after_13 | Adapter Content | flag | identical | 1 | 0 |  |
| ad4_after_13 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad4_after_long | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad4_after_long | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad4_after_long | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad4_after_long | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad4_after_long | Per base sequence quality | Base | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence quality | Mean | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence quality | Median | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence quality | Lower Quartile | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence quality | Upper Quartile | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence quality | 10th Percentile | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence quality | 90th Percentile | identical | 30 | 0 |  |
| ad4_after_long | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad4_after_long | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad4_after_long | Per base sequence content | Base | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence content | G | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence content | A | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence content | T | identical | 30 | 0 |  |
| ad4_after_long | Per base sequence content | C | identical | 30 | 0 |  |
| ad4_after_long | Per base N content | Base | identical | 30 | 0 |  |
| ad4_after_long | Per base N content | N-Count | identical | 30 | 0 |  |
| ad4_after_long | Overrepresented sequences | Sequence | identical | 91 | 0 |  |
| ad4_after_long | Overrepresented sequences | Count | identical | 91 | 0 |  |
| ad4_after_long | Overrepresented sequences | Percentage | identical | 91 | 0 |  |
| ad4_after_long | Overrepresented sequences | Possible Source | identical | 91 | 0 |  |
| ad4_after_long | Adapter Content | Position | identical | 19 | 0 |  |
| ad4_after_long | Adapter Content | Illumina Universal Adapter | identical | 19 | 0 |  |
| ad4_after_long | Adapter Content | Illumina Small RNA 3' Adapter | identical | 19 | 0 |  |
| ad4_after_long | Adapter Content | Illumina Small RNA 5' Adapter | identical | 19 | 0 |  |
| ad4_after_long | Adapter Content | Nextera Transposase Sequence | identical | 19 | 0 |  |
| ad4_after_long | Adapter Content | PolyA | identical | 19 | 0 |  |
| ad4_after_long | Adapter Content | PolyG | identical | 19 | 0 |  |
| ad4_after_long | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad4_after_long | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad4_after_long | Sequence Length Distribution | Length | identical | 19 | 0 |  |
| ad4_after_long | Sequence Length Distribution | Count | identical | 19 | 0 |  |
| ad4_after_long | Basic Statistics | flag | identical | 1 | 0 |  |
| ad4_after_long | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad4_after_long | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad4_after_long | Per base sequence content | flag | identical | 1 | 0 |  |
| ad4_after_long | Per base N content | flag | identical | 1 | 0 |  |
| ad4_after_long | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad4_after_long | Adapter Content | flag | identical | 1 | 0 |  |
| ad4_after_long | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ad4_mixed_order | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ad4_mixed_order | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ad4_mixed_order | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ad4_mixed_order | Basic Statistics | %GC | identical | 1 | 0 |  |
| ad4_mixed_order | Per base sequence quality | Base | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence quality | Mean | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence quality | Median | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence quality | Lower Quartile | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence quality | Upper Quartile | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence quality | 10th Percentile | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence quality | 90th Percentile | identical | 30 | 0 |  |
| ad4_mixed_order | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ad4_mixed_order | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ad4_mixed_order | Per base sequence content | Base | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence content | G | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence content | A | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence content | T | identical | 30 | 0 |  |
| ad4_mixed_order | Per base sequence content | C | identical | 30 | 0 |  |
| ad4_mixed_order | Per base N content | Base | identical | 30 | 0 |  |
| ad4_mixed_order | Per base N content | N-Count | identical | 30 | 0 |  |
| ad4_mixed_order | Overrepresented sequences | Sequence | identical | 91 | 0 |  |
| ad4_mixed_order | Overrepresented sequences | Count | identical | 91 | 0 |  |
| ad4_mixed_order | Overrepresented sequences | Percentage | identical | 91 | 0 |  |
| ad4_mixed_order | Overrepresented sequences | Possible Source | identical | 91 | 0 |  |
| ad4_mixed_order | Adapter Content | Position | identical | 19 | 0 |  |
| ad4_mixed_order | Adapter Content | Illumina Universal Adapter | identical | 19 | 0 |  |
| ad4_mixed_order | Adapter Content | Illumina Small RNA 3' Adapter | identical | 19 | 0 |  |
| ad4_mixed_order | Adapter Content | Illumina Small RNA 5' Adapter | identical | 19 | 0 |  |
| ad4_mixed_order | Adapter Content | Nextera Transposase Sequence | identical | 19 | 0 |  |
| ad4_mixed_order | Adapter Content | PolyA | identical | 19 | 0 |  |
| ad4_mixed_order | Adapter Content | PolyG | identical | 19 | 0 |  |
| ad4_mixed_order | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ad4_mixed_order | Per sequence GC content | Count | identical | 101 | 0 |  |
| ad4_mixed_order | Sequence Length Distribution | Length | identical | 19 | 0 |  |
| ad4_mixed_order | Sequence Length Distribution | Count | identical | 19 | 0 |  |
| ad4_mixed_order | Basic Statistics | flag | identical | 1 | 0 |  |
| ad4_mixed_order | Per base sequence quality | flag | identical | 1 | 0 |  |
| ad4_mixed_order | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ad4_mixed_order | Per base sequence content | flag | identical | 1 | 0 |  |
| ad4_mixed_order | Per base N content | flag | identical | 1 | 0 |  |
| ad4_mixed_order | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ad4_mixed_order | Adapter Content | flag | identical | 1 | 0 |  |
| ad4_mixed_order | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o1_L100 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o1_L100 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o1_L100 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o1_L100 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o1_L100 | Per base sequence quality | Base | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence quality | Mean | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence quality | Median | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence quality | Lower Quartile | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence quality | Upper Quartile | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence quality | 10th Percentile | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence quality | 90th Percentile | identical | 55 | 0 |  |
| ov1_o1_L100 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o1_L100 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o1_L100 | Per base sequence content | Base | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence content | G | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence content | A | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence content | T | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base sequence content | C | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base N content | Base | identical | 55 | 0 |  |
| ov1_o1_L100 | Per base N content | N-Count | identical | 55 | 0 |  |
| ov1_o1_L100 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov1_o1_L100 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov1_o1_L100 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov1_o1_L100 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov1_o1_L100 | Adapter Content | Position | identical | 49 | 0 |  |
| ov1_o1_L100 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov1_o1_L100 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov1_o1_L100 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov1_o1_L100 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov1_o1_L100 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov1_o1_L100 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov1_o1_L100 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o1_L100 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o1_L100 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o1_L100 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o1_L100 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o1_L100 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o1_L100 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o1_L100 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o1_L100 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o1_L100 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o1_L100 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o1_L100 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o1_L60 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o1_L60 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o1_L60 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o1_L60 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o1_L60 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov1_o1_L60 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o1_L60 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o1_L60 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence content | G | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence content | A | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence content | T | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base sequence content | C | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base N content | Base | identical | 60 | 0 |  |
| ov1_o1_L60 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov1_o1_L60 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov1_o1_L60 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov1_o1_L60 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov1_o1_L60 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov1_o1_L60 | Adapter Content | Position | identical | 49 | 0 |  |
| ov1_o1_L60 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov1_o1_L60 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov1_o1_L60 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov1_o1_L60 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov1_o1_L60 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov1_o1_L60 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov1_o1_L60 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o1_L60 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o1_L60 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o1_L60 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o1_L60 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o1_L60 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o1_L60 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o1_L60 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o1_L60 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o1_L60 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o1_L60 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o1_L60 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o1_L75 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o1_L75 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o1_L75 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o1_L75 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o1_L75 | Per base sequence quality | Base | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence quality | Mean | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence quality | Median | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence quality | Lower Quartile | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence quality | Upper Quartile | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence quality | 10th Percentile | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence quality | 90th Percentile | identical | 75 | 0 |  |
| ov1_o1_L75 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o1_L75 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o1_L75 | Per base sequence content | Base | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence content | G | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence content | A | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence content | T | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base sequence content | C | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base N content | Base | identical | 75 | 0 |  |
| ov1_o1_L75 | Per base N content | N-Count | identical | 75 | 0 |  |
| ov1_o1_L75 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov1_o1_L75 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov1_o1_L75 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov1_o1_L75 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov1_o1_L75 | Adapter Content | Position | identical | 64 | 0 |  |
| ov1_o1_L75 | Adapter Content | Illumina Universal Adapter | identical | 64 | 0 |  |
| ov1_o1_L75 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 64 | 0 |  |
| ov1_o1_L75 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 64 | 0 |  |
| ov1_o1_L75 | Adapter Content | Nextera Transposase Sequence | identical | 64 | 0 |  |
| ov1_o1_L75 | Adapter Content | PolyA | identical | 64 | 0 |  |
| ov1_o1_L75 | Adapter Content | PolyG | identical | 64 | 0 |  |
| ov1_o1_L75 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o1_L75 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o1_L75 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o1_L75 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o1_L75 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o1_L75 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o1_L75 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o1_L75 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o1_L75 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o1_L75 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o1_L75 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o1_L75 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o1_L76 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o1_L76 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o1_L76 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o1_L76 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o1_L76 | Per base sequence quality | Base | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence quality | Mean | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence quality | Median | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence quality | Lower Quartile | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence quality | Upper Quartile | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence quality | 10th Percentile | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence quality | 90th Percentile | identical | 43 | 0 |  |
| ov1_o1_L76 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o1_L76 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o1_L76 | Per base sequence content | Base | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence content | G | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence content | A | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence content | T | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base sequence content | C | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base N content | Base | identical | 43 | 0 |  |
| ov1_o1_L76 | Per base N content | N-Count | identical | 43 | 0 |  |
| ov1_o1_L76 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov1_o1_L76 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov1_o1_L76 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov1_o1_L76 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov1_o1_L76 | Adapter Content | Position | identical | 65 | 0 |  |
| ov1_o1_L76 | Adapter Content | Illumina Universal Adapter | identical | 65 | 0 |  |
| ov1_o1_L76 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 65 | 0 |  |
| ov1_o1_L76 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 65 | 0 |  |
| ov1_o1_L76 | Adapter Content | Nextera Transposase Sequence | identical | 65 | 0 |  |
| ov1_o1_L76 | Adapter Content | PolyA | identical | 65 | 0 |  |
| ov1_o1_L76 | Adapter Content | PolyG | identical | 65 | 0 |  |
| ov1_o1_L76 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o1_L76 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o1_L76 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o1_L76 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o1_L76 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o1_L76 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o1_L76 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o1_L76 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o1_L76 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o1_L76 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o1_L76 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o1_L76 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o4_1 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o4_1 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o4_1 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o4_1 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o4_1 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov1_o4_1 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o4_1 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o4_1 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence content | G | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence content | A | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence content | T | identical | 60 | 0 |  |
| ov1_o4_1 | Per base sequence content | C | identical | 60 | 0 |  |
| ov1_o4_1 | Per base N content | Base | identical | 60 | 0 |  |
| ov1_o4_1 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov1_o4_1 | Overrepresented sequences | Sequence | identical | 0 | 0 |  |
| ov1_o4_1 | Overrepresented sequences | Count | identical | 0 | 0 |  |
| ov1_o4_1 | Overrepresented sequences | Percentage | identical | 0 | 0 |  |
| ov1_o4_1 | Overrepresented sequences | Possible Source | identical | 0 | 0 |  |
| ov1_o4_1 | Adapter Content | Position | identical | 49 | 0 |  |
| ov1_o4_1 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov1_o4_1 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov1_o4_1 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov1_o4_1 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov1_o4_1 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov1_o4_1 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov1_o4_1 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o4_1 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o4_1 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o4_1 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o4_1 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o4_1 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o4_1 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o4_1 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o4_1 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o4_1 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o4_1 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o4_1 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o4_2 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o4_2 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o4_2 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o4_2 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o4_2 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov1_o4_2 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o4_2 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o4_2 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence content | G | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence content | A | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence content | T | identical | 60 | 0 |  |
| ov1_o4_2 | Per base sequence content | C | identical | 60 | 0 |  |
| ov1_o4_2 | Per base N content | Base | identical | 60 | 0 |  |
| ov1_o4_2 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov1_o4_2 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov1_o4_2 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov1_o4_2 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov1_o4_2 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov1_o4_2 | Adapter Content | Position | identical | 49 | 0 |  |
| ov1_o4_2 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov1_o4_2 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov1_o4_2 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov1_o4_2 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov1_o4_2 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov1_o4_2 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov1_o4_2 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o4_2 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o4_2 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o4_2 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o4_2 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o4_2 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o4_2 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o4_2 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o4_2 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o4_2 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o4_2 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o4_2 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o5 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o5 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o5 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o5 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o5 | Per base sequence quality | Base | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence quality | Mean | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence quality | Median | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence quality | Lower Quartile | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence quality | Upper Quartile | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence quality | 10th Percentile | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence quality | 90th Percentile | identical | 40 | 0 |  |
| ov1_o5 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o5 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o5 | Per base sequence content | Base | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence content | G | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence content | A | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence content | T | identical | 40 | 0 |  |
| ov1_o5 | Per base sequence content | C | identical | 40 | 0 |  |
| ov1_o5 | Per base N content | Base | identical | 40 | 0 |  |
| ov1_o5 | Per base N content | N-Count | identical | 40 | 0 |  |
| ov1_o5 | Overrepresented sequences | Sequence | identical | 3 | 0 |  |
| ov1_o5 | Overrepresented sequences | Count | identical | 3 | 0 |  |
| ov1_o5 | Overrepresented sequences | Percentage | identical | 3 | 0 |  |
| ov1_o5 | Overrepresented sequences | Possible Source | identical | 3 | 0 |  |
| ov1_o5 | Adapter Content | Position | identical | 29 | 0 |  |
| ov1_o5 | Adapter Content | Illumina Universal Adapter | identical | 29 | 0 |  |
| ov1_o5 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 29 | 0 |  |
| ov1_o5 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 29 | 0 |  |
| ov1_o5 | Adapter Content | Nextera Transposase Sequence | identical | 29 | 0 |  |
| ov1_o5 | Adapter Content | PolyA | identical | 29 | 0 |  |
| ov1_o5 | Adapter Content | PolyG | identical | 29 | 0 |  |
| ov1_o5 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o5 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o5 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o5 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o5 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o5 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o5 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o5 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o5 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o5 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o5 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o5 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o7 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o7 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o7 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o7 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o7 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov1_o7 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o7 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o7 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence content | G | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence content | A | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence content | T | identical | 60 | 0 |  |
| ov1_o7 | Per base sequence content | C | identical | 60 | 0 |  |
| ov1_o7 | Per base N content | Base | identical | 60 | 0 |  |
| ov1_o7 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov1_o7 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov1_o7 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov1_o7 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov1_o7 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov1_o7 | Adapter Content | Position | identical | 49 | 0 |  |
| ov1_o7 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov1_o7 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov1_o7 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov1_o7 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov1_o7 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov1_o7 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov1_o7 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o7 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o7 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o7 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o7 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o7 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o7 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o7 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o7 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o7 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o7 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o7 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o8 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o8 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o8 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o8 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o8 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov1_o8 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o8 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o8 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence content | G | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence content | A | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence content | T | identical | 60 | 0 |  |
| ov1_o8 | Per base sequence content | C | identical | 60 | 0 |  |
| ov1_o8 | Per base N content | Base | identical | 60 | 0 |  |
| ov1_o8 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov1_o8 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov1_o8 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov1_o8 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov1_o8 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov1_o8 | Adapter Content | Position | identical | 49 | 0 |  |
| ov1_o8 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov1_o8 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov1_o8 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov1_o8 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov1_o8 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov1_o8 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov1_o8 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o8 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o8 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o8 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o8 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o8 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o8 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o8 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o8 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o8 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o8 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o8 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o9_10 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o9_10 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o9_10 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o9_10 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o9_10 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov1_o9_10 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o9_10 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o9_10 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence content | G | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence content | A | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence content | T | identical | 60 | 0 |  |
| ov1_o9_10 | Per base sequence content | C | identical | 60 | 0 |  |
| ov1_o9_10 | Per base N content | Base | identical | 60 | 0 |  |
| ov1_o9_10 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov1_o9_10 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov1_o9_10 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov1_o9_10 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov1_o9_10 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov1_o9_10 | Adapter Content | Position | identical | 49 | 0 |  |
| ov1_o9_10 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov1_o9_10 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov1_o9_10 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov1_o9_10 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov1_o9_10 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov1_o9_10 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov1_o9_10 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o9_10 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o9_10 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o9_10 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o9_10 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o9_10 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o9_10 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o9_10 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o9_10 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o9_10 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o9_10 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o9_10 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov1_o9_11 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov1_o9_11 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov1_o9_11 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov1_o9_11 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov1_o9_11 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov1_o9_11 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov1_o9_11 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov1_o9_11 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence content | G | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence content | A | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence content | T | identical | 60 | 0 |  |
| ov1_o9_11 | Per base sequence content | C | identical | 60 | 0 |  |
| ov1_o9_11 | Per base N content | Base | identical | 60 | 0 |  |
| ov1_o9_11 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov1_o9_11 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov1_o9_11 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov1_o9_11 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov1_o9_11 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov1_o9_11 | Adapter Content | Position | identical | 49 | 0 |  |
| ov1_o9_11 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov1_o9_11 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov1_o9_11 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov1_o9_11 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov1_o9_11 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov1_o9_11 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov1_o9_11 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov1_o9_11 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov1_o9_11 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov1_o9_11 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov1_o9_11 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov1_o9_11 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov1_o9_11 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov1_o9_11 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov1_o9_11 | Per base N content | flag | identical | 1 | 0 |  |
| ov1_o9_11 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov1_o9_11 | Adapter Content | flag | identical | 1 | 0 |  |
| ov1_o9_11 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov2_t0 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov2_t0 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov2_t0 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov2_t0 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov2_t0 | Per base sequence quality | Base | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence quality | Mean | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence quality | Median | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence quality | Lower Quartile | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence quality | Upper Quartile | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence quality | 10th Percentile | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence quality | 90th Percentile | identical | 40 | 0 |  |
| ov2_t0 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov2_t0 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov2_t0 | Per base sequence content | Base | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence content | G | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence content | A | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence content | T | identical | 40 | 0 |  |
| ov2_t0 | Per base sequence content | C | identical | 40 | 0 |  |
| ov2_t0 | Per base N content | Base | identical | 40 | 0 |  |
| ov2_t0 | Per base N content | N-Count | identical | 40 | 0 |  |
| ov2_t0 | Overrepresented sequences | Sequence | identical | 5 | 0 |  |
| ov2_t0 | Overrepresented sequences | Count | identical | 5 | 0 |  |
| ov2_t0 | Overrepresented sequences | Percentage | identical | 5 | 0 |  |
| ov2_t0 | Overrepresented sequences | Possible Source | identical | 5 | 0 |  |
| ov2_t0 | Adapter Content | Position | identical | 29 | 0 |  |
| ov2_t0 | Adapter Content | Illumina Universal Adapter | identical | 29 | 0 |  |
| ov2_t0 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 29 | 0 |  |
| ov2_t0 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 29 | 0 |  |
| ov2_t0 | Adapter Content | Nextera Transposase Sequence | identical | 29 | 0 |  |
| ov2_t0 | Adapter Content | PolyA | identical | 29 | 0 |  |
| ov2_t0 | Adapter Content | PolyG | identical | 29 | 0 |  |
| ov2_t0 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov2_t0 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov2_t0 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov2_t0 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov2_t0 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov2_t0 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov2_t0 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov2_t0 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov2_t0 | Per base N content | flag | identical | 1 | 0 |  |
| ov2_t0 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov2_t0 | Adapter Content | flag | identical | 1 | 0 |  |
| ov2_t0 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov2_t1 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov2_t1 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov2_t1 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov2_t1 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov2_t1 | Per base sequence quality | Base | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence quality | Mean | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence quality | Median | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence quality | Lower Quartile | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence quality | Upper Quartile | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence quality | 10th Percentile | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence quality | 90th Percentile | identical | 40 | 0 |  |
| ov2_t1 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov2_t1 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov2_t1 | Per base sequence content | Base | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence content | G | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence content | A | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence content | T | identical | 40 | 0 |  |
| ov2_t1 | Per base sequence content | C | identical | 40 | 0 |  |
| ov2_t1 | Per base N content | Base | identical | 40 | 0 |  |
| ov2_t1 | Per base N content | N-Count | identical | 40 | 0 |  |
| ov2_t1 | Overrepresented sequences | Sequence | identical | 5 | 0 |  |
| ov2_t1 | Overrepresented sequences | Count | identical | 5 | 0 |  |
| ov2_t1 | Overrepresented sequences | Percentage | identical | 5 | 0 |  |
| ov2_t1 | Overrepresented sequences | Possible Source | identical | 5 | 0 |  |
| ov2_t1 | Adapter Content | Position | identical | 29 | 0 |  |
| ov2_t1 | Adapter Content | Illumina Universal Adapter | identical | 29 | 0 |  |
| ov2_t1 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 29 | 0 |  |
| ov2_t1 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 29 | 0 |  |
| ov2_t1 | Adapter Content | Nextera Transposase Sequence | identical | 29 | 0 |  |
| ov2_t1 | Adapter Content | PolyA | identical | 29 | 0 |  |
| ov2_t1 | Adapter Content | PolyG | identical | 29 | 0 |  |
| ov2_t1 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov2_t1 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov2_t1 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov2_t1 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov2_t1 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov2_t1 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov2_t1 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov2_t1 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov2_t1 | Per base N content | flag | identical | 1 | 0 |  |
| ov2_t1 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov2_t1 | Adapter Content | flag | identical | 1 | 0 |  |
| ov2_t1 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov2_t2 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov2_t2 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov2_t2 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov2_t2 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov2_t2 | Per base sequence quality | Base | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence quality | Mean | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence quality | Median | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence quality | Lower Quartile | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence quality | Upper Quartile | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence quality | 10th Percentile | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence quality | 90th Percentile | identical | 40 | 0 |  |
| ov2_t2 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov2_t2 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov2_t2 | Per base sequence content | Base | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence content | G | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence content | A | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence content | T | identical | 40 | 0 |  |
| ov2_t2 | Per base sequence content | C | identical | 40 | 0 |  |
| ov2_t2 | Per base N content | Base | identical | 40 | 0 |  |
| ov2_t2 | Per base N content | N-Count | identical | 40 | 0 |  |
| ov2_t2 | Overrepresented sequences | Sequence | identical | 5 | 0 |  |
| ov2_t2 | Overrepresented sequences | Count | identical | 5 | 0 |  |
| ov2_t2 | Overrepresented sequences | Percentage | identical | 5 | 0 |  |
| ov2_t2 | Overrepresented sequences | Possible Source | identical | 5 | 0 |  |
| ov2_t2 | Adapter Content | Position | identical | 29 | 0 |  |
| ov2_t2 | Adapter Content | Illumina Universal Adapter | identical | 29 | 0 |  |
| ov2_t2 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 29 | 0 |  |
| ov2_t2 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 29 | 0 |  |
| ov2_t2 | Adapter Content | Nextera Transposase Sequence | identical | 29 | 0 |  |
| ov2_t2 | Adapter Content | PolyA | identical | 29 | 0 |  |
| ov2_t2 | Adapter Content | PolyG | identical | 29 | 0 |  |
| ov2_t2 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov2_t2 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov2_t2 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov2_t2 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov2_t2 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov2_t2 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov2_t2 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov2_t2 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov2_t2 | Per base N content | flag | identical | 1 | 0 |  |
| ov2_t2 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov2_t2 | Adapter Content | flag | identical | 1 | 0 |  |
| ov2_t2 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov2_t3 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov2_t3 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov2_t3 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov2_t3 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov2_t3 | Per base sequence quality | Base | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence quality | Mean | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence quality | Median | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence quality | Lower Quartile | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence quality | Upper Quartile | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence quality | 10th Percentile | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence quality | 90th Percentile | identical | 40 | 0 |  |
| ov2_t3 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov2_t3 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov2_t3 | Per base sequence content | Base | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence content | G | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence content | A | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence content | T | identical | 40 | 0 |  |
| ov2_t3 | Per base sequence content | C | identical | 40 | 0 |  |
| ov2_t3 | Per base N content | Base | identical | 40 | 0 |  |
| ov2_t3 | Per base N content | N-Count | identical | 40 | 0 |  |
| ov2_t3 | Overrepresented sequences | Sequence | identical | 5 | 0 |  |
| ov2_t3 | Overrepresented sequences | Count | identical | 5 | 0 |  |
| ov2_t3 | Overrepresented sequences | Percentage | identical | 5 | 0 |  |
| ov2_t3 | Overrepresented sequences | Possible Source | identical | 5 | 0 |  |
| ov2_t3 | Adapter Content | Position | identical | 29 | 0 |  |
| ov2_t3 | Adapter Content | Illumina Universal Adapter | identical | 29 | 0 |  |
| ov2_t3 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 29 | 0 |  |
| ov2_t3 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 29 | 0 |  |
| ov2_t3 | Adapter Content | Nextera Transposase Sequence | identical | 29 | 0 |  |
| ov2_t3 | Adapter Content | PolyA | identical | 29 | 0 |  |
| ov2_t3 | Adapter Content | PolyG | identical | 29 | 0 |  |
| ov2_t3 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov2_t3 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov2_t3 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov2_t3 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov2_t3 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov2_t3 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov2_t3 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov2_t3 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov2_t3 | Per base N content | flag | identical | 1 | 0 |  |
| ov2_t3 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov2_t3 | Adapter Content | flag | identical | 1 | 0 |  |
| ov2_t3 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov2_t4 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov2_t4 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov2_t4 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov2_t4 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov2_t4 | Per base sequence quality | Base | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence quality | Mean | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence quality | Median | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence quality | Lower Quartile | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence quality | Upper Quartile | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence quality | 10th Percentile | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence quality | 90th Percentile | identical | 40 | 0 |  |
| ov2_t4 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov2_t4 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov2_t4 | Per base sequence content | Base | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence content | G | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence content | A | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence content | T | identical | 40 | 0 |  |
| ov2_t4 | Per base sequence content | C | identical | 40 | 0 |  |
| ov2_t4 | Per base N content | Base | identical | 40 | 0 |  |
| ov2_t4 | Per base N content | N-Count | identical | 40 | 0 |  |
| ov2_t4 | Overrepresented sequences | Sequence | identical | 5 | 0 |  |
| ov2_t4 | Overrepresented sequences | Count | identical | 5 | 0 |  |
| ov2_t4 | Overrepresented sequences | Percentage | identical | 5 | 0 |  |
| ov2_t4 | Overrepresented sequences | Possible Source | identical | 5 | 0 |  |
| ov2_t4 | Adapter Content | Position | identical | 29 | 0 |  |
| ov2_t4 | Adapter Content | Illumina Universal Adapter | identical | 29 | 0 |  |
| ov2_t4 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 29 | 0 |  |
| ov2_t4 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 29 | 0 |  |
| ov2_t4 | Adapter Content | Nextera Transposase Sequence | identical | 29 | 0 |  |
| ov2_t4 | Adapter Content | PolyA | identical | 29 | 0 |  |
| ov2_t4 | Adapter Content | PolyG | identical | 29 | 0 |  |
| ov2_t4 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov2_t4 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov2_t4 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov2_t4 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov2_t4 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov2_t4 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov2_t4 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov2_t4 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov2_t4 | Per base N content | flag | identical | 1 | 0 |  |
| ov2_t4 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov2_t4 | Adapter Content | flag | identical | 1 | 0 |  |
| ov2_t4 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov2_t5 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov2_t5 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov2_t5 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov2_t5 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov2_t5 | Per base sequence quality | Base | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence quality | Mean | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence quality | Median | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence quality | Lower Quartile | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence quality | Upper Quartile | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence quality | 10th Percentile | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence quality | 90th Percentile | identical | 40 | 0 |  |
| ov2_t5 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov2_t5 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov2_t5 | Per base sequence content | Base | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence content | G | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence content | A | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence content | T | identical | 40 | 0 |  |
| ov2_t5 | Per base sequence content | C | identical | 40 | 0 |  |
| ov2_t5 | Per base N content | Base | identical | 40 | 0 |  |
| ov2_t5 | Per base N content | N-Count | identical | 40 | 0 |  |
| ov2_t5 | Overrepresented sequences | Sequence | identical | 5 | 0 |  |
| ov2_t5 | Overrepresented sequences | Count | identical | 5 | 0 |  |
| ov2_t5 | Overrepresented sequences | Percentage | identical | 5 | 0 |  |
| ov2_t5 | Overrepresented sequences | Possible Source | identical | 5 | 0 |  |
| ov2_t5 | Adapter Content | Position | identical | 29 | 0 |  |
| ov2_t5 | Adapter Content | Illumina Universal Adapter | identical | 29 | 0 |  |
| ov2_t5 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 29 | 0 |  |
| ov2_t5 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 29 | 0 |  |
| ov2_t5 | Adapter Content | Nextera Transposase Sequence | identical | 29 | 0 |  |
| ov2_t5 | Adapter Content | PolyA | identical | 29 | 0 |  |
| ov2_t5 | Adapter Content | PolyG | identical | 29 | 0 |  |
| ov2_t5 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov2_t5 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov2_t5 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov2_t5 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov2_t5 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov2_t5 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov2_t5 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov2_t5 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov2_t5 | Per base N content | flag | identical | 1 | 0 |  |
| ov2_t5 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov2_t5 | Adapter Content | flag | identical | 1 | 0 |  |
| ov2_t5 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov3_L1 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov3_L1 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov3_L1 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov3_L1 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov3_L1 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov3_L1 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov3_L1 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov3_L1 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence content | G | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence content | A | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence content | T | identical | 60 | 0 |  |
| ov3_L1 | Per base sequence content | C | identical | 60 | 0 |  |
| ov3_L1 | Per base N content | Base | identical | 60 | 0 |  |
| ov3_L1 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov3_L1 | Overrepresented sequences | Sequence | identical | 0 | 0 |  |
| ov3_L1 | Overrepresented sequences | Count | identical | 0 | 0 |  |
| ov3_L1 | Overrepresented sequences | Percentage | identical | 0 | 0 |  |
| ov3_L1 | Overrepresented sequences | Possible Source | identical | 0 | 0 |  |
| ov3_L1 | Adapter Content | Position | identical | 49 | 0 |  |
| ov3_L1 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov3_L1 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov3_L1 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov3_L1 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov3_L1 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov3_L1 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov3_L1 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov3_L1 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov3_L1 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov3_L1 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov3_L1 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov3_L1 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov3_L1 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov3_L1 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov3_L1 | Per base N content | flag | identical | 1 | 0 |  |
| ov3_L1 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov3_L1 | Adapter Content | flag | identical | 1 | 0 |  |
| ov3_L1 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov3_L2 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov3_L2 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov3_L2 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov3_L2 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov3_L2 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov3_L2 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov3_L2 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov3_L2 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence content | G | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence content | A | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence content | T | identical | 60 | 0 |  |
| ov3_L2 | Per base sequence content | C | identical | 60 | 0 |  |
| ov3_L2 | Per base N content | Base | identical | 60 | 0 |  |
| ov3_L2 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov3_L2 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| ov3_L2 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| ov3_L2 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| ov3_L2 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| ov3_L2 | Adapter Content | Position | identical | 49 | 0 |  |
| ov3_L2 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov3_L2 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov3_L2 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov3_L2 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov3_L2 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov3_L2 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov3_L2 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov3_L2 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov3_L2 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov3_L2 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov3_L2 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov3_L2 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov3_L2 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov3_L2 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov3_L2 | Per base N content | flag | identical | 1 | 0 |  |
| ov3_L2 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov3_L2 | Adapter Content | flag | identical | 1 | 0 |  |
| ov3_L2 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov4_B100000 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov4_B100000 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov4_B100000 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov4_B100000 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov4_B100000 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov4_B100000 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov4_B100000 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov4_B100000 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence content | G | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence content | A | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence content | T | identical | 60 | 0 |  |
| ov4_B100000 | Per base sequence content | C | identical | 60 | 0 |  |
| ov4_B100000 | Per base N content | Base | identical | 60 | 0 |  |
| ov4_B100000 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov4_B100000 | Overrepresented sequences | Sequence | identical | 0 | 0 |  |
| ov4_B100000 | Overrepresented sequences | Count | identical | 0 | 0 |  |
| ov4_B100000 | Overrepresented sequences | Percentage | identical | 0 | 0 |  |
| ov4_B100000 | Overrepresented sequences | Possible Source | identical | 0 | 0 |  |
| ov4_B100000 | Adapter Content | Position | identical | 49 | 0 |  |
| ov4_B100000 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov4_B100000 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov4_B100000 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov4_B100000 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov4_B100000 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov4_B100000 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov4_B100000 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov4_B100000 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov4_B100000 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov4_B100000 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov4_B100000 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov4_B100000 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov4_B100000 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov4_B100000 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov4_B100000 | Per base N content | flag | identical | 1 | 0 |  |
| ov4_B100000 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov4_B100000 | Adapter Content | flag | identical | 1 | 0 |  |
| ov4_B100000 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov4_B99999 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov4_B99999 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov4_B99999 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov4_B99999 | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov4_B99999 | Per base sequence quality | Base | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence quality | Mean | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence quality | Median | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence quality | Lower Quartile | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence quality | Upper Quartile | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence quality | 10th Percentile | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence quality | 90th Percentile | identical | 60 | 0 |  |
| ov4_B99999 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov4_B99999 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov4_B99999 | Per base sequence content | Base | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence content | G | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence content | A | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence content | T | identical | 60 | 0 |  |
| ov4_B99999 | Per base sequence content | C | identical | 60 | 0 |  |
| ov4_B99999 | Per base N content | Base | identical | 60 | 0 |  |
| ov4_B99999 | Per base N content | N-Count | identical | 60 | 0 |  |
| ov4_B99999 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| ov4_B99999 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| ov4_B99999 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| ov4_B99999 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| ov4_B99999 | Adapter Content | Position | identical | 49 | 0 |  |
| ov4_B99999 | Adapter Content | Illumina Universal Adapter | identical | 49 | 0 |  |
| ov4_B99999 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 49 | 0 |  |
| ov4_B99999 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 49 | 0 |  |
| ov4_B99999 | Adapter Content | Nextera Transposase Sequence | identical | 49 | 0 |  |
| ov4_B99999 | Adapter Content | PolyA | identical | 49 | 0 |  |
| ov4_B99999 | Adapter Content | PolyG | identical | 49 | 0 |  |
| ov4_B99999 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov4_B99999 | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov4_B99999 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov4_B99999 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov4_B99999 | Basic Statistics | flag | identical | 1 | 0 |  |
| ov4_B99999 | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov4_B99999 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov4_B99999 | Per base sequence content | flag | identical | 1 | 0 |  |
| ov4_B99999 | Per base N content | flag | identical | 1 | 0 |  |
| ov4_B99999 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov4_B99999 | Adapter Content | flag | identical | 1 | 0 |  |
| ov4_B99999 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov5_c | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov5_c | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov5_c | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov5_c | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov5_c | Per base sequence quality | Base | identical | 50 | 0 |  |
| ov5_c | Per base sequence quality | Mean | identical | 50 | 0 |  |
| ov5_c | Per base sequence quality | Median | identical | 50 | 0 |  |
| ov5_c | Per base sequence quality | Lower Quartile | identical | 50 | 0 |  |
| ov5_c | Per base sequence quality | Upper Quartile | identical | 50 | 0 |  |
| ov5_c | Per base sequence quality | 10th Percentile | identical | 50 | 0 |  |
| ov5_c | Per base sequence quality | 90th Percentile | identical | 50 | 0 |  |
| ov5_c | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov5_c | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov5_c | Per base sequence content | Base | identical | 50 | 0 |  |
| ov5_c | Per base sequence content | G | identical | 50 | 0 |  |
| ov5_c | Per base sequence content | A | identical | 50 | 0 |  |
| ov5_c | Per base sequence content | T | identical | 50 | 0 |  |
| ov5_c | Per base sequence content | C | identical | 50 | 0 |  |
| ov5_c | Per base N content | Base | identical | 50 | 0 |  |
| ov5_c | Per base N content | N-Count | identical | 50 | 0 |  |
| ov5_c | Overrepresented sequences | Sequence | identical | 13 | 0 |  |
| ov5_c | Overrepresented sequences | Count | identical | 13 | 0 |  |
| ov5_c | Overrepresented sequences | Percentage | identical | 13 | 0 |  |
| ov5_c | Overrepresented sequences | Possible Source | identical | 13 | 0 |  |
| ov5_c | Adapter Content | Position | identical | 39 | 0 |  |
| ov5_c | Adapter Content | Illumina Universal Adapter | identical | 39 | 0 |  |
| ov5_c | Adapter Content | Illumina Small RNA 3' Adapter | identical | 39 | 0 |  |
| ov5_c | Adapter Content | Illumina Small RNA 5' Adapter | identical | 39 | 0 |  |
| ov5_c | Adapter Content | Nextera Transposase Sequence | identical | 39 | 0 |  |
| ov5_c | Adapter Content | PolyA | identical | 39 | 0 |  |
| ov5_c | Adapter Content | PolyG | identical | 39 | 0 |  |
| ov5_c | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov5_c | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov5_c | Sequence Length Distribution | Length | identical | 21 | 0 |  |
| ov5_c | Sequence Length Distribution | Count | identical | 21 | 0 |  |
| ov5_c | Basic Statistics | flag | identical | 1 | 0 |  |
| ov5_c | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov5_c | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov5_c | Per base sequence content | flag | identical | 1 | 0 |  |
| ov5_c | Per base N content | flag | identical | 1 | 0 |  |
| ov5_c | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov5_c | Adapter Content | flag | identical | 1 | 0 |  |
| ov5_c | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov6_d | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov6_d | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov6_d | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov6_d | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov6_d | Per base sequence quality | Base | identical | 50 | 0 |  |
| ov6_d | Per base sequence quality | Mean | identical | 50 | 0 |  |
| ov6_d | Per base sequence quality | Median | identical | 50 | 0 |  |
| ov6_d | Per base sequence quality | Lower Quartile | identical | 50 | 0 |  |
| ov6_d | Per base sequence quality | Upper Quartile | identical | 50 | 0 |  |
| ov6_d | Per base sequence quality | 10th Percentile | identical | 50 | 0 |  |
| ov6_d | Per base sequence quality | 90th Percentile | identical | 50 | 0 |  |
| ov6_d | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov6_d | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov6_d | Per base sequence content | Base | identical | 50 | 0 |  |
| ov6_d | Per base sequence content | G | identical | 50 | 0 |  |
| ov6_d | Per base sequence content | A | identical | 50 | 0 |  |
| ov6_d | Per base sequence content | T | identical | 50 | 0 |  |
| ov6_d | Per base sequence content | C | identical | 50 | 0 |  |
| ov6_d | Per base N content | Base | identical | 50 | 0 |  |
| ov6_d | Per base N content | N-Count | identical | 50 | 0 |  |
| ov6_d | Overrepresented sequences | Sequence | identical | 7 | 0 |  |
| ov6_d | Overrepresented sequences | Count | identical | 7 | 0 |  |
| ov6_d | Overrepresented sequences | Percentage | identical | 7 | 0 |  |
| ov6_d | Overrepresented sequences | Possible Source | identical | 7 | 0 |  |
| ov6_d | Adapter Content | Position | identical | 39 | 0 |  |
| ov6_d | Adapter Content | Illumina Universal Adapter | identical | 39 | 0 |  |
| ov6_d | Adapter Content | Illumina Small RNA 3' Adapter | identical | 39 | 0 |  |
| ov6_d | Adapter Content | Illumina Small RNA 5' Adapter | identical | 39 | 0 |  |
| ov6_d | Adapter Content | Nextera Transposase Sequence | identical | 39 | 0 |  |
| ov6_d | Adapter Content | PolyA | identical | 39 | 0 |  |
| ov6_d | Adapter Content | PolyG | identical | 39 | 0 |  |
| ov6_d | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov6_d | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov6_d | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov6_d | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov6_d | Basic Statistics | flag | identical | 1 | 0 |  |
| ov6_d | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov6_d | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov6_d | Per base sequence content | flag | identical | 1 | 0 |  |
| ov6_d | Per base N content | flag | identical | 1 | 0 |  |
| ov6_d | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov6_d | Adapter Content | flag | identical | 1 | 0 |  |
| ov6_d | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov7_e | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov7_e | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov7_e | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov7_e | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov7_e | Per base sequence quality | Base | identical | 50 | 0 |  |
| ov7_e | Per base sequence quality | Mean | identical | 50 | 0 |  |
| ov7_e | Per base sequence quality | Median | identical | 50 | 0 |  |
| ov7_e | Per base sequence quality | Lower Quartile | identical | 50 | 0 |  |
| ov7_e | Per base sequence quality | Upper Quartile | identical | 50 | 0 |  |
| ov7_e | Per base sequence quality | 10th Percentile | identical | 50 | 0 |  |
| ov7_e | Per base sequence quality | 90th Percentile | identical | 50 | 0 |  |
| ov7_e | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov7_e | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov7_e | Per base sequence content | Base | identical | 50 | 0 |  |
| ov7_e | Per base sequence content | G | identical | 50 | 0 |  |
| ov7_e | Per base sequence content | A | identical | 50 | 0 |  |
| ov7_e | Per base sequence content | T | identical | 50 | 0 |  |
| ov7_e | Per base sequence content | C | identical | 50 | 0 |  |
| ov7_e | Per base N content | Base | identical | 50 | 0 |  |
| ov7_e | Per base N content | N-Count | identical | 50 | 0 |  |
| ov7_e | Overrepresented sequences | Sequence | identical | 14 | 0 |  |
| ov7_e | Overrepresented sequences | Count | identical | 14 | 0 |  |
| ov7_e | Overrepresented sequences | Percentage | identical | 14 | 0 |  |
| ov7_e | Overrepresented sequences | Possible Source | identical | 14 | 0 |  |
| ov7_e | Adapter Content | Position | identical | 39 | 0 |  |
| ov7_e | Adapter Content | Illumina Universal Adapter | identical | 39 | 0 |  |
| ov7_e | Adapter Content | Illumina Small RNA 3' Adapter | identical | 39 | 0 |  |
| ov7_e | Adapter Content | Illumina Small RNA 5' Adapter | identical | 39 | 0 |  |
| ov7_e | Adapter Content | Nextera Transposase Sequence | identical | 39 | 0 |  |
| ov7_e | Adapter Content | PolyA | identical | 39 | 0 |  |
| ov7_e | Adapter Content | PolyG | identical | 39 | 0 |  |
| ov7_e | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov7_e | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov7_e | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| ov7_e | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| ov7_e | Basic Statistics | flag | identical | 1 | 0 |  |
| ov7_e | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov7_e | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov7_e | Per base sequence content | flag | identical | 1 | 0 |  |
| ov7_e | Per base N content | flag | identical | 1 | 0 |  |
| ov7_e | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov7_e | Adapter Content | flag | identical | 1 | 0 |  |
| ov7_e | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov8_s | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov8_s | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov8_s | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov8_s | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov8_s | Per base sequence quality | Base | identical | 50 | 0 |  |
| ov8_s | Per base sequence quality | Mean | identical | 50 | 0 |  |
| ov8_s | Per base sequence quality | Median | identical | 50 | 0 |  |
| ov8_s | Per base sequence quality | Lower Quartile | identical | 50 | 0 |  |
| ov8_s | Per base sequence quality | Upper Quartile | identical | 50 | 0 |  |
| ov8_s | Per base sequence quality | 10th Percentile | identical | 50 | 0 |  |
| ov8_s | Per base sequence quality | 90th Percentile | identical | 50 | 0 |  |
| ov8_s | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov8_s | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov8_s | Per base sequence content | Base | identical | 50 | 0 |  |
| ov8_s | Per base sequence content | G | identical | 50 | 0 |  |
| ov8_s | Per base sequence content | A | identical | 50 | 0 |  |
| ov8_s | Per base sequence content | T | identical | 50 | 0 |  |
| ov8_s | Per base sequence content | C | identical | 50 | 0 |  |
| ov8_s | Per base N content | Base | identical | 50 | 0 |  |
| ov8_s | Per base N content | N-Count | identical | 50 | 0 |  |
| ov8_s | Overrepresented sequences | Sequence | identical | 16 | 0 |  |
| ov8_s | Overrepresented sequences | Count | identical | 16 | 0 |  |
| ov8_s | Overrepresented sequences | Percentage | identical | 16 | 0 |  |
| ov8_s | Overrepresented sequences | Possible Source | identical | 16 | 0 |  |
| ov8_s | Adapter Content | Position | identical | 39 | 0 |  |
| ov8_s | Adapter Content | Illumina Universal Adapter | identical | 39 | 0 |  |
| ov8_s | Adapter Content | Illumina Small RNA 3' Adapter | identical | 39 | 0 |  |
| ov8_s | Adapter Content | Illumina Small RNA 5' Adapter | identical | 39 | 0 |  |
| ov8_s | Adapter Content | Nextera Transposase Sequence | identical | 39 | 0 |  |
| ov8_s | Adapter Content | PolyA | identical | 39 | 0 |  |
| ov8_s | Adapter Content | PolyG | identical | 39 | 0 |  |
| ov8_s | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov8_s | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov8_s | Sequence Length Distribution | Length | identical | 41 | 0 |  |
| ov8_s | Sequence Length Distribution | Count | identical | 41 | 0 |  |
| ov8_s | Basic Statistics | flag | identical | 1 | 0 |  |
| ov8_s | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov8_s | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov8_s | Per base sequence content | flag | identical | 1 | 0 |  |
| ov8_s | Per base N content | flag | identical | 1 | 0 |  |
| ov8_s | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov8_s | Adapter Content | flag | identical | 1 | 0 |  |
| ov8_s | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ov9_v | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ov9_v | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ov9_v | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ov9_v | Basic Statistics | %GC | identical | 1 | 0 |  |
| ov9_v | Per base sequence quality | Base | identical | 30 | 0 |  |
| ov9_v | Per base sequence quality | Mean | identical | 30 | 0 |  |
| ov9_v | Per base sequence quality | Median | identical | 30 | 0 |  |
| ov9_v | Per base sequence quality | Lower Quartile | identical | 30 | 0 |  |
| ov9_v | Per base sequence quality | Upper Quartile | identical | 30 | 0 |  |
| ov9_v | Per base sequence quality | 10th Percentile | identical | 30 | 0 |  |
| ov9_v | Per base sequence quality | 90th Percentile | identical | 30 | 0 |  |
| ov9_v | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| ov9_v | Per sequence quality scores | Count | identical | 1 | 0 |  |
| ov9_v | Per base sequence content | Base | identical | 30 | 0 |  |
| ov9_v | Per base sequence content | G | identical | 30 | 0 |  |
| ov9_v | Per base sequence content | A | identical | 30 | 0 |  |
| ov9_v | Per base sequence content | T | identical | 30 | 0 |  |
| ov9_v | Per base sequence content | C | identical | 30 | 0 |  |
| ov9_v | Per base N content | Base | identical | 30 | 0 |  |
| ov9_v | Per base N content | N-Count | identical | 30 | 0 |  |
| ov9_v | Overrepresented sequences | Sequence | identical | 8 | 0 |  |
| ov9_v | Overrepresented sequences | Count | identical | 8 | 0 |  |
| ov9_v | Overrepresented sequences | Percentage | identical | 8 | 0 |  |
| ov9_v | Overrepresented sequences | Possible Source | identical | 8 | 0 |  |
| ov9_v | Adapter Content | Position | identical | 19 | 0 |  |
| ov9_v | Adapter Content | Illumina Universal Adapter | identical | 19 | 0 |  |
| ov9_v | Adapter Content | Illumina Small RNA 3' Adapter | identical | 19 | 0 |  |
| ov9_v | Adapter Content | Illumina Small RNA 5' Adapter | identical | 19 | 0 |  |
| ov9_v | Adapter Content | Nextera Transposase Sequence | identical | 19 | 0 |  |
| ov9_v | Adapter Content | PolyA | identical | 19 | 0 |  |
| ov9_v | Adapter Content | PolyG | identical | 19 | 0 |  |
| ov9_v | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ov9_v | Per sequence GC content | Count | identical | 101 | 0 |  |
| ov9_v | Sequence Length Distribution | Length | identical | 27 | 0 |  |
| ov9_v | Sequence Length Distribution | Count | identical | 27 | 0 |  |
| ov9_v | Basic Statistics | flag | identical | 1 | 0 |  |
| ov9_v | Per base sequence quality | flag | identical | 1 | 0 |  |
| ov9_v | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ov9_v | Per base sequence content | flag | identical | 1 | 0 |  |
| ov9_v | Per base N content | flag | identical | 1 | 0 |  |
| ov9_v | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ov9_v | Adapter Content | flag | identical | 1 | 0 |  |
| ov9_v | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_0_48 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_0_48 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_0_48 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_0_48 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_0_48 | Per base sequence quality | Base | identical | 48 | 0 |  |
| p_0_48 | Per base sequence quality | Mean | identical | 48 | 0 |  |
| p_0_48 | Per base sequence quality | Median | identical | 48 | 0 |  |
| p_0_48 | Per base sequence quality | Lower Quartile | identical | 48 | 0 |  |
| p_0_48 | Per base sequence quality | Upper Quartile | identical | 48 | 0 |  |
| p_0_48 | Per base sequence quality | 10th Percentile | identical | 48 | 0 |  |
| p_0_48 | Per base sequence quality | 90th Percentile | identical | 48 | 0 |  |
| p_0_48 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_0_48 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_0_48 | Per base sequence content | Base | identical | 48 | 0 |  |
| p_0_48 | Per base sequence content | G | identical | 48 | 0 |  |
| p_0_48 | Per base sequence content | A | identical | 48 | 0 |  |
| p_0_48 | Per base sequence content | T | identical | 48 | 0 |  |
| p_0_48 | Per base sequence content | C | identical | 48 | 0 |  |
| p_0_48 | Per base N content | Base | identical | 48 | 0 |  |
| p_0_48 | Per base N content | N-Count | identical | 48 | 0 |  |
| p_0_48 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_0_48 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_0_48 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_0_48 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_0_48 | Adapter Content | Position | identical | 37 | 0 |  |
| p_0_48 | Adapter Content | Illumina Universal Adapter | identical | 37 | 0 |  |
| p_0_48 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 37 | 0 |  |
| p_0_48 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 37 | 0 |  |
| p_0_48 | Adapter Content | Nextera Transposase Sequence | identical | 37 | 0 |  |
| p_0_48 | Adapter Content | PolyA | identical | 37 | 0 |  |
| p_0_48 | Adapter Content | PolyG | identical | 37 | 0 |  |
| p_0_48 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_0_48 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_0_48 | Sequence Length Distribution | Length | identical | 49 | 0 |  |
| p_0_48 | Sequence Length Distribution | Count | identical | 49 | 0 |  |
| p_0_48 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_0_48 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_0_48 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_0_48 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_0_48 | Per base N content | flag | identical | 1 | 0 |  |
| p_0_48 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_0_48 | Adapter Content | flag | identical | 1 | 0 |  |
| p_0_48 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_0_49 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_0_49 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_0_49 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_0_49 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_0_49 | Per base sequence quality | Base | identical | 49 | 0 |  |
| p_0_49 | Per base sequence quality | Mean | identical | 49 | 0 |  |
| p_0_49 | Per base sequence quality | Median | identical | 49 | 0 |  |
| p_0_49 | Per base sequence quality | Lower Quartile | identical | 49 | 0 |  |
| p_0_49 | Per base sequence quality | Upper Quartile | identical | 49 | 0 |  |
| p_0_49 | Per base sequence quality | 10th Percentile | identical | 49 | 0 |  |
| p_0_49 | Per base sequence quality | 90th Percentile | identical | 49 | 0 |  |
| p_0_49 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_0_49 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_0_49 | Per base sequence content | Base | identical | 49 | 0 |  |
| p_0_49 | Per base sequence content | G | identical | 49 | 0 |  |
| p_0_49 | Per base sequence content | A | identical | 49 | 0 |  |
| p_0_49 | Per base sequence content | T | identical | 49 | 0 |  |
| p_0_49 | Per base sequence content | C | identical | 49 | 0 |  |
| p_0_49 | Per base N content | Base | identical | 49 | 0 |  |
| p_0_49 | Per base N content | N-Count | identical | 49 | 0 |  |
| p_0_49 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_0_49 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_0_49 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_0_49 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_0_49 | Adapter Content | Position | identical | 38 | 0 |  |
| p_0_49 | Adapter Content | Illumina Universal Adapter | identical | 38 | 0 |  |
| p_0_49 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 38 | 0 |  |
| p_0_49 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 38 | 0 |  |
| p_0_49 | Adapter Content | Nextera Transposase Sequence | identical | 38 | 0 |  |
| p_0_49 | Adapter Content | PolyA | identical | 38 | 0 |  |
| p_0_49 | Adapter Content | PolyG | identical | 38 | 0 |  |
| p_0_49 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_0_49 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_0_49 | Sequence Length Distribution | Length | identical | 50 | 0 |  |
| p_0_49 | Sequence Length Distribution | Count | identical | 50 | 0 |  |
| p_0_49 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_0_49 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_0_49 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_0_49 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_0_49 | Per base N content | flag | identical | 1 | 0 |  |
| p_0_49 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_0_49 | Adapter Content | flag | identical | 1 | 0 |  |
| p_0_49 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_0_50 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_0_50 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_0_50 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_0_50 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_0_50 | Per base sequence quality | Base | identical | 50 | 0 |  |
| p_0_50 | Per base sequence quality | Mean | identical | 50 | 0 |  |
| p_0_50 | Per base sequence quality | Median | identical | 50 | 0 |  |
| p_0_50 | Per base sequence quality | Lower Quartile | identical | 50 | 0 |  |
| p_0_50 | Per base sequence quality | Upper Quartile | identical | 50 | 0 |  |
| p_0_50 | Per base sequence quality | 10th Percentile | identical | 50 | 0 |  |
| p_0_50 | Per base sequence quality | 90th Percentile | identical | 50 | 0 |  |
| p_0_50 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_0_50 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_0_50 | Per base sequence content | Base | identical | 50 | 0 |  |
| p_0_50 | Per base sequence content | G | identical | 50 | 0 |  |
| p_0_50 | Per base sequence content | A | identical | 50 | 0 |  |
| p_0_50 | Per base sequence content | T | identical | 50 | 0 |  |
| p_0_50 | Per base sequence content | C | identical | 50 | 0 |  |
| p_0_50 | Per base N content | Base | identical | 50 | 0 |  |
| p_0_50 | Per base N content | N-Count | identical | 50 | 0 |  |
| p_0_50 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_0_50 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_0_50 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_0_50 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_0_50 | Adapter Content | Position | identical | 39 | 0 |  |
| p_0_50 | Adapter Content | Illumina Universal Adapter | identical | 39 | 0 |  |
| p_0_50 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 39 | 0 |  |
| p_0_50 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 39 | 0 |  |
| p_0_50 | Adapter Content | Nextera Transposase Sequence | identical | 39 | 0 |  |
| p_0_50 | Adapter Content | PolyA | identical | 39 | 0 |  |
| p_0_50 | Adapter Content | PolyG | identical | 39 | 0 |  |
| p_0_50 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_0_50 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_0_50 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| p_0_50 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| p_0_50 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_0_50 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_0_50 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_0_50 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_0_50 | Per base N content | flag | identical | 1 | 0 |  |
| p_0_50 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_0_50 | Adapter Content | flag | identical | 1 | 0 |  |
| p_0_50 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_0_51 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_0_51 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_0_51 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_0_51 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_0_51 | Per base sequence quality | Base | identical | 51 | 0 |  |
| p_0_51 | Per base sequence quality | Mean | identical | 51 | 0 |  |
| p_0_51 | Per base sequence quality | Median | identical | 51 | 0 |  |
| p_0_51 | Per base sequence quality | Lower Quartile | identical | 51 | 0 |  |
| p_0_51 | Per base sequence quality | Upper Quartile | identical | 51 | 0 |  |
| p_0_51 | Per base sequence quality | 10th Percentile | identical | 51 | 0 |  |
| p_0_51 | Per base sequence quality | 90th Percentile | identical | 51 | 0 |  |
| p_0_51 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_0_51 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_0_51 | Per base sequence content | Base | identical | 51 | 0 |  |
| p_0_51 | Per base sequence content | G | identical | 51 | 0 |  |
| p_0_51 | Per base sequence content | A | identical | 51 | 0 |  |
| p_0_51 | Per base sequence content | T | identical | 51 | 0 |  |
| p_0_51 | Per base sequence content | C | identical | 51 | 0 |  |
| p_0_51 | Per base N content | Base | identical | 51 | 0 |  |
| p_0_51 | Per base N content | N-Count | identical | 51 | 0 |  |
| p_0_51 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_0_51 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_0_51 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_0_51 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_0_51 | Adapter Content | Position | identical | 40 | 0 |  |
| p_0_51 | Adapter Content | Illumina Universal Adapter | identical | 40 | 0 |  |
| p_0_51 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 40 | 0 |  |
| p_0_51 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 40 | 0 |  |
| p_0_51 | Adapter Content | Nextera Transposase Sequence | identical | 40 | 0 |  |
| p_0_51 | Adapter Content | PolyA | identical | 40 | 0 |  |
| p_0_51 | Adapter Content | PolyG | identical | 40 | 0 |  |
| p_0_51 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_0_51 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_0_51 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| p_0_51 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| p_0_51 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_0_51 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_0_51 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_0_51 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_0_51 | Per base N content | flag | identical | 1 | 0 |  |
| p_0_51 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_0_51 | Adapter Content | flag | identical | 1 | 0 |  |
| p_0_51 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1000_1040 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1000_1040 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1000_1040 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1000_1040 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1000_1040 | Per base sequence quality | Base | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence quality | Mean | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence quality | Median | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence quality | Lower Quartile | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence quality | Upper Quartile | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence quality | 10th Percentile | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence quality | 90th Percentile | identical | 62 | 0 |  |
| p_1000_1040 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1000_1040 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1000_1040 | Per base sequence content | Base | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence content | G | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence content | A | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence content | T | identical | 62 | 0 |  |
| p_1000_1040 | Per base sequence content | C | identical | 62 | 0 |  |
| p_1000_1040 | Per base N content | Base | identical | 62 | 0 |  |
| p_1000_1040 | Per base N content | N-Count | identical | 62 | 0 |  |
| p_1000_1040 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_1000_1040 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_1000_1040 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_1000_1040 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_1000_1040 | Adapter Content | Position | identical | 61 | 0 |  |
| p_1000_1040 | Adapter Content | Illumina Universal Adapter | identical | 61 | 0 |  |
| p_1000_1040 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 61 | 0 |  |
| p_1000_1040 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 61 | 0 |  |
| p_1000_1040 | Adapter Content | Nextera Transposase Sequence | identical | 61 | 0 |  |
| p_1000_1040 | Adapter Content | PolyA | identical | 61 | 0 |  |
| p_1000_1040 | Adapter Content | PolyG | identical | 61 | 0 |  |
| p_1000_1040 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1000_1040 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1000_1040 | Sequence Length Distribution | Length | identical | 41 | 0 |  |
| p_1000_1040 | Sequence Length Distribution | Count | identical | 41 | 0 |  |
| p_1000_1040 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1000_1040 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1000_1040 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1000_1040 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1000_1040 | Per base N content | flag | identical | 1 | 0 |  |
| p_1000_1040 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1000_1040 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1000_1040 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1000_1048 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1000_1048 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1000_1048 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1000_1048 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1000_1048 | Per base sequence quality | Base | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence quality | Mean | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence quality | Median | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence quality | Lower Quartile | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence quality | Upper Quartile | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence quality | 10th Percentile | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence quality | 90th Percentile | identical | 62 | 0 |  |
| p_1000_1048 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1000_1048 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1000_1048 | Per base sequence content | Base | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence content | G | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence content | A | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence content | T | identical | 62 | 0 |  |
| p_1000_1048 | Per base sequence content | C | identical | 62 | 0 |  |
| p_1000_1048 | Per base N content | Base | identical | 62 | 0 |  |
| p_1000_1048 | Per base N content | N-Count | identical | 62 | 0 |  |
| p_1000_1048 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_1000_1048 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_1000_1048 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_1000_1048 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_1000_1048 | Adapter Content | Position | identical | 61 | 0 |  |
| p_1000_1048 | Adapter Content | Illumina Universal Adapter | identical | 61 | 0 |  |
| p_1000_1048 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 61 | 0 |  |
| p_1000_1048 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 61 | 0 |  |
| p_1000_1048 | Adapter Content | Nextera Transposase Sequence | identical | 61 | 0 |  |
| p_1000_1048 | Adapter Content | PolyA | identical | 61 | 0 |  |
| p_1000_1048 | Adapter Content | PolyG | identical | 61 | 0 |  |
| p_1000_1048 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1000_1048 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1000_1048 | Sequence Length Distribution | Length | identical | 49 | 0 |  |
| p_1000_1048 | Sequence Length Distribution | Count | identical | 49 | 0 |  |
| p_1000_1048 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1000_1048 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1000_1048 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1000_1048 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1000_1048 | Per base N content | flag | identical | 1 | 0 |  |
| p_1000_1048 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1000_1048 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1000_1048 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1000_1049 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1000_1049 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1000_1049 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1000_1049 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1000_1049 | Per base sequence quality | Base | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence quality | Mean | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence quality | Median | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence quality | Lower Quartile | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence quality | Upper Quartile | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence quality | 10th Percentile | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence quality | 90th Percentile | identical | 62 | 0 |  |
| p_1000_1049 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1000_1049 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1000_1049 | Per base sequence content | Base | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence content | G | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence content | A | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence content | T | identical | 62 | 0 |  |
| p_1000_1049 | Per base sequence content | C | identical | 62 | 0 |  |
| p_1000_1049 | Per base N content | Base | identical | 62 | 0 |  |
| p_1000_1049 | Per base N content | N-Count | identical | 62 | 0 |  |
| p_1000_1049 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_1000_1049 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_1000_1049 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_1000_1049 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_1000_1049 | Adapter Content | Position | identical | 61 | 0 |  |
| p_1000_1049 | Adapter Content | Illumina Universal Adapter | identical | 61 | 0 |  |
| p_1000_1049 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 61 | 0 |  |
| p_1000_1049 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 61 | 0 |  |
| p_1000_1049 | Adapter Content | Nextera Transposase Sequence | identical | 61 | 0 |  |
| p_1000_1049 | Adapter Content | PolyA | identical | 61 | 0 |  |
| p_1000_1049 | Adapter Content | PolyG | identical | 61 | 0 |  |
| p_1000_1049 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1000_1049 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1000_1049 | Sequence Length Distribution | Length | identical | 25 | 0 |  |
| p_1000_1049 | Sequence Length Distribution | Count | identical | 25 | 0 |  |
| p_1000_1049 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1000_1049 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1000_1049 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1000_1049 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1000_1049 | Per base N content | flag | identical | 1 | 0 |  |
| p_1000_1049 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1000_1049 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1000_1049 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1000_1050 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1000_1050 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1000_1050 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1000_1050 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1000_1050 | Per base sequence quality | Base | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence quality | Mean | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence quality | Median | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence quality | Lower Quartile | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence quality | Upper Quartile | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence quality | 10th Percentile | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence quality | 90th Percentile | identical | 62 | 0 |  |
| p_1000_1050 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1000_1050 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1000_1050 | Per base sequence content | Base | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence content | G | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence content | A | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence content | T | identical | 62 | 0 |  |
| p_1000_1050 | Per base sequence content | C | identical | 62 | 0 |  |
| p_1000_1050 | Per base N content | Base | identical | 62 | 0 |  |
| p_1000_1050 | Per base N content | N-Count | identical | 62 | 0 |  |
| p_1000_1050 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_1000_1050 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_1000_1050 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_1000_1050 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_1000_1050 | Adapter Content | Position | identical | 61 | 0 |  |
| p_1000_1050 | Adapter Content | Illumina Universal Adapter | identical | 61 | 0 |  |
| p_1000_1050 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 61 | 0 |  |
| p_1000_1050 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 61 | 0 |  |
| p_1000_1050 | Adapter Content | Nextera Transposase Sequence | identical | 61 | 0 |  |
| p_1000_1050 | Adapter Content | PolyA | identical | 61 | 0 |  |
| p_1000_1050 | Adapter Content | PolyG | identical | 61 | 0 |  |
| p_1000_1050 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1000_1050 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1000_1050 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| p_1000_1050 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| p_1000_1050 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1000_1050 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1000_1050 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1000_1050 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1000_1050 | Per base N content | flag | identical | 1 | 0 |  |
| p_1000_1050 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1000_1050 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1000_1050 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1000_1051 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1000_1051 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1000_1051 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1000_1051 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1000_1051 | Per base sequence quality | Base | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence quality | Mean | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence quality | Median | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence quality | Lower Quartile | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence quality | Upper Quartile | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence quality | 10th Percentile | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence quality | 90th Percentile | identical | 62 | 0 |  |
| p_1000_1051 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1000_1051 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1000_1051 | Per base sequence content | Base | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence content | G | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence content | A | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence content | T | identical | 62 | 0 |  |
| p_1000_1051 | Per base sequence content | C | identical | 62 | 0 |  |
| p_1000_1051 | Per base N content | Base | identical | 62 | 0 |  |
| p_1000_1051 | Per base N content | N-Count | identical | 62 | 0 |  |
| p_1000_1051 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_1000_1051 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_1000_1051 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_1000_1051 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_1000_1051 | Adapter Content | Position | identical | 62 | 0 |  |
| p_1000_1051 | Adapter Content | Illumina Universal Adapter | identical | 62 | 0 |  |
| p_1000_1051 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 62 | 0 |  |
| p_1000_1051 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 62 | 0 |  |
| p_1000_1051 | Adapter Content | Nextera Transposase Sequence | identical | 62 | 0 |  |
| p_1000_1051 | Adapter Content | PolyA | identical | 62 | 0 |  |
| p_1000_1051 | Adapter Content | PolyG | identical | 62 | 0 |  |
| p_1000_1051 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1000_1051 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1000_1051 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| p_1000_1051 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| p_1000_1051 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1000_1051 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1000_1051 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1000_1051 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1000_1051 | Per base N content | flag | identical | 1 | 0 |  |
| p_1000_1051 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1000_1051 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1000_1051 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1000_1060 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1000_1060 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1000_1060 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1000_1060 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1000_1060 | Per base sequence quality | Base | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence quality | Mean | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence quality | Median | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence quality | Lower Quartile | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence quality | Upper Quartile | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence quality | 10th Percentile | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence quality | 90th Percentile | identical | 63 | 0 |  |
| p_1000_1060 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1000_1060 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1000_1060 | Per base sequence content | Base | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence content | G | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence content | A | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence content | T | identical | 63 | 0 |  |
| p_1000_1060 | Per base sequence content | C | identical | 63 | 0 |  |
| p_1000_1060 | Per base N content | Base | identical | 63 | 0 |  |
| p_1000_1060 | Per base N content | N-Count | identical | 63 | 0 |  |
| p_1000_1060 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_1000_1060 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_1000_1060 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_1000_1060 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_1000_1060 | Adapter Content | Position | identical | 62 | 0 |  |
| p_1000_1060 | Adapter Content | Illumina Universal Adapter | identical | 62 | 0 |  |
| p_1000_1060 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 62 | 0 |  |
| p_1000_1060 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 62 | 0 |  |
| p_1000_1060 | Adapter Content | Nextera Transposase Sequence | identical | 62 | 0 |  |
| p_1000_1060 | Adapter Content | PolyA | identical | 62 | 0 |  |
| p_1000_1060 | Adapter Content | PolyG | identical | 62 | 0 |  |
| p_1000_1060 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1000_1060 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1000_1060 | Sequence Length Distribution | Length | identical | 31 | 0 |  |
| p_1000_1060 | Sequence Length Distribution | Count | identical | 31 | 0 |  |
| p_1000_1060 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1000_1060 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1000_1060 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1000_1060 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1000_1060 | Per base N content | flag | identical | 1 | 0 |  |
| p_1000_1060 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1000_1060 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1000_1060 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_44 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_44 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_44 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_44 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_44 | Per base sequence quality | Base | identical | 44 | 0 |  |
| p_1_44 | Per base sequence quality | Mean | identical | 44 | 0 |  |
| p_1_44 | Per base sequence quality | Median | identical | 44 | 0 |  |
| p_1_44 | Per base sequence quality | Lower Quartile | identical | 44 | 0 |  |
| p_1_44 | Per base sequence quality | Upper Quartile | identical | 44 | 0 |  |
| p_1_44 | Per base sequence quality | 10th Percentile | identical | 44 | 0 |  |
| p_1_44 | Per base sequence quality | 90th Percentile | identical | 44 | 0 |  |
| p_1_44 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_44 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_44 | Per base sequence content | Base | identical | 44 | 0 |  |
| p_1_44 | Per base sequence content | G | identical | 44 | 0 |  |
| p_1_44 | Per base sequence content | A | identical | 44 | 0 |  |
| p_1_44 | Per base sequence content | T | identical | 44 | 0 |  |
| p_1_44 | Per base sequence content | C | identical | 44 | 0 |  |
| p_1_44 | Per base N content | Base | identical | 44 | 0 |  |
| p_1_44 | Per base N content | N-Count | identical | 44 | 0 |  |
| p_1_44 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_44 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_44 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_44 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_44 | Adapter Content | Position | identical | 33 | 0 |  |
| p_1_44 | Adapter Content | Illumina Universal Adapter | identical | 33 | 0 |  |
| p_1_44 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 33 | 0 |  |
| p_1_44 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 33 | 0 |  |
| p_1_44 | Adapter Content | Nextera Transposase Sequence | identical | 33 | 0 |  |
| p_1_44 | Adapter Content | PolyA | identical | 33 | 0 |  |
| p_1_44 | Adapter Content | PolyG | identical | 33 | 0 |  |
| p_1_44 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_44 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_44 | Sequence Length Distribution | Length | identical | 44 | 0 |  |
| p_1_44 | Sequence Length Distribution | Count | identical | 44 | 0 |  |
| p_1_44 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_44 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_44 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_44 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_44 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_44 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_44 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_44 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_45 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_45 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_45 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_45 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_45 | Per base sequence quality | Base | identical | 45 | 0 |  |
| p_1_45 | Per base sequence quality | Mean | identical | 45 | 0 |  |
| p_1_45 | Per base sequence quality | Median | identical | 45 | 0 |  |
| p_1_45 | Per base sequence quality | Lower Quartile | identical | 45 | 0 |  |
| p_1_45 | Per base sequence quality | Upper Quartile | identical | 45 | 0 |  |
| p_1_45 | Per base sequence quality | 10th Percentile | identical | 45 | 0 |  |
| p_1_45 | Per base sequence quality | 90th Percentile | identical | 45 | 0 |  |
| p_1_45 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_45 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_45 | Per base sequence content | Base | identical | 45 | 0 |  |
| p_1_45 | Per base sequence content | G | identical | 45 | 0 |  |
| p_1_45 | Per base sequence content | A | identical | 45 | 0 |  |
| p_1_45 | Per base sequence content | T | identical | 45 | 0 |  |
| p_1_45 | Per base sequence content | C | identical | 45 | 0 |  |
| p_1_45 | Per base N content | Base | identical | 45 | 0 |  |
| p_1_45 | Per base N content | N-Count | identical | 45 | 0 |  |
| p_1_45 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_45 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_45 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_45 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_45 | Adapter Content | Position | identical | 34 | 0 |  |
| p_1_45 | Adapter Content | Illumina Universal Adapter | identical | 34 | 0 |  |
| p_1_45 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 34 | 0 |  |
| p_1_45 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 34 | 0 |  |
| p_1_45 | Adapter Content | Nextera Transposase Sequence | identical | 34 | 0 |  |
| p_1_45 | Adapter Content | PolyA | identical | 34 | 0 |  |
| p_1_45 | Adapter Content | PolyG | identical | 34 | 0 |  |
| p_1_45 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_45 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_45 | Sequence Length Distribution | Length | identical | 45 | 0 |  |
| p_1_45 | Sequence Length Distribution | Count | identical | 45 | 0 |  |
| p_1_45 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_45 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_45 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_45 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_45 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_45 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_45 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_45 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_46 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_46 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_46 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_46 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_46 | Per base sequence quality | Base | identical | 46 | 0 |  |
| p_1_46 | Per base sequence quality | Mean | identical | 46 | 0 |  |
| p_1_46 | Per base sequence quality | Median | identical | 46 | 0 |  |
| p_1_46 | Per base sequence quality | Lower Quartile | identical | 46 | 0 |  |
| p_1_46 | Per base sequence quality | Upper Quartile | identical | 46 | 0 |  |
| p_1_46 | Per base sequence quality | 10th Percentile | identical | 46 | 0 |  |
| p_1_46 | Per base sequence quality | 90th Percentile | identical | 46 | 0 |  |
| p_1_46 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_46 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_46 | Per base sequence content | Base | identical | 46 | 0 |  |
| p_1_46 | Per base sequence content | G | identical | 46 | 0 |  |
| p_1_46 | Per base sequence content | A | identical | 46 | 0 |  |
| p_1_46 | Per base sequence content | T | identical | 46 | 0 |  |
| p_1_46 | Per base sequence content | C | identical | 46 | 0 |  |
| p_1_46 | Per base N content | Base | identical | 46 | 0 |  |
| p_1_46 | Per base N content | N-Count | identical | 46 | 0 |  |
| p_1_46 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_46 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_46 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_46 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_46 | Adapter Content | Position | identical | 35 | 0 |  |
| p_1_46 | Adapter Content | Illumina Universal Adapter | identical | 35 | 0 |  |
| p_1_46 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 35 | 0 |  |
| p_1_46 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 35 | 0 |  |
| p_1_46 | Adapter Content | Nextera Transposase Sequence | identical | 35 | 0 |  |
| p_1_46 | Adapter Content | PolyA | identical | 35 | 0 |  |
| p_1_46 | Adapter Content | PolyG | identical | 35 | 0 |  |
| p_1_46 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_46 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_46 | Sequence Length Distribution | Length | identical | 46 | 0 |  |
| p_1_46 | Sequence Length Distribution | Count | identical | 46 | 0 |  |
| p_1_46 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_46 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_46 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_46 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_46 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_46 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_46 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_46 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_47 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_47 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_47 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_47 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_47 | Per base sequence quality | Base | identical | 47 | 0 |  |
| p_1_47 | Per base sequence quality | Mean | identical | 47 | 0 |  |
| p_1_47 | Per base sequence quality | Median | identical | 47 | 0 |  |
| p_1_47 | Per base sequence quality | Lower Quartile | identical | 47 | 0 |  |
| p_1_47 | Per base sequence quality | Upper Quartile | identical | 47 | 0 |  |
| p_1_47 | Per base sequence quality | 10th Percentile | identical | 47 | 0 |  |
| p_1_47 | Per base sequence quality | 90th Percentile | identical | 47 | 0 |  |
| p_1_47 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_47 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_47 | Per base sequence content | Base | identical | 47 | 0 |  |
| p_1_47 | Per base sequence content | G | identical | 47 | 0 |  |
| p_1_47 | Per base sequence content | A | identical | 47 | 0 |  |
| p_1_47 | Per base sequence content | T | identical | 47 | 0 |  |
| p_1_47 | Per base sequence content | C | identical | 47 | 0 |  |
| p_1_47 | Per base N content | Base | identical | 47 | 0 |  |
| p_1_47 | Per base N content | N-Count | identical | 47 | 0 |  |
| p_1_47 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_47 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_47 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_47 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_47 | Adapter Content | Position | identical | 36 | 0 |  |
| p_1_47 | Adapter Content | Illumina Universal Adapter | identical | 36 | 0 |  |
| p_1_47 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 36 | 0 |  |
| p_1_47 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 36 | 0 |  |
| p_1_47 | Adapter Content | Nextera Transposase Sequence | identical | 36 | 0 |  |
| p_1_47 | Adapter Content | PolyA | identical | 36 | 0 |  |
| p_1_47 | Adapter Content | PolyG | identical | 36 | 0 |  |
| p_1_47 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_47 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_47 | Sequence Length Distribution | Length | identical | 47 | 0 |  |
| p_1_47 | Sequence Length Distribution | Count | identical | 47 | 0 |  |
| p_1_47 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_47 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_47 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_47 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_47 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_47 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_47 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_47 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_48 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_48 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_48 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_48 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_48 | Per base sequence quality | Base | identical | 48 | 0 |  |
| p_1_48 | Per base sequence quality | Mean | identical | 48 | 0 |  |
| p_1_48 | Per base sequence quality | Median | identical | 48 | 0 |  |
| p_1_48 | Per base sequence quality | Lower Quartile | identical | 48 | 0 |  |
| p_1_48 | Per base sequence quality | Upper Quartile | identical | 48 | 0 |  |
| p_1_48 | Per base sequence quality | 10th Percentile | identical | 48 | 0 |  |
| p_1_48 | Per base sequence quality | 90th Percentile | identical | 48 | 0 |  |
| p_1_48 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_48 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_48 | Per base sequence content | Base | identical | 48 | 0 |  |
| p_1_48 | Per base sequence content | G | identical | 48 | 0 |  |
| p_1_48 | Per base sequence content | A | identical | 48 | 0 |  |
| p_1_48 | Per base sequence content | T | identical | 48 | 0 |  |
| p_1_48 | Per base sequence content | C | identical | 48 | 0 |  |
| p_1_48 | Per base N content | Base | identical | 48 | 0 |  |
| p_1_48 | Per base N content | N-Count | identical | 48 | 0 |  |
| p_1_48 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_48 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_48 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_48 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_48 | Adapter Content | Position | identical | 37 | 0 |  |
| p_1_48 | Adapter Content | Illumina Universal Adapter | identical | 37 | 0 |  |
| p_1_48 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 37 | 0 |  |
| p_1_48 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 37 | 0 |  |
| p_1_48 | Adapter Content | Nextera Transposase Sequence | identical | 37 | 0 |  |
| p_1_48 | Adapter Content | PolyA | identical | 37 | 0 |  |
| p_1_48 | Adapter Content | PolyG | identical | 37 | 0 |  |
| p_1_48 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_48 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_48 | Sequence Length Distribution | Length | identical | 48 | 0 |  |
| p_1_48 | Sequence Length Distribution | Count | identical | 48 | 0 |  |
| p_1_48 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_48 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_48 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_48 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_48 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_48 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_48 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_48 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_49 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_49 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_49 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_49 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_49 | Per base sequence quality | Base | identical | 49 | 0 |  |
| p_1_49 | Per base sequence quality | Mean | identical | 49 | 0 |  |
| p_1_49 | Per base sequence quality | Median | identical | 49 | 0 |  |
| p_1_49 | Per base sequence quality | Lower Quartile | identical | 49 | 0 |  |
| p_1_49 | Per base sequence quality | Upper Quartile | identical | 49 | 0 |  |
| p_1_49 | Per base sequence quality | 10th Percentile | identical | 49 | 0 |  |
| p_1_49 | Per base sequence quality | 90th Percentile | identical | 49 | 0 |  |
| p_1_49 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_49 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_49 | Per base sequence content | Base | identical | 49 | 0 |  |
| p_1_49 | Per base sequence content | G | identical | 49 | 0 |  |
| p_1_49 | Per base sequence content | A | identical | 49 | 0 |  |
| p_1_49 | Per base sequence content | T | identical | 49 | 0 |  |
| p_1_49 | Per base sequence content | C | identical | 49 | 0 |  |
| p_1_49 | Per base N content | Base | identical | 49 | 0 |  |
| p_1_49 | Per base N content | N-Count | identical | 49 | 0 |  |
| p_1_49 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_49 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_49 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_49 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_49 | Adapter Content | Position | identical | 38 | 0 |  |
| p_1_49 | Adapter Content | Illumina Universal Adapter | identical | 38 | 0 |  |
| p_1_49 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 38 | 0 |  |
| p_1_49 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 38 | 0 |  |
| p_1_49 | Adapter Content | Nextera Transposase Sequence | identical | 38 | 0 |  |
| p_1_49 | Adapter Content | PolyA | identical | 38 | 0 |  |
| p_1_49 | Adapter Content | PolyG | identical | 38 | 0 |  |
| p_1_49 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_49 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_49 | Sequence Length Distribution | Length | identical | 49 | 0 |  |
| p_1_49 | Sequence Length Distribution | Count | identical | 49 | 0 |  |
| p_1_49 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_49 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_49 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_49 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_49 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_49 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_49 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_49 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_50 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_50 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_50 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_50 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_50 | Per base sequence quality | Base | identical | 50 | 0 |  |
| p_1_50 | Per base sequence quality | Mean | identical | 50 | 0 |  |
| p_1_50 | Per base sequence quality | Median | identical | 50 | 0 |  |
| p_1_50 | Per base sequence quality | Lower Quartile | identical | 50 | 0 |  |
| p_1_50 | Per base sequence quality | Upper Quartile | identical | 50 | 0 |  |
| p_1_50 | Per base sequence quality | 10th Percentile | identical | 50 | 0 |  |
| p_1_50 | Per base sequence quality | 90th Percentile | identical | 50 | 0 |  |
| p_1_50 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_50 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_50 | Per base sequence content | Base | identical | 50 | 0 |  |
| p_1_50 | Per base sequence content | G | identical | 50 | 0 |  |
| p_1_50 | Per base sequence content | A | identical | 50 | 0 |  |
| p_1_50 | Per base sequence content | T | identical | 50 | 0 |  |
| p_1_50 | Per base sequence content | C | identical | 50 | 0 |  |
| p_1_50 | Per base N content | Base | identical | 50 | 0 |  |
| p_1_50 | Per base N content | N-Count | identical | 50 | 0 |  |
| p_1_50 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_50 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_50 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_50 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_50 | Adapter Content | Position | identical | 39 | 0 |  |
| p_1_50 | Adapter Content | Illumina Universal Adapter | identical | 39 | 0 |  |
| p_1_50 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 39 | 0 |  |
| p_1_50 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 39 | 0 |  |
| p_1_50 | Adapter Content | Nextera Transposase Sequence | identical | 39 | 0 |  |
| p_1_50 | Adapter Content | PolyA | identical | 39 | 0 |  |
| p_1_50 | Adapter Content | PolyG | identical | 39 | 0 |  |
| p_1_50 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_50 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_50 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| p_1_50 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| p_1_50 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_50 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_50 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_50 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_50 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_50 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_50 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_50 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_51 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_51 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_51 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_51 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_51 | Per base sequence quality | Base | identical | 51 | 0 |  |
| p_1_51 | Per base sequence quality | Mean | identical | 51 | 0 |  |
| p_1_51 | Per base sequence quality | Median | identical | 51 | 0 |  |
| p_1_51 | Per base sequence quality | Lower Quartile | identical | 51 | 0 |  |
| p_1_51 | Per base sequence quality | Upper Quartile | identical | 51 | 0 |  |
| p_1_51 | Per base sequence quality | 10th Percentile | identical | 51 | 0 |  |
| p_1_51 | Per base sequence quality | 90th Percentile | identical | 51 | 0 |  |
| p_1_51 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_51 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_51 | Per base sequence content | Base | identical | 51 | 0 |  |
| p_1_51 | Per base sequence content | G | identical | 51 | 0 |  |
| p_1_51 | Per base sequence content | A | identical | 51 | 0 |  |
| p_1_51 | Per base sequence content | T | identical | 51 | 0 |  |
| p_1_51 | Per base sequence content | C | identical | 51 | 0 |  |
| p_1_51 | Per base N content | Base | identical | 51 | 0 |  |
| p_1_51 | Per base N content | N-Count | identical | 51 | 0 |  |
| p_1_51 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_51 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_51 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_51 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_51 | Adapter Content | Position | identical | 40 | 0 |  |
| p_1_51 | Adapter Content | Illumina Universal Adapter | identical | 40 | 0 |  |
| p_1_51 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 40 | 0 |  |
| p_1_51 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 40 | 0 |  |
| p_1_51 | Adapter Content | Nextera Transposase Sequence | identical | 40 | 0 |  |
| p_1_51 | Adapter Content | PolyA | identical | 40 | 0 |  |
| p_1_51 | Adapter Content | PolyG | identical | 40 | 0 |  |
| p_1_51 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_51 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_51 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| p_1_51 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| p_1_51 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_51 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_51 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_51 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_51 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_51 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_51 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_51 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_52 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_52 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_52 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_52 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_52 | Per base sequence quality | Base | identical | 52 | 0 |  |
| p_1_52 | Per base sequence quality | Mean | identical | 52 | 0 |  |
| p_1_52 | Per base sequence quality | Median | identical | 52 | 0 |  |
| p_1_52 | Per base sequence quality | Lower Quartile | identical | 52 | 0 |  |
| p_1_52 | Per base sequence quality | Upper Quartile | identical | 52 | 0 |  |
| p_1_52 | Per base sequence quality | 10th Percentile | identical | 52 | 0 |  |
| p_1_52 | Per base sequence quality | 90th Percentile | identical | 52 | 0 |  |
| p_1_52 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_52 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_52 | Per base sequence content | Base | identical | 52 | 0 |  |
| p_1_52 | Per base sequence content | G | identical | 52 | 0 |  |
| p_1_52 | Per base sequence content | A | identical | 52 | 0 |  |
| p_1_52 | Per base sequence content | T | identical | 52 | 0 |  |
| p_1_52 | Per base sequence content | C | identical | 52 | 0 |  |
| p_1_52 | Per base N content | Base | identical | 52 | 0 |  |
| p_1_52 | Per base N content | N-Count | identical | 52 | 0 |  |
| p_1_52 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_52 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_52 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_52 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_52 | Adapter Content | Position | identical | 41 | 0 |  |
| p_1_52 | Adapter Content | Illumina Universal Adapter | identical | 41 | 0 |  |
| p_1_52 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 41 | 0 |  |
| p_1_52 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 41 | 0 |  |
| p_1_52 | Adapter Content | Nextera Transposase Sequence | identical | 41 | 0 |  |
| p_1_52 | Adapter Content | PolyA | identical | 41 | 0 |  |
| p_1_52 | Adapter Content | PolyG | identical | 41 | 0 |  |
| p_1_52 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_52 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_52 | Sequence Length Distribution | Length | identical | 27 | 0 |  |
| p_1_52 | Sequence Length Distribution | Count | identical | 27 | 0 |  |
| p_1_52 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_52 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_52 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_52 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_52 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_52 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_52 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_52 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_53 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_53 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_53 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_53 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_53 | Per base sequence quality | Base | identical | 53 | 0 |  |
| p_1_53 | Per base sequence quality | Mean | identical | 53 | 0 |  |
| p_1_53 | Per base sequence quality | Median | identical | 53 | 0 |  |
| p_1_53 | Per base sequence quality | Lower Quartile | identical | 53 | 0 |  |
| p_1_53 | Per base sequence quality | Upper Quartile | identical | 53 | 0 |  |
| p_1_53 | Per base sequence quality | 10th Percentile | identical | 53 | 0 |  |
| p_1_53 | Per base sequence quality | 90th Percentile | identical | 53 | 0 |  |
| p_1_53 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_53 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_53 | Per base sequence content | Base | identical | 53 | 0 |  |
| p_1_53 | Per base sequence content | G | identical | 53 | 0 |  |
| p_1_53 | Per base sequence content | A | identical | 53 | 0 |  |
| p_1_53 | Per base sequence content | T | identical | 53 | 0 |  |
| p_1_53 | Per base sequence content | C | identical | 53 | 0 |  |
| p_1_53 | Per base N content | Base | identical | 53 | 0 |  |
| p_1_53 | Per base N content | N-Count | identical | 53 | 0 |  |
| p_1_53 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_53 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_53 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_53 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_53 | Adapter Content | Position | identical | 42 | 0 |  |
| p_1_53 | Adapter Content | Illumina Universal Adapter | identical | 42 | 0 |  |
| p_1_53 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 42 | 0 |  |
| p_1_53 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 42 | 0 |  |
| p_1_53 | Adapter Content | Nextera Transposase Sequence | identical | 42 | 0 |  |
| p_1_53 | Adapter Content | PolyA | identical | 42 | 0 |  |
| p_1_53 | Adapter Content | PolyG | identical | 42 | 0 |  |
| p_1_53 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_53 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_53 | Sequence Length Distribution | Length | identical | 27 | 0 |  |
| p_1_53 | Sequence Length Distribution | Count | identical | 27 | 0 |  |
| p_1_53 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_53 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_53 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_53 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_53 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_53 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_53 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_53 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_54 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_54 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_54 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_54 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_54 | Per base sequence quality | Base | identical | 54 | 0 |  |
| p_1_54 | Per base sequence quality | Mean | identical | 54 | 0 |  |
| p_1_54 | Per base sequence quality | Median | identical | 54 | 0 |  |
| p_1_54 | Per base sequence quality | Lower Quartile | identical | 54 | 0 |  |
| p_1_54 | Per base sequence quality | Upper Quartile | identical | 54 | 0 |  |
| p_1_54 | Per base sequence quality | 10th Percentile | identical | 54 | 0 |  |
| p_1_54 | Per base sequence quality | 90th Percentile | identical | 54 | 0 |  |
| p_1_54 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_54 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_54 | Per base sequence content | Base | identical | 54 | 0 |  |
| p_1_54 | Per base sequence content | G | identical | 54 | 0 |  |
| p_1_54 | Per base sequence content | A | identical | 54 | 0 |  |
| p_1_54 | Per base sequence content | T | identical | 54 | 0 |  |
| p_1_54 | Per base sequence content | C | identical | 54 | 0 |  |
| p_1_54 | Per base N content | Base | identical | 54 | 0 |  |
| p_1_54 | Per base N content | N-Count | identical | 54 | 0 |  |
| p_1_54 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_54 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_54 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_54 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_54 | Adapter Content | Position | identical | 43 | 0 |  |
| p_1_54 | Adapter Content | Illumina Universal Adapter | identical | 43 | 0 |  |
| p_1_54 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 43 | 0 |  |
| p_1_54 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 43 | 0 |  |
| p_1_54 | Adapter Content | Nextera Transposase Sequence | identical | 43 | 0 |  |
| p_1_54 | Adapter Content | PolyA | identical | 43 | 0 |  |
| p_1_54 | Adapter Content | PolyG | identical | 43 | 0 |  |
| p_1_54 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_54 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_54 | Sequence Length Distribution | Length | identical | 28 | 0 |  |
| p_1_54 | Sequence Length Distribution | Count | identical | 28 | 0 |  |
| p_1_54 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_54 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_54 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_54 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_54 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_54 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_54 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_54 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_1_55 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_1_55 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_1_55 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_1_55 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_1_55 | Per base sequence quality | Base | identical | 55 | 0 |  |
| p_1_55 | Per base sequence quality | Mean | identical | 55 | 0 |  |
| p_1_55 | Per base sequence quality | Median | identical | 55 | 0 |  |
| p_1_55 | Per base sequence quality | Lower Quartile | identical | 55 | 0 |  |
| p_1_55 | Per base sequence quality | Upper Quartile | identical | 55 | 0 |  |
| p_1_55 | Per base sequence quality | 10th Percentile | identical | 55 | 0 |  |
| p_1_55 | Per base sequence quality | 90th Percentile | identical | 55 | 0 |  |
| p_1_55 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_1_55 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_1_55 | Per base sequence content | Base | identical | 55 | 0 |  |
| p_1_55 | Per base sequence content | G | identical | 55 | 0 |  |
| p_1_55 | Per base sequence content | A | identical | 55 | 0 |  |
| p_1_55 | Per base sequence content | T | identical | 55 | 0 |  |
| p_1_55 | Per base sequence content | C | identical | 55 | 0 |  |
| p_1_55 | Per base N content | Base | identical | 55 | 0 |  |
| p_1_55 | Per base N content | N-Count | identical | 55 | 0 |  |
| p_1_55 | Overrepresented sequences | Sequence | identical | 2 | 0 |  |
| p_1_55 | Overrepresented sequences | Count | identical | 2 | 0 |  |
| p_1_55 | Overrepresented sequences | Percentage | identical | 2 | 0 |  |
| p_1_55 | Overrepresented sequences | Possible Source | identical | 2 | 0 |  |
| p_1_55 | Adapter Content | Position | identical | 44 | 0 |  |
| p_1_55 | Adapter Content | Illumina Universal Adapter | identical | 44 | 0 |  |
| p_1_55 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 44 | 0 |  |
| p_1_55 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 44 | 0 |  |
| p_1_55 | Adapter Content | Nextera Transposase Sequence | identical | 44 | 0 |  |
| p_1_55 | Adapter Content | PolyA | identical | 44 | 0 |  |
| p_1_55 | Adapter Content | PolyG | identical | 44 | 0 |  |
| p_1_55 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_1_55 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_1_55 | Sequence Length Distribution | Length | identical | 28 | 0 |  |
| p_1_55 | Sequence Length Distribution | Count | identical | 28 | 0 |  |
| p_1_55 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_1_55 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_1_55 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_1_55 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_1_55 | Per base N content | flag | identical | 1 | 0 |  |
| p_1_55 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_1_55 | Adapter Content | flag | identical | 1 | 0 |  |
| p_1_55 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_240 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_240 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_240 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_240 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_240 | Per base sequence quality | Base | identical | 56 | 0 |  |
| p_200_240 | Per base sequence quality | Mean | identical | 56 | 0 |  |
| p_200_240 | Per base sequence quality | Median | identical | 56 | 0 |  |
| p_200_240 | Per base sequence quality | Lower Quartile | identical | 56 | 0 |  |
| p_200_240 | Per base sequence quality | Upper Quartile | identical | 56 | 0 |  |
| p_200_240 | Per base sequence quality | 10th Percentile | identical | 56 | 0 |  |
| p_200_240 | Per base sequence quality | 90th Percentile | identical | 56 | 0 |  |
| p_200_240 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_240 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_240 | Per base sequence content | Base | identical | 56 | 0 |  |
| p_200_240 | Per base sequence content | G | identical | 56 | 0 |  |
| p_200_240 | Per base sequence content | A | identical | 56 | 0 |  |
| p_200_240 | Per base sequence content | T | identical | 56 | 0 |  |
| p_200_240 | Per base sequence content | C | identical | 56 | 0 |  |
| p_200_240 | Per base N content | Base | identical | 56 | 0 |  |
| p_200_240 | Per base N content | N-Count | identical | 56 | 0 |  |
| p_200_240 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_240 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_240 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_240 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_240 | Adapter Content | Position | identical | 53 | 0 |  |
| p_200_240 | Adapter Content | Illumina Universal Adapter | identical | 53 | 0 |  |
| p_200_240 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 53 | 0 |  |
| p_200_240 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 53 | 0 |  |
| p_200_240 | Adapter Content | Nextera Transposase Sequence | identical | 53 | 0 |  |
| p_200_240 | Adapter Content | PolyA | identical | 53 | 0 |  |
| p_200_240 | Adapter Content | PolyG | identical | 53 | 0 |  |
| p_200_240 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_240 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_240 | Sequence Length Distribution | Length | identical | 41 | 0 |  |
| p_200_240 | Sequence Length Distribution | Count | identical | 41 | 0 |  |
| p_200_240 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_240 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_240 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_240 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_240 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_240 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_240 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_240 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_241 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_241 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_241 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_241 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_241 | Per base sequence quality | Base | identical | 56 | 0 |  |
| p_200_241 | Per base sequence quality | Mean | identical | 56 | 0 |  |
| p_200_241 | Per base sequence quality | Median | identical | 56 | 0 |  |
| p_200_241 | Per base sequence quality | Lower Quartile | identical | 56 | 0 |  |
| p_200_241 | Per base sequence quality | Upper Quartile | identical | 56 | 0 |  |
| p_200_241 | Per base sequence quality | 10th Percentile | identical | 56 | 0 |  |
| p_200_241 | Per base sequence quality | 90th Percentile | identical | 56 | 0 |  |
| p_200_241 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_241 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_241 | Per base sequence content | Base | identical | 56 | 0 |  |
| p_200_241 | Per base sequence content | G | identical | 56 | 0 |  |
| p_200_241 | Per base sequence content | A | identical | 56 | 0 |  |
| p_200_241 | Per base sequence content | T | identical | 56 | 0 |  |
| p_200_241 | Per base sequence content | C | identical | 56 | 0 |  |
| p_200_241 | Per base N content | Base | identical | 56 | 0 |  |
| p_200_241 | Per base N content | N-Count | identical | 56 | 0 |  |
| p_200_241 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_241 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_241 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_241 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_241 | Adapter Content | Position | identical | 54 | 0 |  |
| p_200_241 | Adapter Content | Illumina Universal Adapter | identical | 54 | 0 |  |
| p_200_241 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 54 | 0 |  |
| p_200_241 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 54 | 0 |  |
| p_200_241 | Adapter Content | Nextera Transposase Sequence | identical | 54 | 0 |  |
| p_200_241 | Adapter Content | PolyA | identical | 54 | 0 |  |
| p_200_241 | Adapter Content | PolyG | identical | 54 | 0 |  |
| p_200_241 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_241 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_241 | Sequence Length Distribution | Length | identical | 42 | 0 |  |
| p_200_241 | Sequence Length Distribution | Count | identical | 42 | 0 |  |
| p_200_241 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_241 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_241 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_241 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_241 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_241 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_241 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_241 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_242 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_242 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_242 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_242 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_242 | Per base sequence quality | Base | identical | 56 | 0 |  |
| p_200_242 | Per base sequence quality | Mean | identical | 56 | 0 |  |
| p_200_242 | Per base sequence quality | Median | identical | 56 | 0 |  |
| p_200_242 | Per base sequence quality | Lower Quartile | identical | 56 | 0 |  |
| p_200_242 | Per base sequence quality | Upper Quartile | identical | 56 | 0 |  |
| p_200_242 | Per base sequence quality | 10th Percentile | identical | 56 | 0 |  |
| p_200_242 | Per base sequence quality | 90th Percentile | identical | 56 | 0 |  |
| p_200_242 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_242 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_242 | Per base sequence content | Base | identical | 56 | 0 |  |
| p_200_242 | Per base sequence content | G | identical | 56 | 0 |  |
| p_200_242 | Per base sequence content | A | identical | 56 | 0 |  |
| p_200_242 | Per base sequence content | T | identical | 56 | 0 |  |
| p_200_242 | Per base sequence content | C | identical | 56 | 0 |  |
| p_200_242 | Per base N content | Base | identical | 56 | 0 |  |
| p_200_242 | Per base N content | N-Count | identical | 56 | 0 |  |
| p_200_242 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_242 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_242 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_242 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_242 | Adapter Content | Position | identical | 54 | 0 |  |
| p_200_242 | Adapter Content | Illumina Universal Adapter | identical | 54 | 0 |  |
| p_200_242 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 54 | 0 |  |
| p_200_242 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 54 | 0 |  |
| p_200_242 | Adapter Content | Nextera Transposase Sequence | identical | 54 | 0 |  |
| p_200_242 | Adapter Content | PolyA | identical | 54 | 0 |  |
| p_200_242 | Adapter Content | PolyG | identical | 54 | 0 |  |
| p_200_242 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_242 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_242 | Sequence Length Distribution | Length | identical | 43 | 0 |  |
| p_200_242 | Sequence Length Distribution | Count | identical | 43 | 0 |  |
| p_200_242 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_242 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_242 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_242 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_242 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_242 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_242 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_242 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_243 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_243 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_243 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_243 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_243 | Per base sequence quality | Base | identical | 56 | 0 |  |
| p_200_243 | Per base sequence quality | Mean | identical | 56 | 0 |  |
| p_200_243 | Per base sequence quality | Median | identical | 56 | 0 |  |
| p_200_243 | Per base sequence quality | Lower Quartile | identical | 56 | 0 |  |
| p_200_243 | Per base sequence quality | Upper Quartile | identical | 56 | 0 |  |
| p_200_243 | Per base sequence quality | 10th Percentile | identical | 56 | 0 |  |
| p_200_243 | Per base sequence quality | 90th Percentile | identical | 56 | 0 |  |
| p_200_243 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_243 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_243 | Per base sequence content | Base | identical | 56 | 0 |  |
| p_200_243 | Per base sequence content | G | identical | 56 | 0 |  |
| p_200_243 | Per base sequence content | A | identical | 56 | 0 |  |
| p_200_243 | Per base sequence content | T | identical | 56 | 0 |  |
| p_200_243 | Per base sequence content | C | identical | 56 | 0 |  |
| p_200_243 | Per base N content | Base | identical | 56 | 0 |  |
| p_200_243 | Per base N content | N-Count | identical | 56 | 0 |  |
| p_200_243 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_243 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_243 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_243 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_243 | Adapter Content | Position | identical | 54 | 0 |  |
| p_200_243 | Adapter Content | Illumina Universal Adapter | identical | 54 | 0 |  |
| p_200_243 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 54 | 0 |  |
| p_200_243 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 54 | 0 |  |
| p_200_243 | Adapter Content | Nextera Transposase Sequence | identical | 54 | 0 |  |
| p_200_243 | Adapter Content | PolyA | identical | 54 | 0 |  |
| p_200_243 | Adapter Content | PolyG | identical | 54 | 0 |  |
| p_200_243 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_243 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_243 | Sequence Length Distribution | Length | identical | 44 | 0 |  |
| p_200_243 | Sequence Length Distribution | Count | identical | 44 | 0 |  |
| p_200_243 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_243 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_243 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_243 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_243 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_243 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_243 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_243 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_244 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_244 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_244 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_244 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_244 | Per base sequence quality | Base | identical | 56 | 0 |  |
| p_200_244 | Per base sequence quality | Mean | identical | 56 | 0 |  |
| p_200_244 | Per base sequence quality | Median | identical | 56 | 0 |  |
| p_200_244 | Per base sequence quality | Lower Quartile | identical | 56 | 0 |  |
| p_200_244 | Per base sequence quality | Upper Quartile | identical | 56 | 0 |  |
| p_200_244 | Per base sequence quality | 10th Percentile | identical | 56 | 0 |  |
| p_200_244 | Per base sequence quality | 90th Percentile | identical | 56 | 0 |  |
| p_200_244 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_244 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_244 | Per base sequence content | Base | identical | 56 | 0 |  |
| p_200_244 | Per base sequence content | G | identical | 56 | 0 |  |
| p_200_244 | Per base sequence content | A | identical | 56 | 0 |  |
| p_200_244 | Per base sequence content | T | identical | 56 | 0 |  |
| p_200_244 | Per base sequence content | C | identical | 56 | 0 |  |
| p_200_244 | Per base N content | Base | identical | 56 | 0 |  |
| p_200_244 | Per base N content | N-Count | identical | 56 | 0 |  |
| p_200_244 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_244 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_244 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_244 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_244 | Adapter Content | Position | identical | 54 | 0 |  |
| p_200_244 | Adapter Content | Illumina Universal Adapter | identical | 54 | 0 |  |
| p_200_244 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 54 | 0 |  |
| p_200_244 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 54 | 0 |  |
| p_200_244 | Adapter Content | Nextera Transposase Sequence | identical | 54 | 0 |  |
| p_200_244 | Adapter Content | PolyA | identical | 54 | 0 |  |
| p_200_244 | Adapter Content | PolyG | identical | 54 | 0 |  |
| p_200_244 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_244 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_244 | Sequence Length Distribution | Length | identical | 45 | 0 |  |
| p_200_244 | Sequence Length Distribution | Count | identical | 45 | 0 |  |
| p_200_244 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_244 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_244 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_244 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_244 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_244 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_244 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_244 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_245 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_245 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_245 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_245 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_245 | Per base sequence quality | Base | identical | 57 | 0 |  |
| p_200_245 | Per base sequence quality | Mean | identical | 57 | 0 |  |
| p_200_245 | Per base sequence quality | Median | identical | 57 | 0 |  |
| p_200_245 | Per base sequence quality | Lower Quartile | identical | 57 | 0 |  |
| p_200_245 | Per base sequence quality | Upper Quartile | identical | 57 | 0 |  |
| p_200_245 | Per base sequence quality | 10th Percentile | identical | 57 | 0 |  |
| p_200_245 | Per base sequence quality | 90th Percentile | identical | 57 | 0 |  |
| p_200_245 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_245 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_245 | Per base sequence content | Base | identical | 57 | 0 |  |
| p_200_245 | Per base sequence content | G | identical | 57 | 0 |  |
| p_200_245 | Per base sequence content | A | identical | 57 | 0 |  |
| p_200_245 | Per base sequence content | T | identical | 57 | 0 |  |
| p_200_245 | Per base sequence content | C | identical | 57 | 0 |  |
| p_200_245 | Per base N content | Base | identical | 57 | 0 |  |
| p_200_245 | Per base N content | N-Count | identical | 57 | 0 |  |
| p_200_245 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_245 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_245 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_245 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_245 | Adapter Content | Position | identical | 54 | 0 |  |
| p_200_245 | Adapter Content | Illumina Universal Adapter | identical | 54 | 0 |  |
| p_200_245 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 54 | 0 |  |
| p_200_245 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 54 | 0 |  |
| p_200_245 | Adapter Content | Nextera Transposase Sequence | identical | 54 | 0 |  |
| p_200_245 | Adapter Content | PolyA | identical | 54 | 0 |  |
| p_200_245 | Adapter Content | PolyG | identical | 54 | 0 |  |
| p_200_245 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_245 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_245 | Sequence Length Distribution | Length | identical | 46 | 0 |  |
| p_200_245 | Sequence Length Distribution | Count | identical | 46 | 0 |  |
| p_200_245 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_245 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_245 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_245 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_245 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_245 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_245 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_245 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_246 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_246 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_246 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_246 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_246 | Per base sequence quality | Base | identical | 57 | 0 |  |
| p_200_246 | Per base sequence quality | Mean | identical | 57 | 0 |  |
| p_200_246 | Per base sequence quality | Median | identical | 57 | 0 |  |
| p_200_246 | Per base sequence quality | Lower Quartile | identical | 57 | 0 |  |
| p_200_246 | Per base sequence quality | Upper Quartile | identical | 57 | 0 |  |
| p_200_246 | Per base sequence quality | 10th Percentile | identical | 57 | 0 |  |
| p_200_246 | Per base sequence quality | 90th Percentile | identical | 57 | 0 |  |
| p_200_246 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_246 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_246 | Per base sequence content | Base | identical | 57 | 0 |  |
| p_200_246 | Per base sequence content | G | identical | 57 | 0 |  |
| p_200_246 | Per base sequence content | A | identical | 57 | 0 |  |
| p_200_246 | Per base sequence content | T | identical | 57 | 0 |  |
| p_200_246 | Per base sequence content | C | identical | 57 | 0 |  |
| p_200_246 | Per base N content | Base | identical | 57 | 0 |  |
| p_200_246 | Per base N content | N-Count | identical | 57 | 0 |  |
| p_200_246 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_246 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_246 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_246 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_246 | Adapter Content | Position | identical | 55 | 0 |  |
| p_200_246 | Adapter Content | Illumina Universal Adapter | identical | 55 | 0 |  |
| p_200_246 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 55 | 0 |  |
| p_200_246 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 55 | 0 |  |
| p_200_246 | Adapter Content | Nextera Transposase Sequence | identical | 55 | 0 |  |
| p_200_246 | Adapter Content | PolyA | identical | 55 | 0 |  |
| p_200_246 | Adapter Content | PolyG | identical | 55 | 0 |  |
| p_200_246 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_246 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_246 | Sequence Length Distribution | Length | identical | 47 | 0 |  |
| p_200_246 | Sequence Length Distribution | Count | identical | 47 | 0 |  |
| p_200_246 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_246 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_246 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_246 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_246 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_246 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_246 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_246 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_247 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_247 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_247 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_247 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_247 | Per base sequence quality | Base | identical | 57 | 0 |  |
| p_200_247 | Per base sequence quality | Mean | identical | 57 | 0 |  |
| p_200_247 | Per base sequence quality | Median | identical | 57 | 0 |  |
| p_200_247 | Per base sequence quality | Lower Quartile | identical | 57 | 0 |  |
| p_200_247 | Per base sequence quality | Upper Quartile | identical | 57 | 0 |  |
| p_200_247 | Per base sequence quality | 10th Percentile | identical | 57 | 0 |  |
| p_200_247 | Per base sequence quality | 90th Percentile | identical | 57 | 0 |  |
| p_200_247 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_247 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_247 | Per base sequence content | Base | identical | 57 | 0 |  |
| p_200_247 | Per base sequence content | G | identical | 57 | 0 |  |
| p_200_247 | Per base sequence content | A | identical | 57 | 0 |  |
| p_200_247 | Per base sequence content | T | identical | 57 | 0 |  |
| p_200_247 | Per base sequence content | C | identical | 57 | 0 |  |
| p_200_247 | Per base N content | Base | identical | 57 | 0 |  |
| p_200_247 | Per base N content | N-Count | identical | 57 | 0 |  |
| p_200_247 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_247 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_247 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_247 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_247 | Adapter Content | Position | identical | 55 | 0 |  |
| p_200_247 | Adapter Content | Illumina Universal Adapter | identical | 55 | 0 |  |
| p_200_247 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 55 | 0 |  |
| p_200_247 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 55 | 0 |  |
| p_200_247 | Adapter Content | Nextera Transposase Sequence | identical | 55 | 0 |  |
| p_200_247 | Adapter Content | PolyA | identical | 55 | 0 |  |
| p_200_247 | Adapter Content | PolyG | identical | 55 | 0 |  |
| p_200_247 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_247 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_247 | Sequence Length Distribution | Length | identical | 48 | 0 |  |
| p_200_247 | Sequence Length Distribution | Count | identical | 48 | 0 |  |
| p_200_247 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_247 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_247 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_247 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_247 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_247 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_247 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_247 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_248 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_248 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_248 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_248 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_248 | Per base sequence quality | Base | identical | 57 | 0 |  |
| p_200_248 | Per base sequence quality | Mean | identical | 57 | 0 |  |
| p_200_248 | Per base sequence quality | Median | identical | 57 | 0 |  |
| p_200_248 | Per base sequence quality | Lower Quartile | identical | 57 | 0 |  |
| p_200_248 | Per base sequence quality | Upper Quartile | identical | 57 | 0 |  |
| p_200_248 | Per base sequence quality | 10th Percentile | identical | 57 | 0 |  |
| p_200_248 | Per base sequence quality | 90th Percentile | identical | 57 | 0 |  |
| p_200_248 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_248 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_248 | Per base sequence content | Base | identical | 57 | 0 |  |
| p_200_248 | Per base sequence content | G | identical | 57 | 0 |  |
| p_200_248 | Per base sequence content | A | identical | 57 | 0 |  |
| p_200_248 | Per base sequence content | T | identical | 57 | 0 |  |
| p_200_248 | Per base sequence content | C | identical | 57 | 0 |  |
| p_200_248 | Per base N content | Base | identical | 57 | 0 |  |
| p_200_248 | Per base N content | N-Count | identical | 57 | 0 |  |
| p_200_248 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_248 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_248 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_248 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_248 | Adapter Content | Position | identical | 55 | 0 |  |
| p_200_248 | Adapter Content | Illumina Universal Adapter | identical | 55 | 0 |  |
| p_200_248 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 55 | 0 |  |
| p_200_248 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 55 | 0 |  |
| p_200_248 | Adapter Content | Nextera Transposase Sequence | identical | 55 | 0 |  |
| p_200_248 | Adapter Content | PolyA | identical | 55 | 0 |  |
| p_200_248 | Adapter Content | PolyG | identical | 55 | 0 |  |
| p_200_248 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_248 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_248 | Sequence Length Distribution | Length | identical | 49 | 0 |  |
| p_200_248 | Sequence Length Distribution | Count | identical | 49 | 0 |  |
| p_200_248 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_248 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_248 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_248 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_248 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_248 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_248 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_248 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_249 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_249 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_249 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_249 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_249 | Per base sequence quality | Base | identical | 57 | 0 |  |
| p_200_249 | Per base sequence quality | Mean | identical | 57 | 0 |  |
| p_200_249 | Per base sequence quality | Median | identical | 57 | 0 |  |
| p_200_249 | Per base sequence quality | Lower Quartile | identical | 57 | 0 |  |
| p_200_249 | Per base sequence quality | Upper Quartile | identical | 57 | 0 |  |
| p_200_249 | Per base sequence quality | 10th Percentile | identical | 57 | 0 |  |
| p_200_249 | Per base sequence quality | 90th Percentile | identical | 57 | 0 |  |
| p_200_249 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_249 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_249 | Per base sequence content | Base | identical | 57 | 0 |  |
| p_200_249 | Per base sequence content | G | identical | 57 | 0 |  |
| p_200_249 | Per base sequence content | A | identical | 57 | 0 |  |
| p_200_249 | Per base sequence content | T | identical | 57 | 0 |  |
| p_200_249 | Per base sequence content | C | identical | 57 | 0 |  |
| p_200_249 | Per base N content | Base | identical | 57 | 0 |  |
| p_200_249 | Per base N content | N-Count | identical | 57 | 0 |  |
| p_200_249 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_249 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_249 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_249 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_249 | Adapter Content | Position | identical | 55 | 0 |  |
| p_200_249 | Adapter Content | Illumina Universal Adapter | identical | 55 | 0 |  |
| p_200_249 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 55 | 0 |  |
| p_200_249 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 55 | 0 |  |
| p_200_249 | Adapter Content | Nextera Transposase Sequence | identical | 55 | 0 |  |
| p_200_249 | Adapter Content | PolyA | identical | 55 | 0 |  |
| p_200_249 | Adapter Content | PolyG | identical | 55 | 0 |  |
| p_200_249 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_249 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_249 | Sequence Length Distribution | Length | identical | 25 | 0 |  |
| p_200_249 | Sequence Length Distribution | Count | identical | 25 | 0 |  |
| p_200_249 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_249 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_249 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_249 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_249 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_249 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_249 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_249 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_250 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_250 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_250 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_250 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_250 | Per base sequence quality | Base | identical | 58 | 0 |  |
| p_200_250 | Per base sequence quality | Mean | identical | 58 | 0 |  |
| p_200_250 | Per base sequence quality | Median | identical | 58 | 0 |  |
| p_200_250 | Per base sequence quality | Lower Quartile | identical | 58 | 0 |  |
| p_200_250 | Per base sequence quality | Upper Quartile | identical | 58 | 0 |  |
| p_200_250 | Per base sequence quality | 10th Percentile | identical | 58 | 0 |  |
| p_200_250 | Per base sequence quality | 90th Percentile | identical | 58 | 0 |  |
| p_200_250 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_250 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_250 | Per base sequence content | Base | identical | 58 | 0 |  |
| p_200_250 | Per base sequence content | G | identical | 58 | 0 |  |
| p_200_250 | Per base sequence content | A | identical | 58 | 0 |  |
| p_200_250 | Per base sequence content | T | identical | 58 | 0 |  |
| p_200_250 | Per base sequence content | C | identical | 58 | 0 |  |
| p_200_250 | Per base N content | Base | identical | 58 | 0 |  |
| p_200_250 | Per base N content | N-Count | identical | 58 | 0 |  |
| p_200_250 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_250 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_250 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_250 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_250 | Adapter Content | Position | identical | 55 | 0 |  |
| p_200_250 | Adapter Content | Illumina Universal Adapter | identical | 55 | 0 |  |
| p_200_250 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 55 | 0 |  |
| p_200_250 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 55 | 0 |  |
| p_200_250 | Adapter Content | Nextera Transposase Sequence | identical | 55 | 0 |  |
| p_200_250 | Adapter Content | PolyA | identical | 55 | 0 |  |
| p_200_250 | Adapter Content | PolyG | identical | 55 | 0 |  |
| p_200_250 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_250 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_250 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| p_200_250 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| p_200_250 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_250 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_250 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_250 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_250 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_250 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_250 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_250 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_251 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_251 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_251 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_251 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_251 | Per base sequence quality | Base | identical | 58 | 0 |  |
| p_200_251 | Per base sequence quality | Mean | identical | 58 | 0 |  |
| p_200_251 | Per base sequence quality | Median | identical | 58 | 0 |  |
| p_200_251 | Per base sequence quality | Lower Quartile | identical | 58 | 0 |  |
| p_200_251 | Per base sequence quality | Upper Quartile | identical | 58 | 0 |  |
| p_200_251 | Per base sequence quality | 10th Percentile | identical | 58 | 0 |  |
| p_200_251 | Per base sequence quality | 90th Percentile | identical | 58 | 0 |  |
| p_200_251 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_251 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_251 | Per base sequence content | Base | identical | 58 | 0 |  |
| p_200_251 | Per base sequence content | G | identical | 58 | 0 |  |
| p_200_251 | Per base sequence content | A | identical | 58 | 0 |  |
| p_200_251 | Per base sequence content | T | identical | 58 | 0 |  |
| p_200_251 | Per base sequence content | C | identical | 58 | 0 |  |
| p_200_251 | Per base N content | Base | identical | 58 | 0 |  |
| p_200_251 | Per base N content | N-Count | identical | 58 | 0 |  |
| p_200_251 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_251 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_251 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_251 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_251 | Adapter Content | Position | identical | 56 | 0 |  |
| p_200_251 | Adapter Content | Illumina Universal Adapter | identical | 56 | 0 |  |
| p_200_251 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 56 | 0 |  |
| p_200_251 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 56 | 0 |  |
| p_200_251 | Adapter Content | Nextera Transposase Sequence | identical | 56 | 0 |  |
| p_200_251 | Adapter Content | PolyA | identical | 56 | 0 |  |
| p_200_251 | Adapter Content | PolyG | identical | 56 | 0 |  |
| p_200_251 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_251 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_251 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| p_200_251 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| p_200_251 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_251 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_251 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_251 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_251 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_251 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_251 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_251 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_252 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_252 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_252 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_252 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_252 | Per base sequence quality | Base | identical | 58 | 0 |  |
| p_200_252 | Per base sequence quality | Mean | identical | 58 | 0 |  |
| p_200_252 | Per base sequence quality | Median | identical | 58 | 0 |  |
| p_200_252 | Per base sequence quality | Lower Quartile | identical | 58 | 0 |  |
| p_200_252 | Per base sequence quality | Upper Quartile | identical | 58 | 0 |  |
| p_200_252 | Per base sequence quality | 10th Percentile | identical | 58 | 0 |  |
| p_200_252 | Per base sequence quality | 90th Percentile | identical | 58 | 0 |  |
| p_200_252 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_252 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_252 | Per base sequence content | Base | identical | 58 | 0 |  |
| p_200_252 | Per base sequence content | G | identical | 58 | 0 |  |
| p_200_252 | Per base sequence content | A | identical | 58 | 0 |  |
| p_200_252 | Per base sequence content | T | identical | 58 | 0 |  |
| p_200_252 | Per base sequence content | C | identical | 58 | 0 |  |
| p_200_252 | Per base N content | Base | identical | 58 | 0 |  |
| p_200_252 | Per base N content | N-Count | identical | 58 | 0 |  |
| p_200_252 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_252 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_252 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_252 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_252 | Adapter Content | Position | identical | 56 | 0 |  |
| p_200_252 | Adapter Content | Illumina Universal Adapter | identical | 56 | 0 |  |
| p_200_252 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 56 | 0 |  |
| p_200_252 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 56 | 0 |  |
| p_200_252 | Adapter Content | Nextera Transposase Sequence | identical | 56 | 0 |  |
| p_200_252 | Adapter Content | PolyA | identical | 56 | 0 |  |
| p_200_252 | Adapter Content | PolyG | identical | 56 | 0 |  |
| p_200_252 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_252 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_252 | Sequence Length Distribution | Length | identical | 27 | 0 |  |
| p_200_252 | Sequence Length Distribution | Count | identical | 27 | 0 |  |
| p_200_252 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_252 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_252 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_252 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_252 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_252 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_252 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_252 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_253 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_253 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_253 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_253 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_253 | Per base sequence quality | Base | identical | 58 | 0 |  |
| p_200_253 | Per base sequence quality | Mean | identical | 58 | 0 |  |
| p_200_253 | Per base sequence quality | Median | identical | 58 | 0 |  |
| p_200_253 | Per base sequence quality | Lower Quartile | identical | 58 | 0 |  |
| p_200_253 | Per base sequence quality | Upper Quartile | identical | 58 | 0 |  |
| p_200_253 | Per base sequence quality | 10th Percentile | identical | 58 | 0 |  |
| p_200_253 | Per base sequence quality | 90th Percentile | identical | 58 | 0 |  |
| p_200_253 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_253 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_253 | Per base sequence content | Base | identical | 58 | 0 |  |
| p_200_253 | Per base sequence content | G | identical | 58 | 0 |  |
| p_200_253 | Per base sequence content | A | identical | 58 | 0 |  |
| p_200_253 | Per base sequence content | T | identical | 58 | 0 |  |
| p_200_253 | Per base sequence content | C | identical | 58 | 0 |  |
| p_200_253 | Per base N content | Base | identical | 58 | 0 |  |
| p_200_253 | Per base N content | N-Count | identical | 58 | 0 |  |
| p_200_253 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_253 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_253 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_253 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_253 | Adapter Content | Position | identical | 56 | 0 |  |
| p_200_253 | Adapter Content | Illumina Universal Adapter | identical | 56 | 0 |  |
| p_200_253 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 56 | 0 |  |
| p_200_253 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 56 | 0 |  |
| p_200_253 | Adapter Content | Nextera Transposase Sequence | identical | 56 | 0 |  |
| p_200_253 | Adapter Content | PolyA | identical | 56 | 0 |  |
| p_200_253 | Adapter Content | PolyG | identical | 56 | 0 |  |
| p_200_253 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_253 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_253 | Sequence Length Distribution | Length | identical | 27 | 0 |  |
| p_200_253 | Sequence Length Distribution | Count | identical | 27 | 0 |  |
| p_200_253 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_253 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_253 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_253 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_253 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_253 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_253 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_253 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_254 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_254 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_254 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_254 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_254 | Per base sequence quality | Base | identical | 58 | 0 |  |
| p_200_254 | Per base sequence quality | Mean | identical | 58 | 0 |  |
| p_200_254 | Per base sequence quality | Median | identical | 58 | 0 |  |
| p_200_254 | Per base sequence quality | Lower Quartile | identical | 58 | 0 |  |
| p_200_254 | Per base sequence quality | Upper Quartile | identical | 58 | 0 |  |
| p_200_254 | Per base sequence quality | 10th Percentile | identical | 58 | 0 |  |
| p_200_254 | Per base sequence quality | 90th Percentile | identical | 58 | 0 |  |
| p_200_254 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_254 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_254 | Per base sequence content | Base | identical | 58 | 0 |  |
| p_200_254 | Per base sequence content | G | identical | 58 | 0 |  |
| p_200_254 | Per base sequence content | A | identical | 58 | 0 |  |
| p_200_254 | Per base sequence content | T | identical | 58 | 0 |  |
| p_200_254 | Per base sequence content | C | identical | 58 | 0 |  |
| p_200_254 | Per base N content | Base | identical | 58 | 0 |  |
| p_200_254 | Per base N content | N-Count | identical | 58 | 0 |  |
| p_200_254 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_254 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_254 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_254 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_254 | Adapter Content | Position | identical | 56 | 0 |  |
| p_200_254 | Adapter Content | Illumina Universal Adapter | identical | 56 | 0 |  |
| p_200_254 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 56 | 0 |  |
| p_200_254 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 56 | 0 |  |
| p_200_254 | Adapter Content | Nextera Transposase Sequence | identical | 56 | 0 |  |
| p_200_254 | Adapter Content | PolyA | identical | 56 | 0 |  |
| p_200_254 | Adapter Content | PolyG | identical | 56 | 0 |  |
| p_200_254 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_254 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_254 | Sequence Length Distribution | Length | identical | 28 | 0 |  |
| p_200_254 | Sequence Length Distribution | Count | identical | 28 | 0 |  |
| p_200_254 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_254 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_254 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_254 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_254 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_254 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_254 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_254 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| p_200_255 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| p_200_255 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| p_200_255 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| p_200_255 | Basic Statistics | %GC | identical | 1 | 0 |  |
| p_200_255 | Per base sequence quality | Base | identical | 59 | 0 |  |
| p_200_255 | Per base sequence quality | Mean | identical | 59 | 0 |  |
| p_200_255 | Per base sequence quality | Median | identical | 59 | 0 |  |
| p_200_255 | Per base sequence quality | Lower Quartile | identical | 59 | 0 |  |
| p_200_255 | Per base sequence quality | Upper Quartile | identical | 59 | 0 |  |
| p_200_255 | Per base sequence quality | 10th Percentile | identical | 59 | 0 |  |
| p_200_255 | Per base sequence quality | 90th Percentile | identical | 59 | 0 |  |
| p_200_255 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| p_200_255 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| p_200_255 | Per base sequence content | Base | identical | 59 | 0 |  |
| p_200_255 | Per base sequence content | G | identical | 59 | 0 |  |
| p_200_255 | Per base sequence content | A | identical | 59 | 0 |  |
| p_200_255 | Per base sequence content | T | identical | 59 | 0 |  |
| p_200_255 | Per base sequence content | C | identical | 59 | 0 |  |
| p_200_255 | Per base N content | Base | identical | 59 | 0 |  |
| p_200_255 | Per base N content | N-Count | identical | 59 | 0 |  |
| p_200_255 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| p_200_255 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| p_200_255 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| p_200_255 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| p_200_255 | Adapter Content | Position | identical | 56 | 0 |  |
| p_200_255 | Adapter Content | Illumina Universal Adapter | identical | 56 | 0 |  |
| p_200_255 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 56 | 0 |  |
| p_200_255 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 56 | 0 |  |
| p_200_255 | Adapter Content | Nextera Transposase Sequence | identical | 56 | 0 |  |
| p_200_255 | Adapter Content | PolyA | identical | 56 | 0 |  |
| p_200_255 | Adapter Content | PolyG | identical | 56 | 0 |  |
| p_200_255 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| p_200_255 | Per sequence GC content | Count | identical | 101 | 0 |  |
| p_200_255 | Sequence Length Distribution | Length | identical | 28 | 0 |  |
| p_200_255 | Sequence Length Distribution | Count | identical | 28 | 0 |  |
| p_200_255 | Basic Statistics | flag | identical | 1 | 0 |  |
| p_200_255 | Per base sequence quality | flag | identical | 1 | 0 |  |
| p_200_255 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| p_200_255 | Per base sequence content | flag | identical | 1 | 0 |  |
| p_200_255 | Per base N content | flag | identical | 1 | 0 |  |
| p_200_255 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| p_200_255 | Adapter Content | flag | identical | 1 | 0 |  |
| p_200_255 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| a0_49 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| a0_49 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| a0_49 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| a0_49 | Basic Statistics | %GC | identical | 1 | 0 |  |
| a0_49 | Per base sequence quality | Base | identical | 49 | 0 |  |
| a0_49 | Per base sequence quality | Mean | identical | 49 | 0 |  |
| a0_49 | Per base sequence quality | Median | identical | 49 | 0 |  |
| a0_49 | Per base sequence quality | Lower Quartile | identical | 49 | 0 |  |
| a0_49 | Per base sequence quality | Upper Quartile | identical | 49 | 0 |  |
| a0_49 | Per base sequence quality | 10th Percentile | identical | 49 | 0 |  |
| a0_49 | Per base sequence quality | 90th Percentile | identical | 49 | 0 |  |
| a0_49 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| a0_49 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| a0_49 | Per base sequence content | Base | identical | 49 | 0 |  |
| a0_49 | Per base sequence content | G | identical | 49 | 0 |  |
| a0_49 | Per base sequence content | A | identical | 49 | 0 |  |
| a0_49 | Per base sequence content | T | identical | 49 | 0 |  |
| a0_49 | Per base sequence content | C | identical | 49 | 0 |  |
| a0_49 | Per base N content | Base | identical | 49 | 0 |  |
| a0_49 | Per base N content | N-Count | identical | 49 | 0 |  |
| a0_49 | Overrepresented sequences | Sequence | identical | 50 | 0 |  |
| a0_49 | Overrepresented sequences | Count | identical | 50 | 0 |  |
| a0_49 | Overrepresented sequences | Percentage | identical | 50 | 0 |  |
| a0_49 | Overrepresented sequences | Possible Source | identical | 50 | 0 |  |
| a0_49 | Adapter Content | Position | identical | 38 | 0 |  |
| a0_49 | Adapter Content | Illumina Universal Adapter | identical | 38 | 0 |  |
| a0_49 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 38 | 0 |  |
| a0_49 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 38 | 0 |  |
| a0_49 | Adapter Content | Nextera Transposase Sequence | identical | 38 | 0 |  |
| a0_49 | Adapter Content | PolyA | identical | 38 | 0 |  |
| a0_49 | Adapter Content | PolyG | identical | 38 | 0 |  |
| a0_49 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| a0_49 | Per sequence GC content | Count | identical | 101 | 0 |  |
| a0_49 | Sequence Length Distribution | Length | identical | 50 | 0 |  |
| a0_49 | Sequence Length Distribution | Count | identical | 50 | 0 |  |
| a0_49 | Basic Statistics | flag | identical | 1 | 0 |  |
| a0_49 | Per base sequence quality | flag | identical | 1 | 0 |  |
| a0_49 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| a0_49 | Per base sequence content | flag | identical | 1 | 0 |  |
| a0_49 | Per base N content | flag | identical | 1 | 0 |  |
| a0_49 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| a0_49 | Adapter Content | flag | identical | 1 | 0 |  |
| a0_49 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| a1000_3449 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| a1000_3449 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| a1000_3449 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| a1000_3449 | Basic Statistics | %GC | identical | 1 | 0 |  |
| a1000_3449 | Per base sequence quality | Base | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence quality | Mean | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence quality | Median | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence quality | Lower Quartile | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence quality | Upper Quartile | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence quality | 10th Percentile | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence quality | 90th Percentile | identical | 44 | 0 |  |
| a1000_3449 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| a1000_3449 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| a1000_3449 | Per base sequence content | Base | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence content | G | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence content | A | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence content | T | identical | 44 | 0 |  |
| a1000_3449 | Per base sequence content | C | identical | 44 | 0 |  |
| a1000_3449 | Per base N content | Base | identical | 44 | 0 |  |
| a1000_3449 | Per base N content | N-Count | identical | 44 | 0 |  |
| a1000_3449 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| a1000_3449 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| a1000_3449 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| a1000_3449 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| a1000_3449 | Adapter Content | Position | identical | 44 | 0 |  |
| a1000_3449 | Adapter Content | Illumina Universal Adapter | identical | 44 | 0 |  |
| a1000_3449 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 44 | 0 |  |
| a1000_3449 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 44 | 0 |  |
| a1000_3449 | Adapter Content | Nextera Transposase Sequence | identical | 44 | 0 |  |
| a1000_3449 | Adapter Content | PolyA | identical | 44 | 0 |  |
| a1000_3449 | Adapter Content | PolyG | identical | 44 | 0 |  |
| a1000_3449 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| a1000_3449 | Per sequence GC content | Count | identical | 101 | 0 |  |
| a1000_3449 | Sequence Length Distribution | Length | identical | 49 | 0 |  |
| a1000_3449 | Sequence Length Distribution | Count | identical | 49 | 0 |  |
| a1000_3449 | Basic Statistics | flag | identical | 1 | 0 |  |
| a1000_3449 | Per base sequence quality | flag | identical | 1 | 0 |  |
| a1000_3449 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| a1000_3449 | Per base sequence content | flag | identical | 1 | 0 |  |
| a1000_3449 | Per base N content | flag | identical | 1 | 0 |  |
| a1000_3449 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| a1000_3449 | Adapter Content | flag | identical | 1 | 0 |  |
| a1000_3449 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| a1000_3500 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| a1000_3500 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| a1000_3500 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| a1000_3500 | Basic Statistics | %GC | identical | 1 | 0 |  |
| a1000_3500 | Per base sequence quality | Base | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence quality | Mean | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence quality | Median | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence quality | Lower Quartile | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence quality | Upper Quartile | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence quality | 10th Percentile | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence quality | 90th Percentile | identical | 45 | 0 |  |
| a1000_3500 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| a1000_3500 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| a1000_3500 | Per base sequence content | Base | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence content | G | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence content | A | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence content | T | identical | 45 | 0 |  |
| a1000_3500 | Per base sequence content | C | identical | 45 | 0 |  |
| a1000_3500 | Per base N content | Base | identical | 45 | 0 |  |
| a1000_3500 | Per base N content | N-Count | identical | 45 | 0 |  |
| a1000_3500 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| a1000_3500 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| a1000_3500 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| a1000_3500 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| a1000_3500 | Adapter Content | Position | identical | 44 | 0 |  |
| a1000_3500 | Adapter Content | Illumina Universal Adapter | identical | 44 | 0 |  |
| a1000_3500 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 44 | 0 |  |
| a1000_3500 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 44 | 0 |  |
| a1000_3500 | Adapter Content | Nextera Transposase Sequence | identical | 44 | 0 |  |
| a1000_3500 | Adapter Content | PolyA | identical | 44 | 0 |  |
| a1000_3500 | Adapter Content | PolyG | identical | 44 | 0 |  |
| a1000_3500 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| a1000_3500 | Per sequence GC content | Count | identical | 101 | 0 |  |
| a1000_3500 | Sequence Length Distribution | Length | identical | 51 | 0 |  |
| a1000_3500 | Sequence Length Distribution | Count | identical | 51 | 0 |  |
| a1000_3500 | Basic Statistics | flag | identical | 1 | 0 |  |
| a1000_3500 | Per base sequence quality | flag | identical | 1 | 0 |  |
| a1000_3500 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| a1000_3500 | Per base sequence content | flag | identical | 1 | 0 |  |
| a1000_3500 | Per base N content | flag | identical | 1 | 0 |  |
| a1000_3500 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| a1000_3500 | Adapter Content | flag | identical | 1 | 0 |  |
| a1000_3500 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| a100_149 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| a100_149 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| a100_149 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| a100_149 | Basic Statistics | %GC | identical | 1 | 0 |  |
| a100_149 | Per base sequence quality | Base | identical | 37 | 0 |  |
| a100_149 | Per base sequence quality | Mean | identical | 37 | 0 |  |
| a100_149 | Per base sequence quality | Median | identical | 37 | 0 |  |
| a100_149 | Per base sequence quality | Lower Quartile | identical | 37 | 0 |  |
| a100_149 | Per base sequence quality | Upper Quartile | identical | 37 | 0 |  |
| a100_149 | Per base sequence quality | 10th Percentile | identical | 37 | 0 |  |
| a100_149 | Per base sequence quality | 90th Percentile | identical | 37 | 0 |  |
| a100_149 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| a100_149 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| a100_149 | Per base sequence content | Base | identical | 37 | 0 |  |
| a100_149 | Per base sequence content | G | identical | 37 | 0 |  |
| a100_149 | Per base sequence content | A | identical | 37 | 0 |  |
| a100_149 | Per base sequence content | T | identical | 37 | 0 |  |
| a100_149 | Per base sequence content | C | identical | 37 | 0 |  |
| a100_149 | Per base N content | Base | identical | 37 | 0 |  |
| a100_149 | Per base N content | N-Count | identical | 37 | 0 |  |
| a100_149 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| a100_149 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| a100_149 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| a100_149 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| a100_149 | Adapter Content | Position | identical | 74 | 0 |  |
| a100_149 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| a100_149 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| a100_149 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| a100_149 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| a100_149 | Adapter Content | PolyA | identical | 74 | 0 |  |
| a100_149 | Adapter Content | PolyG | identical | 74 | 0 |  |
| a100_149 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| a100_149 | Per sequence GC content | Count | identical | 101 | 0 |  |
| a100_149 | Sequence Length Distribution | Length | identical | 25 | 0 |  |
| a100_149 | Sequence Length Distribution | Count | identical | 25 | 0 |  |
| a100_149 | Basic Statistics | flag | identical | 1 | 0 |  |
| a100_149 | Per base sequence quality | flag | identical | 1 | 0 |  |
| a100_149 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| a100_149 | Per base sequence content | flag | identical | 1 | 0 |  |
| a100_149 | Per base N content | flag | identical | 1 | 0 |  |
| a100_149 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| a100_149 | Adapter Content | flag | identical | 1 | 0 |  |
| a100_149 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| a1_50 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| a1_50 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| a1_50 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| a1_50 | Basic Statistics | %GC | identical | 1 | 0 |  |
| a1_50 | Per base sequence quality | Base | identical | 50 | 0 |  |
| a1_50 | Per base sequence quality | Mean | identical | 50 | 0 |  |
| a1_50 | Per base sequence quality | Median | identical | 50 | 0 |  |
| a1_50 | Per base sequence quality | Lower Quartile | identical | 50 | 0 |  |
| a1_50 | Per base sequence quality | Upper Quartile | identical | 50 | 0 |  |
| a1_50 | Per base sequence quality | 10th Percentile | identical | 50 | 0 |  |
| a1_50 | Per base sequence quality | 90th Percentile | identical | 50 | 0 |  |
| a1_50 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| a1_50 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| a1_50 | Per base sequence content | Base | identical | 50 | 0 |  |
| a1_50 | Per base sequence content | G | identical | 50 | 0 |  |
| a1_50 | Per base sequence content | A | identical | 50 | 0 |  |
| a1_50 | Per base sequence content | T | identical | 50 | 0 |  |
| a1_50 | Per base sequence content | C | identical | 50 | 0 |  |
| a1_50 | Per base N content | Base | identical | 50 | 0 |  |
| a1_50 | Per base N content | N-Count | identical | 50 | 0 |  |
| a1_50 | Overrepresented sequences | Sequence | identical | 50 | 0 |  |
| a1_50 | Overrepresented sequences | Count | identical | 50 | 0 |  |
| a1_50 | Overrepresented sequences | Percentage | identical | 50 | 0 |  |
| a1_50 | Overrepresented sequences | Possible Source | identical | 50 | 0 |  |
| a1_50 | Adapter Content | Position | identical | 39 | 0 |  |
| a1_50 | Adapter Content | Illumina Universal Adapter | identical | 39 | 0 |  |
| a1_50 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 39 | 0 |  |
| a1_50 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 39 | 0 |  |
| a1_50 | Adapter Content | Nextera Transposase Sequence | identical | 39 | 0 |  |
| a1_50 | Adapter Content | PolyA | identical | 39 | 0 |  |
| a1_50 | Adapter Content | PolyG | identical | 39 | 0 |  |
| a1_50 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| a1_50 | Per sequence GC content | Count | identical | 101 | 0 |  |
| a1_50 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| a1_50 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| a1_50 | Basic Statistics | flag | identical | 1 | 0 |  |
| a1_50 | Per base sequence quality | flag | identical | 1 | 0 |  |
| a1_50 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| a1_50 | Per base sequence content | flag | identical | 1 | 0 |  |
| a1_50 | Per base N content | flag | identical | 1 | 0 |  |
| a1_50 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| a1_50 | Adapter Content | flag | identical | 1 | 0 |  |
| a1_50 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| a1_51 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| a1_51 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| a1_51 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| a1_51 | Basic Statistics | %GC | identical | 1 | 0 |  |
| a1_51 | Per base sequence quality | Base | identical | 51 | 0 |  |
| a1_51 | Per base sequence quality | Mean | identical | 51 | 0 |  |
| a1_51 | Per base sequence quality | Median | identical | 51 | 0 |  |
| a1_51 | Per base sequence quality | Lower Quartile | identical | 51 | 0 |  |
| a1_51 | Per base sequence quality | Upper Quartile | identical | 51 | 0 |  |
| a1_51 | Per base sequence quality | 10th Percentile | identical | 51 | 0 |  |
| a1_51 | Per base sequence quality | 90th Percentile | identical | 51 | 0 |  |
| a1_51 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| a1_51 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| a1_51 | Per base sequence content | Base | identical | 51 | 0 |  |
| a1_51 | Per base sequence content | G | identical | 51 | 0 |  |
| a1_51 | Per base sequence content | A | identical | 51 | 0 |  |
| a1_51 | Per base sequence content | T | identical | 51 | 0 |  |
| a1_51 | Per base sequence content | C | identical | 51 | 0 |  |
| a1_51 | Per base N content | Base | identical | 51 | 0 |  |
| a1_51 | Per base N content | N-Count | identical | 51 | 0 |  |
| a1_51 | Overrepresented sequences | Sequence | identical | 50 | 0 |  |
| a1_51 | Overrepresented sequences | Count | identical | 50 | 0 |  |
| a1_51 | Overrepresented sequences | Percentage | identical | 50 | 0 |  |
| a1_51 | Overrepresented sequences | Possible Source | identical | 50 | 0 |  |
| a1_51 | Adapter Content | Position | identical | 40 | 0 |  |
| a1_51 | Adapter Content | Illumina Universal Adapter | identical | 40 | 0 |  |
| a1_51 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 40 | 0 |  |
| a1_51 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 40 | 0 |  |
| a1_51 | Adapter Content | Nextera Transposase Sequence | identical | 40 | 0 |  |
| a1_51 | Adapter Content | PolyA | identical | 40 | 0 |  |
| a1_51 | Adapter Content | PolyG | identical | 40 | 0 |  |
| a1_51 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| a1_51 | Per sequence GC content | Count | identical | 101 | 0 |  |
| a1_51 | Sequence Length Distribution | Length | identical | 26 | 0 |  |
| a1_51 | Sequence Length Distribution | Count | identical | 26 | 0 |  |
| a1_51 | Basic Statistics | flag | identical | 1 | 0 |  |
| a1_51 | Per base sequence quality | flag | identical | 1 | 0 |  |
| a1_51 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| a1_51 | Per base sequence content | flag | identical | 1 | 0 |  |
| a1_51 | Per base N content | flag | identical | 1 | 0 |  |
| a1_51 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| a1_51 | Adapter Content | flag | identical | 1 | 0 |  |
| a1_51 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| a7_251 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| a7_251 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| a7_251 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| a7_251 | Basic Statistics | %GC | identical | 1 | 0 |  |
| a7_251 | Per base sequence quality | Base | identical | 58 | 0 |  |
| a7_251 | Per base sequence quality | Mean | identical | 58 | 0 |  |
| a7_251 | Per base sequence quality | Median | identical | 58 | 0 |  |
| a7_251 | Per base sequence quality | Lower Quartile | identical | 58 | 0 |  |
| a7_251 | Per base sequence quality | Upper Quartile | identical | 58 | 0 |  |
| a7_251 | Per base sequence quality | 10th Percentile | identical | 58 | 0 |  |
| a7_251 | Per base sequence quality | 90th Percentile | identical | 58 | 0 |  |
| a7_251 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| a7_251 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| a7_251 | Per base sequence content | Base | identical | 58 | 0 |  |
| a7_251 | Per base sequence content | G | identical | 58 | 0 |  |
| a7_251 | Per base sequence content | A | identical | 58 | 0 |  |
| a7_251 | Per base sequence content | T | identical | 58 | 0 |  |
| a7_251 | Per base sequence content | C | identical | 58 | 0 |  |
| a7_251 | Per base N content | Base | identical | 58 | 0 |  |
| a7_251 | Per base N content | N-Count | identical | 58 | 0 |  |
| a7_251 | Overrepresented sequences | Sequence | identical | 44 | 0 |  |
| a7_251 | Overrepresented sequences | Count | identical | 44 | 0 |  |
| a7_251 | Overrepresented sequences | Percentage | identical | 44 | 0 |  |
| a7_251 | Overrepresented sequences | Possible Source | identical | 44 | 0 |  |
| a7_251 | Adapter Content | Position | identical | 56 | 0 |  |
| a7_251 | Adapter Content | Illumina Universal Adapter | identical | 56 | 0 |  |
| a7_251 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 56 | 0 |  |
| a7_251 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 56 | 0 |  |
| a7_251 | Adapter Content | Nextera Transposase Sequence | identical | 56 | 0 |  |
| a7_251 | Adapter Content | PolyA | identical | 56 | 0 |  |
| a7_251 | Adapter Content | PolyG | identical | 56 | 0 |  |
| a7_251 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| a7_251 | Per sequence GC content | Count | identical | 101 | 0 |  |
| a7_251 | Sequence Length Distribution | Length | identical | 50 | 0 |  |
| a7_251 | Sequence Length Distribution | Count | identical | 50 | 0 |  |
| a7_251 | Basic Statistics | flag | identical | 1 | 0 |  |
| a7_251 | Per base sequence quality | flag | identical | 1 | 0 |  |
| a7_251 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| a7_251 | Per base sequence content | flag | identical | 1 | 0 |  |
| a7_251 | Per base N content | flag | identical | 1 | 0 |  |
| a7_251 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| a7_251 | Adapter Content | flag | identical | 1 | 0 |  |
| a7_251 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| a7_256 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| a7_256 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| a7_256 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| a7_256 | Basic Statistics | %GC | identical | 1 | 0 |  |
| a7_256 | Per base sequence quality | Base | identical | 59 | 0 |  |
| a7_256 | Per base sequence quality | Mean | identical | 59 | 0 |  |
| a7_256 | Per base sequence quality | Median | identical | 59 | 0 |  |
| a7_256 | Per base sequence quality | Lower Quartile | identical | 59 | 0 |  |
| a7_256 | Per base sequence quality | Upper Quartile | identical | 59 | 0 |  |
| a7_256 | Per base sequence quality | 10th Percentile | identical | 59 | 0 |  |
| a7_256 | Per base sequence quality | 90th Percentile | identical | 59 | 0 |  |
| a7_256 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| a7_256 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| a7_256 | Per base sequence content | Base | identical | 59 | 0 |  |
| a7_256 | Per base sequence content | G | identical | 59 | 0 |  |
| a7_256 | Per base sequence content | A | identical | 59 | 0 |  |
| a7_256 | Per base sequence content | T | identical | 59 | 0 |  |
| a7_256 | Per base sequence content | C | identical | 59 | 0 |  |
| a7_256 | Per base N content | Base | identical | 59 | 0 |  |
| a7_256 | Per base N content | N-Count | identical | 59 | 0 |  |
| a7_256 | Overrepresented sequences | Sequence | identical | 44 | 0 |  |
| a7_256 | Overrepresented sequences | Count | identical | 44 | 0 |  |
| a7_256 | Overrepresented sequences | Percentage | identical | 44 | 0 |  |
| a7_256 | Overrepresented sequences | Possible Source | identical | 44 | 0 |  |
| a7_256 | Adapter Content | Position | identical | 57 | 0 |  |
| a7_256 | Adapter Content | Illumina Universal Adapter | identical | 57 | 0 |  |
| a7_256 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 57 | 0 |  |
| a7_256 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 57 | 0 |  |
| a7_256 | Adapter Content | Nextera Transposase Sequence | identical | 57 | 0 |  |
| a7_256 | Adapter Content | PolyA | identical | 57 | 0 |  |
| a7_256 | Adapter Content | PolyG | identical | 57 | 0 |  |
| a7_256 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| a7_256 | Per sequence GC content | Count | identical | 101 | 0 |  |
| a7_256 | Sequence Length Distribution | Length | identical | 51 | 0 |  |
| a7_256 | Sequence Length Distribution | Count | identical | 51 | 0 |  |
| a7_256 | Basic Statistics | flag | identical | 1 | 0 |  |
| a7_256 | Per base sequence quality | flag | identical | 1 | 0 |  |
| a7_256 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| a7_256 | Per base sequence content | flag | identical | 1 | 0 |  |
| a7_256 | Per base N content | flag | identical | 1 | 0 |  |
| a7_256 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| a7_256 | Adapter Content | flag | identical | 1 | 0 |  |
| a7_256 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| eq150 | Basic Statistics | Encoding | identical | 1 | 0 |  |
| eq150 | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| eq150 | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| eq150 | Basic Statistics | %GC | identical | 1 | 0 |  |
| eq150 | Per base sequence quality | Base | identical | 38 | 0 |  |
| eq150 | Per base sequence quality | Mean | identical | 38 | 0 |  |
| eq150 | Per base sequence quality | Median | identical | 38 | 0 |  |
| eq150 | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| eq150 | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| eq150 | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| eq150 | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| eq150 | Per sequence quality scores | Quality | identical | 1 | 0 |  |
| eq150 | Per sequence quality scores | Count | identical | 1 | 0 |  |
| eq150 | Per base sequence content | Base | identical | 38 | 0 |  |
| eq150 | Per base sequence content | G | identical | 38 | 0 |  |
| eq150 | Per base sequence content | A | identical | 38 | 0 |  |
| eq150 | Per base sequence content | T | identical | 38 | 0 |  |
| eq150 | Per base sequence content | C | identical | 38 | 0 |  |
| eq150 | Per base N content | Base | identical | 38 | 0 |  |
| eq150 | Per base N content | N-Count | identical | 38 | 0 |  |
| eq150 | Overrepresented sequences | Sequence | identical | 1 | 0 |  |
| eq150 | Overrepresented sequences | Count | identical | 1 | 0 |  |
| eq150 | Overrepresented sequences | Percentage | identical | 1 | 0 |  |
| eq150 | Overrepresented sequences | Possible Source | identical | 1 | 0 |  |
| eq150 | Adapter Content | Position | identical | 74 | 0 |  |
| eq150 | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| eq150 | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| eq150 | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| eq150 | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| eq150 | Adapter Content | PolyA | identical | 74 | 0 |  |
| eq150 | Adapter Content | PolyG | identical | 74 | 0 |  |
| eq150 | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| eq150 | Per sequence GC content | Count | identical | 101 | 0 |  |
| eq150 | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| eq150 | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| eq150 | Basic Statistics | flag | identical | 1 | 0 |  |
| eq150 | Per base sequence quality | flag | identical | 1 | 0 |  |
| eq150 | Per sequence quality scores | flag | identical | 1 | 0 |  |
| eq150 | Per base sequence content | flag | identical | 1 | 0 |  |
| eq150 | Per base N content | flag | identical | 1 | 0 |  |
| eq150 | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| eq150 | Adapter Content | flag | identical | 1 | 0 |  |
| eq150 | Overrepresented sequences | flag | identical | 1 | 0 |  |
| mixed | Basic Statistics | Encoding | identical | 1 | 0 |  |
| mixed | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| mixed | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| mixed | Basic Statistics | %GC | identical | 1 | 0 |  |
| mixed | Per base sequence quality | Base | identical | 58 | 0 |  |
| mixed | Per base sequence quality | Mean | identical | 58 | 0 |  |
| mixed | Per base sequence quality | Median | identical | 58 | 0 |  |
| mixed | Per base sequence quality | Lower Quartile | identical | 58 | 0 |  |
| mixed | Per base sequence quality | Upper Quartile | identical | 58 | 0 |  |
| mixed | Per base sequence quality | 10th Percentile | identical | 58 | 0 |  |
| mixed | Per base sequence quality | 90th Percentile | identical | 58 | 0 |  |
| mixed | Per sequence quality scores | Quality | identical | 15 | 0 |  |
| mixed | Per sequence quality scores | Count | identical | 15 | 0 |  |
| mixed | Per base sequence content | Base | identical | 58 | 0 |  |
| mixed | Per base sequence content | G | identical | 58 | 0 |  |
| mixed | Per base sequence content | A | identical | 58 | 0 |  |
| mixed | Per base sequence content | T | identical | 58 | 0 |  |
| mixed | Per base sequence content | C | identical | 58 | 0 |  |
| mixed | Per base N content | Base | identical | 58 | 0 |  |
| mixed | Per base N content | N-Count | identical | 58 | 0 |  |
| mixed | Overrepresented sequences | Sequence | identical | 0 | 0 |  |
| mixed | Overrepresented sequences | Count | identical | 0 | 0 |  |
| mixed | Overrepresented sequences | Percentage | identical | 0 | 0 |  |
| mixed | Overrepresented sequences | Possible Source | identical | 0 | 0 |  |
| mixed | Adapter Content | Position | identical | 55 | 0 |  |
| mixed | Adapter Content | Illumina Universal Adapter | identical | 55 | 0 |  |
| mixed | Adapter Content | Illumina Small RNA 3' Adapter | identical | 55 | 0 |  |
| mixed | Adapter Content | Illumina Small RNA 5' Adapter | identical | 55 | 0 |  |
| mixed | Adapter Content | Nextera Transposase Sequence | identical | 55 | 0 |  |
| mixed | Adapter Content | PolyA | identical | 55 | 0 |  |
| mixed | Adapter Content | PolyG | identical | 55 | 0 |  |
| mixed | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| mixed | Per sequence GC content | Count | identical | 101 | 0 |  |
| mixed | Sequence Length Distribution | Length | identical | 45 | 0 |  |
| mixed | Sequence Length Distribution | Count | identical | 45 | 0 |  |
| mixed | Basic Statistics | flag | identical | 1 | 0 |  |
| mixed | Per base sequence quality | flag | identical | 1 | 0 |  |
| mixed | Per sequence quality scores | flag | identical | 1 | 0 |  |
| mixed | Per base sequence content | flag | identical | 1 | 0 |  |
| mixed | Per base N content | flag | identical | 1 | 0 |  |
| mixed | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| mixed | Adapter Content | flag | identical | 1 | 0 |  |
| mixed | Overrepresented sequences | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Basic Statistics | Encoding | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Basic Statistics | %GC | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence quality | Base | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence quality | Mean | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence quality | Median | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per sequence quality scores | Quality | identical | 8 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per sequence quality scores | Count | identical | 8 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence content | Base | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence content | G | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence content | A | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence content | T | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence content | C | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base N content | Base | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base N content | N-Count | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Overrepresented sequences | Sequence | identical | 0 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Overrepresented sequences | Count | identical | 0 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Overrepresented sequences | Percentage | identical | 0 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Overrepresented sequences | Possible Source | identical | 0 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Adapter Content | Position | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Adapter Content | PolyA | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Adapter Content | PolyG | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per sequence GC content | Count | identical | 101 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Basic Statistics | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence quality | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per sequence quality scores | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base sequence content | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Per base N content | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Adapter Content | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq.gz | Overrepresented sequences | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Basic Statistics | Encoding | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Basic Statistics | %GC | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence quality | Base | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence quality | Mean | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence quality | Median | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence quality | Lower Quartile | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence quality | Upper Quartile | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence quality | 10th Percentile | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence quality | 90th Percentile | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per sequence quality scores | Quality | identical | 8 | 0 |  |
| illumina_like_1M_150bp.fastq | Per sequence quality scores | Count | identical | 8 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence content | Base | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence content | G | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence content | A | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence content | T | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence content | C | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base N content | Base | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base N content | N-Count | identical | 38 | 0 |  |
| illumina_like_1M_150bp.fastq | Overrepresented sequences | Sequence | identical | 0 | 0 |  |
| illumina_like_1M_150bp.fastq | Overrepresented sequences | Count | identical | 0 | 0 |  |
| illumina_like_1M_150bp.fastq | Overrepresented sequences | Percentage | identical | 0 | 0 |  |
| illumina_like_1M_150bp.fastq | Overrepresented sequences | Possible Source | identical | 0 | 0 |  |
| illumina_like_1M_150bp.fastq | Adapter Content | Position | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq | Adapter Content | Illumina Universal Adapter | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq | Adapter Content | Illumina Small RNA 3' Adapter | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq | Adapter Content | Illumina Small RNA 5' Adapter | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq | Adapter Content | Nextera Transposase Sequence | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq | Adapter Content | PolyA | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq | Adapter Content | PolyG | identical | 74 | 0 |  |
| illumina_like_1M_150bp.fastq | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| illumina_like_1M_150bp.fastq | Per sequence GC content | Count | identical | 101 | 0 |  |
| illumina_like_1M_150bp.fastq | Sequence Length Distribution | Length | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Sequence Length Distribution | Count | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Basic Statistics | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence quality | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Per sequence quality scores | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base sequence content | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Per base N content | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Adapter Content | flag | identical | 1 | 0 |  |
| illumina_like_1M_150bp.fastq | Overrepresented sequences | flag | identical | 1 | 0 |  |
| real_ont_20k | Basic Statistics | Encoding | identical | 1 | 0 |  |
| real_ont_20k | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| real_ont_20k | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| real_ont_20k | Basic Statistics | %GC | identical | 1 | 0 |  |
| real_ont_20k | Per base sequence quality | Base | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence quality | Mean | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence quality | Median | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence quality | Lower Quartile | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence quality | Upper Quartile | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence quality | 10th Percentile | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence quality | 90th Percentile | identical | 56 | 0 |  |
| real_ont_20k | Per sequence quality scores | Quality | identical | 33 | 0 |  |
| real_ont_20k | Per sequence quality scores | Count | identical | 33 | 0 |  |
| real_ont_20k | Per base sequence content | Base | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence content | G | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence content | A | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence content | T | identical | 56 | 0 |  |
| real_ont_20k | Per base sequence content | C | identical | 56 | 0 |  |
| real_ont_20k | Per base N content | Base | identical | 56 | 0 |  |
| real_ont_20k | Per base N content | N-Count | identical | 56 | 0 |  |
| real_ont_20k | Overrepresented sequences | Sequence | identical | 53 | 0 |  |
| real_ont_20k | Overrepresented sequences | Count | identical | 53 | 0 |  |
| real_ont_20k | Overrepresented sequences | Percentage | identical | 53 | 0 |  |
| real_ont_20k | Overrepresented sequences | Possible Source | identical | 53 | 0 |  |
| real_ont_20k | Adapter Content | Position | identical | 56 | 0 |  |
| real_ont_20k | Adapter Content | Illumina Universal Adapter | identical | 56 | 0 |  |
| real_ont_20k | Adapter Content | Illumina Small RNA 3' Adapter | identical | 56 | 0 |  |
| real_ont_20k | Adapter Content | Illumina Small RNA 5' Adapter | identical | 56 | 0 |  |
| real_ont_20k | Adapter Content | Nextera Transposase Sequence | identical | 56 | 0 |  |
| real_ont_20k | Adapter Content | PolyA | identical | 56 | 0 |  |
| real_ont_20k | Adapter Content | PolyG | identical | 56 | 0 |  |
| real_ont_20k | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| real_ont_20k | Per sequence GC content | Count | identical | 101 | 0 |  |
| real_ont_20k | Sequence Length Distribution | Length | identical | 46 | 0 |  |
| real_ont_20k | Sequence Length Distribution | Count | identical | 46 | 0 |  |
| real_ont_20k | Basic Statistics | flag | identical | 1 | 0 |  |
| real_ont_20k | Per base sequence quality | flag | identical | 1 | 0 |  |
| real_ont_20k | Per sequence quality scores | flag | identical | 1 | 0 |  |
| real_ont_20k | Per base sequence content | flag | identical | 1 | 0 |  |
| real_ont_20k | Per base N content | flag | identical | 1 | 0 |  |
| real_ont_20k | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| real_ont_20k | Adapter Content | flag | identical | 1 | 0 |  |
| real_ont_20k | Overrepresented sequences | flag | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Basic Statistics | Encoding | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Basic Statistics | Total Sequences | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Basic Statistics | Sequence length | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Basic Statistics | %GC | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence quality | Base | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence quality | Mean | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence quality | Median | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence quality | Lower Quartile | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence quality | Upper Quartile | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence quality | 10th Percentile | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence quality | 90th Percentile | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per sequence quality scores | Quality | identical | 4 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per sequence quality scores | Count | identical | 4 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence content | Base | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence content | G | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence content | A | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence content | T | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence content | C | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base N content | Base | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base N content | N-Count | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Overrepresented sequences | Sequence | identical | 0 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Overrepresented sequences | Count | identical | 0 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Overrepresented sequences | Percentage | identical | 0 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Overrepresented sequences | Possible Source | identical | 0 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Adapter Content | Position | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Adapter Content | Illumina Universal Adapter | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Adapter Content | Illumina Small RNA 3' Adapter | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Adapter Content | Illumina Small RNA 5' Adapter | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Adapter Content | Nextera Transposase Sequence | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Adapter Content | PolyA | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Adapter Content | PolyG | identical | 64 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per sequence GC content | GC Content | identical | 101 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per sequence GC content | Count | identical | 101 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Sequence Length Distribution | Length | identical | 22 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Sequence Length Distribution | Count | identical | 22 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Basic Statistics | flag | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence quality | flag | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per sequence quality scores | flag | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base sequence content | flag | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Per base N content | flag | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Sequence Length Distribution | flag | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Adapter Content | flag | identical | 1 | 0 |  |
| ont_like_50k_lognormal.fastq.gz | Overrepresented sequences | flag | identical | 1 | 0 |  |

Total differing values: 0

## Text comparison

| maxlen13009 | 621 lines | identical |
| maxlen13010 | 504 lines | identical |
| maxlen1309 | 622 lines | identical |
| maxlen1310 | 504 lines | identical |
| maxlen139 | 623 lines | identical |
| maxlen140 | 507 lines | identical |
| maxlen32509 | 621 lines | identical |
| maxlen32510 | 522 lines | identical |
| maxlen3259 | 621 lines | identical |
| maxlen3260 | 521 lines | identical |
| maxlen334 | 619 lines | identical |
| maxlen335 | 524 lines | identical |
| maxlen65009 | 621 lines | identical |
| maxlen65010 | 522 lines | identical |
| maxlen6509 | 621 lines | identical |
| maxlen6510 | 522 lines | identical |
| maxlen659 | 619 lines | identical |
| maxlen660 | 526 lines | identical |
| maxlen75 | 622 lines | identical |
| maxlen76 | 529 lines | identical |
| fqc_b2_content | 147 lines | identical |
| fqc_b2_group | 382 lines | identical |
| fqc_b2_groupn | 380 lines | identical |
| fqc_b2_seqq | 192 lines | identical |
| fqc_b3_enc_59 | 150 lines | identical |
| fqc_b3_enc_63 | 150 lines | identical |
| fqc_b3_enc_64 | 150 lines | identical |
| fqc_b3_enc_65 | 150 lines | identical |
| fqc_b3_enc_66 | 150 lines | identical |
| fqc_b3_enc_74 | 150 lines | identical |
| fqc_b3_len_long | 430 lines | identical |
| fqc_b3_len_mid | 453 lines | identical |
| fqc_b3_len_small | 447 lines | identical |
| fqc_b3_len_two | 352 lines | identical |
| fqc_b3_nan | 383 lines | identical |
| fqc_b3_u | 148 lines | identical |
| fqc_b7_mode19 | 169 lines | identical |
| fqc_b7_mode20 | 170 lines | identical |
| fqc_b7_mode21 | 171 lines | identical |
| fqc_b7_mode26 | 176 lines | identical |
| fqc_b7_mode27 | 177 lines | identical |
| fqc_b7_mode28 | 178 lines | identical |
| fqc_b8_ct10_100 | 144 lines | identical |
| fqc_b8_ct10_200 | 144 lines | identical |
| fqc_b8_ct10_40 | 144 lines | identical |
| fqc_b8_ct20_100 | 144 lines | identical |
| fqc_b8_ct20_200 | 144 lines | identical |
| fqc_b8_lq10 | 154 lines | identical |
| fqc_b8_lq11 | 154 lines | identical |
| fqc_b8_lq5 | 157 lines | identical |
| fqc_b8_lq6 | 156 lines | identical |
| fqc_b8_med20 | 154 lines | identical |
| fqc_b8_med21 | 154 lines | identical |
| fqc_b8_med25 | 152 lines | identical |
| fqc_b8_med26 | 151 lines | identical |
| fqc_b8_n20_100 | 142 lines | identical |
| fqc_b8_n20_200 | 142 lines | identical |
| fqc_b8_n21_100 | 142 lines | identical |
| fqc_b8_n5_100 | 142 lines | identical |
| fqc_b8_n5_200 | 142 lines | identical |
| fqc_b8_n6_100 | 142 lines | identical |
| fqc_b9_tie15_30 | 180 lines | identical |
| fqc_b9_tie25_35 | 185 lines | identical |
| fqc_b9_tie30_15 | 180 lines | identical |
| gc2_allN | 168 lines | identical |
| gc2_end150 | 327 lines | identical |
| gc2_first100_30 | 378 lines | identical |
| gc2_iupac10 | 168 lines | identical |
| gc2_len200_gc100 | 328 lines | identical |
| gc2_len250 | 368 lines | identical |
| gc2_len99_c33 | 350 lines | identical |
| gc2_lower10 | 168 lines | identical |
| gc2_mid | 327 lines | identical |
| gc2_n10 | 168 lines | identical |
| gc2_n_first | 327 lines | identical |
| gc2_start150 | 327 lines | identical |
| gc2_u10 | 168 lines | identical |
| gc4_p_2800_2800 | 403 lines | identical |
| gc4_p_2800_2850 | 432 lines | identical |
| gc4_p_2850_2800 | 432 lines | identical |
| gc4_s2800 | 402 lines | identical |
| gc4_s2800b | 402 lines | identical |
| gc4_s2850 | 406 lines | identical |
| gc5_L1000 | 378 lines | identical |
| gc5_L100500 | 379 lines | identical |
| gc5_L19999 | 335 lines | identical |
| gc5_L2999 | 415 lines | identical |
| gc5_L3000 | 418 lines | identical |
| gc5_L999 | 375 lines | identical |
| gc5_L9999 | 375 lines | identical |
| gc6_L100 | 353 lines | identical |
| gc6_L1000 | 378 lines | identical |
| gc6_L123456 | 423 lines | identical |
| gc6_L1999 | 335 lines | identical |
| gc6_L54321 | 395 lines | identical |
| gc6_L9876 | 375 lines | identical |
| ad1_a1 | 567 lines | identical |
| ad1_a2 | 597 lines | identical |
| ad1_a3 | 567 lines | identical |
| ad1_a4 | 567 lines | identical |
| ad1_a5 | 526 lines | identical |
| ad1_a6 | 567 lines | identical |
| ad1_a7 | 567 lines | identical |
| ad1_a8 | 567 lines | identical |
| ad2_b1 | 526 lines | identical |
| ad2_b2 | 577 lines | identical |
| ad2_b3 | 667 lines | identical |
| ad2_b4f | 567 lines | identical |
| ad2_b4f2 | 567 lines | identical |
| ad2_b4w | 567 lines | identical |
| ad2_b4w2 | 567 lines | identical |
| ad2_b5 | 590 lines | identical |
| ad2_b6 | 437 lines | identical |
| ad2_b7 | 171 lines | identical |
| ad3_len12 | 356 lines | identical |
| ad3_len13_end | 355 lines | identical |
| ad3_len13_start | 355 lines | identical |
| ad4_after_12 | 356 lines | identical |
| ad4_after_13 | 356 lines | identical |
| ad4_after_long | 356 lines | identical |
| ad4_mixed_order | 356 lines | identical |
| ov1_o1_L100 | 353 lines | identical |
| ov1_o1_L60 | 368 lines | identical |
| ov1_o1_L75 | 428 lines | identical |
| ov1_o1_L76 | 333 lines | identical |
| ov1_o4_1 | 366 lines | identical |
| ov1_o4_2 | 368 lines | identical |
| ov1_o5 | 290 lines | identical |
| ov1_o7 | 368 lines | identical |
| ov1_o8 | 368 lines | identical |
| ov1_o9_10 | 368 lines | identical |
| ov1_o9_11 | 368 lines | identical |
| ov2_t0 | 292 lines | identical |
| ov2_t1 | 292 lines | identical |
| ov2_t2 | 292 lines | identical |
| ov2_t3 | 292 lines | identical |
| ov2_t4 | 292 lines | identical |
| ov2_t5 | 292 lines | identical |
| ov3_L1 | 366 lines | identical |
| ov3_L2 | 369 lines | identical |
| ov4_B100000 | 366 lines | identical |
| ov4_B99999 | 368 lines | identical |
| ov5_c | 360 lines | identical |
| ov6_d | 334 lines | identical |
| ov7_e | 341 lines | identical |
| ov8_s | 383 lines | identical |
| ov9_v | 281 lines | identical |
| p_0_48 | 369 lines | identical |
| p_0_49 | 374 lines | identical |
| p_0_50 | 354 lines | identical |
| p_0_51 | 358 lines | identical |
| p_1000_1040 | 426 lines | identical |
| p_1000_1048 | 434 lines | identical |
| p_1000_1049 | 410 lines | identical |
| p_1000_1050 | 411 lines | identical |
| p_1000_1051 | 412 lines | identical |
| p_1000_1060 | 420 lines | identical |
| p_1_44 | 348 lines | identical |
| p_1_45 | 353 lines | identical |
| p_1_46 | 358 lines | identical |
| p_1_47 | 363 lines | identical |
| p_1_48 | 368 lines | identical |
| p_1_49 | 373 lines | identical |
| p_1_50 | 354 lines | identical |
| p_1_51 | 358 lines | identical |
| p_1_52 | 363 lines | identical |
| p_1_53 | 367 lines | identical |
| p_1_54 | 372 lines | identical |
| p_1_55 | 376 lines | identical |
| p_200_240 | 400 lines | identical |
| p_200_241 | 402 lines | identical |
| p_200_242 | 403 lines | identical |
| p_200_243 | 404 lines | identical |
| p_200_244 | 405 lines | identical |
| p_200_245 | 409 lines | identical |
| p_200_246 | 411 lines | identical |
| p_200_247 | 412 lines | identical |
| p_200_248 | 413 lines | identical |
| p_200_249 | 389 lines | identical |
| p_200_250 | 393 lines | identical |
| p_200_251 | 394 lines | identical |
| p_200_252 | 395 lines | identical |
| p_200_253 | 395 lines | identical |
| p_200_254 | 396 lines | identical |
| p_200_255 | 399 lines | identical |
| a0_49 | 422 lines | identical |
| a1000_3449 | 363 lines | identical |
| a1000_3500 | 368 lines | identical |
| a100_149 | 348 lines | identical |
| a1_50 | 402 lines | identical |
| a1_51 | 406 lines | identical |
| a7_251 | 461 lines | identical |
| a7_256 | 466 lines | identical |
| eq150 | 327 lines | identical |
| mixed | 424 lines | identical |
| illumina_like_1M_150bp.fastq.gz | 332 lines | identical |
| illumina_like_1M_150bp.fastq | 332 lines | identical |
| real_ont_20k | 492 lines | identical |
| ont_like_50k_lognormal.fastq.gz | 417 lines | identical |
inputs with differences: 0
