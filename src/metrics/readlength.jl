# Exact read-length statistics from a histogram of read lengths.

"""
    ReadLength()

Exact read-length statistics: number of reads, total bases, minimum, maximum,
mean, median, read N50/N90 and the full length histogram.

The state keeps one counter per distinct read length (dense array for lengths
below `$(1 << 16)`, dictionary above), so memory grows with the number of
*distinct* lengths, not with the number of reads, and every statistic is exact.

Read N50 is computed on reads, not on an assembly: the largest length `L` such
that reads of length `>= L` contain at least 50% of all bases (N90: 90%).
The median of an even number of reads is the mean of the two middle lengths.
"""
struct ReadLength <: AbstractQCMetric end

const DENSE_LENGTHS = 1 << 16

mutable struct ReadLengthState
    dense::Vector{Int}          # dense[len + 1] = reads of length len, len < DENSE_LENGTHS
    sparse::Dict{Int,Int}       # longer reads
    reads::Int
    bases::Int
end

metric_name(::ReadLength) = :read_length
requirements(::ReadLength) = (:sequence,)
memory_complexity(::ReadLength) = :distinct_lengths
definition(::ReadLength) = "Exact statistics of read lengths in bases. Read N50 (N90): largest L such " *
    "that reads of length >= L hold >= 50% (90%) of all bases. Median of an even count: mean of the two middle values."

init_state(::ReadLength) = ReadLengthState(zeros(Int, DENSE_LENGTHS), Dict{Int,Int}(), 0, 0)

function update!(s::ReadLengthState, read::ReadView)
    len = read.summary.length
    if len < DENSE_LENGTHS
        @inbounds s.dense[len + 1] += 1
    else
        s.sparse[len] = get(s.sparse, len, 0) + 1
    end
    s.reads += 1
    s.bases += len
    return s
end

function Base.merge!(dst::ReadLengthState, src::ReadLengthState)
    dst.dense .+= src.dense
    mergewith!(+, dst.sparse, src.sparse)
    dst.reads += src.reads
    dst.bases += src.bases
    return dst
end

# Sorted (length, count) pairs with count > 0.
function _length_histogram(s::ReadLengthState)
    lengths = Int[]
    counts = Int[]
    @inbounds for i in eachindex(s.dense)
        c = s.dense[i]
        if c > 0
            push!(lengths, i - 1)
            push!(counts, c)
        end
    end
    for len in sort!(collect(keys(s.sparse)))
        push!(lengths, len)
        push!(counts, s.sparse[len])
    end
    return lengths, counts
end

# Length of the read at 1-based rank `k` in ascending order.
function _length_at_rank(lengths, counts, k)
    seen = 0
    for i in eachindex(lengths)
        seen += counts[i]
        seen >= k && return lengths[i]
    end
    error("rank out of range")
end

# Largest L such that reads of length >= L hold >= num/den of all bases.
function _nxx(lengths, counts, total, num, den)
    cum = Int128(0)
    for i in reverse(eachindex(lengths))
        cum += Int128(lengths[i]) * counts[i]
        cum * den >= Int128(total) * num && return lengths[i]
    end
    return 0
end

function finalize_metric(s::ReadLengthState)
    lengths, counts = _length_histogram(s)
    n = s.reads
    if n == 0
        return (total_reads = 0, total_bases = 0, min_length = nothing, max_length = nothing,
                mean_length = nothing, median_length = nothing, n50 = nothing, n90 = nothing,
                length_histogram = (lengths = lengths, counts = counts))
    end
    lo = _length_at_rank(lengths, counts, (n + 1) ÷ 2)
    hi = _length_at_rank(lengths, counts, n ÷ 2 + 1)
    median = isodd(n) ? Float64(lo) : (lo + hi) / 2
    n50 = s.bases == 0 ? 0 : _nxx(lengths, counts, s.bases, 1, 2)
    n90 = s.bases == 0 ? 0 : _nxx(lengths, counts, s.bases, 9, 10)
    return (total_reads = n, total_bases = s.bases,
            min_length = first(lengths), max_length = last(lengths),
            mean_length = s.bases / n, median_length = median, n50 = n50, n90 = n90,
            length_histogram = (lengths = lengths, counts = counts))
end

"""
    yield_by_length(result) -> NamedTuple

Cumulative yield from the read-length histogram of a [`QCResult`](@ref) (or of
the `read_length` metric result): for every distinct length `L`, in
descending order, the number of reads and of bases in reads of length `>= L`.
"""
function yield_by_length(r)
    h = r isa QCResult ? r.metrics.read_length.length_histogram : r.length_histogram
    k = length(h.lengths)
    lengths = reverse(h.lengths)
    reads = Vector{Int}(undef, k)
    bases = Vector{Int}(undef, k)
    nr = 0
    nb = 0
    for (i, j) in enumerate(reverse(eachindex(h.lengths)))
        nr += h.counts[j]
        nb += h.counts[j] * h.lengths[j]
        reads[i] = nr
        bases[i] = nb
    end
    return (min_length = lengths, reads = reads, bases = bases)
end
