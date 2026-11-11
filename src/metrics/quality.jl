# Base- and read-level quality statistics.

"""
    QualityDistribution(; thresholds = (7, 10, 12, 15, 20, 30))

Quality statistics with two explicitly named averaging conventions:

- **Phred-space mean** (FastQC convention): arithmetic mean of Phred scores;
- **error-probability mean** (NanoPlot/ONT convention): `-10 log10(mean(10^(-Q/10)))`,
  i.e. the Phred value of the mean error probability.

Base level (exact, from the histogram of Phred scores 0–$(MAX_PHRED)):
`mean_base_quality` (Phred space), `base_error_rate` and
`base_quality_from_error_rate`, `fraction_q20`, `fraction_q30`.

Read level (zero-length reads are excluded and counted in `reads_without_bases`):
`mean_read_quality` (mean over reads of the per-read error-probability mean Q),
`mean_read_quality_phred` (mean over reads of the per-read Phred-space mean),
`read_quality_of_mean_error` (Phred value of the mean over reads of the
per-read mean error probability; this is NanoPlot's `mean_qual`),
histograms of both per-read values in bins of width 0.1 Q (bin `k` holds values
in `[k/10, (k+1)/10)`), and the number of reads whose per-read mean Q is
`>= t` for each threshold `t`.

All bases of a read are used (no trimming of the read start).
"""
struct QualityDistribution <: AbstractQCMetric
    thresholds::Vector{Int}
    function QualityDistribution(thresholds::AbstractVector{<:Integer})
        t = unique!(sort!(collect(Int, thresholds)))
        all(x -> 0 <= x <= MAX_PHRED, t) ||
            throw(ArgumentError("quality thresholds must lie in 0:$(MAX_PHRED), got $(thresholds)"))
        return new(t)
    end
end

QualityDistribution(; thresholds = (7, 10, 12, 15, 20, 30)) = QualityDistribution(collect(thresholds))

const READ_Q_BINS = 10 * MAX_PHRED + 1      # 0.0, 0.1, ..., 93.0

mutable struct QualityState
    thresholds::Vector{Int}
    base_histogram::Vector{Int}         # index Q + 1
    read_histogram::Vector{Int}         # error-probability mean, 0.1 bins
    read_histogram_phred::Vector{Int}   # Phred-space mean, 0.1 bins
    above::Vector{Int}                  # per threshold, error-probability mean
    above_phred::Vector{Int}
    reads::Int
    reads_without_bases::Int
    sum_read_q::Float64
    sum_read_q_phred::Float64
    sum_read_error::Float64             # sum over reads of the per-read mean error probability
end

metric_name(::QualityDistribution) = :quality
requirements(::QualityDistribution) = (:sequence, :quality)
memory_complexity(::QualityDistribution) = :constant
definition(::QualityDistribution) = "Phred-space mean = arithmetic mean of Phred scores; error-probability " *
    "mean = -10 log10(mean 10^(-Q/10)). Read-level histograms in 0.1 Q bins [k/10, (k+1)/10). All bases used."

function init_state(m::QualityDistribution)
    k = length(m.thresholds)
    return QualityState(copy(m.thresholds), zeros(Int, MAX_PHRED + 1), zeros(Int, READ_Q_BINS),
                        zeros(Int, READ_Q_BINS), zeros(Int, k), zeros(Int, k), 0, 0, 0.0, 0.0, 0.0)
end

@inline _q_bin(q::Float64) = clamp(floor(Int, 10 * q), 0, READ_Q_BINS - 1) + 1

function update!(st::QualityState, read::ReadView)
    s = read.summary
    len = s.length
    if len == 0
        st.reads_without_bases += 1
        return st
    end
    off = read.phred_offset
    h = st.base_histogram
    @inbounds for b in read.qual
        h[b - off + 1] += 1
    end
    q_err = s.mean_error_q
    q_phred = s.qsum / len
    st.reads += 1
    st.sum_read_q += q_err
    st.sum_read_q_phred += q_phred
    st.sum_read_error += s.error_sum / len
    @inbounds st.read_histogram[_q_bin(q_err)] += 1
    @inbounds st.read_histogram_phred[_q_bin(q_phred)] += 1
    @inbounds for (i, t) in enumerate(st.thresholds)
        st.above[i] += q_err >= t
        st.above_phred[i] += s.qsum >= t * len      # exact integer comparison
    end
    return st
end

function Base.merge!(dst::QualityState, src::QualityState)
    dst.thresholds == src.thresholds || throw(ArgumentError("cannot merge quality states with different thresholds"))
    dst.base_histogram .+= src.base_histogram
    dst.read_histogram .+= src.read_histogram
    dst.read_histogram_phred .+= src.read_histogram_phred
    dst.above .+= src.above
    dst.above_phred .+= src.above_phred
    dst.reads += src.reads
    dst.reads_without_bases += src.reads_without_bases
    dst.sum_read_q += src.sum_read_q
    dst.sum_read_q_phred += src.sum_read_q_phred
    dst.sum_read_error += src.sum_read_error
    return dst
end

function finalize_metric(st::QualityState)
    h = st.base_histogram
    nb = sum(h)
    qsum = sum((q - 1) * h[q] for q in eachindex(h); init = 0)
    errsum = sum(h[q] * ERROR_PROBABILITY[q] for q in eachindex(h); init = 0.0)
    q20 = sum(@view h[21:end])
    q30 = sum(@view h[31:end])
    rate = nb == 0 ? nothing : errsum / nb
    thr = Tuple(Symbol("Q", t) for t in st.thresholds)
    return (mean_base_quality = nb == 0 ? nothing : qsum / nb,
            base_error_rate = rate,
            base_quality_from_error_rate = rate === nothing ? nothing : -10 * log10(rate),
            fraction_q20 = nb == 0 ? nothing : q20 / nb,
            fraction_q30 = nb == 0 ? nothing : q30 / nb,
            base_quality_histogram = (phred = collect(0:MAX_PHRED), counts = copy(h)),
            mean_read_quality = st.reads == 0 ? nothing : st.sum_read_q / st.reads,
            mean_read_quality_phred = st.reads == 0 ? nothing : st.sum_read_q_phred / st.reads,
            read_quality_of_mean_error = st.reads == 0 ? nothing : -10 * log10(st.sum_read_error / st.reads),
            read_quality_histogram = (bin_width = 0.1, counts = copy(st.read_histogram)),
            read_quality_histogram_phred = (bin_width = 0.1, counts = copy(st.read_histogram_phred)),
            reads_at_least = NamedTuple{thr}(Tuple(st.above)),
            reads_at_least_phred = NamedTuple{thr}(Tuple(st.above_phred)),
            reads_without_bases = st.reads_without_bases)
end
