# Joint distribution of read length and read quality.

# Integer lower edges of logarithmic length bins: 20 bins per decade, bin k
# starts at ceil(10^(k/20)). Lengths >= the last edge (10^9) go to the last bin.
const LENGTH_BINS_PER_DECADE = 20
const LENGTH_EDGES = let e = Int[0, 1]
    for k in 1:(9 * LENGTH_BINS_PER_DECADE)
        x = ceil(Int, 10.0^(k / LENGTH_BINS_PER_DECADE))
        x > last(e) && push!(e, x)
    end
    e
end

"""
    QualityVsLength()

Two-dimensional histogram of read length against per-read quality
(error-probability mean, see [`QualityDistribution`](@ref)).

Length bins are logarithmic, 20 per decade, with integer lower edges
`length_edges` (bin `i` holds lengths in `[length_edges[i], length_edges[i+1])`;
the first bin holds zero-length reads, the last one all lengths `>= 10^9`).
Quality bins have width 1 Q: column `j` holds per-read Q in `[j-1, j)`.
Zero-length reads have no quality and are not counted.
"""
struct QualityVsLength <: AbstractQCMetric end

mutable struct QualityVsLengthState
    counts::Matrix{Int}     # length bin × quality bin
end

metric_name(::QualityVsLength) = :quality_vs_length
requirements(::QualityVsLength) = (:sequence, :quality)
memory_complexity(::QualityVsLength) = :constant
definition(::QualityVsLength) = "Counts of reads by logarithmic length bin (20 per decade, integer lower " *
    "edges) and by per-read error-probability mean Q in 1-Q bins [j-1, j)."

init_state(::QualityVsLength) = QualityVsLengthState(zeros(Int, length(LENGTH_EDGES), MAX_PHRED + 1))

function update!(st::QualityVsLengthState, read::ReadView)
    s = read.summary
    len = s.length
    len == 0 && return st
    q = s.mean_error_q
    i = searchsortedlast(LENGTH_EDGES, len)
    j = clamp(floor(Int, q), 0, MAX_PHRED) + 1
    @inbounds st.counts[i, j] += 1
    return st
end

function Base.merge!(dst::QualityVsLengthState, src::QualityVsLengthState)
    dst.counts .+= src.counts
    return dst
end

finalize_metric(st::QualityVsLengthState) =
    (quality_vs_length = (length_edges = copy(LENGTH_EDGES), quality_edges = collect(0:MAX_PHRED),
                          counts = copy(st.counts)),)
