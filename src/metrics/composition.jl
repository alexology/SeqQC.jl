# Base composition, GC content and per-read GC distribution.

"""
    BaseComposition()

Base counts and GC statistics.

- `gc_content = (G + C) / (A + C + G + T)`: N, other IUPAC codes and invalid
  bytes are excluded from numerator and denominator (U counts as T);
- `n_content = N / total bases`, `ambiguous_content` = non-N IUPAC codes / total bases;
- `gc_histogram[k + 1]`: reads whose own GC percentage, rounded half up to an
  integer, is `k` (0–100); reads without any A/C/G/T are counted in
  `reads_without_acgt` instead.

Invalid bytes (anything that is not a nucleotide or IUPAC code) are counted in
`base_counts.invalid` and produce a warning in the result.
"""
struct BaseComposition <: AbstractQCMetric end

mutable struct BaseCompositionState
    counts::Vector{Int}         # by class: A C G T N ambiguous invalid
    gc_histogram::Vector{Int}   # 0..100 %
    reads_without_acgt::Int
end

metric_name(::BaseComposition) = :base_composition
requirements(::BaseComposition) = (:sequence,)
memory_complexity(::BaseComposition) = :constant
definition(::BaseComposition) = "gc_content = (G+C)/(A+C+G+T), case-insensitive, U as T; N, IUPAC codes " *
    "and invalid bytes excluded. Per-read GC percentage rounded half up to an integer."

init_state(::BaseComposition) = BaseCompositionState(zeros(Int, N_CLASSES), zeros(Int, 101), 0)

function update!(st::BaseCompositionState, read::ReadView)
    s = read.summary
    c = st.counts
    @inbounds begin
        c[CLASS_A] += s.a
        c[CLASS_C] += s.c
        c[CLASS_G] += s.g
        c[CLASS_T] += s.t
        c[CLASS_N] += s.n
        c[CLASS_AMBIGUOUS] += s.ambiguous
        c[CLASS_INVALID] += s.invalid
    end
    acgt = s.a + s.c + s.g + s.t
    if acgt == 0
        st.reads_without_acgt += 1
    else
        gc = s.g + s.c
        pct = (200 * gc + acgt) ÷ (2 * acgt)       # round(100 gc / acgt), ties up
        @inbounds st.gc_histogram[pct + 1] += 1
    end
    return st
end

function Base.merge!(dst::BaseCompositionState, src::BaseCompositionState)
    dst.counts .+= src.counts
    dst.gc_histogram .+= src.gc_histogram
    dst.reads_without_acgt += src.reads_without_acgt
    return dst
end

function finalize_metric(st::BaseCompositionState)
    a, c, g, t, n, amb, inv = st.counts
    total = sum(st.counts)
    acgt = a + c + g + t
    return (gc_content = acgt == 0 ? nothing : (g + c) / acgt,
            n_content = total == 0 ? nothing : n / total,
            ambiguous_content = total == 0 ? nothing : amb / total,
            base_counts = (A = a, C = c, G = g, T = t, N = n, ambiguous = amb, invalid = inv),
            gc_histogram = copy(st.gc_histogram),
            reads_without_acgt = st.reads_without_acgt)
end
