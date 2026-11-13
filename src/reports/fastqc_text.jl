# FastQC-format text outputs (fastqc_data.txt, summary.txt) built from the
# SeqQC.FastQC tables. Layout and number formatting follow FastQC 0.12.1
# (docs/src/FASTQC.md). Modules SeqQC does not compute (Per tile sequence quality,
# Sequence Duplication Levels) are not written; the Per sequence GC content
# flag, which SeqQC does not reproduce, is written as "NA".

# java.lang.Double.toString (JDK 19+: shortest round-trip digits): decimal
# notation for 1e-3 <= |x| < 1e7 with at least one fractional digit,
# otherwise d.ddd...E<exp>.
function _jdouble(x::Real)
    x = Float64(x)
    isnan(x) && return "NaN"
    isinf(x) && return x > 0 ? "Infinity" : "-Infinity"
    x == 0 && return signbit(x) ? "-0.0" : "0.0"
    neg = x < 0
    s = repr(abs(x))                                 # shortest digits (Ryu)
    # decompose into digit string and decimal exponent: value = 0.d1d2... × 10^e
    if occursin('e', s)
        m, e = split(s, 'e')
        mi, mf = occursin('.', m) ? split(m, '.') : (m, "")
        digits = mi * mf
        exp10 = parse(Int, e) + length(mi)
    else
        mi, mf = split(s, '.')
        digits = mi * mf
        exp10 = length(mi)
    end
    nz = findfirst(!=('0'), digits)                  # strip leading zeros
    nz === nothing && return neg ? "-0.0" : "0.0"   # unreachable: x != 0 was checked above
    exp10 -= nz - 1
    digits = rstrip(digits[nz:end], '0')
    isempty(digits) && (digits = "0")
    a = abs(x)
    if 1e-3 <= a < 1e7
        if exp10 <= 0
            out = "0." * "0"^(-exp10) * digits
        elseif exp10 >= length(digits)
            out = digits * "0"^(exp10 - length(digits)) * ".0"
        else
            out = digits[1:exp10] * "." * digits[exp10+1:end]
        end
    else
        frac = length(digits) > 1 ? digits[2:end] : "0"
        out = string(digits[1], ".", frac, "E", exp10 - 1)
    end
    return neg ? "-" * out : out
end

# "Total Bases" as FastQC prints it: one decimal, truncated, trailing ".0" dropped.
function _fastqc_bases(n::Integer)
    n < 1000 && return string(n, " bp")
    unit, div = n < 10^6 ? ("kbp", 10^3) : n < 10^9 ? ("Mbp", 10^6) : ("Gbp", 10^9)
    tenths = n ÷ (div ÷ 10)
    whole, frac = divrem(tenths, 10)
    return frac == 0 ? string(whole, " ", unit) : string(whole, ".", frac, " ", unit)
end

const _FASTQC_MODULE_NAMES = (basic_statistics = "Basic Statistics", per_base_quality = "Per base sequence quality",
    per_sequence_quality = "Per sequence quality scores", per_base_content = "Per base sequence content",
    per_sequence_gc = "Per sequence GC content", per_base_n_content = "Per base N content",
    sequence_length_distribution = "Sequence Length Distribution",
    overrepresented_sequences = "Overrepresented sequences", adapter_content = "Adapter Content")

_status(f) = f === nothing ? "NA" : string(f)

"""
    write_fastqc_data(io_or_path, result; filename = basename(result.input.path), fastqc_header = false)

Write the FastQC-compatible modules of `result` in the layout of FastQC's
`fastqc_data.txt` (requires the metrics of `SeqQC.FastQC.metrics()`). The
first line identifies SeqQC; `fastqc_header = true` writes `##FastQC	0.12.1`
instead, for tools that only accept that header. Modules SeqQC does not
compute are absent; the per-sequence GC flag is `NA`.
"""
function write_fastqc_data(io::IO, r::QCResult; filename::AbstractString = basename(r.input.path),
                           fastqc_header::Bool = false)
    F = FastQC
    m = F.modules(r)
    fl = m.flags
    println(io, fastqc_header ? "##FastQC\t0.12.1" : "##SeqQC\t$(VERSION_STRING)\tFastQC 0.12.1-compatible modules")
    mod(name, flag) = println(io, ">>", name, "\t", _status(flag))
    endm() = println(io, ">>END_MODULE")
    row(xs...) = println(io, join(xs, '\t'))

    b = m.basic_statistics
    mod("Basic Statistics", fl.basic_statistics)
    row("#Measure", "Value")
    row("Filename", filename)
    row("File type", "Conventional base calls")
    row("Encoding", b.encoding)
    row("Total Sequences", b.total_sequences)
    row("Total Bases", _fastqc_bases(b.total_bases))
    row("Sequences flagged as poor quality", 0)
    row("Sequence length", b.sequence_length)
    row("%GC", b.percent_gc)
    endm()

    q = m.per_base_quality
    mod("Per base sequence quality", fl.per_base_quality)
    row("#Base", "Mean", "Median", "Lower Quartile", "Upper Quartile", "10th Percentile", "90th Percentile")
    for i in eachindex(q.base)
        row(q.base[i], _jdouble(q.mean[i]), _jdouble(q.median[i]), _jdouble(q.lower_quartile[i]),
            _jdouble(q.upper_quartile[i]), _jdouble(q.percentile_10[i]), _jdouble(q.percentile_90[i]))
    end
    endm()

    s = m.per_sequence_quality
    mod("Per sequence quality scores", fl.per_sequence_quality)
    row("#Quality", "Count")
    for i in eachindex(s.quality)
        row(s.quality[i], _jdouble(s.count[i]))
    end
    endm()

    c = m.per_base_content
    mod("Per base sequence content", fl.per_base_content)
    row("#Base", "G", "A", "T", "C")
    for i in eachindex(c.base)
        row(c.base[i], _jdouble(c.G[i]), _jdouble(c.A[i]), _jdouble(c.T[i]), _jdouble(c.C[i]))
    end
    endm()

    if m.per_sequence_gc !== nothing
        g = m.per_sequence_gc
        mod("Per sequence GC content", nothing)
        row("#GC Content", "Count")
        for i in eachindex(g.gc_content)
            row(g.gc_content[i], _jdouble(g.count[i]))
        end
        endm()
    end

    n = m.per_base_n_content
    mod("Per base N content", fl.per_base_n_content)
    row("#Base", "N-Count")
    for i in eachindex(n.base)
        row(n.base[i], _jdouble(n.n_count[i]))
    end
    endm()

    l = m.sequence_length_distribution
    mod("Sequence Length Distribution", fl.sequence_length_distribution)
    row("#Length", "Count")
    for i in eachindex(l.length)
        row(l.length[i], _jdouble(l.count[i]))
    end
    endm()

    if m.overrepresented_sequences !== nothing
        o = m.overrepresented_sequences
        mod("Overrepresented sequences", fl.overrepresented_sequences)
        if !isempty(o.sequence)
            row("#Sequence", "Count", "Percentage", "Possible Source")
            for i in eachindex(o.sequence)
                row(o.sequence[i], o.count[i], _jdouble(o.percentage[i]),
                    o.possible_source === nothing ? "Not computed (no contaminant list)" : o.possible_source[i])
            end
        end
        endm()
    end

    if m.adapter_content !== nothing
        a = m.adapter_content
        mod("Adapter Content", fl.adapter_content)
        isempty(a.position) || row("#Position", a.names...)        # FastQC omits the header of an empty table
        for i in eachindex(a.position)
            row(a.position[i], (_jdouble(v[i]) for v in a.values)...)
        end
        endm()
    end
    return nothing
end

write_fastqc_data(path::AbstractString, r::QCResult; kwargs...) =
    _atomic_write(io -> write_fastqc_data(io, r; kwargs...), path)

"""
    write_fastqc_summary(io_or_path, result; filename = basename(result.input.path))

FastQC-style `summary.txt`: one line `STATUS<TAB>module<TAB>filename` per
module written by [`write_fastqc_data`](@ref) (`NA` for the per-sequence GC
flag).
"""
function write_fastqc_summary(io::IO, r::QCResult; filename::AbstractString = basename(r.input.path))
    m = FastQC.modules(r)
    fl = m.flags
    for (k, name) in pairs(_FASTQC_MODULE_NAMES)
        k === :per_sequence_gc && m.per_sequence_gc === nothing && continue
        k === :overrepresented_sequences && m.overrepresented_sequences === nothing && continue
        k === :adapter_content && m.adapter_content === nothing && continue
        f = k === :per_sequence_gc ? nothing : fl[k]
        println(io, uppercase(_status(f)), "\t", name, "\t", filename)
    end
    return nothing
end

write_fastqc_summary(path::AbstractString, r::QCResult; kwargs...) =
    _atomic_write(io -> write_fastqc_summary(io, r; kwargs...), path)
