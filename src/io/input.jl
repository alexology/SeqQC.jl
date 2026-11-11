# Input detection and opening. Compression is detected from the magic bytes,
# never from the file extension; the format from the first decompressed byte.

"""
    InputInfo

Description of an analysed input: `path`, `file_size` (bytes on disk),
`compression` (`:none` or `:gzip`) and `format` (`:fastq`).
"""
struct InputInfo
    path::String
    file_size::Int
    compression::Symbol
    format::Symbol
end

"""
    SeqQCInputError(path, record, message)

Invalid or unreadable input. `record` is the 1-based number of the FASTQ record
at which the problem was detected (`nothing` when it does not apply); `cause`
holds the underlying exception, if any.
"""
struct SeqQCInputError <: Exception
    path::String
    record::Union{Nothing,Int}
    message::String
    cause::Any
end

SeqQCInputError(path, record, message) = SeqQCInputError(path, record, message, nothing)

function Base.showerror(io::IO, e::SeqQCInputError)
    print(io, "SeqQCInputError: ", e.path)
    e.record === nothing || print(io, ", record ", e.record)
    print(io, ": ", e.message)
    if e.cause !== nothing
        print(io, "\n  caused by: ")
        showerror(io, e.cause)
    end
end

const GZIP_MAGIC = (0x1f, 0x8b)

# Calls `f(reader, info)` with a FASTQ reader over the (decompressed) file and
# closes everything afterwards. `reader === nothing` for an empty input.
function open_reads(f, path::AbstractString)
    path = String(path)
    isfile(path) || throw(SeqQCInputError(path, nothing, "file not found"))
    raw = open(path, "r")
    try
        head = read(raw, 2)
        seekstart(raw)
        gz = length(head) == 2 && (head[1], head[2]) == GZIP_MAGIC
        stream = gz ? GzipDecompressorStream(raw) : NoopStream(raw)
        try
            info = InputInfo(path, filesize(path), gz ? :gzip : :none, :fastq)
            empty_input = try
                eof(stream)
            catch err
                throw(SeqQCInputError(path, nothing, "cannot decompress input", err))
            end
            empty_input && return f(nothing, info)
            first_byte = peek(stream, UInt8)
            if first_byte == UInt8('>')
                throw(SeqQCInputError(path, nothing,
                    "FASTA input is not supported yet (quality-free QC is planned, see docs/ROADMAP.md)"))
            elseif gz && first_byte == UInt8('B')
                throw(SeqQCInputError(path, nothing,
                    "input looks like BAM (BGZF), which is not supported yet (see docs/ROADMAP.md)"))
            elseif first_byte != UInt8('@')
                throw(SeqQCInputError(path, nothing,
                    "not a FASTQ file: first byte is $(repr(Char(first_byte))), expected '@'"))
            end
            reader = FASTQ.Reader(stream; copy = false)
            return f(reader, info)
        finally
            close(stream)
        end
    finally
        close(raw)
    end
end
