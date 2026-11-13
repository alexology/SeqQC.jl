"""
    SeqQC

Streaming quality control for sequencing reads (Illumina, Oxford Nanopore,
PacBio). The analysis engine makes a single pass over the input, feeds every
read to a set of independent, mergeable metric accumulators and returns a
structured [`QCResult`](@ref).

Current scope (0.1.0): FASTQ and gzip-compressed FASTQ input, generic
(platform-independent) metrics. See `docs/ROADMAP.md` for planned features.

```julia
using SeqQC
result = analyze("sample.fastq.gz")
result.total_reads, result.total_bases, result.gc_content, result.n50
```
"""
module SeqQC

using FASTX: FASTQ, sequence, quality
using StringViews: StringView
using CodecZlibNG: GzipDecompressorStream, GzipCompressorStream
using TranscodingStreams: NoopStream
using PrecompileTools: @setup_workload, @compile_workload

export analyze, default_metrics,
    AbstractQCMetric, ReadView, ReadSummary, QCResult, InputInfo, SeqQCInputError,
    ReadLength, BaseComposition, QualityDistribution, QualityVsLength, PerPositionStats,
    init_state, update!, finalize_metric, metric_name, requirements,
    memory_complexity, definition, yield_by_length, to_json, write_json, report,
    aggregate, SampleSet, write_table, read_json, sample_name, write_fastqc_data, write_fastqc_summary

const VERSION_STRING = "0.1.0"

include("core/read.jl")
include("core/metric.jl")
include("io/pipe.jl")
include("io/input.jl")
include("metrics/readlength.jl")
include("metrics/composition.jl")
include("metrics/quality.jl")
include("metrics/quality_length.jl")
include("metrics/positional.jl")
include("core/result.jl")
include("core/engine.jl")
include("compat/fastqc.jl")
include("reports/json.jl")
include("reports/jsonread.jl")
include("reports/aggregate.jl")
include("reports/html.jl")
include("reports/html_single.jl")
include("reports/fastqc_text.jl")
include("cli.jl")
include("precompile.jl")

end # module
