# Truncation profiles: how many reads (or read pairs) DADA2's filterAndTrim
# would keep for every truncation length and a set of maxEE thresholds, and a
# documented rule that proposes a truncation (docs/src/TRUNCATION.md).
#
# Filtering rules (R dada2 1.36 fastqFilter, as ported by DADA2.jl): remove the
# first trimLeft bases; truncate before the first base with Q <= truncQ;
# truncLen (measured on the raw read, ignored when <= trimLeft) discards reads
# shorter than truncLen and truncates the others; then minLen on the kept
# bases, at most maxN N, expected errors sum(10^(-Q/10)) <= maxEE. PhiX
# removal (rm.phix) is not modelled.
#
# For one read and one maxEE threshold the set of truncation lengths at which
# it passes is an interval [trimLeft + minLen, Lmax] (expected errors and N
# only grow with the length), so one number per read and threshold is enough:
# reads kept at L = number of reads with Lmax >= L, for L >= trimLeft + minLen
# (below, truncation leaves fewer than minLen bases and nothing is kept).

"""
    TruncationProfile

Result of [`truncation_profile`](@ref): for single-end input,
`kept[L, k]` = reads kept with `truncLen = L` and `maxEE = max_ee[k]`; for
paired-end input, `kept[L1, L2, k]` = pairs whose both reads are kept with
`truncLen = (L1, L2)`. `kept_untruncated[k]`: kept without `truncLen`. Fields
also record the filter settings, the number of reads or pairs, the longest
read of each file, `modal_length_fraction` (fraction of reads at the most
frequent length, per file: well below 1 for trimmed reads or variable
amplicons) and `positions` (truncation lengths covered, up to
`max_positions`).
"""
struct TruncationProfile
    paired::Bool
    files::Vector{String}
    reads::Int
    max_ee::Vector{Float64}
    trim_left::Vector{Int}
    trunc_q::Int
    max_n::Int
    min_len::Int
    phred_offset::Int
    max_length::Vector{Int}
    modal_length_fraction::Vector{Float64}
    positions::Vector{Int}
    kept::Array{Int}
    kept_untruncated::Vector{Int}
end

const DEFAULT_MAX_EE = [0.5, 1.0, 2.0, 3.0, 5.0, Inf]

# Per-read limits: lmax[k] = largest truncation length at which the read passes
# with max_ee[k] (0 = never), capped at `cap`; pass_untrunc[k] = passes without
# truncLen.
function _read_limits!(lmax::Vector{Int}, untrunc::Vector{Bool}, seq, qual, thresholds::Vector{Float64},
                       trim_left::Int, trunc_q::Int, max_n::Int, min_len::Int, offset::Int, cap::Int)
    fill!(lmax, 0)
    fill!(untrunc, false)
    n = length(seq)
    first = trim_left + 1
    n < first && return nothing
    last = n
    @inbounds for i in first:n
        q = Int(qual[i]) - offset
        (q < 0 || qual[i] > UInt8('~')) && throw(ArgumentError("quality byte outside the Phred+$(offset) range"))
        if q <= trunc_q
            last = i - 1
            break
        end
    end
    lmin = first + min_len - 1
    ee = 0.0
    ns = 0
    K = length(thresholds)
    nbreak = false
    @inbounds for i in first:last
        ee += ERROR_PROBABILITY[Int(qual[i]) - offset + 1]
        b = seq[i]
        ns += (b == UInt8('N')) | (b == UInt8('n'))
        if ns > max_n
            nbreak = true
            break
        end
        if i >= lmin
            for k in K:-1:1                           # thresholds ascending: stop at the first failing one
                ee <= thresholds[k] || break
                lmax[k] = min(i, cap)
            end
        end
    end
    if !nbreak && last - first + 1 >= min_len
        for k in 1:K
            untrunc[k] = ee <= thresholds[k]
        end
    end
    return nothing
end

function _check_truncation_args(max_ee, trim_left, trunc_q, max_n, min_len, phred_offset, max_positions)
    all(x -> x >= 0, max_ee) || throw(ArgumentError("max_ee values must be >= 0"))
    all(x -> x >= 0, trim_left) || throw(ArgumentError("trim_left must be >= 0"))
    0 <= trunc_q <= MAX_PHRED || throw(ArgumentError("trunc_q must be in 0:$(MAX_PHRED)"))
    max_n >= 0 || throw(ArgumentError("max_n must be >= 0"))
    min_len >= 1 || throw(ArgumentError("min_len must be >= 1 (DADA2 default 20)"))
    phred_offset in (33, 64) || throw(ArgumentError("phred_offset must be 33 or 64"))
    max_positions >= 1 || throw(ArgumentError("max_positions must be >= 1"))
end

_pair_id(id::AbstractString) = (s = first(split(id)); endswith(s, "/1") || endswith(s, "/2") ? s[1:end-2] : s)

function _next_read(reader, path, n)
    it = _next_record(reader, path, n)
    it === nothing && return nothing
    rec = first(it)
    return rec, codeunits(sequence(StringView, rec)), codeunits(quality(StringView, rec))
end

"""
    truncation_profile(fastq; kwargs...) -> TruncationProfile
    truncation_profile(fastq_r1, fastq_r2; kwargs...) -> TruncationProfile

Reads kept (single-end) or pairs kept (paired-end, both reads must pass, as
in DADA2's `filterAndTrim`) for every truncation length and each `max_ee`
threshold, computed exactly in one pass.

Keywords (defaults = DADA2's `filterAndTrim` defaults where they exist):
`max_ee = $(DEFAULT_MAX_EE)`, `trim_left = 0` (an integer, or a tuple for R1
and R2), `trunc_q = 2`, `max_n = 0`, `min_len = 20`, `phred_offset = 33`,
`max_positions` (truncation lengths covered; default 600 for pairs, enough
for 2 × 300 bp, and 100,000 for single-end; memory grows with its square for
pairs), `max_reads = nothing` (first records only, head sampling).

PhiX removal (`rm.phix`) is not modelled: with PhiX in the data DADA2 keeps
fewer reads than predicted.
"""
function truncation_profile(paths::AbstractString...; max_ee = DEFAULT_MAX_EE, trim_left = 0, trunc_q::Integer = 2,
                            max_n::Integer = 0, min_len::Integer = 20, phred_offset::Integer = 33,
                            max_positions::Union{Nothing,Integer} = nothing, max_reads::Union{Nothing,Integer} = nothing)
    length(paths) in (1, 2) || throw(ArgumentError("give one FASTQ file (single-end) or two (R1, R2)"))
    paired = length(paths) == 2
    thr = sort!(unique(Float64.(collect(max_ee))))
    isempty(thr) && throw(ArgumentError("max_ee must not be empty"))
    tl = trim_left isa Integer ? fill(Int(trim_left), length(paths)) : Int.(collect(trim_left))
    length(tl) == length(paths) || throw(ArgumentError("trim_left needs one value per input file"))
    cap = Int(something(max_positions, paired ? 600 : 100_000))
    _check_truncation_args(thr, tl, trunc_q, max_n, min_len, phred_offset, cap)
    limit = max_reads === nothing ? typemax(Int) : Int(max_reads)
    K = length(thr)
    lmax = [zeros(Int, K) for _ in paths]
    untr = [zeros(Bool, K) for _ in paths]
    maxlen = zeros(Int, length(paths))
    lens = [zeros(Int, cap + 2) for _ in paths]              # lens[min(len, cap + 1) + 1]
    untrunc_counts = zeros(Int, K)
    args = (Int(trunc_q), Int(max_n), Int(min_len), Int(phred_offset), cap)
    n = 0
    if !paired
        hist = zeros(Int, cap + 1, K)                         # hist[Lmax + 1, k]
        open_reads(paths[1]) do reader, info
            reader === nothing && return
            while n < limit
                r = _next_read(reader, info.path, n)
                r === nothing && break
                _, seq, qual = r
                n += 1
                maxlen[1] = max(maxlen[1], length(seq))
                lens[1][min(length(seq), cap + 1) + 1] += 1
                try
                    _read_limits!(lmax[1], untr[1], seq, qual, thr, tl[1], args...)
                catch err
                    err isa ArgumentError || rethrow()
                    throw(SeqQCInputError(info.path, n, err.msg))
                end
                for k in 1:K
                    hist[lmax[1][k] + 1, k] += 1
                    untrunc_counts[k] += untr[1][k]
                end
            end
        end
        top = max(1, min(cap, maxlen[1]))                     # no read is kept beyond its length
        kept = zeros(Int, top, K)
        for k in 1:K
            acc = sum(view(hist, top+2:cap+1, k); init = 0)
            for L in top:-1:1
                acc += hist[L + 1, k]
                kept[L, k] = acc
            end
        end
        kept[1:min(top, tl[1] + min_len - 1), :] .= 0                # truncated below minLen: nothing passes
    else
        hist = zeros(Int, cap + 1, cap + 1, K)
        open_reads(paths[1]) do r1, i1
            open_reads(paths[2]) do r2, i2
                (r1 === nothing) == (r2 === nothing) || throw(SeqQCInputError(paths[2], nothing, "R1 and R2 differ in number of reads"))
                r1 === nothing && return
                while n < limit
                    a = _next_read(r1, i1.path, n)
                    b = _next_read(r2, i2.path, n)
                    a === nothing && b === nothing && break
                    (a === nothing || b === nothing) &&
                        throw(SeqQCInputError(paths[2], n + 1, "R1 and R2 differ in number of reads"))
                    n += 1
                    _pair_id(identifier(a[1])) == _pair_id(identifier(b[1])) ||
                        throw(SeqQCInputError(paths[2], n, "read IDs of R1 and R2 differ ($(identifier(a[1])) / $(identifier(b[1])))"))
                    for (j, (path, (_, seq, qual))) in enumerate(((i1.path, a), (i2.path, b)))
                        maxlen[j] = max(maxlen[j], length(seq))
                        lens[j][min(length(seq), cap + 1) + 1] += 1
                        try
                            _read_limits!(lmax[j], untr[j], seq, qual, thr, tl[j], args...)
                        catch err
                            err isa ArgumentError || rethrow()
                            throw(SeqQCInputError(path, n, err.msg))
                        end
                    end
                    for k in 1:K
                        hist[lmax[1][k] + 1, lmax[2][k] + 1, k] += 1
                        untrunc_counts[k] += untr[1][k] & untr[2][k]
                    end
                end
            end
        end
        # kept[L1, L2, k] = pairs with Lmax1 >= L1 and Lmax2 >= L2 (2-D suffix sums)
        t1, t2 = max(1, min(cap, maxlen[1])), max(1, min(cap, maxlen[2]))
        kept = zeros(Int, t1, t2, K)
        acc = zeros(Int, cap + 2, cap + 2)
        for k in 1:K
            fill!(acc, 0)
            for a in cap:-1:1, b in cap:-1:1
                acc[a, b] = hist[a + 1, b + 1, k] + acc[a + 1, b] + acc[a, b + 1] - acc[a + 1, b + 1]
            end
            kept[:, :, k] .= view(acc, 1:t1, 1:t2)
        end
        kept[1:min(t1, tl[1] + min_len - 1), :, :] .= 0              # truncated below minLen: nothing passes
        kept[:, 1:min(t2, tl[2] + min_len - 1), :] .= 0
    end
    return TruncationProfile(paired, String.(collect(paths)), n, thr, tl, Int(trunc_q), Int(max_n), Int(min_len),
                             Int(phred_offset), maxlen,
                             [n == 0 ? 0.0 : maximum(l) / n for l in lens], collect(1:size(kept, 1)), kept, untrunc_counts)
end

"""
    kept_reads(profile, truncLen, max_ee) -> Int

Reads (single-end; `truncLen` an integer, `0` = no truncation) or pairs
(paired-end; `truncLen = (L1, L2)`, `(0, 0)` = no truncation) that DADA2's
`filterAndTrim` keeps with the profile's settings and `maxEE = max_ee` (one of
`profile.max_ee`). A `truncLen` not above `trim_left` is ignored, as in DADA2.
"""
function kept_reads(p::TruncationProfile, trunc_len, max_ee::Real)
    k = findfirst(==(Float64(max_ee)), p.max_ee)
    k === nothing && throw(ArgumentError("max_ee $(max_ee) is not in the profile ($(p.max_ee))"))
    Ls = trunc_len isa Integer ? (Int(trunc_len),) : Int.(Tuple(trunc_len))
    length(Ls) == (p.paired ? 2 : 1) || throw(ArgumentError("truncLen needs $(p.paired ? 2 : 1) value(s)"))
    active = [L > p.trim_left[j] for (j, L) in enumerate(Ls)]
    if !any(active)
        return p.kept_untruncated[k]
    elseif all(active)
        # beyond the longest read nothing is kept; beyond max_positions the profile does not know
        any(L > size(p.kept, j) && size(p.kept, j) < p.max_length[j] for (j, L) in enumerate(Ls)) &&
            throw(ArgumentError("truncLen beyond the profile's max_positions"))
        any(L > size(p.kept, j) for (j, L) in enumerate(Ls)) && return 0
        return p.paired ? p.kept[Ls[1], Ls[2], k] : p.kept[Ls[1], k]
    end
    throw(ArgumentError("mixing truncated and untruncated reads of a pair is not supported; give both lengths"))
end
