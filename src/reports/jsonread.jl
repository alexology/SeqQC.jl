# Minimal strict JSON reader (RFC 8259) for SeqQC's own documents.
# Objects -> Dict{String,Any}, arrays -> Vector{Any}, integers -> Int (Float64
# when out of Int range), other numbers -> Float64, null -> nothing.

struct JSONParseError <: Exception
    msg::String
    pos::Int
end
Base.showerror(io::IO, e::JSONParseError) = print(io, "JSONParseError at byte ", e.pos, ": ", e.msg)

mutable struct _JSONReader
    str::String                         # the document
    s::Base.CodeUnits{UInt8,String}     # its bytes (no copy)
    i::Int
end
_JSONReader(str::String) = _JSONReader(str, codeunits(str), 1)

_jerr(r, msg) = throw(JSONParseError(msg, r.i))
@inline _peek(r::_JSONReader) = r.i <= length(r.s) ? r.s[r.i] : 0x00

function _skipws(r::_JSONReader)
    while r.i <= length(r.s) && r.s[r.i] in (0x20, 0x09, 0x0a, 0x0d)
        r.i += 1
    end
end

function _expect(r::_JSONReader, lit::String)
    n = ncodeunits(lit)
    (r.i + n - 1 <= length(r.s) && view(r.s, r.i:r.i+n-1) == codeunits(lit)) || _jerr(r, "expected $(lit)")
    r.i += n
end

function _value(r::_JSONReader)
    _skipws(r)
    c = _peek(r)
    c == UInt8('{') && return _object(r)
    c == UInt8('[') && return _array(r)
    c == UInt8('"') && return _string(r)
    c == UInt8('t') && (_expect(r, "true"); return true)
    c == UInt8('f') && (_expect(r, "false"); return false)
    c == UInt8('n') && (_expect(r, "null"); return nothing)
    (c == UInt8('-') || UInt8('0') <= c <= UInt8('9')) && return _number(r)
    _jerr(r, c == 0x00 ? "unexpected end of input" : "unexpected character $(repr(Char(c)))")
end

function _object(r::_JSONReader)
    r.i += 1
    d = Dict{String,Any}()
    _skipws(r)
    _peek(r) == UInt8('}') && (r.i += 1; return d)
    while true
        _skipws(r)
        _peek(r) == UInt8('"') || _jerr(r, "expected a string key")
        k = _string(r)
        _skipws(r)
        _peek(r) == UInt8(':') || _jerr(r, "expected ':'")
        r.i += 1
        d[k] = _value(r)
        _skipws(r)
        c = _peek(r)
        r.i += 1
        c == UInt8('}') && return d
        c == UInt8(',') || (r.i -= 1; _jerr(r, "expected ',' or '}'"))
    end
end

@inline _isnumstart(c::UInt8) = c == UInt8('-') || UInt8('0') <= c <= UInt8('9')

# Separator after an element: true at ']' (consumed), false at ',' (consumed).
@inline function _array_sep(r::_JSONReader)
    _skipws(r)
    c = _peek(r)
    r.i += 1
    c == UInt8(']') && return true
    c == UInt8(',') || (r.i -= 1; _jerr(r, "expected ',' or ']'"))
    return false
end

function _array(r::_JSONReader)
    r.i += 1
    _skipws(r)
    _peek(r) == UInt8(']') && (r.i += 1; return Any[])
    # Typed fast path for numeric arrays (histograms, per-position values):
    # Vector{Int} while all elements are integers, Vector{Float64} once a
    # non-integer appears; any other element falls back to Vector{Any}.
    if _isnumstart(_peek(r))
        ints = Int[]
        floats = Float64[]
        isfloat = false
        while true
            x = _number(r)
            if !isfloat && x isa Int
                push!(ints, x)
            else
                if !isfloat
                    append!(floats, ints)
                    isfloat = true
                end
                push!(floats, Float64(x))
            end
            _array_sep(r) && return isfloat ? floats : ints
            _skipws(r)
            if !_isnumstart(_peek(r))                     # mixed array: continue untyped
                v = Any[(isfloat ? floats : ints)...]
                while true
                    push!(v, _value(r))
                    _array_sep(r) && return v
                end
            end
        end
    end
    v = Any[]
    while true
        push!(v, _value(r))
        _array_sep(r) && return v
    end
end

function _hex4(r::_JSONReader)
    r.i + 3 <= length(r.s) || _jerr(r, "truncated \\u escape")
    x = tryparse(UInt16, GC.@preserve(r, unsafe_string(pointer(r.str, r.i), 4)); base = 16)
    x === nothing && _jerr(r, "invalid \\u escape")
    r.i += 4
    return x
end

function _string(r::_JSONReader)
    r.i += 1
    # fast path: no escape before the closing quote
    j = r.i
    s = r.s
    @inbounds while j <= length(s) && s[j] != UInt8('"') && s[j] != UInt8('\\') && s[j] >= 0x20
        j += 1
    end
    if j <= length(s) && s[j] == UInt8('"')
        out = GC.@preserve r unsafe_string(pointer(r.str, r.i), j - r.i)   # plain byte copy
        r.i = j + 1
        return out
    end
    io = IOBuffer()
    while true
        r.i <= length(r.s) || _jerr(r, "unterminated string")
        c = r.s[r.i]
        if c == UInt8('"')
            r.i += 1
            return String(take!(io))
        elseif c == UInt8('\\')
            r.i += 1
            e = _peek(r)
            r.i += 1
            if e == UInt8('u')
                u = _hex4(r)
                if 0xd800 <= u <= 0xdbff                       # surrogate pair
                    (_peek(r) == UInt8('\\') && r.i + 1 <= length(r.s) && r.s[r.i+1] == UInt8('u')) ||
                        _jerr(r, "unpaired surrogate")
                    r.i += 2
                    lo = _hex4(r)
                    0xdc00 <= lo <= 0xdfff || _jerr(r, "invalid low surrogate")
                    print(io, Char(0x10000 + ((UInt32(u) - 0xd800) << 10) + (UInt32(lo) - 0xdc00)))
                elseif 0xdc00 <= u <= 0xdfff
                    _jerr(r, "unpaired surrogate")
                else
                    print(io, Char(u))
                end
            else
                ch = e == UInt8('"') ? '"' : e == UInt8('\\') ? '\\' : e == UInt8('/') ? '/' :
                     e == UInt8('b') ? '\b' : e == UInt8('f') ? '\f' : e == UInt8('n') ? '\n' :
                     e == UInt8('r') ? '\r' : e == UInt8('t') ? '\t' : _jerr(r, "invalid escape")
                print(io, ch)
            end
        elseif c < 0x20
            _jerr(r, "control character in string")
        else
            write(io, c)
            r.i += 1
        end
    end
end

function _number(r::_JSONReader)
    start = r.i
    _peek(r) == UInt8('-') && (r.i += 1)
    if _peek(r) == UInt8('0')
        r.i += 1
    elseif UInt8('1') <= _peek(r) <= UInt8('9')
        while UInt8('0') <= _peek(r) <= UInt8('9'); r.i += 1; end
    else
        _jerr(r, "invalid number")
    end
    isint = true
    if _peek(r) == UInt8('.')
        isint = false
        r.i += 1
        UInt8('0') <= _peek(r) <= UInt8('9') || _jerr(r, "invalid number")
        while UInt8('0') <= _peek(r) <= UInt8('9'); r.i += 1; end
    end
    if _peek(r) in (UInt8('e'), UInt8('E'))
        isint = false
        r.i += 1
        _peek(r) in (UInt8('+'), UInt8('-')) && (r.i += 1)
        UInt8('0') <= _peek(r) <= UInt8('9') || _jerr(r, "invalid number")
        while UInt8('0') <= _peek(r) <= UInt8('9'); r.i += 1; end
    end
    if isint && r.i - start <= 18            # fits in Int64: accumulate digits, no allocation
        neg = r.s[start] == UInt8('-')
        x = 0
        @inbounds for k in (start + neg):(r.i - 1)
            x = 10x + (r.s[k] - UInt8('0'))
        end
        return neg ? -x : x
    end
    sub = SubString(r.str, start, r.i - 1)   # view, no copy
    if isint
        x = tryparse(Int, sub)
        x !== nothing && return x
    end
    return parse(Float64, sub)
end

"""
    read_json(io_or_path) -> Dict / Vector / value

Parse a JSON document (strict RFC 8259; trailing content is an error).
Used to read SeqQC's own reports back (see [`aggregate`](@ref)).
"""
function read_json(src::Union{IO,AbstractString}; is_text::Bool = false)
    str = src isa IO ? read(src, String) : (is_text ? String(src) : read(src, String))
    r = _JSONReader(str)
    v = _value(r)
    _skipws(r)
    r.i <= length(r.s) && _jerr(r, "trailing content")
    return v
end

parse_json(text::AbstractString) = read_json(text; is_text = true)
