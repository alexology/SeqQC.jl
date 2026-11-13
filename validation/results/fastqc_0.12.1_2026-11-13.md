# SeqQC.FastQC vs FastQC 0.12.1 — validation of 2026-11-13

Command: `julia --project=. validation/fastqc_compare.jl <FastQC dir> <work dir> --max-positions=200000 label=path ...`
(FastQC 0.12.1, OpenJDK 21.0.3, Windows 11; SeqQC 0.1.0-DEV, Julia 1.12.2).

Same inputs as `fastqc_0.12.1_2026-11-12.md` plus the per-sequence GC experiments (`gc2_*`, `gc4_*`,
`gc5_*`, `gc6_*`: N/U/IUPAC/lower case, truncation points, pairs of long reads, single reads of
999–123,456 bp): 148 inputs, all synthetic except `real_ont_20k` (first 20,000 reads of the real
ONT amplicon file, not stored). Modules compared: Basic Statistics (Encoding, Total Sequences,
Sequence length, %GC), Per base sequence quality, Per sequence quality scores, Per base sequence
content, **Per sequence GC content** (counts), Per base N content, Sequence Length Distribution, and
the flags of all but Per sequence GC content.

Result: **every compared column and flag identical** — 4,440 comparisons covering 122,072 values;
0 differing values; no value needed the 1e-9 tolerance.

## Full table

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

Total differing values: 0
