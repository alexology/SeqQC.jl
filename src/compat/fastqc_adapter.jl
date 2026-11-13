# FastQC "Adapter Content" (inside module SeqQC.FastQC).
#
# Rules determined by black-box experiments on FastQC 0.12.1 (docs/FASTQC.md):
# - an adapter is found where its sequence occurs exactly (case-insensitive) in
#   a read; only the first occurrence counts, at its start position;
# - the value at position p is 100 * (reads with an occurrence starting at or
#   before p) / (all reads), computed as (100 n) / total (the other modules use
#   (n / total) * 100), i.e. cumulative and over every read;
# - positions 1 .. max_length - 11 are reported, grouped with
#   base_groups(max_length - 11); a group's value is the mean of its positions;
# - reads are searched only once a read longer than the adapter has been seen
#   (a 12-base read equal to the adapter counts only if an earlier read had more
#   than 12 bases): an order effect inside FastQC;
# - flags: warn if any value > 5, fail if > 10; an empty table (no read of at
#   least 12 bases) is flagged warn.

"""
Default adapter list of FastQC 0.12.1 (`Configuration/adapter_list.txt`).
"""
const DEFAULT_ADAPTERS = [
    "Illumina Universal Adapter" => "AGATCGGAAGAG",
    "Illumina Small RNA 3' Adapter" => "TGGAATTCTCGG",
    "Illumina Small RNA 5' Adapter" => "GATCGTCGGACT",
    "Nextera Transposase Sequence" => "CTGTCTCTTATA",
    "PolyA" => "AAAAAAAAAAAA",
    "PolyG" => "GGGGGGGGGGGG",
]

"""
    AdapterContent(; adapters = DEFAULT_ADAPTERS, max_positions = 100_000)

Metric for FastQC's adapter content: for each adapter (name => sequence of
A/C/G/T, at most 32 bases), the start position of its first exact,
case-insensitive occurrence in every read. The table reports positions
1 .. max_length - 11 as FastQC does with its default 12-base adapters; for
custom adapters of another length this row count was not compared with FastQC. Occurrences starting beyond
`max_positions` are pooled and make the per-position table unavailable. As in
FastQC, reads are only searched once a read longer than the adapter has been
seen, so merging states of separate chunks can differ from one pass for reads
of exactly the adapter's length at the start of a chunk.
Cost per base is constant (2-bit rolling k-mer codes and a lookup table).
"""
struct AdapterContent <: AbstractQCMetric
    names::Vector{String}
    seqs::Vector{String}
    max_positions::Int
    function AdapterContent(adapters, max_positions::Integer)
        names = [String(first(a)) for a in adapters]
        seqs = [uppercase(String(last(a))) for a in adapters]
        allunique(names) || throw(ArgumentError("adapter names must be unique"))
        for s in seqs
            1 <= length(s) <= 32 && all(in("ACGT"), s) ||
                throw(ArgumentError("adapter sequences must be 1-32 bases of A/C/G/T, got $(repr(s))"))
        end
        max_positions >= 1 || throw(ArgumentError("max_positions must be >= 1"))
        return new(names, seqs, Int(max_positions))
    end
end

AdapterContent(; adapters = DEFAULT_ADAPTERS, max_positions::Integer = 100_000) =
    AdapterContent(adapters, max_positions)

const _CODE2 = let t = fill(0xff, 256)
    for (ch, v) in zip("ACGTacgt", (0, 1, 2, 3, 0, 1, 2, 3))
        t[UInt8(ch) + 1] = UInt8(v)
    end
    t
end

_kmer_code(s::AbstractString) = foldl((acc, ch) -> (acc << 2) | UInt64(_CODE2[UInt8(ch) + 1]), s; init = UInt64(0))

# Prefilter: one bit per value of a 24-bit mix of the k-mer code; the Dict is
# consulted only when the bit is set (almost never for real reads).
const _FILTER_BITS = 1 << 24
@inline _filter_index(code::UInt64) = Int((code ⊻ (code >> 24) ⊻ (code >> 48)) & UInt64(_FILTER_BITS - 1))

mutable struct AdapterState
    names::Vector{String}
    max_positions::Int
    lengths::Vector{Int}                         # distinct adapter lengths
    lookup::Vector{Dict{UInt64,Vector{Int}}}     # per length: code -> adapter indices
    filters::Vector{Vector{UInt64}}              # per length: 2^24-bit prefilter of codes
    starts::Matrix{Int}                          # adapter × position: first-occurrence starts
    beyond::Vector{Int}                          # starts beyond max_positions
    found::Vector{Int}                           # scratch: first start per adapter in this read
    reads::Int
    max_length::Int
end

SeqQC.metric_name(::AdapterContent) = :fastqc_adapters
SeqQC.requirements(::AdapterContent) = (:sequence,)
SeqQC.memory_complexity(::AdapterContent) = :bounded_positions
SeqQC.definition(::AdapterContent) = "FastQC 0.12.1 adapter content: first exact case-insensitive occurrence of each " *
    "adapter per read; value at position p = 100 * reads with an occurrence starting <= p / all reads."

function SeqQC.init_state(m::AdapterContent)
    lens = sort!(unique(length.(m.seqs)))
    lookup = [Dict{UInt64,Vector{Int}}() for _ in lens]
    for (i, s) in enumerate(m.seqs)
        k = findfirst(==(length(s)), lens)
        push!(get!(Vector{Int}, lookup[k], _kmer_code(s)), i)
    end
    filters = [zeros(UInt64, _FILTER_BITS ÷ 64) for _ in lens]
    for (li, d) in enumerate(lookup), code in keys(d)
        h = _filter_index(code)
        filters[li][h >> 6 + 1] |= UInt64(1) << (h & 63)
    end
    na = length(m.seqs)
    return AdapterState(copy(m.names), m.max_positions, lens, lookup, filters, zeros(Int, na, 0), zeros(Int, na),
                        zeros(Int, na), 0, 0)
end

function _grow_adapter!(st::AdapterState, len::Int)
    n = min(st.max_positions, max(len, 2 * size(st.starts, 2), 64))
    n <= size(st.starts, 2) && return st
    s = zeros(Int, size(st.starts, 1), n)
    s[:, 1:size(st.starts, 2)] .= st.starts
    st.starts = s
    return st
end

function SeqQC.update!(st::AdapterState, read::SeqQC.ReadView)
    seq = read.seq
    len = length(seq)
    st.reads += 1
    len > st.max_length && (st.max_length = len)
    longest = st.max_length                          # longest read so far, this one included
    fill!(st.found, 0)
    nfound = 0
    na = length(st.found)
    for (li, k) in enumerate(st.lengths)
        # FastQC only searches once a read longer than the adapter has been seen
        # (a read of exactly the adapter's length counts only after such a read)
        (len < k || longest <= k) && continue
        mask = k == 32 ? typemax(UInt64) : (UInt64(1) << (2k)) - 1
        dict = st.lookup[li]
        filt = st.filters[li]
        code = UInt64(0)
        valid = 0                                # consecutive A/C/G/T bases ending here
        @inbounds for i in 1:len
            v = _CODE2[seq[i] + 1]
            if v == 0xff
                valid = 0
                code = UInt64(0)
                continue
            end
            code = ((code << 2) | v) & mask
            valid += 1
            if valid >= k
                h = _filter_index(code)
                (filt[h >> 6 + 1] >> (h & 63)) & 1 == 0 && continue
                hits = get(dict, code, nothing)
                hits === nothing && continue
                for a in hits
                    if st.found[a] == 0
                        st.found[a] = i - k + 1
                        nfound += 1
                    end
                end
                nfound == na && break
            end
        end
    end
    for a in 1:na
        p = st.found[a]
        p == 0 && continue
        if p <= st.max_positions
            p > size(st.starts, 2) && _grow_adapter!(st, p)
            @inbounds st.starts[a, p] += 1
        else
            st.beyond[a] += 1
        end
    end
    return st
end

function Base.merge!(dst::AdapterState, src::AdapterState)
    dst.names == src.names || throw(ArgumentError("cannot merge adapter states with different adapters"))
    size(src.starts, 2) > size(dst.starts, 2) && _grow_adapter!(dst, size(src.starts, 2))
    view(dst.starts, :, 1:size(src.starts, 2)) .+= src.starts
    dst.beyond .+= src.beyond
    dst.reads += src.reads
    dst.max_length = max(dst.max_length, src.max_length)
    return dst
end

SeqQC.finalize_metric(st::AdapterState) =
    (fastqc_adapters = (names = copy(st.names), reads = st.reads, max_length = st.max_length,
                        first_occurrence_starts = copy(st.starts), beyond = copy(st.beyond),
                        max_positions = st.max_positions),)

"""
    adapter_content(result) -> NamedTuple

FastQC "Adapter Content": `position` labels (groups of
`base_groups(max_length - 11)`) and, for each adapter, the percentage of all
reads with an occurrence starting at or before each position (group means).
Requires the [`AdapterContent`](@ref) metric (included in [`metrics`](@ref)).
"""
function adapter_content(r::QCResult)
    haskey(r.metrics, :fastqc_adapters) ||
        throw(ArgumentError("adapter_content needs the FastQC.AdapterContent metric; analyse with SeqQC.FastQC.metrics()"))
    a = r.metrics.fastqc_adapters.fastqc_adapters
    L = a.max_length - 11
    if L > a.max_positions || any(>(0), a.beyond)
        throw(ArgumentError("FastQC-compatible adapter content needs max_positions >= $(L) (longest read $(a.max_length))"))
    end
    groups = base_groups(max(L, 0))
    cols = Vector{Vector{Float64}}()
    for i in eachindex(a.names)
        cum = zeros(Int, max(L, 0))
        acc = 0
        for p in 1:max(L, 0)
            acc += p <= size(a.first_occurrence_starts, 2) ? a.first_occurrence_starts[i, p] : 0
            cum[p] = acc
        end
        pct = [100 * c / a.reads for c in cum]       # 100n/total: FastQC's order here (unlike content)
        push!(cols, [_seqmean([pct[p] for p in g]) for g in groups])
    end
    return (position = _label.(groups), names = copy(a.names), values = cols)
end

function _adapter_flag(r::QCResult)
    haskey(r.metrics, :fastqc_adapters) || return nothing
    t = adapter_content(r)
    isempty(t.position) && return :warn
    m = maximum(maximum(v) for v in t.values)
    return _flag(m > 10, m > 5, false)
end
