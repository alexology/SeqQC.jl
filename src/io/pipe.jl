# Decompression in a separate task. A producer task inflates the gzip stream
# into fixed-size blocks and hands them to the reader through a bounded
# Channel (back-pressure without polling); emptied blocks are recycled. Errors
# of the producer are re-thrown to the reader at the point where the data stop.

const PIPE_BLOCK = 1 << 20          # bytes per block
const PIPE_DEPTH = 8                # blocks in flight

mutable struct BlockPipe <: IO
    full::Channel{Vector{UInt8}}
    free::Channel{Vector{UInt8}}
    cur::Vector{UInt8}
    pos::Int                        # next unread index in `cur`
    task::Task
    open::Bool
end

function _produce(full::Channel{Vector{UInt8}}, free::Channel{Vector{UInt8}}, raw::IO, block::Int)
    gz = GzipDecompressorStream(raw)
    try
        while !eof(gz)
            buf = isready(free) ? take!(free) : Vector{UInt8}(undef, block)
            resize!(buf, block)
            n = readbytes!(gz, buf, block)
            resize!(buf, n)
            put!(full, buf)                 # blocks while the reader is behind
        end
        close(full)
    catch err
        # A closed `full` means the reader stopped early: not an error.
        isopen(full) ? close(full, err) : nothing
    finally
        close(gz)
    end
    return nothing
end

function BlockPipe(raw::IO; block::Int = PIPE_BLOCK, depth::Int = PIPE_DEPTH)
    full = Channel{Vector{UInt8}}(depth)
    free = Channel{Vector{UInt8}}(depth + 2)
    task = Threads.@spawn _produce(full, free, raw, block)
    return BlockPipe(full, free, UInt8[], 1, task, true)
end

Base.bytesavailable(p::BlockPipe) = length(p.cur) - p.pos + 1
Base.isopen(p::BlockPipe) = p.open
Base.isreadable(p::BlockPipe) = p.open
Base.iswritable(::BlockPipe) = false

# Moves to the next non-empty block; returns false at the end of the data.
function _advance!(p::BlockPipe)
    while bytesavailable(p) == 0
        # At most depth + 2 blocks ever exist (depth queued, one in the producer,
        # one here), so `free` (capacity depth + 2) never blocks this put!.
        isempty(p.cur) || put!(p.free, p.cur)
        p.cur = UInt8[]
        p.pos = 1
        next = try
            take!(p.full)
        catch err
            err isa InvalidStateException && err.state === :closed && return false
            rethrow()
        end
        p.cur = next
    end
    return true
end

Base.eof(p::BlockPipe) = !_advance!(p)

function Base.read(p::BlockPipe, ::Type{UInt8})
    _advance!(p) || throw(EOFError())
    @inbounds b = p.cur[p.pos]
    p.pos += 1
    return b
end

function Base.unsafe_read(p::BlockPipe, ptr::Ptr{UInt8}, n::UInt)
    remaining = Int(n)
    while remaining > 0
        _advance!(p) || throw(EOFError())
        k = min(remaining, bytesavailable(p))
        GC.@preserve p unsafe_copyto!(ptr, pointer(p.cur, p.pos), k)
        p.pos += k
        ptr += k
        remaining -= k
    end
    return nothing
end

function Base.close(p::BlockPipe)
    p.open || return nothing
    p.open = false
    close(p.full)                       # unblocks a producer waiting in put!
    close(p.free)
    try
        wait(p.task)
    catch
        # The producer's error, if any, was already delivered through `full`.
    end
    return nothing
end
