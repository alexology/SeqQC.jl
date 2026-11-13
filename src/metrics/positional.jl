# Exact per-position statistics with bounded memory.

# Base classes for per-position counts. Unlike `BaseComposition`, U is kept
# separate from T (needed to reproduce tools that ignore U).
const POS_A, POS_C, POS_G, POS_T, POS_U, POS_N, POS_OTHER = 1:7
const N_POS_CLASSES = 7
const POS_CLASS = let t = fill(UInt8(POS_OTHER), 256)
    for (chars, class) in (("Aa", POS_A), ("Cc", POS_C), ("Gg", POS_G), ("Tt", POS_T),
                           ("Uu", POS_U), ("Nn", POS_N))
        for ch in chars
            t[UInt8(ch) + 1] = class
        end
    end
    t
end

# Quality histograms are kept on raw bytes '!' (33) to '~' (126), so that the
# Phred offset can be applied (or guessed, for compatibility outputs) at the end.
const RAW_QUAL_BINS = 126 - 33 + 1

"""
    PerPositionStats(; max_positions = 100_000)

Exact statistics for every read position `1:max_positions`:

- per position: number of bases, mean Phred score, quantiles of the Phred
  scores (10%, 25%, 50%, 75%, 90%; quantile `p` of `n` values is the value of
  rank `max(1, floor(p n))` in ascending order), and counts of A, C, G, T, U, N
  and other bytes (case-insensitive; U is **not** merged with T here);
- bases at positions beyond `max_positions` are pooled into one aggregate
  (`beyond`), and the result reports `truncated = true` with a warning.

Memory: about 0.8 kB per position up to the longest read observed (capped at
`max_positions`; storage grows by doubling, so up to twice that while reads get
longer), independent of the number of reads: ~0.25 MB for 300 bp reads,
~22–44 MB for 27 kb reads, at most ~80–160 MB with the default cap. The per-position quality
histograms are stored on raw quality bytes, so FastQC-compatible tables (see
`SeqQC.FastQC`) can apply FastQC's encoding guess.
"""
struct PerPositionStats <: AbstractQCMetric
    max_positions::Int
    function PerPositionStats(max_positions::Integer)
        max_positions >= 1 || throw(ArgumentError("max_positions must be >= 1, got $(max_positions)"))
        return new(Int(max_positions))
    end
end

PerPositionStats(; max_positions::Integer = 100_000) = PerPositionStats(max_positions)

mutable struct PerPositionState
    max_positions::Int
    npos::Int                       # positions currently allocated (<= max_positions)
    qual::Matrix{Int}               # RAW_QUAL_BINS × npos, raw byte - 32
    bases::Matrix{Int}              # N_POS_CLASSES × npos
    beyond_qual::Vector{Int}        # pooled over positions > max_positions
    beyond_bases::Vector{Int}
    max_length::Int
    offset::Int
end

metric_name(::PerPositionStats) = :per_position
requirements(::PerPositionStats) = (:sequence, :quality)
memory_complexity(::PerPositionStats) = :bounded_positions
definition(m::PerPositionStats) = "Per position 1:$(m.max_positions): bases, mean Phred, quantiles " *
    "(rank max(1, floor(p n))), counts of A C G T U N other (case-insensitive). Later positions pooled."

init_state(m::PerPositionStats) =
    PerPositionState(m.max_positions, 0, zeros(Int, RAW_QUAL_BINS, 0), zeros(Int, N_POS_CLASSES, 0),
                     zeros(Int, RAW_QUAL_BINS), zeros(Int, N_POS_CLASSES), 0, -1)

function _grow!(st::PerPositionState, len::Int)
    n = min(st.max_positions, max(len, 2 * st.npos, 64))
    n <= st.npos && return st
    q = zeros(Int, RAW_QUAL_BINS, n)
    b = zeros(Int, N_POS_CLASSES, n)
    copyto!(view(q, :, 1:st.npos), st.qual)
    copyto!(view(b, :, 1:st.npos), st.bases)
    st.qual, st.bases, st.npos = q, b, n
    return st
end

function update!(st::PerPositionState, read::ReadView)
    st.offset < 0 && (st.offset = read.phred_offset)
    seq, qual = read.seq, read.qual
    len = length(seq)
    len > st.max_length && (st.max_length = len)
    len > st.npos && st.npos < st.max_positions && _grow!(st, len)
    k = min(len, st.npos)
    q, b = st.qual, st.bases
    @inbounds for i in 1:k
        q[qual[i] - 32, i] += 1
        b[POS_CLASS[seq[i] + 1], i] += 1
    end
    @inbounds for i in (k + 1):len
        st.beyond_qual[qual[i] - 32] += 1
        st.beyond_bases[POS_CLASS[seq[i] + 1]] += 1
    end
    return st
end

function Base.merge!(dst::PerPositionState, src::PerPositionState)
    dst.max_positions == src.max_positions ||
        throw(ArgumentError("cannot merge per-position states with different max_positions"))
    # raw quality bytes only mean the same Phred scores under the same offset
    dst.offset >= 0 && src.offset >= 0 && dst.offset != src.offset &&
        throw(ArgumentError("cannot merge per-position states with different Phred offsets " *
                            "($(dst.offset) and $(src.offset))"))
    src.npos > dst.npos && _grow!(dst, src.npos)
    view(dst.qual, :, 1:src.npos) .+= src.qual
    view(dst.bases, :, 1:src.npos) .+= src.bases
    dst.beyond_qual .+= src.beyond_qual
    dst.beyond_bases .+= src.beyond_bases
    dst.max_length = max(dst.max_length, src.max_length)
    dst.offset < 0 && (dst.offset = src.offset)
    return dst
end

const POSITION_QUANTILES = (0.10, 0.25, 0.50, 0.75, 0.90)

# Value of rank max(1, floor(p n)) in a histogram (bin k holds value k - 1 + shift).
function _hist_quantile(h::AbstractVector{Int}, n::Int, p::Float64, shift::Int)
    rank = max(1, floor(Int, p * n))
    seen = 0
    @inbounds for k in eachindex(h)
        seen += h[k]
        seen >= rank && return k - 1 + shift
    end
    error("rank beyond histogram")
end

function finalize_metric(st::PerPositionState)
    npos = min(st.max_length, st.npos)
    offset = st.offset < 0 ? 33 : st.offset
    shift = 33 - offset                     # raw bin k (value k-1+33) -> Phred
    count = zeros(Int, npos)
    meanq = fill(NaN, npos)
    quant = fill(NaN, length(POSITION_QUANTILES), npos)
    for i in 1:npos
        h = view(st.qual, :, i)
        n = sum(h)
        count[i] = n
        n == 0 && continue
        meanq[i] = sum((k - 1 + shift) * h[k] for k in eachindex(h)) / n
        for (j, p) in enumerate(POSITION_QUANTILES)
            quant[j, i] = _hist_quantile(h, n, p, shift)
        end
    end
    nb = sum(st.beyond_qual)
    truncated = st.max_length > st.max_positions
    return (per_position = (positions = npos, max_length = max(st.max_length, 0), phred_offset = offset,
                            bases = count, mean_quality = meanq,
                            quantile_probabilities = collect(POSITION_QUANTILES), quality_quantiles = quant,
                            base_counts = copy(view(st.bases, :, 1:npos)),
                            base_classes = [:A, :C, :G, :T, :U, :N, :other],
                            raw_quality_histograms = copy(view(st.qual, :, 1:npos)),
                            truncated = truncated, max_positions = st.max_positions,
                            beyond = (bases = nb, base_counts = copy(st.beyond_bases),
                                      raw_quality_histogram = copy(st.beyond_qual))),)
end

function metric_warnings(r::NamedTuple{(:per_position,)})
    p = r.per_position
    p.truncated || return String[]
    return ["per-position statistics cover positions 1:$(p.max_positions) only; $(p.beyond.bases) bases " *
            "of reads up to $(p.max_length) bp are pooled (increase max_positions to keep them)"]
end
