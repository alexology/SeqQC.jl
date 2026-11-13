# SeqQC.jl

Streaming quality control for sequencing reads, written in Julia: exact read
statistics in one pass with bounded memory, FastQC-compatible modules,
JSON/HTML reports, multi-sample summaries and a command line.

This package is part of an experimental effort to use AI to port
bioinformatics and quantitative ecology packages to Julia, with the goal of
creating a unified environment for high performance scientific computing.
High performance is a design goal, not a measured guarantee: see
[Benchmarks](BENCHMARKS.md) for what has actually been measured.

Status: **0.1.0** (see [Roadmap](ROADMAP.md)). Implemented today:

- FASTQ and gzip-compressed FASTQ (compression detected from content;
  multi-member gzip; LF and CRLF), read with FASTX.jl;
- one streaming pass with bounded memory and mergeable metric accumulators;
- exact read-length statistics (min, max, mean, median, **read** N50/N90,
  histogram, cumulative yield), base composition and GC content, base- and
  read-level quality under three explicitly named conventions (Phred-space
  mean, error-probability mean, and NanoPlot's mean of per-read error
  probabilities), quality versus length;
- exact per-position statistics (`PerPositionStats`, bounded memory);
- `SeqQC.FastQC`: nine FastQC modules (Basic Statistics, per-base quality,
  per-sequence quality, per-base content, per-sequence GC counts, per-base N,
  length distribution, overrepresented sequences, adapter content), their
  flags (except per-sequence GC) and `fastqc_data.txt`/`summary.txt`,
  identical to FastQC 0.12.1 on the validation inputs (rules determined by
  black-box experiments, see [FastQC compatibility](FASTQC.md));
- command line `seqqc analyze` / `seqqc report` ([Command line](CLI.md)) and
  single-sample HTML reports;
- JSON report with a versioned schema (`report(result, "sample.json")`,
  [JSON reports](JSON.md));
- multi-sample summary (`aggregate`, similar in purpose to MultiQC but for
  SeqQC results only): table, TSV, JSON and a self-contained interactive HTML
  page with distribution charts ([Multi-sample reports](MULTISAMPLE.md));
- input validation with record numbers; custom metrics without engine changes.

Not implemented: platform profiles and metadata (Nanopore, PacBio HiFi/CLR),
BAM/CRAM input, multithreaded analysis (only gzip decompression can run in a
separate task), and FastQC's duplication, k-mer and per-tile modules and its
per-sequence GC flag.
`analyze(...; platform = :nanopore)` raises an error rather than pretending.

## Command line

```
bin/seqqc analyze --fastqc --html -o qc/ reads/*.fastq.gz     # Windows: bin\seqqc.cmd
bin/seqqc report -o qc/all.html qc/
```

## Installation

The package is not registered. Install it from GitHub:

```julia
using Pkg
Pkg.add(url = "https://github.com/alexology/SeqQC.jl")
```

or, from a local clone, `Pkg.develop(path = "path/to/SeqQC.jl")`. Julia ≥ 1.10
(developed and tested on 1.12 and 1.13).

## Usage

```julia
using SeqQC

result = analyze("sample.fastq.gz")
result.total_reads, result.total_bases
result.gc_content            # (G+C)/(A+C+G+T)
result.n50, result.n90       # read N50/N90, not assembly N50
result.mean_read_quality     # mean of per-read -10log10(mean error probability)
result.mean_read_quality_phred
result.metrics.quality.reads_at_least.Q20
yield_by_length(result)      # cumulative yield by minimum read length
report(result, "sample.json") # versioned JSON document

# a subset of metrics
analyze("sample.fastq"; metrics = [ReadLength(), BaseComposition()])

# head sampling: first 100,000 records only (recorded in result.settings and warnings)
analyze("big.fastq.gz"; max_reads = 100_000)

# with julia --threads=2 or more: gzip is inflated in a separate task (same results)
analyze("big.fastq.gz"; threads = 2)
```

### Custom metrics

```julia
struct CountLongReads <: AbstractQCMetric
    min_length::Int
end
mutable struct CountLongReadsState
    min_length::Int
    n::Int
end
SeqQC.init_state(m::CountLongReads) = CountLongReadsState(m.min_length, 0)
SeqQC.update!(s::CountLongReadsState, read::ReadView) = (s.n += read.summary.length >= s.min_length; s)
Base.merge!(a::CountLongReadsState, b::CountLongReadsState) = (a.n += b.n; a)
SeqQC.finalize_metric(s::CountLongReadsState) = (long_reads = s.n,)
SeqQC.metric_name(::CountLongReads) = :long_reads

analyze("reads.fastq.gz"; metrics = [ReadLength(), CountLongReads(10_000)]).long_reads
```

### Several samples

```julia
rs = analyze(["s1.fastq.gz", "s2.fastq.gz", "s3.fastq.gz"])
s = aggregate(rs)                   # or aggregate("dir_with_seqqc_json_reports")
report(s, "summary.html")           # also .tsv and .json
```

### FastQC-compatible modules

```julia
r = analyze("reads.fastq.gz"; metrics = SeqQC.FastQC.metrics())
SeqQC.FastQC.per_base_quality(r)   # same groups, values and labels as FastQC 0.12.1
SeqQC.FastQC.flags(r)              # pass / warn / fail
```

## Where to read next

- [Metrics](METRICS.md): exact definitions and limitations of every metric.
- [Multi-sample reports](MULTISAMPLE.md), [Command line](CLI.md),
  [JSON reports](JSON.md).
- [FastQC compatibility](FASTQC.md): the rules of FastQC 0.12.1 reproduced by
  `SeqQC.FastQC`, how they were determined and validated.
- [Architecture](ARCHITECTURE.md), [Benchmarks](BENCHMARKS.md),
  [Roadmap](ROADMAP.md), [Development log](DEVELOPMENT.md).
- [API](api.md): every exported function and type.

## Licence

GPL-3.0-or-later, the licence of FastQC. Copyright (C) 2026 Alex Laini.
