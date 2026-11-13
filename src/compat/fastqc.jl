"""
    SeqQC.FastQC

FastQC-compatible views of SeqQC results. The rules below were determined by
black-box experiments on FastQC 0.12.1 outputs (no FastQC source code was read
or translated); they are documented with the evidence in `docs/src/FASTQC.md`.
Only modules listed there as validated are provided.

Analyse with [`metrics`](@ref SeqQC.FastQC.metrics) (or any metric set that
contains `ReadLength`, `QualityDistribution` and `PerPositionStats`), then call
the module functions on the result:

```julia
r = analyze("reads.fastq.gz"; metrics = SeqQC.FastQC.metrics())
SeqQC.FastQC.per_base_quality(r)
SeqQC.FastQC.modules(r)          # all supported modules and pass/warn/fail flags
```
"""
module FastQC

import ..SeqQC
using ..SeqQC: QCResult, AbstractQCMetric, ReadLength, QualityDistribution, PerPositionStats,
               POS_A, POS_C, POS_G, POS_T, POS_N, POSITION_QUANTILES, _hist_quantile

const SERIES_BASE = (1, 2, 5)

# 1, 2, 5, 10, 20, 50, ... : the k-th value of the series (k >= 1).
_series(k::Int) = SERIES_BASE[mod1(k, 3)] * 10^((k - 1) ÷ 3)

"""
    metrics() -> Vector{AbstractQCMetric}

Metrics needed by the FastQC-compatible modules. `max_positions` of
`PerPositionStats` must be at least the longest read.
"""
metrics(; max_positions::Integer = 100_000, contaminants = nothing) =
    AbstractQCMetric[ReadLength(), QualityDistribution(), PerPositionStats(; max_positions), GCModel(),
                     AdapterContent(; max_positions), Overrepresented(; contaminants)]

"""
    base_groups(max_length) -> Vector{UnitRange{Int}}

FastQC position groups for a maximum read length: one group per position up to
75 bp; otherwise positions 1–9 singly, then groups of width `S` aligned to
multiples of `S` from position 10 (the last group truncated at `max_length`),
with `S` the smallest of 2, 5, 10, 20, 50, … such that `max_length - 9 <= 65 S`.
"""
function base_groups(max_length::Integer)
    L = Int(max_length)
    L <= 0 && return UnitRange{Int}[]
    L <= 75 && return [i:i for i in 1:L]
    k = 2
    while L - 9 > 65 * _series(k)
        k += 1
    end
    S = _series(k)
    groups = [i:i for i in 1:9]
    start = 10
    while start <= L
        stop = min(L, (start ÷ S + 1) * S - 1)
        push!(groups, start:stop)
        start = stop + 1
    end
    return groups
end

"""
    length_bins(min_length, max_length) -> (width, bins)

FastQC length-distribution bins: width `S`, the smallest of 1, 2, 5, 10, …
with `max - max(min, 1) <= 51 S - 3`; bins `[k S, (k+1) S - 1]` from
`floor(min / S) S` to the bin containing `max`.
"""
function length_bins(min_length::Integer, max_length::Integer)
    lo, hi = Int(min_length), Int(max_length)
    k = 1
    while hi - max(lo, 1) > 51 * _series(k) - 3
        k += 1
    end
    S = _series(k)
    first_bin = (lo ÷ S) * S
    return S, [b:(b + S - 1) for b in first_bin:S:hi]
end

_label(r::UnitRange) = length(r) == 1 ? string(first(r)) : string(first(r), "-", last(r))

# Checks that the metrics a table needs are present. Only the per-base modules
# need every position (`per_base = true`); encoding, per-sequence quality and
# basic statistics also use the bases pooled beyond `max_positions`, and the
# length distribution needs only ReadLength.
function _require(r::QCResult, names...; per_base::Bool = false)
    for n in names
        haskey(r.metrics, n) || throw(ArgumentError("FastQC-compatible output needs metric $(repr(n)); " *
                                                    "analyse with SeqQC.FastQC.metrics()"))
    end
    :per_position in names || return nothing
    p = r.metrics.per_position.per_position
    per_base && p.truncated &&
        throw(ArgumentError("FastQC-compatible per-base modules need max_positions >= the longest " *
                            "read ($(p.max_length)); analyse with a larger max_positions"))
    return p
end

# Smallest raw quality byte over all bases (from the per-position histograms).
function _min_raw_byte(p)
    h = vec(sum(p.raw_quality_histograms; dims = 2)) .+ p.beyond.raw_quality_histogram
    k = findfirst(>(0), h)
    return k === nothing ? nothing : k + 32
end

"""
    encoding(result) -> (offset, name)

FastQC's encoding guess: Phred+64 when the smallest quality byte is at least
64 (`@`), otherwise Phred+33. Names as printed by FastQC 0.12.1.
"""
function encoding(r::QCResult)
    p = _require(r, :per_position)
    b = _min_raw_byte(p)
    b === nothing && return (offset = 33, name = "Sanger / Illumina 1.9")
    b < 64 && return (offset = 33, name = "Sanger / Illumina 1.9")
    return (offset = 64, name = b == 65 ? "Illumina 1.3" : "Illumina 1.5")
end

"""
    per_base_quality(result) -> NamedTuple

FastQC "Per base sequence quality": for each position group, the unweighted
mean over its positions of the per-position mean Phred score, and for each
quantile the mean over positions with more than 100 bases of the per-position
quantile (rank `floor(p n)`), `NaN` when no position qualifies. Phred values use
FastQC's encoding guess ([`encoding`](@ref)).
"""
function per_base_quality(r::QCResult)
    p = _require(r, :per_position; per_base = true)
    offset = encoding(r).offset
    shift = 33 - offset
    groups = base_groups(p.max_length)
    np = length(POSITION_QUANTILES)
    mean = Float64[]
    quant = [Float64[] for _ in 1:np]
    for g in groups
        means = Float64[]
        qs = [Float64[] for _ in 1:np]
        for i in g
            h = view(p.raw_quality_histograms, :, i)
            n = sum(h)
            n == 0 && continue
            push!(means, sum((k - 1 + shift) * h[k] for k in eachindex(h)) / n)
            if n > 100
                for (j, pr) in enumerate(POSITION_QUANTILES)
                    push!(qs[j], _hist_quantile(h, n, pr, shift))
                end
            end
        end
        push!(mean, _seqmean(means))
        for j in 1:np
            push!(quant[j], _seqmean(qs[j]))
        end
    end
    return (base = _label.(groups), mean = mean, median = quant[3], lower_quartile = quant[2],
            upper_quartile = quant[4], percentile_10 = quant[1], percentile_90 = quant[5])
end

# Left-to-right sum: `sum` on a Float64 vector re-associates (SIMD blocks),
# which changes the last bits compared with FastQC's sequential sum.
_seqmean(x::Vector{Float64}) = isempty(x) ? NaN : foldl(+, x) / length(x)

_pooled(p, g, class) = sum(p.base_counts[class, i] for i in g; init = 0)

"""
    per_base_content(result) -> NamedTuple

FastQC "Per base sequence content": per position group, percentages of G, A, T
and C among the G/A/T/C bases of the group (pooled counts, case-insensitive;
N, U and IUPAC codes ignored; `NaN` when the group has none).
"""
function per_base_content(r::QCResult)
    p = _require(r, :per_position; per_base = true)
    groups = base_groups(p.max_length)
    cols = Dict(c => Float64[] for c in (:G, :A, :T, :C))
    for g in groups
        n = Dict(:G => _pooled(p, g, POS_G), :A => _pooled(p, g, POS_A),
                 :T => _pooled(p, g, POS_T), :C => _pooled(p, g, POS_C))
        tot = sum(values(n))
        for c in keys(cols)
            push!(cols[c], tot == 0 ? NaN : (n[c] / tot) * 100)     # FastQC's order of operations
        end
    end
    return (base = _label.(groups), G = cols[:G], A = cols[:A], T = cols[:T], C = cols[:C])
end

"""
    per_base_n(result) -> NamedTuple

FastQC "Per base N content": per position group, 100 × N / all bases of the
group (pooled).
"""
function per_base_n(r::QCResult)
    p = _require(r, :per_position; per_base = true)
    groups = base_groups(p.max_length)
    pct = Float64[]
    for g in groups
        tot = sum(sum(view(p.base_counts, :, i)) for i in g)
        push!(pct, tot == 0 ? NaN : (_pooled(p, g, POS_N) / tot) * 100)
    end
    return (base = _label.(groups), n_count = pct)
end

"""
    per_sequence_quality(result) -> NamedTuple

FastQC "Per sequence quality scores": number of reads by the integer part of
their mean Phred score (FastQC's encoding guess), from the lowest to the
highest observed value.
"""
function per_sequence_quality(r::QCResult)
    _require(r, :per_position, :quality)
    shift = encoding(r).offset - r.settings.phred_offset
    h = r.metrics.quality.read_quality_floor_histogram
    nz = findall(>(0), h.counts)
    isempty(nz) && return (quality = Int[], count = Int[])
    ks = first(nz):last(nz)
    return (quality = h.phred[ks] .- shift, count = h.counts[ks])
end

"""
    length_distribution(result) -> NamedTuple

FastQC "Sequence Length Distribution" with the bins of [`length_bins`](@ref).
Labels reproduce FastQC 0.12.1, whose last label ends at `max_length + 1`
when the bin is wider (a labelling quirk; counts are unaffected).
"""
function length_distribution(r::QCResult)
    _require(r, :read_length)
    rl = r.metrics.read_length
    rl.total_reads == 0 && return (length = String[], count = Int[])
    S, bins = length_bins(rl.min_length, rl.max_length)
    counts = zeros(Int, length(bins))
    for (L, c) in zip(rl.length_histogram.lengths, rl.length_histogram.counts)
        counts[(L - first(first(bins))) ÷ S + 1] += c
    end
    labels = map(bins) do b
        S == 1 ? string(first(b)) : string(first(b), "-", min(last(b), rl.max_length + 1))
    end
    return (length = labels, count = counts)
end

"""
    basic_statistics(result) -> NamedTuple

FastQC "Basic Statistics" values that SeqQC reproduces: encoding, total
sequences, total bases (exact count; FastQC prints a rounded value with
units), sequence length (`"min-max"` or `"L"`) and %GC — the integer part of
`100 (G+C)/(A+C+G+T)`, case-insensitive, with N, U and IUPAC codes ignored
(0 when there is no A/C/G/T, as FastQC prints).
"""
function basic_statistics(r::QCResult)
    p = _require(r, :per_position, :read_length)
    rl = r.metrics.read_length
    tot(c) = sum(view(p.base_counts, c, :)) + p.beyond.base_counts[c]
    a, c, g, t = tot(POS_A), tot(POS_C), tot(POS_G), tot(POS_T)
    gc = a + c + g + t == 0 ? 0 : (100 * (g + c)) ÷ (a + c + g + t)    # FastQC prints 0 without A/C/G/T
    len = rl.total_reads == 0 ? "" : rl.min_length == rl.max_length ? string(rl.max_length) :
          string(rl.min_length, "-", rl.max_length)
    return (encoding = encoding(r).name, total_sequences = rl.total_reads, total_bases = rl.total_bases,
            sequence_length = len, percent_gc = gc)
end

_flag(x, warn, fail) = x ? :fail : warn ? :warn : :pass

"""
    flags(result) -> NamedTuple

Pass/warn/fail for each supported module, with FastQC's documented default
thresholds (FastQC 0.12.1 help pages and `limits.txt`):

(The per-sequence GC flag is not reproduced: it depends on FastQC's fitted
normal distribution, which its text output does not contain.)

- per base quality: warn if any lower quartile < 10 or median < 25; fail if < 5 or < 20;
- per sequence quality: warn if the most frequent integer mean quality (lowest
  one on ties) is <= 27; fail if <= 20 — FastQC's behaviour; its help page says
  "below";
- per base content: warn if |A - T| or |G - C| > 10 in any group; fail if > 20
  (on the floating-point percentages, so e.g. 27.5 - 17.5 = 10.000000000000004 warns);
- per base N content: warn if any group > 5%; fail if > 20%;
- length distribution: warn if lengths differ; fail if any read has length 0.
"""
function flags(r::QCResult)
    q = per_base_quality(r)
    pq = _flag(any(<(5), q.lower_quartile) || any(<(20), q.median),
               any(<(10), q.lower_quartile) || any(<(25), q.median), false)
    sq = per_sequence_quality(r)
    mode = isempty(sq.count) ? nothing : sq.quality[argmax(sq.count)]
    psq = mode === nothing ? :pass : _flag(mode <= 20, mode <= 27, false)   # <=, not < (see docstring)
    c = per_base_content(r)
    d = [max(abs(c.A[i] - c.T[i]), abs(c.G[i] - c.C[i])) for i in eachindex(c.A)]
    pc = _flag(any(>(20), d), any(>(10), d), false)
    n = per_base_n(r)
    pn = _flag(any(>(20), n.n_count), any(>(5), n.n_count), false)
    rl = r.metrics.read_length
    sl = rl.total_reads == 0 ? :pass : _flag(rl.min_length == 0, rl.min_length != rl.max_length, false)
    return (basic_statistics = :pass, per_base_quality = pq, per_sequence_quality = psq,
            per_base_content = pc, per_base_n_content = pn, sequence_length_distribution = sl,
            adapter_content = _adapter_flag(r), overrepresented_sequences = _overrep_flag(r))
end

"""
    modules(result) -> NamedTuple

All supported FastQC-compatible modules and their flags.
"""
modules(r::QCResult) = (basic_statistics = basic_statistics(r), per_base_quality = per_base_quality(r),
                        per_sequence_quality = per_sequence_quality(r), per_base_content = per_base_content(r),
                        per_sequence_gc = haskey(r.metrics, :fastqc_gc) ? per_sequence_gc(r) : nothing,
                        per_base_n_content = per_base_n(r), sequence_length_distribution = length_distribution(r),
                        adapter_content = haskey(r.metrics, :fastqc_adapters) ? adapter_content(r) : nothing,
                        overrepresented_sequences = haskey(r.metrics, :fastqc_overrepresented) ? overrepresented(r) : nothing,
                        flags = flags(r))

include("fastqc_gc.jl")
include("fastqc_adapter.jl")
include("fastqc_overrep.jl")

end # module FastQC
