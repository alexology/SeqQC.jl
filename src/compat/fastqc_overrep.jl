# FastQC "Overrepresented sequences" (inside module SeqQC.FastQC).
#
# Rules determined by black-box experiments on FastQC 0.12.1 (docs/FASTQC.md):
# - key: the first 50 bases of each read, upper-cased (N kept);
# - a new key is tracked only while fewer than 100,000 distinct keys are
#   tracked; tracked keys are counted to the end of the file;
# - reported: keys with (count / reads) * 100 > 0.1, in the iteration order of a
#   java.util.HashMap holding all tracked keys (String.hashCode, spread
#   h ^ (h >>> 16), default capacity growth, insertion order within a bucket),
#   then stably sorted by decreasing count;
# - flags: warn if any is reported, fail if any percentage > 1;
# - possible source (needs a contaminant list): on each diagonal of the
#   sequence (and of its reverse complement) against each contaminant, scan
#   left to right; at the second mismatch close the window (its length runs
#   to the last matching base, the window keeps one mismatch in its count) and
#   restart after that mismatch with no mismatch; the last window of a
#   diagonal also ends at its last matching base; windows need >= min(20,
#   length of the sequence) matching bases; sequences under 8 bases are
#   never searched ("No Hit"); the longest window wins, then the one with more matches, then the
#   first contaminant in the list; identity = floor(100 * matches / length).

const OVERREP_KEY_LENGTH = 50
const OVERREP_MAX_DISTINCT = 100_000

"""
    read_contaminants(path) -> Vector{Pair{String,String}}

Read a FastQC-style contaminant list (one `name<TAB...>sequence` per line, `#`
comments). SeqQC does not ship FastQC's list; pass e.g.
`"<FastQC dir>/Configuration/contaminant_list.txt"`.
"""
function read_contaminants(path::AbstractString)
    out = Pair{String,String}[]
    for line in eachline(path)
        s = strip(line)
        (isempty(s) || startswith(s, "#")) && continue
        parts = [strip(p) for p in split(line, '\t') if !isempty(strip(p))]
        length(parts) >= 2 || throw(ArgumentError("$(path): cannot parse contaminant line $(repr(line))"))
        push!(out, String(parts[1]) => uppercase(String(parts[end])))
    end
    return out
end

"""
    Overrepresented(; contaminants = nothing)

Metric for FastQC's overrepresented sequences (rules above and in
`docs/FASTQC.md`). `contaminants`: `nothing` (no "Possible Source"), a path to
a FastQC-style list, or a vector of `name => sequence`. Not mergeable: which
sequences are tracked depends on the order of the reads.
"""
struct Overrepresented <: AbstractQCMetric
    contaminants::Union{Nothing,Vector{Pair{String,String}}}
end

Overrepresented(; contaminants = nothing) = Overrepresented(
    contaminants === nothing ? nothing :
    contaminants isa AbstractString ? read_contaminants(contaminants) :
    [String(first(c)) => uppercase(String(last(c))) for c in contaminants])

mutable struct OverrepState
    contaminants::Union{Nothing,Vector{Pair{String,String}}}
    index::Dict{String,Int}       # key -> position in keys/counts (insertion order)
    keys::Vector{String}
    counts::Vector{Int}
    reads::Int
    buf::Vector{UInt8}
end

SeqQC.metric_name(::Overrepresented) = :fastqc_overrepresented
SeqQC.requirements(::Overrepresented) = (:sequence,)
SeqQC.memory_complexity(::Overrepresented) = :bounded_100k_keys
SeqQC.definition(::Overrepresented) = "FastQC 0.12.1 overrepresented sequences: first 50 bases upper-cased, at most " *
    "100,000 distinct sequences tracked, reported above 0.1% of reads."
SeqQC.init_state(m::Overrepresented) =
    OverrepState(m.contaminants, Dict{String,Int}(), String[], Int[], 0, UInt8[])

function SeqQC.update!(st::OverrepState, read::SeqQC.ReadView)
    seq = read.seq
    n = min(length(seq), OVERREP_KEY_LENGTH)
    resize!(st.buf, n)
    @inbounds for i in 1:n
        b = seq[i]
        st.buf[i] = UInt8('a') <= b <= UInt8('z') ? b - 0x20 : b
    end
    st.reads += 1
    key = String(copy(st.buf))
    k = get(st.index, key, 0)
    if k > 0
        @inbounds st.counts[k] += 1
    elseif length(st.keys) < OVERREP_MAX_DISTINCT
        push!(st.keys, key)
        push!(st.counts, 1)
        st.index[key] = length(st.keys)
    end
    return st
end

Base.merge!(::OverrepState, ::OverrepState) =
    throw(ArgumentError("Overrepresented states cannot be merged exactly: the sequences FastQC tracks depend on read order"))

# java.lang.String.hashCode (ASCII keys) and HashMap bucket order
function _java_hash(s::String)
    h = Int32(0)
    for b in codeunits(s)
        h = Int32(31) * h + Int32(b)
    end
    return reinterpret(UInt32, h)
end
_java_spread(h::UInt32) = h ⊻ (h >> 16)
function _java_capacity(n::Int)
    cap = 16
    while n > 0.75 * cap
        cap *= 2
    end
    return cap
end

const _RC = let t = collect(UInt8, 0:255)
    for (a, b) in zip("ACGTNacgtn", "TGCANtgcan")
        t[UInt8(a) + 1] = UInt8(b)
    end
    t
end
_revcomp(s::String) = String([_RC[b + 1] for b in reverse(codeunits(s))])

# Best window of `q` against `c` (all diagonals): (length, matches) or (0, 0).
function _best_window(q::AbstractVector{UInt8}, c::AbstractVector{UInt8})
    bestL, bestM = 0, 0
    nq, nc = length(q), length(c)
    need = min(20, nq)                       # sequences shorter than 20 need a full exact match
    for off in -(nq - 1):(nc - 1)
        lo = max(1, 1 - off)
        hi = min(nq, nc - off)
        start = lo
        mm = 0
        lastmatch = lo - 1
        for i in lo:hi
            if q[i] != c[i + off]
                mm += 1
                if mm > 1
                    L = lastmatch - start + 1
                    M = L - 1
                    if M >= need && (L > bestL || (L == bestL && M > bestM))
                        bestL, bestM = L, M
                    end
                    start = i + 1
                    mm = 0
                    lastmatch = i
                end
            else
                lastmatch = i
            end
        end
        # last window: its length also stops at the last matching base, while a
        # trailing mismatch stays in the count (as when a window is closed)
        L = lastmatch - start + 1
        M = L - mm
        if L > 0 && M >= need && (L > bestL || (L == bestL && M > bestM))
            bestL, bestM = L, M
        end
    end
    return bestL, bestM
end

function _possible_source(seq::String, contaminants)
    contaminants === nothing && return nothing
    length(seq) < 8 && return "No Hit"           # FastQC 0.12.1 does not search sequences under 8 bases
    q = codeunits(seq)
    qr = codeunits(_revcomp(seq))
    best = nothing
    bL, bM = 0, 0
    for (name, cseq) in contaminants
        c = codeunits(cseq)
        for qq in (q, qr)
            L, M = _best_window(qq, c)
            if L > 0 && (L > bL || (L == bL && M > bM))
                bL, bM, best = L, M, name
            end
        end
    end
    best === nothing && return "No Hit"
    return string(best, " (", (100 * bM) ÷ bL, "% over ", bL, "bp)")
end

function SeqQC.finalize_metric(st::OverrepState)
    cap = _java_capacity(length(st.keys))
    rows = [k for k in eachindex(st.keys) if (st.counts[k] / st.reads) * 100 > 0.1]
    # HashMap iteration order (bucket, then insertion), then stable sort by count
    sort!(rows; by = k -> (_java_spread(_java_hash(st.keys[k])) & UInt32(cap - 1), k))
    sort!(rows; by = k -> -st.counts[k], alg = MergeSort)
    seqs = st.keys[rows]
    return (fastqc_overrepresented = (sequence = seqs, count = st.counts[rows],
                                      percentage = [(c / st.reads) * 100 for c in st.counts[rows]],
                                      possible_source = st.contaminants === nothing ? nothing :
                                                        [_possible_source(s, st.contaminants) for s in seqs],
                                      reads = st.reads, tracked = length(st.keys),
                                      contaminant_list = st.contaminants !== nothing),)
end

"""
    overrepresented(result) -> NamedTuple

FastQC "Overrepresented sequences": `sequence`, `count`, `percentage` and
`possible_source` (`nothing` when the analysis had no contaminant list).
Requires the [`Overrepresented`](@ref) metric.
"""
function overrepresented(r::QCResult)
    haskey(r.metrics, :fastqc_overrepresented) ||
        throw(ArgumentError("overrepresented needs the FastQC.Overrepresented metric; analyse with SeqQC.FastQC.metrics()"))
    o = r.metrics.fastqc_overrepresented.fastqc_overrepresented
    return (sequence = o.sequence, count = o.count, percentage = o.percentage, possible_source = o.possible_source)
end

function _overrep_flag(r::QCResult)
    haskey(r.metrics, :fastqc_overrepresented) || return nothing
    p = overrepresented(r).percentage
    return isempty(p) ? :pass : _flag(any(>(1), p), true, false)
end
