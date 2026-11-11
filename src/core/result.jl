# Structured analysis results. Independent of any report format.

"""
    QCResult

Result of [`analyze`](@ref). Fields:

- `input::InputInfo`: path, size, compression, format;
- `platform::Symbol`: analysis profile (`:generic`);
- `settings::NamedTuple`: Phred offset, sampling, metric names and definitions;
- `total_reads`, `total_bases`: reads and bases processed by the engine;
- `metrics::NamedTuple`: one finalized result per metric, keyed by [`metric_name`](@ref);
- `warnings::Vector{String}`;
- `software::NamedTuple`: SeqQC and Julia versions;
- `elapsed_seconds::Float64`: wall-clock time of the pass (not part of the scientific result).

Fields of the metric results can be read directly when the name is unique
across metrics, e.g. `result.gc_content` or `result.n50`
(equivalent to `result.metrics.base_composition.gc_content` and
`result.metrics.read_length.n50`).
"""
struct QCResult
    input::InputInfo
    platform::Symbol
    settings::NamedTuple
    total_reads::Int
    total_bases::Int
    metrics::NamedTuple
    warnings::Vector{String}
    software::NamedTuple
    elapsed_seconds::Float64
end

function Base.getproperty(r::QCResult, name::Symbol)
    hasfield(QCResult, name) && return getfield(r, name)
    metrics = getfield(r, :metrics)
    owners = [k for k in keys(metrics) if metrics[k] isa NamedTuple && haskey(metrics[k], name)]
    isempty(owners) && throw(ArgumentError("QCResult has no field or metric value $(repr(name))"))
    length(owners) > 1 && throw(ArgumentError("$(repr(name)) is ambiguous (metrics $(join(owners, ", "))); " *
                                              "use result.metrics.<metric>.$(name)"))
    return metrics[only(owners)][name]
end

function Base.propertynames(r::QCResult, private::Bool = false)
    metrics = getfield(r, :metrics)
    names = Symbol[fieldnames(QCResult)...]
    counts = Dict{Symbol,Int}()
    for k in keys(metrics)
        metrics[k] isa NamedTuple || continue
        for n in keys(metrics[k])
            counts[n] = get(counts, n, 0) + 1
        end
    end
    append!(names, sort!([n for (n, c) in counts if c == 1 && !(n in names)]))
    return Tuple(names)
end

_fmt(x::Nothing) = "NA"
_fmt(x::Integer) = string(x)
_fmt(x::AbstractFloat) = string(round(x; digits = 4))
_fmt(x) = string(x)

function Base.show(io::IO, ::MIME"text/plain", r::QCResult)
    println(io, "QCResult: ", r.input.path, " (", r.input.format, ", ", r.input.compression, ")")
    println(io, "  platform: ", r.platform, "; reads: ", r.total_reads, "; bases: ", r.total_bases)
    m = r.metrics
    if haskey(m, :read_length)
        x = m.read_length
        println(io, "  length: min ", _fmt(x.min_length), ", max ", _fmt(x.max_length), ", mean ",
                _fmt(x.mean_length), ", median ", _fmt(x.median_length), ", N50 ", _fmt(x.n50),
                ", N90 ", _fmt(x.n90))
    end
    haskey(m, :base_composition) &&
        println(io, "  GC: ", _fmt(m.base_composition.gc_content), "; N: ", _fmt(m.base_composition.n_content))
    if haskey(m, :quality)
        x = m.quality
        println(io, "  quality: mean base Q (Phred) ", _fmt(x.mean_base_quality), ", mean read Q (error prob.) ",
                _fmt(x.mean_read_quality), ", Q30 bases ", _fmt(x.fraction_q30))
    end
    print(io, "  metrics: ", join(keys(m), ", "))
    isempty(r.warnings) || print(io, "\n  warnings: ", length(r.warnings))
    for w in r.warnings
        print(io, "\n    - ", w)
    end
end

Base.show(io::IO, r::QCResult) = print(io, "QCResult(", repr(r.input.path), ", ", r.total_reads, " reads)")
