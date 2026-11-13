# Read representation and the per-read summary shared by all metrics.

# Base classes. Lower-case letters fold to upper case; U is counted with T.
const CLASS_A, CLASS_C, CLASS_G, CLASS_T, CLASS_N, CLASS_AMBIGUOUS, CLASS_INVALID = 1:7
const N_CLASSES = 7

const BASE_CLASS = let t = fill(UInt8(CLASS_INVALID), 256)
    for (chars, class) in (("Aa", CLASS_A), ("Cc", CLASS_C), ("Gg", CLASS_G),
                           ("TtUu", CLASS_T), ("Nn", CLASS_N),
                           ("RYSWKMBDHVryswkmbdhv", CLASS_AMBIGUOUS))
        for ch in chars
            t[UInt8(ch) + 1] = class
        end
    end
    t
end

# Packed counting: every byte adds 1 to an 8-bit lane of a UInt64 (one lane per
# class). A lane overflows after 255 additions, so the sequence is processed in
# chunks of at most 255 bytes and the lanes are unpacked after each chunk.
const CLASS_INCREMENT = UInt64[UInt64(1) << (8 * (c - 1)) for c in BASE_CLASS]
const PACK_CHUNK = 255

"""
    ReadSummary

Per-read quantities computed once by the engine and shared by all metrics
(read through `read.summary` in [`update!`](@ref)). The quality fields are
filled only when at least one metric declares `:quality` in its
[`requirements`](@ref); otherwise `error_sum` and `mean_error_q` are `NaN`,
`qsum` is 0 and `qmin`/`qmax` are `-1`. Fields:

- `length`: read length in bases;
- `a`, `c`, `g`, `t`, `n`: counts of A, C, G, T (U counted as T) and N, case-insensitive;
- `ambiguous`: IUPAC ambiguity codes other than N (`RYSWKMBDHV`);
- `invalid`: any other byte;
- `qsum`: sum of Phred scores (integer);
- `error_sum`: sum of base error probabilities `10^(-Q/10)`, computed exactly
  in fixed point (see `docs/METRICS.md`) and rounded once to `Float64`;
- `qmin`, `qmax`: smallest and largest Phred score (`-1` for an empty read);
- `mean_error_q`: per-read error-probability mean quality
  `-10 log10(error_sum / length)`, capped at $(126 - 33) and rounded to 6
  decimals (`NaN` for an empty read).
"""
mutable struct ReadSummary
    length::Int
    a::Int
    c::Int
    g::Int
    t::Int
    n::Int
    ambiguous::Int
    invalid::Int
    qsum::Int
    error_sum::Float64
    qmin::Int
    qmax::Int
    mean_error_q::Float64
end

ReadSummary() = ReadSummary(0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0, -1, -1, NaN)

"""
    ReadView

The view of one read passed to [`update!`](@ref). Fields:

- `seq`: sequence bytes (`AbstractVector{UInt8}`, valid only during the call);
- `qual`: raw quality bytes, still encoded with the Phred offset;
- `phred_offset`: the offset used to decode `qual`;
- `summary`: the [`ReadSummary`](@ref) of the read;
- `record`: the underlying `FASTX.FASTQ.Record` (reused between reads; copy it to keep it).

Metrics must not keep references to `seq`, `qual` or `record` after `update!` returns.
"""
struct ReadView{V<:AbstractVector{UInt8}}
    seq::V
    qual::V
    phred_offset::Int
    summary::ReadSummary
    record::FASTQ.Record
end

# Error probability for every Phred score that a printable byte can encode,
# tabulated in fixed point as an integer multiple of 2^-44. The Float64 table
# holds exactly the same values (integer < 2^53 divided by a power of two), so
# integer sums of ERROR_FIXED are the exact sums of ERROR_PROBABILITY values:
# order-independent and exactly mergeable. Quantisation: at most 2^-45 per base,
# i.e. a relative error < 3e-8 for Q <= 60 and < 6e-5 at Q93.
const MAX_PHRED = 126 - 33
const ERROR_SCALE_BITS = 44
const ERROR_FIXED = Int64[round(Int64, 10.0^(-q / 10) * 2.0^ERROR_SCALE_BITS) for q in 0:MAX_PHRED]
const ERROR_PROBABILITY = Float64[x / 2.0^ERROR_SCALE_BITS for x in ERROR_FIXED]
# Bytes per Int64 partial sum: 2^18 * 2^44 = 2^62 < typemax(Int64).
const ERROR_CHUNK = 1 << 18

# Exact fixed-point sum of the error probabilities of `qual` (Int128 for reads
# of any length).
function _error_sum_fixed(qual::AbstractVector{UInt8}, offset::Int)
    total = Int128(0)
    i = firstindex(qual)
    stop = lastindex(qual)
    @inbounds while i <= stop
        chunk_end = min(stop, i + ERROR_CHUNK - 1)
        acc = Int64(0)
        @simd for j in i:chunk_end
            acc += ERROR_FIXED[qual[j] - offset + 1]
        end
        total += acc
        i = chunk_end + 1
    end
    return total
end

@inline function _unpack!(totals::Vector{Int}, packed::UInt64)
    @inbounds for k in 1:N_CLASSES
        totals[k] += Int((packed >> (8 * (k - 1))) & 0xff)
    end
    return totals
end

# Fills `s` from the sequence and the raw quality bytes. Returns `true` when all
# quality bytes are valid for `offset` (offset <= byte <= '~'), `false` otherwise;
# the caller reports the error with the read position. With `with_quality =
# false` the quality string is neither read nor validated and the quality fields
# are set to their "absent" values (used when no metric requires quality).
function summarize!(s::ReadSummary, totals::Vector{Int}, seq::AbstractVector{UInt8},
                    qual::AbstractVector{UInt8}, offset::Int, with_quality::Bool = true)
    len = length(seq)
    s.length = len
    fill!(totals, 0)
    i = firstindex(seq)
    stop = lastindex(seq)
    @inbounds while i <= stop
        chunk_end = min(stop, i + PACK_CHUNK - 1)
        packed = UInt64(0)
        for j in i:chunk_end
            packed += CLASS_INCREMENT[seq[j] + 1]
        end
        _unpack!(totals, packed)
        i = chunk_end + 1
    end
    @inbounds begin
        s.a, s.c, s.g, s.t = totals[CLASS_A], totals[CLASS_C], totals[CLASS_G], totals[CLASS_T]
        s.n, s.ambiguous, s.invalid = totals[CLASS_N], totals[CLASS_AMBIGUOUS], totals[CLASS_INVALID]
    end

    if len == 0
        s.qsum, s.error_sum, s.qmin, s.qmax, s.mean_error_q = 0, 0.0, -1, -1, NaN
        return true
    elseif !with_quality
        s.qsum, s.error_sum, s.qmin, s.qmax, s.mean_error_q = 0, NaN, -1, -1, NaN
        return true
    end
    bytesum = 0
    lo = 0xff
    hi = 0x00
    @inbounds for b in qual
        bytesum += b
        lo = min(lo, b)
        hi = max(hi, b)
    end
    (lo < offset || hi > UInt8('~')) && return false
    errsum = Float64(_error_sum_fixed(qual, offset)) / 2.0^ERROR_SCALE_BITS
    s.qsum = bytesum - offset * len
    s.error_sum = errsum
    s.qmin = lo - offset
    s.qmax = hi - offset
    # Rounded to 6 decimals so that floating-point noise does not move a read
    # across a threshold or bin edge (all-Q10 bases must give exactly 10.0).
    # `round(x * 1e6) / 1e6` equals `round(x; digits = 6)` on [0, 93] (checked on
    # 3.9e8 values incl. halfway cases, 2026-11-12) and is several times faster.
    s.mean_error_q = round(min(-10 * log10(errsum / len), Float64(MAX_PHRED)) * 1e6) / 1e6
    return true
end
