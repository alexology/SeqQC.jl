# JSON report: a versioned, dependency-free serialisation of QCResult.
# The schema is documented in docs/JSON.md; bump JSON_SCHEMA_VERSION on any
# incompatible change (renamed/removed field, changed type or meaning).

const JSON_SCHEMA = "seqqc-result"
const JSON_SCHEMA_VERSION = "1.0.0"
const DEFAULT_JSON_OMIT = (:raw_quality_histograms,)

# --- generic writer -----------------------------------------------------------

function _json_string(io::IO, s::AbstractString)
    print(io, '"')
    for ch in s
        if ch == '"'
            print(io, "\\\"")
        elseif ch == '\\'
            print(io, "\\\\")
        elseif ch == '\n'
            print(io, "\\n")
        elseif ch == '\r'
            print(io, "\\r")
        elseif ch == '\t'
            print(io, "\\t")
        elseif ch < ' ' || ch == '\u7f'
            print(io, "\\u", string(UInt16(ch); base = 16, pad = 4))
        else
            print(io, ch)
        end
    end
    print(io, '"')
end

_json(io::IO, x::Nothing, omit) = print(io, "null")
_json(io::IO, x::Missing, omit) = print(io, "null")
_json(io::IO, x::Bool, omit) = print(io, x ? "true" : "false")
_json(io::IO, x::Integer, omit) = print(io, x)
# Non-finite values have no JSON representation: null (docs/JSON.md).
_json(io::IO, x::AbstractFloat, omit) = isfinite(x) ? print(io, repr(Float64(x))) : print(io, "null")
_json(io::IO, x::AbstractString, omit) = _json_string(io, x)
_json(io::IO, x::Symbol, omit) = _json_string(io, String(x))
_json(io::IO, x::VersionNumber, omit) = _json_string(io, string(x))

function _json(io::IO, x::Union{AbstractVector,Tuple}, omit)
    print(io, '[')
    for (i, v) in enumerate(x)
        i > 1 && print(io, ',')
        _json(io, v, omit)
    end
    print(io, ']')
end

# Matrices as an array of rows.
function _json(io::IO, x::AbstractMatrix, omit)
    print(io, '[')
    for i in axes(x, 1)
        i > first(axes(x, 1)) && print(io, ',')
        _json(io, view(x, i, :), omit)
    end
    print(io, ']')
end

function _json(io::IO, x::Union{NamedTuple,AbstractDict}, omit)
    print(io, '{')
    first_field = true
    for (k, v) in pairs(x)
        Symbol(k) in omit && continue
        first_field || print(io, ',')
        first_field = false
        _json_string(io, string(k))
        print(io, ':')
        _json(io, v, omit)
    end
    print(io, '}')
end

_json(io::IO, x, omit) = throw(ArgumentError("cannot serialise a value of type $(typeof(x)) to JSON"))

# --- QCResult -------------------------------------------------------------------

"""
    to_json(result::QCResult; omit = $(DEFAULT_JSON_OMIT), fastqc = false) -> String

Serialise `result` to JSON (schema `$(JSON_SCHEMA)` version $(JSON_SCHEMA_VERSION),
see `docs/JSON.md`). Field names listed in `omit` are dropped at any depth and
listed in `omitted_fields`; by default the raw per-position quality
histograms (94 numbers per read position) are omitted. With `fastqc = true`
the FastQC-compatible module tables and flags are added under `fastqc`
(requires the metrics of `SeqQC.FastQC.metrics()`); when they cannot be
computed, `fastqc.modules` is null and `fastqc.unavailable` gives the reason. Non-finite numbers are
written as `null`. Wall-clock time is kept apart under `runtime`, so the rest
of the document is reproducible.
"""
function to_json(r::QCResult; omit = DEFAULT_JSON_OMIT, fastqc::Bool = false)
    io = IOBuffer()
    write_json(io, r; omit, fastqc)
    return String(take!(io))
end

"""
    write_json(io_or_path, result::QCResult; omit, fastqc = false)

Write the JSON document of [`to_json`](@ref) to an `IO` or to a file (written
to a temporary file in the same directory and then renamed, so an existing
report is never left half-written).
"""
function write_json(io::IO, r::QCResult; omit = DEFAULT_JSON_OMIT, fastqc::Bool = false)
    om = Tuple(Symbol.(omit))
    doc = (schema = JSON_SCHEMA, schema_version = JSON_SCHEMA_VERSION,
           software = r.software,
           input = (path = r.input.path, file_size = r.input.file_size, compression = r.input.compression,
                    format = r.input.format, decompression = r.input.decompression),
           platform = r.platform,
           settings = r.settings,
           total_reads = r.total_reads,
           total_bases = r.total_bases,
           warnings = r.warnings,
           metrics = r.metrics,
           fastqc = fastqc ? _fastqc_section(r) : nothing,
           omitted_fields = collect(om),
           runtime = (elapsed_seconds = r.elapsed_seconds,))
    _json(io, doc, om)
    println(io)
    return nothing
end

# FastQC tables, or the reason they cannot be computed (e.g. reads longer than
# max_positions): recorded instead of failing, so batch runs keep going.
function _fastqc_section(r::QCResult)
    rules = "FastQC 0.12.1 (docs/FASTQC.md)"
    try
        return (rules = rules, modules = FastQC.modules(r), unavailable = nothing)
    catch err
        err isa ArgumentError || rethrow()
        return (rules = rules, modules = nothing, unavailable = err.msg)
    end
end

function write_json(path::AbstractString, r::QCResult; kwargs...)
    dir = dirname(abspath(path))
    isdir(dir) || throw(ArgumentError("output directory does not exist: $(dir)"))
    tmp, tio = mktemp(dir)
    try
        write_json(tio, r; kwargs...)
        close(tio)
        mv(tmp, path; force = true)
    catch
        close(tio)
        rm(tmp; force = true)
        rethrow()
    end
    return path
end

"""
    report(result::QCResult, path; kwargs...)

Write a report whose format follows the file extension: `.json` (see
[`write_json`](@ref)). HTML and MultiQC outputs are not implemented yet.
"""
function report(r::QCResult, path::AbstractString; kwargs...)
    ext = lowercase(splitext(path)[2])
    ext == ".json" && return write_json(path, r; kwargs...)
    ext == ".html" && return _atomic_write(io -> write_html(io, r; kwargs...), path)
    throw(ArgumentError("report format $(repr(ext)) is not available for a QCResult; use .json or .html"))
end
