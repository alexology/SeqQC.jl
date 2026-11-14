# Command line

```
seqqc analyze [options] FILE...      analyse FASTQ / FASTQ.gz files
seqqc report [options] DIR|JSON...   multi-sample report from saved SeqQC JSON reports
seqqc truncation [options] R1 [R2]   suggest DADA2 truncLen / maxEE
seqqc --help | --version
```

## Running it

The package ships `bin/seqqc.jl` and two launchers:

```
bin/seqqc analyze reads/*.fastq.gz -o qc/          # Unix (sh)
bin\seqqc.cmd analyze reads\*.fastq.gz -o qc\      # Windows (cmd)
julia --project=<SeqQC.jl> -t auto bin/seqqc.jl analyze ...   # directly
```

The launchers start Julia with the package's project and `-t auto`
(`SEQQC_THREADS` overrides it). Start-up plus a small file takes under a
second thanks to the precompilation workload.

## `analyze`

| Option | Meaning |
|---|---|
| `-o, --output DIR` | output directory, created if missing (default `.`) |
| `-t, --threads N` | threads used by `analyze` (gzip decompression task with N ≥ 2); Julia must be started with at least N threads |
| `--phred-offset N` | 33 (default) or 64 |
| `--max-reads N` | first N records of each file only (head sampling; reported as a warning) |
| `--fastqc` | also compute the FastQC-compatible modules and write `<sample>_fastqc_data.txt` and `<sample>_summary.txt` |
| `--contaminants FILE` | contaminant list for "Possible Source" (with `--fastqc`), e.g. `<FastQC>/Configuration/contaminant_list.txt` |
| `--fastqc-header` | first line of `fastqc_data.txt` = `##FastQC<TAB>0.12.1` (default identifies SeqQC) |
| `--max-positions N` | limit of per-position statistics (default 100,000) |
| `--html` | single-sample HTML report per input |
| `--no-report` | skip the multi-sample report |
| `-q, --quiet` / `-v, --verbose` | only errors / one line per input with timing |

Outputs per input: `<sample>.seqqc.json` (always), FastQC text files with
`--fastqc`, `<sample>.html` with `--html`. Then `seqqc_report.html`,
`seqqc_report.tsv` and `seqqc_report.json` for all successfully analysed
inputs. Sample names follow `docs/src/MULTISAMPLE.md` (`/` of a directory prefix
becomes `_` in file names). Output names that still collide (`a/x.fastq` and
`a_x.fastq` both give `a_x`) get `_2`, `_3`, … in input order, with a note on
stderr: no report is ever overwritten by another input of the same run.

Errors: an unreadable or malformed input is reported on stderr and skipped;
the other inputs are still analysed and the exit code is 1. Warnings of the
analysis (e.g. head sampling) are printed on stderr. If FastQC text files
cannot be written for an input (reads longer than `--max-positions`), the
JSON is still written and the input counts as failed.

## `report`

`seqqc report [-o FILE.html] DIR|JSON...` aggregates saved `*.seqqc.json`
reports (any SeqQC result JSON) and writes the HTML page plus `.tsv` and
`.json` with the same base name (default `seqqc_report.html`).

## `truncation`

`seqqc truncation [options] R1 [R2]` computes the truncation profile of one
FASTQ file or a pair and prints the suggestion, its alternatives and the
DADA2 / vsearch commands ([Truncation for DADA2](TRUNCATION.md)).

| Option | Meaning |
|---|---|
| `--amplicon-length N` | sequenced fragment length, from the first base of R1 to the first base of R2 (required for pairs) |
| `--min-overlap N` | overlap required between R1 and R2 (default 20) |
| `--max-ee X` | maxEE of the suggestion (default 2); 0.5, 1, 2, 3, 5 and Inf are always profiled |
| `--trim-left N[,M]` | trimLeft, one value or one per file (default 0) |
| `--trunc-q N`, `--max-n N`, `--min-len N` | DADA2 filter settings (defaults 2, 0, 20) |
| `--min-trunc-len N` | do not suggest a truncation shorter than N |
| `--phred-offset N` | 33 (default) or 64 |
| `--max-reads N` | first N reads or pairs only |
| `-o, --output FILE` | also write `.json`, `.tsv` or `.html` (charts); repeatable |
| `-q, --quiet` | do not print the suggestion |

## Exit codes

0 success · 1 at least one input failed · 2 usage error (unknown option,
missing value, invalid number).
