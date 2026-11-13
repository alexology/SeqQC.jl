# FastQC "Per sequence GC content" counts (inside module SeqQC.FastQC).
#
# Rules determined by black-box experiments on FastQC 0.12.1 (docs/src/FASTQC.md):
# - reads are truncated: 100 <= L < 1000 to a multiple of 100, L >= 1000 to a
#   multiple of 1000 (150 -> 100, 2850 -> 2000, 19999 -> 19000);
# - c = number of G/C (case-insensitive) in the truncated read; N, U and IUPAC
#   codes count in the length but not as G/C;
# - GC count c of length L claims the percentage bins
#   jround(100 (c - 0.5) / L) ... jround(100 (c + 0.5) / L), clipped to 0:100,
#   with jround(x) = floor(x + 0.5) (Java Math.round);
# - each claimed bin receives 1 / (number of GC counts of that length claiming it);
# - weights are added read by read, in input order (bit-identical sums).

"""
    GCModel()

Metric reproducing FastQC's per-sequence GC counts (fractional weights per GC
percentage bin 0–100). Reads of 100–999 bases are truncated to a multiple of 100,
longer reads to a multiple of 1,000 (2,850 → 2,000), as FastQC 0.12.1 does.
Needs `:sequence`. Weights are accumulated read by read in input order, as FastQC does; merging two states adds the bin sums, which can
differ from a single pass in the last bits.
"""
struct GCModel <: AbstractQCMetric end

mutable struct GCModelState
    counts::Vector{Float64}                                    # 101 bins
    models::Dict{Int,Vector{Vector{Tuple{Int,Float64}}}}       # length -> c -> (bin, weight)
end

SeqQC.metric_name(::GCModel) = :fastqc_gc
SeqQC.requirements(::GCModel) = (:sequence,)
SeqQC.memory_complexity(::GCModel) = :distinct_lengths
SeqQC.definition(::GCModel) = "FastQC 0.12.1 per-sequence GC model: reads truncated to a multiple of 100 " *
    "(100-999 bp) or 1000 (>= 1000 bp); GC count c of L bases claims bins jround(100(c-0.5)/L)..jround(100(c+0.5)/L), weight 1/claims per bin."
SeqQC.init_state(::GCModel) = GCModelState(zeros(101), Dict{Int,Vector{Vector{Tuple{Int,Float64}}}}())

_jround(x::Float64) = floor(Int, x + 0.5)

# Effective length used by FastQC's GC model.
_gc_length(len::Int) = len < 100 ? len : len < 1000 ? (len ÷ 100) * 100 : (len ÷ 1000) * 1000

function _gc_model(L::Int)
    lo = [clamp(_jround(100 * (c - 0.5) / L), 0, 100) for c in 0:L]
    hi = [clamp(_jround(100 * (c + 0.5) / L), 0, 100) for c in 0:L]
    claims = zeros(Int, 101)
    for c in 0:L, b in lo[c + 1]:hi[c + 1]
        claims[b + 1] += 1
    end
    return [[(b, 1.0 / claims[b + 1]) for b in lo[c + 1]:hi[c + 1]] for c in 0:L]
end

const _GC_BYTE = let t = falses(256)
    for ch in "GCgc"
        t[UInt8(ch) + 1] = true
    end
    t
end

function SeqQC.update!(st::GCModelState, read::SeqQC.ReadView)
    seq = read.seq
    len = length(seq)
    len == 0 && return st
    L = _gc_length(len)
    c = 0
    @inbounds for i in 1:L
        c += _GC_BYTE[seq[i] + 1]
    end
    model = get!(() -> _gc_model(L), st.models, L)
    @inbounds for (b, w) in model[c + 1]
        st.counts[b + 1] += w
    end
    return st
end

function Base.merge!(dst::GCModelState, src::GCModelState)
    dst.counts .+= src.counts
    for (k, v) in src.models
        haskey(dst.models, k) || (dst.models[k] = v)
    end
    return dst
end

SeqQC.finalize_metric(st::GCModelState) = (fastqc_gc_counts = copy(st.counts),)

"""
    per_sequence_gc(result) -> NamedTuple

FastQC "Per sequence GC content" counts for GC percentages 0–100 (requires
[`GCModel`](@ref) in the analysis, included in [`metrics`](@ref)).
"""
function per_sequence_gc(r::QCResult)
    haskey(r.metrics, :fastqc_gc) || throw(ArgumentError("per_sequence_gc needs the FastQC.GCModel metric; " *
                                                        "analyse with SeqQC.FastQC.metrics()"))
    return (gc_content = collect(0:100), count = copy(r.metrics.fastqc_gc.fastqc_gc_counts))
end
