# Single-pass streaming engine.

"""
    default_metrics() -> Vector{AbstractQCMetric}

The metrics computed when `analyze` is called without `metrics`:
[`ReadLength`](@ref), [`BaseComposition`](@ref), [`QualityDistribution`](@ref),
[`QualityVsLength`](@ref).
"""
default_metrics() = AbstractQCMetric[ReadLength(), BaseComposition(), QualityDistribution(), QualityVsLength()]

"""
    metric_warnings(state_result) -> Vector{String}

Optional hook: warnings derived from a finalized metric result. Defaults to none.
"""
metric_warnings(result) = String[]

function metric_warnings(r::NamedTuple)
    w = String[]
    if haskey(r, :base_counts) && r.base_counts.invalid > 0
        push!(w, "$(r.base_counts.invalid) bases are not nucleotide or IUPAC codes; they are excluded from GC content")
    end
    if haskey(r, :reads_without_bases) && r.reads_without_bases > 0
        push!(w, "$(r.reads_without_bases) zero-length reads have no quality and are excluded from quality statistics")
    end
    return w
end

const PLATFORMS = (:generic,)

@inline _update_all!(::Tuple{}, read) = nothing
@inline function _update_all!(states::Tuple, read)
    update!(first(states), read)
    return _update_all!(Base.tail(states), read)
end

function _next_record(reader, path, n)
    try
        return iterate(reader)
    catch err
        err isa InterruptException && rethrow()
        throw(SeqQCInputError(path, n + 1, "malformed or truncated FASTQ record", err))
    end
end

# Streams up to `limit` records through `states`. Returns reads, bases and
# whether records were left unread because of the limit.
function _stream!(reader, states::Tuple, offset::Int, limit::Int, path::String)
    summary = ReadSummary()
    totals = zeros(Int, N_CLASSES)
    n = 0
    bases = 0
    while n < limit
        it = _next_record(reader, path, n)
        it === nothing && return n, bases, false
        record = first(it)
        seq = codeunits(sequence(StringView, record))
        qual = codeunits(quality(StringView, record))
        if !summarize!(summary, totals, seq, qual, offset)
            throw(SeqQCInputError(path, n + 1,
                "quality string contains bytes outside the Phred+$(offset) range " *
                "('$(Char(offset))' to '~'); check the quality encoding (phred_offset)"))
        end
        _update_all!(states, ReadView(seq, qual, offset, summary, record))
        n += 1
        bases += summary.length
    end
    more = try
        iterate(reader) !== nothing
    catch
        true            # a malformed record after the limit: data were left unread
    end
    return n, bases, more
end

"""
    analyze(path; metrics = default_metrics(), platform = :generic,
            phred_offset = 33, max_reads = nothing) -> QCResult
    analyze(paths::AbstractVector; kwargs...) -> Vector{QCResult}

Run all `metrics` over the reads of a FASTQ file (plain or gzip-compressed,
detected from the content) in a single streaming pass.

- `metrics`: any collection of [`AbstractQCMetric`](@ref)s with unique names,
  including user-defined ones;
- `platform`: analysis profile; only `:generic` is implemented in this version;
- `phred_offset`: 33 (Sanger/Illumina 1.8+, ONT, PacBio) or 64 (old Illumina);
  quality bytes outside `offset`–`'~'` raise an error, no guessing is done;
- `max_reads`: process only the first `max_reads` records (head sampling, not
  random); recorded in `settings` and reported as a warning when reads were left.

Errors in the input raise [`SeqQCInputError`](@ref) with the record number.
"""
function analyze(path::AbstractString; metrics = default_metrics(), platform::Symbol = :generic,
                 phred_offset::Integer = 33, max_reads::Union{Nothing,Integer} = nothing)
    platform in PLATFORMS ||
        throw(ArgumentError("platform $(repr(platform)) is not implemented yet; available: $(join(repr.(PLATFORMS), ", "))"))
    phred_offset in (33, 64) || throw(ArgumentError("phred_offset must be 33 or 64, got $(phred_offset)"))
    max_reads === nothing || max_reads >= 0 || throw(ArgumentError("max_reads must be >= 0, got $(max_reads)"))
    ms = Tuple(metrics)
    all(m -> m isa AbstractQCMetric, ms) || throw(ArgumentError("metrics must be AbstractQCMetric instances"))
    isempty(ms) && throw(ArgumentError("at least one metric is required"))
    names = map(metric_name, ms)
    allunique(names) || throw(ArgumentError("metric names must be unique, got $(collect(names))"))
    available = INPUT_FIELDS[:fastq]
    for m in ms, req in requirements(m)
        req in available ||
            throw(ArgumentError("metric $(metric_name(m)) requires $(repr(req)), which FASTQ input does not provide"))
    end

    states = map(init_state, ms)
    limit = max_reads === nothing ? typemax(Int) : Int(max_reads)
    t0 = time_ns()
    info, nreads, nbases, more = open_reads(path) do reader, info
        reader === nothing && return info, 0, 0, false
        return (info, _stream!(reader, states, Int(phred_offset), limit, info.path)...)
    end
    elapsed = (time_ns() - t0) / 1e9

    results = NamedTuple{names}(map(finalize_metric, states))
    warnings = String[]
    for r in results
        append!(warnings, metric_warnings(r))
    end
    nreads == 0 && push!(warnings, "the input contains no reads")
    more && push!(warnings, "max_reads = $(max_reads): only the first $(nreads) records were analysed " *
                            "(head sampling, not random); further records were not read")
    settings = (phred_offset = Int(phred_offset), max_reads = max_reads === nothing ? nothing : Int(max_reads),
                sampling = more ? :head : :none, metrics = collect(names),
                definitions = NamedTuple{names}(map(definition, ms)))
    software = (name = "SeqQC", version = VERSION_STRING, julia = string(VERSION))
    return QCResult(info, platform, settings, nreads, nbases, results, warnings, software, elapsed)
end

analyze(paths::AbstractVector{<:AbstractString}; kwargs...) = [analyze(p; kwargs...) for p in paths]
