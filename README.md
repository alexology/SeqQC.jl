# SeqQC.jl

Streaming quality control for sequencing reads, written in Julia.

> **Experimental.** SeqQC.jl is part of an experiment in AI-assisted
> development of a single Julia environment for sequence analysis. High
> performance is a design goal, not a measured guarantee: see
> `bench/results/` for what has actually been measured.

Status: **0.1.0-DEV, Phase 1** (see `docs/ROADMAP.md`). Implemented today:

- FASTQ and gzip-compressed FASTQ (compression detected from content;
  multi-member gzip; LF and CRLF), read with FASTX.jl;
- one streaming pass with bounded memory and mergeable metric accumulators;
- exact read-length statistics (min, max, mean, median, **read** N50/N90,
  histogram, cumulative yield), base composition and GC content, base- and
  read-level quality under two explicitly named conventions (Phred-space mean
  and error-probability mean), quality versus length;
- input validation with record numbers; custom metrics without engine changes.

Not implemented yet: platform profiles (Illumina/FastQC-like modules,
Nanopore, PacBio HiFi/CLR), BAM/CRAM, multithreading, JSON/HTML/MultiQC
reports, CLI. `analyze(...; platform = :nanopore)` raises an error rather than
pretending.

## Installation

The package is not registered. From a local checkout:

```julia
using Pkg
Pkg.develop(path = "path/to/SeqQC.jl")
```

Requires Julia 1.10 or later (developed and tested on 1.12.2).

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

# a subset of metrics
analyze("sample.fastq"; metrics = [ReadLength(), BaseComposition()])

# head sampling: first 100,000 records only (recorded in result.settings and warnings)
analyze("big.fastq.gz"; max_reads = 100_000)
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

## Documentation

- `docs/ARCHITECTURE.md` — design, layers, survey of existing tools and libraries
- `docs/METRICS.md` — exact definitions and limitations of every metric
- `docs/ROADMAP.md` — phases and status
- `docs/BENCHMARKS.md` — benchmark methodology; results in `bench/results/`
- `docs/DEVELOPMENT.md` — development log

## Tests

```
julia --project=. -e "using Pkg; Pkg.test()"
```

## Licence

Not yet defined.
