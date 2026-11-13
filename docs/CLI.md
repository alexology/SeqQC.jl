# Command line

```
seqqc analyze [options] FILE...      analyse FASTQ / FASTQ.gz files
seqqc report [options] DIR|JSON...   multi-sample report from saved SeqQC JSON reports
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
inputs. Sample names follow `docs/MULTISAMPLE.md` (`/` of a directory prefix
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

## Exit codes

0 success · 1 at least one input failed · 2 usage error (unknown option,
missing value, invalid number).
