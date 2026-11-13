# Multi-sample aggregation of SeqQC results (MultiQC-like summaries).
# Works on SeqQC JSON documents (schema seqqc-result 1.x): QCResult inputs are
# converted with to_json first, so in-memory results and saved reports follow
# exactly the same path.

const AGGREGATE_SCHEMA = "seqqc-aggregate"
const AGGREGATE_SCHEMA_VERSION = "1.0.0"

"""
    SampleSet

Result of [`aggregate`](@ref): `samples` (names), `sources` (input file of
each sample), `table` (one column per summary statistic, `nothing` where a
sample lacks the metric), `series` (distributions on common bins, for plots),
`warnings` (per-sample and set-level notes) and `settings`.
"""
struct SampleSet
    samples::Vector{String}
    sources::Vector{String}
    table::NamedTuple
    series::NamedTuple
    warnings::Vector{String}
    settings::NamedTuple
end

Base.length(s::SampleSet) = length(s.samples)

function Base.show(io::IO, ::MIME"text/plain", s::SampleSet)
    println(io, "SampleSet: ", length(s), " samples")
    for (i, n) in enumerate(s.samples[1:min(end, 10)])
        println(io, "  ", n, "  (", _fmt(s.table.reads[i]), " reads)")
    end
    length(s) > 10 && println(io, "  …")
    isempty(s.warnings) || print(io, "  warnings: ", length(s.warnings))
end

# --- inputs -------------------------------------------------------------------

_get(d, keys...) = foldl((x, k) -> x isa AbstractDict ? get(x, k, nothing) : nothing, keys; init = d)

function _check_doc(doc, src)
    doc isa AbstractDict && _get(doc, "schema") == JSON_SCHEMA ||
        throw(ArgumentError("$(src) is not a SeqQC result (schema $(JSON_SCHEMA))"))
    v = string(_get(doc, "schema_version"))
    startswith(v, "1.") || throw(ArgumentError("$(src): unsupported $(JSON_SCHEMA) version $(v) (supported: 1.x)"))
    return doc
end

# Natural order: digit runs compare as numbers (barcode2 < barcode10).
function _natural_key(s::AbstractString)
    parts = Any[]
    for m in eachmatch(r"\d+|\D+", s)
        t = m.match
        push!(parts, isdigit(first(t)) ? (0, parse(BigInt, t), "") : (1, big(0), lowercase(t)))
    end
    return parts
end
_natural_less(a, b) = isless(_natural_key(a), _natural_key(b))

function _collect_inputs(items)
    docs = Dict{String,Any}[]
    srcs = String[]
    notes = String[]
    for it in items
        if it isa QCResult
            # FastQC flags are added when the result has the metrics they need
            fq = all(k -> haskey(it.metrics, k), (:read_length, :quality, :per_position)) &&
                 !it.metrics.per_position.per_position.truncated
            push!(docs, parse_json(to_json(it; omit = DEFAULT_JSON_OMIT, fastqc = fq)))
            push!(srcs, it.input.path)
        elseif it isa AbstractString && isdir(it)
            files = sort!([f for f in readdir(it) if endswith(lowercase(f), ".json")]; lt = _natural_less)
            for f in files
                p = joinpath(it, f)
                d = try
                    read_json(p)
                catch err
                    err isa JSONParseError || rethrow()
                    push!(notes, "skipped $(f): not valid JSON ($(err.msg))")
                    continue
                end
                if !(d isa AbstractDict) || _get(d, "schema") != JSON_SCHEMA
                    push!(notes, "skipped $(f): not a $(JSON_SCHEMA) document")
                    continue
                end
                push!(docs, _check_doc(d, p))
                push!(srcs, _get(d, "input", "path") === nothing ? p : string(_get(d, "input", "path")))
            end
        elseif it isa AbstractString && isfile(it)
            d = read_json(it)
            push!(docs, _check_doc(d, it))
            push!(srcs, _get(d, "input", "path") === nothing ? it : string(_get(d, "input", "path")))
        else
            throw(ArgumentError("aggregate: $(repr(it)) is neither a QCResult, a SeqQC JSON file nor a directory"))
        end
    end
    isempty(docs) && throw(ArgumentError("aggregate: no SeqQC results found"))
    return docs, srcs, notes
end

const _SAMPLE_SUFFIXES = (r"\.(gz|bgz|bz2|xz|zst)$"i, r"\.json$"i, r"\.seqqc$"i, r"\.(fastq|fq)$"i)

"""
    sample_name(path) -> String

Default sample name: the file name without compression, `.json`, `.seqqc` and
`.fastq`/`.fq` extensions (`ONT_barcode01.fastq.gz` → `ONT_barcode01`).
"""
function sample_name(path::AbstractString)
    n = basename(path)
    for r in _SAMPLE_SUFFIXES
        n = replace(n, r => "")
    end
    return n
end

function _names(srcs, names)
    # default names for every sample first, so that a name does not depend on
    # which other samples the user renames
    out = sample_name.(srcs)
    # colliding names: prefix the parent directory (barcode01/reads, barcode02/reads)
    dup = Set(n for n in out if count(==(n), out) > 1)
    for i in eachindex(out)
        out[i] in dup && (out[i] = string(basename(dirname(srcs[i])), "/", out[i]))
    end
    if names isa AbstractVector
        length(names) == length(srcs) ||
            throw(ArgumentError("names has $(length(names)) entries for $(length(srcs)) samples"))
        out = String.(names)
    elseif names isa AbstractDict
        out = [String(get(names, s, out[i])) for (i, s) in enumerate(srcs)]
    end
    d = [n for n in unique(out) if count(==(n), out) > 1]
    isempty(d) || throw(ArgumentError("duplicate sample names $(join(repr.(d), ", ")); pass names = [...] or a Dict " *
                                      "source => name to aggregate()"))
    return out
end

# --- summary table ----------------------------------------------------------------

_num(x) = x isa Real ? x : nothing
_pct(a, b) = (a isa Real && b isa Real && b > 0) ? 100 * a / b : nothing

function _row(doc)
    m = _get(doc, "metrics")
    rl = _get(m, "read_length")
    bc = _get(m, "base_composition")
    q = _get(m, "quality")
    reads = _num(_get(doc, "total_reads"))
    flags = _get(doc, "fastqc", "modules", "flags")
    return (reads = reads, bases = _num(_get(doc, "total_bases")),
            min_length = _num(_get(rl, "min_length")), median_length = _num(_get(rl, "median_length")),
            mean_length = _num(_get(rl, "mean_length")), max_length = _num(_get(rl, "max_length")),
            n50 = _num(_get(rl, "n50")),
            gc_percent = (g = _num(_get(bc, "gc_content")); g === nothing ? nothing : 100 * g),
            n_percent = (g = _num(_get(bc, "n_content")); g === nothing ? nothing : 100 * g),
            mean_base_quality = _num(_get(q, "mean_base_quality")),
            mean_read_quality = _num(_get(q, "mean_read_quality")),
            percent_reads_q20 = _pct(_get(q, "reads_at_least", "Q20"), reads),
            percent_bases_q30 = (g = _num(_get(q, "fraction_q30")); g === nothing ? nothing : 100 * g),
            warnings = length(something(_get(doc, "warnings"), [])),
            fastqc_flags = flags isa AbstractDict ?
                Dict{String,String}(string(k) => string(v) for (k, v) in flags if v !== nothing) : nothing)
end

# --- common bins for plots ------------------------------------------------------------

# Bins for read lengths shared by all samples: linear "nice" width up to 1 kb,
# logarithmic (20 per decade, as QualityVsLength) beyond.
function _length_bins(maxlen::Int)
    if maxlen <= 1000
        w = 1
        for s in (1, 2, 5, 10, 20, 50)
            w = s
            cld(maxlen + 1, s) <= 120 && break
        end
        edges = collect(0:w:(maxlen + w))
        return edges, :linear
    else
        e = [x for x in LENGTH_EDGES if x <= maxlen]
        push!(e, maxlen + 1)
        return e, :log
    end
end

function _binned(lengths, counts, edges)
    out = zeros(Float64, length(edges) - 1)
    for (L, c) in zip(lengths, counts)
        k = searchsortedlast(edges, L)
        k = clamp(k, 1, length(out))
        out[k] += c
    end
    return out
end

_frac(v) = (s = sum(v); s > 0 ? v ./ s : fill(NaN, length(v)))

_float(x) = x isa Real ? Float64(x) : NaN

# Mean Phred score by read position, on common linear bins of positions.
# A bin's value pools the bases of its positions (sum of mean_i * bases_i /
# sum of bases_i, i.e. the exact mean of those bases). Positions covered by
# fewer than max(min_bases, min_fraction * reads) bases are left out, so the
# sparse tails of very long reads do not dominate the chart.
function _position_quality(docs; min_bases = 100, min_fraction = 0.01)
    n = length(docs)
    covered = zeros(Int, n)
    data = Vector{Any}(nothing, n)
    for (i, d) in enumerate(docs)
        p = _get(d, "metrics", "per_position", "per_position")
        p === nothing && continue
        bases = Int.(something(_get(p, "bases"), Int[]))
        meanq = [_float(x) for x in something(_get(p, "mean_quality"), Float64[])]
        reads = something(_get(d, "total_reads"), 0)
        thr = max(min_bases, ceil(Int, min_fraction * reads))
        ok = findall(>=(thr), bases)
        isempty(ok) && continue
        covered[i] = maximum(ok)
        data[i] = (bases = bases, meanq = meanq, thr = thr)
    end
    P = maximum(covered)
    P == 0 && return (edges = [1, 2], mean_quality = fill(NaN, n, 1), min_bases = min_bases, min_fraction = min_fraction)
    w = 1
    for s in (1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000)
        w = s
        cld(P, s) <= 150 && break
    end
    edges = collect(1:w:(P + w))
    nb = length(edges) - 1
    m = fill(NaN, n, nb)
    for i in 1:n
        data[i] === nothing && continue
        b, q, thr = data[i].bases, data[i].meanq, data[i].thr
        for k in 1:nb
            num = 0.0
            den = 0
            for pos in edges[k]:min(edges[k+1] - 1, length(b))
                (b[pos] >= thr && isfinite(q[pos])) || continue
                num += q[pos] * b[pos]
                den += b[pos]
            end
            den > 0 && (m[i, k] = num / den)
        end
    end
    return (edges = edges, mean_quality = m, min_bases = min_bases, min_fraction = min_fraction)
end

function _series(docs)
    n = length(docs)
    m(d, ks...) = _get(d, "metrics", ks...)
    # read length distribution and yield
    hists = [(something(m(d, "read_length", "length_histogram", "lengths"), Int[]),
              something(m(d, "read_length", "length_histogram", "counts"), Int[])) for d in docs]
    maxlen = maximum((isempty(h[1]) ? 0 : maximum(h[1])) for h in hists)
    edges, scale = _length_bins(max(maxlen, 1))
    nb = length(edges) - 1
    lenfrac = fill(NaN, n, nb)
    yield = fill(NaN, n, nb)
    for (i, (L, C)) in enumerate(hists)
        isempty(L) && continue
        lenfrac[i, :] = _frac(_binned(L, C, edges))
        b = _binned(L, Float64.(L) .* C, edges)          # bases per bin
        tot = sum(b)
        tot > 0 && (yield[i, :] = reverse(cumsum(reverse(b))) ./ tot)   # bases in reads >= lower edge
    end
    # per-read quality (error-probability mean), 1-Q bins
    qmax = 0
    rq = Vector{Union{Nothing,Vector{Float64}}}(nothing, n)
    for (i, d) in enumerate(docs)
        h = m(d, "quality", "read_quality_histogram", "counts")
        h === nothing && continue
        v = zeros(94)
        for (k, c) in enumerate(h)
            v[min(94, (k - 1) ÷ 10 + 1)] += c
        end
        rq[i] = v
        nz = findlast(>(0), v)
        nz !== nothing && (qmax = max(qmax, nz))
    end
    qmax = max(qmax, 1)
    readq = fill(NaN, n, qmax)
    for i in 1:n
        rq[i] === nothing || (readq[i, :] = _frac(rq[i][1:qmax]))
    end
    # base quality
    bq = fill(NaN, n, qmax)
    bmax = 1
    raw = [m(d, "quality", "base_quality_histogram", "counts") for d in docs]
    for h in raw
        h === nothing && continue
        nz = findlast(>(0), h)
        nz !== nothing && (bmax = max(bmax, nz))
    end
    basq = fill(NaN, n, bmax)
    for (i, h) in enumerate(raw)
        h === nothing || (basq[i, :] = _frac(Float64.(h[1:bmax])))
    end
    # per-read GC
    gc = fill(NaN, n, 101)
    for (i, d) in enumerate(docs)
        h = m(d, "base_composition", "gc_histogram")
        h === nothing || (gc[i, :] = _frac(Float64.(h)))
    end
    return (length = (edges = edges, scale = scale, fraction = lenfrac, yield = yield),
            read_quality = (q = collect(0:qmax-1), fraction = readq),
            base_quality = (q = collect(0:bmax-1), fraction = basq),
            gc = (percent = collect(0:100), fraction = gc),
            position_quality = _position_quality(docs))
end

"""
    aggregate(inputs; names = nothing, low_reads_fraction = 0.1) -> SampleSet

Collect SeqQC results of several samples into one [`SampleSet`](@ref).
`inputs` may mix `QCResult`s, SeqQC JSON files and directories (every
`*.json` file whose schema is `seqqc-result` is used, in natural order; other
files are skipped with a note). Samples are kept side by side, never merged.

Sample names: by default the input file name without extensions (see
[`sample_name`](@ref)); names that collide get their parent directory as a
prefix; if they still collide, an error asks for `names` (a vector in input
order, or a `Dict` from input path to name).

A sample with fewer than `low_reads_fraction` × the median number of reads is
reported in `warnings` (a heuristic, configurable; not a FastQC flag).
"""
function aggregate(inputs; names = nothing, low_reads_fraction::Real = 0.1)
    items = inputs isa Union{QCResult,AbstractString} ? [inputs] : collect(inputs)
    docs, srcs, notes = _collect_inputs(items)
    samples = _names(srcs, names)
    rows = [_row(d) for d in docs]
    cols = keys(first(rows))
    table = NamedTuple{(:sample, cols...)}((samples, [[r[c] for r in rows] for c in cols]...))
    warnings = copy(notes)
    for (s, d) in zip(samples, docs)
        for w in something(_get(d, "warnings"), [])
            push!(warnings, "$(s): $(w)")
        end
    end
    reads = [r.reads for r in rows if r.reads isa Real]
    if length(reads) >= 3
        med = sort(reads)[(length(reads) + 1) ÷ 2]
        for (s, r) in zip(samples, rows)
            r.reads isa Real && r.reads < low_reads_fraction * med &&
                push!(warnings, "$(s): $(r.reads) reads, below $(low_reads_fraction) × the median ($(med))")
        end
    end
    settings = (low_reads_fraction = Float64(low_reads_fraction),
                software = (name = "SeqQC", version = VERSION_STRING, julia = string(VERSION)),
                sample_schema_versions = unique(string(_get(d, "schema_version")) for d in docs))
    return SampleSet(samples, srcs, table, _series(docs), warnings, settings)
end

# --- outputs -------------------------------------------------------------------

const _TABLE_HEADERS = (sample = "sample", reads = "reads", bases = "bases", min_length = "min_length",
    median_length = "median_length", mean_length = "mean_length", max_length = "max_length", n50 = "read_n50",
    gc_percent = "gc_percent", n_percent = "n_percent", mean_base_quality = "mean_base_quality_phred",
    mean_read_quality = "mean_read_quality_error_prob", percent_reads_q20 = "percent_reads_q20",
    percent_bases_q30 = "percent_bases_q30", warnings = "warnings")

_tsv(x::Nothing) = ""
_tsv(x::AbstractFloat) = isfinite(x) ? repr(x) : ""
_tsv(x) = replace(string(x), r"[\t\r\n]" => " ")

"""
    write_table(io_or_path, set::SampleSet)

Write the summary table as tab-separated values (one row per sample; empty
cells where a metric is missing; FastQC flags as `fastqc_<module>` columns when
present).
"""
function write_table(io::IO, s::SampleSet)
    flagkeys = sort!(unique(k for f in s.table.fastqc_flags if f !== nothing for k in keys(f)))
    cols = [k for k in keys(_TABLE_HEADERS)]
    println(io, join([[_TABLE_HEADERS[c] for c in cols]; ["fastqc_" * k for k in flagkeys]], '\t'))
    for i in eachindex(s.samples)
        vals = [_tsv(s.table[c][i]) for c in cols]
        f = s.table.fastqc_flags[i]
        append!(vals, [f === nothing ? "" : get(f, k, "") for k in flagkeys])
        println(io, join(vals, '\t'))
    end
    return nothing
end
write_table(path::AbstractString, s::SampleSet) = (_atomic_write(io -> write_table(io, s), path); path)

function _atomic_write(f, path)
    dir = dirname(abspath(path))
    isdir(dir) || throw(ArgumentError("output directory does not exist: $(dir)"))
    tmp, tio = mktemp(dir)
    try
        f(tio)
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
    to_json(set::SampleSet) -> String

Aggregated document, schema `seqqc-aggregate` 1.0.0 (`docs/JSON.md`).
"""
function to_json(s::SampleSet)
    io = IOBuffer()
    doc = (schema = AGGREGATE_SCHEMA, schema_version = AGGREGATE_SCHEMA_VERSION, settings = s.settings,
           samples = s.samples, sources = s.sources, table = s.table, series = s.series, warnings = s.warnings)
    _json(io, doc, ())
    println(io)
    return String(take!(io))
end

function report(s::SampleSet, path::AbstractString; kwargs...)
    ext = lowercase(splitext(path)[2])
    ext == ".html" && return _atomic_write(io -> write_html(io, s; kwargs...), path)
    ext == ".tsv" && return write_table(path, s)
    ext == ".json" && return _atomic_write(io -> print(io, to_json(s)), path)
    throw(ArgumentError("report format $(repr(ext)) is not available for a SampleSet; use .html, .tsv or .json"))
end
