# Truncation suggestion from a TruncationProfile, and the DADA2 / vsearch
# commands that apply it (docs/src/TRUNCATION.md).

const TruncationAlternative = NamedTuple{(:max_ee, :trunc_len, :kept, :fraction, :overlap),
                                         Tuple{Float64,Vector{Int},Int,Float64,Union{Nothing,Int}}}

"""
    TruncationSuggestion

Result of [`suggest_truncation`](@ref): the proposed `trunc_len` (one value,
or `[L1, L2]` for pairs) and `max_ee`, the reads or pairs `kept` and their
`fraction`, the expected `overlap` of the two reads (paired-end), the best
choice for every `max_ee` of the profile (`alternatives`), `warnings`, and the
`profile` itself. [`truncation_commands`](@ref) turns it into DADA2 (R and
DADA2.jl) and vsearch commands.
"""
struct TruncationSuggestion
    profile::TruncationProfile
    trunc_len::Vector{Int}
    max_ee::Float64
    kept::Int
    fraction::Float64
    amplicon_length::Union{Nothing,Int}
    min_overlap::Int
    overlap::Union{Nothing,Int}
    criterion::String
    alternatives::Vector{TruncationAlternative}
    warnings::Vector{String}
end

_lowest_len(p::TruncationProfile, j::Int, min_trunc_len::Int) =
    max(p.trim_left[j] + p.min_len, min_trunc_len, 1)

# Best truncation for threshold k, or nothing when no length keeps anything.
function _best_truncation(p::TruncationProfile, k::Int, amplicon_length::Int, min_overlap::Int, min_trunc_len::Int)
    if !p.paired
        best = nothing
        bscore = -1
        for L in _lowest_len(p, 1, min_trunc_len):size(p.kept, 1)
            c = p.kept[L, k]
            score = c * (L - p.trim_left[1])                  # retained bases
            if c > 0 && score >= bscore                       # ties: the longer truncation
                best, bscore = ([L], c), score
            end
        end
        return best
    end
    need = amplicon_length + min_overlap
    t1, t2 = size(p.kept, 1), size(p.kept, 2)
    lo1, lo2 = _lowest_len(p, 1, min_trunc_len), _lowest_len(p, 2, min_trunc_len)
    best = nothing
    bkey = (-1, -1, -1)
    for L1 in lo1:t1
        for L2 in max(lo2, need - L1):t2
            c = p.kept[L1, L2, k]
            key = (c, L1 + L2, L1)                            # pairs kept, then total length, then R1
            if c > 0 && key > bkey
                best, bkey = ([L1, L2], c), key
            end
        end
    end
    return best
end

"""
    suggest_truncation(profile; amplicon_length = nothing, min_overlap = 20,
                       max_ee = 2.0, min_trunc_len = 0) -> TruncationSuggestion
    suggest_truncation(fastq...; amplicon_length, min_overlap, max_ee, min_trunc_len,
                       profile_max_ee = $(DEFAULT_MAX_EE), profile_kwargs...)

Propose DADA2 `truncLen` values from a [`truncation_profile`](@ref) (or
compute the profile first from the FASTQ files: `profile_max_ee`, to which
`max_ee` is added, gives its thresholds and the other keywords are passed
to it).

- Single-end: the length that maximises the retained bases (reads kept ×
  (truncLen − trimLeft)), ties going to the longer truncation; `min_trunc_len`
  sets a lower bound (e.g. the length the analysis needs).
- Paired-end (`amplicon_length` required): the pair `(L1, L2)` that keeps the
  most pairs subject to `L1 + L2 ≥ amplicon_length + min_overlap`, ties going
  to the larger `L1 + L2` and then to the longer R1. `amplicon_length` is the
  length of the sequenced fragment from the first base of R1 to the first base
  of R2 (primers included if they are in the reads). DADA2's `mergePairs`
  needs at least 12 overlapping bases; `min_overlap = 20` leaves a margin for
  length variation.

`max_ee` must be one of `profile.max_ee`; the best choice for every threshold
is in `alternatives`. The read counts are exact for DADA2's filter (PhiX
removal aside); the choice itself is a heuristic that knows nothing about the
quality of the ASVs inferred afterwards.
"""
function suggest_truncation(p::TruncationProfile; amplicon_length::Union{Nothing,Integer} = nothing,
                            min_overlap::Integer = 20, max_ee::Real = 2.0, min_trunc_len::Integer = 0)
    findfirst(==(Float64(max_ee)), p.max_ee) === nothing &&
        throw(ArgumentError("max_ee $(max_ee) is not in the profile ($(p.max_ee))"))
    p.reads > 0 || throw(ArgumentError("the profile has no reads"))
    min_overlap >= 0 || throw(ArgumentError("min_overlap must be >= 0"))
    if p.paired
        amplicon_length === nothing &&
            throw(ArgumentError("paired-end data: give amplicon_length (the sequenced fragment length)"))
        amplicon_length >= 1 || throw(ArgumentError("amplicon_length must be >= 1"))
    end
    amp = amplicon_length === nothing ? nothing : Int(amplicon_length)
    criterion = p.paired ? "most pairs kept with L1 + L2 >= amplicon_length + min_overlap" :
                           "most retained bases: reads kept x (truncLen - trimLeft)"
    alts = TruncationAlternative[]
    for (j, thr) in enumerate(p.max_ee)
        b = _best_truncation(p, j, something(amp, 0), Int(min_overlap), Int(min_trunc_len))
        b === nothing && continue
        Ls, c = b
        push!(alts, (max_ee = thr, trunc_len = Ls, kept = c, fraction = c / p.reads,
                     overlap = p.paired ? Ls[1] + Ls[2] - amp : nothing))
    end
    i = findfirst(a -> a.max_ee == Float64(max_ee), alts)
    i === nothing && throw(ArgumentError(p.paired ?
        "no truncation keeps any pair with $(min_overlap) bases of overlap on a $(amp) bp fragment: reads too short or too poor" :
        "no truncation length keeps any read"))
    a = alts[i]
    warns = String[]
    for (j, f) in enumerate(p.modal_length_fraction)
        f < 0.9 && push!(warns, "$(basename(p.files[j])): only $(round(100f; digits = 1))% of the reads have the most " *
                                "frequent length (trimmed reads or a variable-length amplicon); truncLen discards every " *
                                "read shorter than it, consider truncLen = 0 with maxEE alone")
    end
    a.fraction < 0.5 && push!(warns, "fewer than half of the $(p.paired ? "pairs" : "reads") are kept; " *
                                      "check primers, trimLeft and read quality")
    any(p.max_length[j] > length(p.positions) for j in eachindex(p.max_length)) &&
        push!(warns, "reads are longer than max_positions; longer truncations were not considered")
    push!(warns, "PhiX removal (rm.phix) is not modelled: with PhiX in the data DADA2 keeps fewer reads")
    return TruncationSuggestion(p, a.trunc_len, a.max_ee, a.kept, a.fraction, amp, Int(min_overlap), a.overlap,
                                criterion, alts, warns)
end

function suggest_truncation(paths::AbstractString...; amplicon_length = nothing, min_overlap = 20, max_ee = 2.0,
                            min_trunc_len = 0, profile_max_ee = DEFAULT_MAX_EE, kwargs...)
    p = truncation_profile(paths...; max_ee = unique([collect(profile_max_ee); max_ee]), kwargs...)
    return suggest_truncation(p; amplicon_length, min_overlap, max_ee, min_trunc_len)
end

_rnum(x::Real) = isinf(x) ? "Inf" : isinteger(x) ? string(Int(x)) : string(x)

"""
    truncation_commands(s::TruncationSuggestion) -> NamedTuple

Commands that apply the suggestion: `dada2_r` (R dada2 `filterAndTrim`),
`dada2_jl` (DADA2.jl `filterAndTrim`) and `vsearch` (`--fastq_filter`,
single-end only; for pairs, merge first with `--fastq_mergepairs` and filter
the merged reads, which this profile does not describe). The DADA2 commands
apply exactly the filter of the profile (plus PhiX removal); the vsearch one
has not been validated against vsearch. File names are placeholders.
"""
function truncation_commands(s::TruncationSuggestion)
    p = s.profile
    e = _rnum(s.max_ee)
    ejl = isinf(s.max_ee) ? "Inf" : repr(s.max_ee)
    opt(L, tl) = "FilterOptions(trimLeft = $(tl), truncLen = $(L), truncQ = $(p.trunc_q), maxN = $(p.max_n), " *
                 "maxEE = $(ejl), minLen = $(p.min_len))"
    if p.paired
        L1, L2 = s.trunc_len
        r = "filterAndTrim(fwd, filtF, rev, filtR, truncLen = c($(L1), $(L2)), " *
            "trimLeft = c($(p.trim_left[1]), $(p.trim_left[2])), truncQ = $(p.trunc_q), maxN = $(p.max_n), " *
            "maxEE = c($(e), $(e)), minLen = $(p.min_len), rm.phix = TRUE, compress = TRUE)"
        jl = "filterAndTrim(fwd, rev, filtF, filtR; optionsF = $(opt(L1, p.trim_left[1])), " *
             "optionsR = $(opt(L2, p.trim_left[2])))"
        vs = "# merge the pairs first (vsearch --fastq_mergepairs R1.fastq --reverse R2.fastq ...) and filter the " *
             "merged reads; this profile describes the unmerged reads"
    else
        L = s.trunc_len[1]
        tl = p.trim_left[1]
        r = "filterAndTrim(fwd, filtF, truncLen = $(L), trimLeft = $(tl), truncQ = $(p.trunc_q), maxN = $(p.max_n), " *
            "maxEE = $(e), minLen = $(p.min_len), rm.phix = TRUE, compress = TRUE)"
        jl = "filterAndTrim(fwd, filtF; options = $(opt(L, tl)))"
        vs = "vsearch --fastq_filter reads.fastq" * (tl > 0 ? " --fastq_stripleft $(tl)" : "") *
             " --fastq_truncqual $(p.trunc_q) --fastq_trunclen $(L) --fastq_maxns $(p.max_n)" *
             (isinf(s.max_ee) ? "" : " --fastq_maxee $(e)") * " --fastq_minlen $(p.min_len)" *
             (p.phred_offset == 64 ? " --fastq_ascii 64" : "") * " --fastqout filtered.fastq"
        tl > 0 && (vs *= "  # not validated: check whether --fastq_trunclen counts the stripped bases (DADA2's truncLen does)")
    end
    return (dada2_r = r, dada2_jl = jl, vsearch = vs)
end

function Base.show(io::IO, ::MIME"text/plain", p::TruncationProfile)
    println(io, "TruncationProfile: ", p.reads, p.paired ? " pairs" : " reads", ", longest read ",
            join(p.max_length, " / "))
    print(io, "  trimLeft = ", join(p.trim_left, "/"), ", truncQ = ", p.trunc_q, ", maxN = ", p.max_n,
          ", minLen = ", p.min_len, ", maxEE = ", join(_rnum.(p.max_ee), ", "))
end

function Base.show(io::IO, ::MIME"text/plain", s::TruncationSuggestion)
    p = s.profile
    println(io, "Suggested truncation (", s.criterion, ")")
    println(io, "  truncLen = ", p.paired ? "c($(s.trunc_len[1]), $(s.trunc_len[2]))" : s.trunc_len[1],
            ", maxEE = ", _rnum(s.max_ee), ": ", s.kept, " of ", p.reads, p.paired ? " pairs" : " reads", " kept (",
            round(100 * s.fraction; digits = 1), "%)", s.overlap === nothing ? "" : ", overlap $(s.overlap) bases")
    println(io, "  alternatives:")
    for a in s.alternatives
        println(io, "    maxEE ", rpad(_rnum(a.max_ee), 4), "  truncLen ", rpad(join(a.trunc_len, ", "), 9),
                "  kept ", a.kept, " (", round(100 * a.fraction; digits = 1), "%)")
    end
    c = truncation_commands(s)
    println(io, "  R dada2:  ", c.dada2_r)
    println(io, "  DADA2.jl: ", c.dada2_jl)
    print(io, "  vsearch:  ", c.vsearch)
    for w in s.warnings
        print(io, "\n  warning: ", w)
    end
end

# --- reports -----------------------------------------------------------------------

function _truncation_doc(s::TruncationSuggestion)
    p = s.profile
    return (schema = "seqqc-truncation", schema_version = "1.0.0",
            software = (name = "SeqQC.jl", version = VERSION_STRING),
            files = p.files, paired = p.paired, reads = p.reads,
            filter = (trim_left = p.trim_left, trunc_q = p.trunc_q, max_n = p.max_n, min_len = p.min_len,
                      phred_offset = p.phred_offset, rm_phix = "not modelled"),
            max_length = p.max_length, modal_length_fraction = p.modal_length_fraction,
            criterion = s.criterion, amplicon_length = s.amplicon_length, min_overlap = s.min_overlap,
            suggestion = (trunc_len = s.trunc_len, max_ee = s.max_ee, kept = s.kept, fraction = s.fraction,
                          overlap = s.overlap),
            alternatives = s.alternatives,
            kept_untruncated = (max_ee = p.max_ee, kept = p.kept_untruncated),
            commands = truncation_commands(s),
            warnings = s.warnings)
end

# TSV: single-end, one row per truncLen; paired-end, one row per L1 with the
# shortest L2 that gives the required overlap. Columns kept_ee<threshold>.
function _write_truncation_tsv(io::IO, s::TruncationSuggestion)
    p = s.profile
    heads = ["kept_ee" * _rnum(t) for t in p.max_ee]
    if !p.paired
        println(io, join(["trunc_len"; heads], '\t'))
        for L in _lowest_len(p, 1, 0):size(p.kept, 1)
            println(io, join([L; view(p.kept, L, :)], '\t'))
        end
    else
        println(io, join(["trunc_len_r1"; "trunc_len_r2"; "overlap"; heads], '\t'))
        need = s.amplicon_length + s.min_overlap
        for L1 in _lowest_len(p, 1, 0):size(p.kept, 1)
            L2 = max(_lowest_len(p, 2, 0), need - L1)
            L2 <= size(p.kept, 2) || continue
            println(io, join([L1; L2; L1 + L2 - s.amplicon_length; view(p.kept, L1, L2, :)], '\t'))
        end
    end
    return nothing
end

"""
    report(s::TruncationSuggestion, path)

Write the suggestion as `.json` (schema `seqqc-truncation`, with the
alternatives and the commands), `.tsv` (reads kept for every truncation
length and `max_ee`; for pairs, one row per R1 length with the shortest R2
length giving the required overlap) or `.html` (charts, see
[`write_html`](@ref SeqQC.write_html)).
"""
function report(s::TruncationSuggestion, path::AbstractString)
    ext = lowercase(splitext(path)[2])
    ext == ".json" && return _atomic_write(io -> (_json(io, _truncation_doc(s), ()); println(io)), path)
    ext == ".tsv" && return _atomic_write(io -> _write_truncation_tsv(io, s), path)
    ext == ".html" && return _atomic_write(io -> write_html(io, s), path)
    throw(ArgumentError("report format $(repr(ext)) is not available for a TruncationSuggestion; use .json, .tsv or .html"))
end
