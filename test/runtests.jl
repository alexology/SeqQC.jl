using SeqQC
using Test
using Random
using Statistics: mean, median
using JSON3
using CodecZlibNG: GzipCompressor, GzipDecompressor
using TranscodingStreams: NoopStream

const TMP = mktempdir()

# ---------------------------------------------------------------------------
# Fixture helpers

fastq_text(reads; eol = "\n") = join(("@$(id)$(eol)$(s)$(eol)+$(eol)$(q)$(eol)" for (id, s, q) in reads))

function write_plain(name, text)
    p = joinpath(TMP, name)
    write(p, text)
    return p
end

gzip_bytes(text) = transcode(GzipCompressor, Vector{UInt8}(codeunits(text)))

function write_gz(name, text; members = 1)
    p = joinpath(TMP, name)
    if members == 1
        write(p, gzip_bytes(text))
    else
        # Split the text at record boundaries into several gzip members.
        lines = split(text, '\n'; keepempty = false)
        nrec = length(lines) ÷ 4
        cut = 4 * max(1, nrec ÷ members)
        parts = [join(lines[i:min(i + cut - 1, end)], '\n') * "\n" for i in 1:cut:length(lines)]
        write(p, reduce(vcat, gzip_bytes.(parts)))
    end
    return p
end

const QCHARS = Char.(33:73)        # Phred 0..40

function random_reads(rng, n; lengths)
    reads = Tuple{String,String,String}[]
    for i in 1:n
        len = lengths isa Integer ? lengths : rand(rng, lengths)
        s = String(rand(rng, collect("ACGTACGTACGTNacgtRY"), len))
        q = String(rand(rng, QCHARS, len))
        push!(reads, ("read$(i) extra=$(i)", s, q))
    end
    return reads
end

# ---------------------------------------------------------------------------
# Independent reference implementation (plain loops, no shared code)

function reference_stats(reads)
    lens = [length(s) for (_, s, _) in reads]
    total = sum(lens; init = 0)
    nxx(frac) = begin
        acc = 0
        for L in sort(lens; rev = true)
            acc += L
            acc >= frac * total && return L
        end
        0
    end
    up(s) = uppercase(s)
    cnt(ch) = sum(count(==(ch), up(s)) for (_, s, _) in reads; init = 0)
    a, c, g, t = cnt('A'), cnt('C'), cnt('G'), cnt('T') + cnt('U')
    phred = reduce(vcat, [Int.(collect(codeunits(q))) .- 33 for (_, _, q) in reads]; init = Int[])
    readq = [-10 * log10(mean(10.0 .^ (-(Int.(collect(codeunits(q))) .- 33) ./ 10))) for (_, _, q) in reads if !isempty(q)]
    readq_phred = [mean(Int.(collect(codeunits(q))) .- 33) for (_, _, q) in reads if !isempty(q)]
    return (n = length(reads), bases = total, min = minimum(lens), max = maximum(lens),
            mean = total / length(lens), median = median(lens), n50 = nxx(0.5), n90 = nxx(0.9),
            gc = (g + c) / (a + c + g + t),
            nN = cnt('N'), mean_base_q = mean(phred), err = mean(10.0 .^ (-phred ./ 10)),
            q30 = count(>=(30), phred) / length(phred),
            mean_read_q = mean(readq), mean_read_q_phred = mean(readq_phred),
            readq = readq, readq_phred = readq_phred,
            q_of_mean_error = -10 * log10(mean(10.0 .^ (-readq ./ 10))))
end

function check_against_reference(r, reads)
    ref = reference_stats(reads)
    @test r.total_reads == ref.n
    @test r.total_bases == ref.bases
    @test r.min_length == ref.min
    @test r.max_length == ref.max
    @test r.mean_length ≈ ref.mean
    @test r.median_length == ref.median
    @test r.n50 == ref.n50
    @test r.n90 == ref.n90
    @test r.gc_content ≈ ref.gc
    @test r.base_counts.N == ref.nN
    @test r.mean_base_quality ≈ ref.mean_base_q
    @test r.base_error_rate ≈ ref.err
    @test r.fraction_q30 ≈ ref.q30
    @test r.mean_read_quality ≈ ref.mean_read_q
    @test r.mean_read_quality_phred ≈ ref.mean_read_q_phred
    @test r.read_quality_of_mean_error ≈ ref.q_of_mean_error
    @test r.reads_at_least.Q20 == count(>=(20), ref.readq)
    @test r.reads_at_least_phred.Q20 == count(>=(20), ref.readq_phred)
    @test sum(r.read_quality_histogram.counts) == length(ref.readq)
    @test sum(r.length_histogram.counts) == ref.n
    @test sum(r.quality_vs_length.counts) == length(ref.readq)
end

# Analyse two halves separately, merge the states, compare with the whole.
function merged_states(paths, metrics)
    states = map(SeqQC.init_state, Tuple(metrics))
    parts = map(paths) do p
        st = map(SeqQC.init_state, Tuple(metrics))
        SeqQC.open_reads(p) do reader, info
            SeqQC._stream!(reader, st, 33, typemax(Int), p)
        end
        st
    end
    foreach(st -> foreach(merge!, states, st), parts)
    return map(SeqQC.finalize_metric, states)
end

# ---------------------------------------------------------------------------

@testset "SeqQC" begin

@testset "hand-computed example" begin
    reads = [("r1", "AC", "II"), ("r2", "GGT", "+++"), ("r3", "ACGTN", "!!5?I"),
             ("r4", "acgu", "IIII"), ("r5", "NNRYAC", "######")]
    p = write_plain("hand.fq", fastq_text(reads))
    r = analyze(p)
    # lengths 2,3,5,4,6: total 20; descending 6,5 -> 11 >= 10 => N50 = 5; 6+5+4+3 = 18 => N90 = 3
    @test r.total_reads == 5
    @test r.total_bases == 20
    @test (r.min_length, r.max_length, r.median_length, r.mean_length) == (2, 6, 4.0, 4.0)
    @test (r.n50, r.n90) == (5, 3)
    # A: 1+1+1+1 = 4, C: 1+1+1+1 = 4, G: 2+1+1 = 4, T/U: 1+1+1 = 3, N: 1+2, ambiguous: 2
    @test r.base_counts == (A = 4, C = 4, G = 4, T = 3, N = 3, ambiguous = 2, invalid = 0)
    @test r.gc_content ≈ 8 / 15
    @test r.n_content ≈ 3 / 20
    @test r.ambiguous_content ≈ 2 / 20
    # per-read GC %: r1 50, r2 67 (66.67 rounds up), r3 50, r4 50, r5 50
    @test r.gc_histogram[51] == 4 && r.gc_histogram[68] == 1
    # Phred: I=40, +=10, !=0, 5=20, ?=30, #=2
    @test r.metrics.quality.base_quality_histogram.counts[41] == 2 + 1 + 4
    @test r.mean_base_quality ≈ (80 + 30 + 0 + 20 + 30 + 40 + 160 + 12) / 20
    @test r.metrics.quality.reads_at_least_phred.Q30 == 2            # r1 and r4
    @test r.metrics.quality.reads_at_least.Q10 == 3                  # r1, r2 (exactly 10), r4
    @test isempty(r.warnings)
    @test r.input.compression == :none && r.input.format == :fastq
    @test r.settings.sampling == :none
    y = yield_by_length(r)
    @test y.min_length == [6, 5, 4, 3, 2]
    @test y.reads == [1, 2, 3, 4, 5]
    @test y.bases == [6, 11, 15, 18, 20]
end

@testset "random short and long reads vs independent calculation" begin
    rng = Xoshiro(20261110)
    short = random_reads(rng, 2000; lengths = 150)
    check_against_reference(analyze(write_plain("short.fq", fastq_text(short))), short)
    variable = random_reads(rng, 2001; lengths = 35:301)
    check_against_reference(analyze(write_plain("var.fq", fastq_text(variable))), variable)
    # long reads crossing the dense/sparse boundary of the length histogram
    long = random_reads(rng, 120; lengths = vcat(collect(1:3000), collect(65_530:65_540), collect(70_000:120_000)))
    push!(long, ("edge1", "A"^65_535, "I"^65_535), ("edge2", "C"^65_536, "I"^65_536))
    check_against_reference(analyze(write_plain("long.fq", fastq_text(long))), long)
end

@testset "compression, line endings, determinism" begin
    rng = Xoshiro(7)
    reads = random_reads(rng, 500; lengths = 10:400)
    text = fastq_text(reads)
    plain = analyze(write_plain("p.fq", text))
    gz = analyze(write_gz("p.fq.gz", text))
    multi = analyze(write_gz("multi.fq.gz", text; members = 5))
    noext = analyze(write_gz("gzip_without_extension", text))
    crlf = analyze(write_plain("crlf.fq", fastq_text(reads; eol = "\r\n")))
    @test gz.input.compression == :gzip && noext.input.compression == :gzip
    for other in (gz, multi, noext, crlf)
        @test other.metrics == plain.metrics
    end
    @test analyze(write_plain("p2.fq", text)).metrics == plain.metrics
end

@testset "empty input" begin
    for p in (write_plain("empty.fq", ""), write_gz("empty.fq.gz", ""))
        r = analyze(p)
        @test r.total_reads == 0 && r.total_bases == 0
        @test r.n50 === nothing && r.median_length === nothing && r.gc_content === nothing
        @test r.mean_base_quality === nothing && r.mean_read_quality === nothing
        @test any(occursin("no reads", w) for w in r.warnings)
    end
end

@testset "zero-length reads and invalid bytes" begin
    reads = [("a", "ACGT", "IIII"), ("b", "", ""), ("c", "AC-T", "IIII")]
    r = analyze(write_plain("zero.fq", fastq_text(reads)))
    @test r.total_reads == 3 && r.total_bases == 8
    @test r.min_length == 0
    @test r.metrics.quality.reads_without_bases == 1
    @test r.base_counts.invalid == 1
    @test r.gc_content ≈ 3 / 7
    @test length(r.warnings) == 2
end

@testset "extremely long read" begin
    n = 2_000_000
    s = String(rand(Xoshiro(1), collect("ACGT"), n))
    r = analyze(write_plain("huge.fq", fastq_text([("big", s, "5"^n), ("small", "AC", "55")])))
    @test r.max_length == n && r.n50 == n && r.n90 == n
    @test r.mean_base_quality == 20.0
    @test r.mean_read_quality ≈ 20.0
    @test r.metrics.read_length.length_histogram.lengths == [2, n]
end

@testset "malformed input" begin
    function input_error(p; kwargs...)
        try
            analyze(p; kwargs...)
        catch e
            return e
        end
        return nothing
    end
    good = "@ok\nACGT\n+\nIIII\n"
    cases = [
        ("missing_plus.fq", good * "@r2\nACGT\nIIII\n", 2),
        ("length_mismatch.fq", good * "@r2\nACGT\n+\nIII\n", 2),
        ("truncated.fq", good * good * "@r3\nACG", 3),
        ("no_header.fq", good * "r2\nACGT\n+\nIIII\n", 2),
    ]
    for (name, text, record) in cases
        e = input_error(write_plain(name, text))
        @test e isa SeqQCInputError
        @test e.record == record
        @test occursin(name, sprint(showerror, e))
    end
    # truncated gzip stream
    bytes = gzip_bytes(good^200)
    p = joinpath(TMP, "truncated.fq.gz")
    write(p, bytes[1:end÷2])
    @test input_error(p) isa SeqQCInputError
    # wrong formats
    @test occursin("FASTA", sprint(showerror, input_error(write_plain("x.fa", ">s\nACGT\n"))))
    @test occursin("not a FASTQ", sprint(showerror, input_error(write_plain("x.txt", "hello\n"))))
    @test occursin("BAM", sprint(showerror, input_error(write_gz("x.bam", "BAM\x01rest"))))
    @test input_error(joinpath(TMP, "does_not_exist.fq")) isa SeqQCInputError
    # quality encoding: '!' (33) is invalid for Phred+64
    e = input_error(write_plain("phred.fq", good * "@r2\nAC\n+\n!!\n"); phred_offset = 64)
    @test e isa SeqQCInputError && e.record == 2    # 'I' (73) is valid Phred+64, '!' (33) is not
end

@testset "Phred+64" begin
    r = analyze(write_plain("p64.fq", fastq_text([("a", "ACGT", "hhhh")])); phred_offset = 64)
    @test r.mean_base_quality == 40.0
    @test r.settings.phred_offset == 64
end

@testset "max_reads (head sampling)" begin
    reads = random_reads(Xoshiro(3), 100; lengths = 50)
    p = write_plain("head.fq", fastq_text(reads))
    r = analyze(p; max_reads = 10)
    @test r.total_reads == 10
    @test r.settings.sampling == :head && r.settings.max_reads == 10
    @test any(occursin("head sampling", w) for w in r.warnings)
    check_against_reference(r, reads[1:10])
    all100 = analyze(p; max_reads = 100)
    @test all100.settings.sampling == :none && isempty(all100.warnings)
    @test analyze(p; max_reads = 0).total_reads == 0
end

@testset "merging states equals a single pass" begin
    reads = random_reads(Xoshiro(11), 900; lengths = vcat(collect(1:500), [70_000, 80_000]))
    whole = analyze(write_plain("whole.fq", fastq_text(reads)))
    p1 = write_plain("half1.fq", fastq_text(reads[1:400]))
    p2 = write_plain("half2.fq", fastq_text(reads[401:end]))
    merged = merged_states([p1, p2], default_metrics())
    for (a, b) in zip(merged, whole.metrics)
        for k in keys(b)
            if b[k] isa AbstractFloat
                @test a[k] ≈ b[k]
            else
                @test a[k] == b[k]
            end
        end
    end
end

@testset "custom metric without engine changes" begin
    struct StartsWithA <: AbstractQCMetric end
    mutable struct StartsWithAState
        n::Int
    end
    SeqQC.init_state(::StartsWithA) = StartsWithAState(0)
    SeqQC.update!(s::StartsWithAState, read::ReadView) =
        (s.n += !isempty(read.seq) && read.seq[1] == UInt8('A'); s)
    Base.merge!(a::StartsWithAState, b::StartsWithAState) = (a.n += b.n; a)
    SeqQC.finalize_metric(s::StartsWithAState) = (reads_starting_with_a = s.n,)
    SeqQC.metric_name(::StartsWithA) = :starts_with_a
    reads = [("a", "ACG", "III"), ("b", "TTT", "III"), ("c", "AAA", "III")]
    r = analyze(write_plain("custom.fq", fastq_text(reads)); metrics = [ReadLength(), StartsWithA()])
    @test r.reads_starting_with_a == 2
    @test r.n50 == 3
    @test keys(r.metrics) == (:read_length, :starts_with_a)
end

@testset "API and argument validation" begin
    p = write_plain("api.fq", fastq_text([("a", "ACGT", "IIII")]))
    r = analyze(p; metrics = [ReadLength()])
    @test r.total_bases == 4
    @test_throws ArgumentError r.gc_content          # metric not computed
    @test :n50 in propertynames(r)
    @test_throws ArgumentError analyze(p; platform = :nanopore)
    @test_throws ArgumentError analyze(p; phred_offset = 40)
    @test_throws ArgumentError analyze(p; max_reads = -1)
    @test_throws ArgumentError analyze(p; metrics = [ReadLength(), ReadLength()])
    @test_throws ArgumentError analyze(p; metrics = AbstractQCMetric[])
    @test_throws ArgumentError QualityDistribution(thresholds = (10, 100))
    @test QualityDistribution(thresholds = (20, 7, 20)).thresholds == [7, 20]
    rs = analyze([p, p])
    @test length(rs) == 2 && rs[1].metrics == rs[2].metrics
    @test occursin("reads: 1", sprint(show, MIME"text/plain"(), analyze(p)))
    @test r.software.name == "SeqQC"
    @test r.settings.definitions.read_length == definition(ReadLength())
end

@testset "fixed-point error probabilities" begin
    P = SeqQC.ERROR_PROBABILITY
    exact = [10.0^(-q / 10) for q in 0:SeqQC.MAX_PHRED]
    rel = abs.(P .- exact) ./ exact
    @test maximum(rel[1:61]) < 3e-8          # Q0..Q60
    @test maximum(rel) < 6e-5                # up to Q93
    @test P[1] == 1.0 && P[11] == round(0.1 * 2.0^44) / 2.0^44
    rng = Xoshiro(5)
    s = SeqQC.ReadSummary()
    t = zeros(Int, SeqQC.N_CLASSES)
    for len in (1, 7, 150, 4000, (1 << 18) + 3, 600_000)
        q = UInt8.(33 .+ rand(rng, 0:60, len))
        seq = fill(UInt8('A'), len)
        @test SeqQC.summarize!(s, t, seq, q, 33)
        e1 = s.error_sum
        ref = Float64(sum(big(P[b - 33 + 1]) for b in q))    # exact sum of the tabulated values
        @test e1 == ref
        SeqQC.summarize!(s, t, seq, reverse(q), 33)
        @test s.error_sum == e1                                # order-independent
    end
end

@testset "quality pass skipped when no metric needs quality" begin
    p = write_plain("badq.fq", "@a
ACGT
+
!!!!
")
    @test_throws SeqQCInputError analyze(p; phred_offset = 64)
    r = analyze(p; phred_offset = 64, metrics = [ReadLength(), BaseComposition()])
    @test r.total_bases == 4 && r.settings.quality_validated == false
    @test analyze(p).settings.quality_validated == true
end

@testset "decompression in a separate task" begin
    reads = random_reads(Xoshiro(21), 20_000; lengths = 50:400)
    text = fastq_text(reads)
    p = write_gz("pipe.fq.gz", text; members = 3)
    expected = transcode(GzipDecompressor, read(p))
    for block in (1, 7, 1000, 1 << 20), depth in (1, 3)
        got = open(p) do raw
            pipe = SeqQC.BlockPipe(raw; block, depth)
            s = NoopStream(pipe)
            out = read(s)
            close(s)
            @test istaskdone(pipe.task)
            out
        end
        @test got == expected
    end
    # producer errors reach the reader
    bad = joinpath(TMP, "pipe_truncated.fq.gz")
    write(bad, read(p)[1:end ÷ 2])
    @test_throws Exception open(raw -> read(NoopStream(SeqQC.BlockPipe(raw))), bad)
    # early close while the producer is blocked on a full channel
    open(p) do raw
        pipe = SeqQC.BlockPipe(raw; block = 100, depth = 1)
        @test read(pipe, UInt8) == UInt8('@')
        close(pipe)
        @test istaskdone(pipe.task) && !isopen(pipe)
    end
    # same results with and without the task, and through the engine
    r1 = analyze(p; threads = 1)
    r2 = analyze(p; threads = 2)
    @test r1.input.decompression == :inline
    @test r2.input.decompression == (Threads.nthreads() >= 2 ? :task : :inline)
    @test r1.metrics == r2.metrics
    @test analyze(p; threads = 2, max_reads = 10).total_reads == 10
    e = try analyze(bad; threads = 2) catch err; err end
    @test e isa SeqQCInputError && e.record !== nothing
    @test analyze(write_plain("pipe_plain.fq", text); threads = 2).input.decompression == :none
    @test_throws ArgumentError analyze(p; threads = 0)
end

@testset "per-position statistics vs independent calculation" begin
    rng = Xoshiro(77)
    reads = random_reads(rng, 400; lengths = 1:180)
    push!(reads, ("u", "UUuuACGT", "IIII####"))
    r = analyze(write_plain("pos.fq", fastq_text(reads)); metrics = [PerPositionStats()], threads = 1)
    p = r.per_position
    L = maximum(length(s) for (_, s, _) in reads)
    @test p.positions == L == p.max_length && !p.truncated
    class(ch) = (c = uppercase(ch); c == 'A' ? 1 : c == 'C' ? 2 : c == 'G' ? 3 : c == 'T' ? 4 : c == 'U' ? 5 : c == 'N' ? 6 : 7)
    for i in (1, 2, 9, 10, 77, L)
        qs = sort([Int(q[i]) - 33 for (_, s, q) in reads if length(s) >= i])
        n = length(qs)
        @test p.bases[i] == n
        @test p.mean_quality[i] ≈ sum(qs) / n
        for (j, pr) in enumerate(p.quantile_probabilities)
            @test p.quality_quantiles[j, i] == qs[max(1, floor(Int, pr * n))]
        end
        counts = zeros(Int, 7)
        for (_, s, _) in reads
            length(s) >= i && (counts[class(s[i])] += 1)
        end
        @test p.base_counts[:, i] == counts
    end
    # floor of the per-read Phred mean, exact
    rq = analyze(write_plain("pos.fq", fastq_text(reads)); metrics = [QualityDistribution()]).metrics.quality
    expected = zeros(Int, 94)
    for (_, s, q) in reads
        isempty(q) || (expected[div(sum(Int.(collect(codeunits(q))) .- 33), length(q)) + 1] += 1)
    end
    @test rq.read_quality_floor_histogram.counts == expected
end

@testset "per-position truncation and merging" begin
    reads = random_reads(Xoshiro(78), 300; lengths = 1:500)
    p1 = write_plain("posm1.fq", fastq_text(reads[1:150]))
    p2 = write_plain("posm2.fq", fastq_text(reads[151:end]))
    whole = analyze(write_plain("posm.fq", fastq_text(reads)); metrics = [PerPositionStats(max_positions = 100)])
    pw = whole.per_position
    @test pw.truncated && pw.positions == 100
    @test pw.beyond.bases == sum(max(0, length(s) - 100) for (_, s, _) in reads)
    @test any(occursin("max_positions", w) for w in whole.warnings)
    merged = merged_states([p1, p2], [PerPositionStats(max_positions = 100)])
    @test merged[1].per_position.raw_quality_histograms == pw.raw_quality_histograms
    @test merged[1].per_position.base_counts == pw.base_counts
    @test merged[1].per_position.beyond == pw.beyond
    @test_throws ArgumentError PerPositionStats(max_positions = 0)
    @test_throws ArgumentError SeqQC.FastQC.per_base_quality(analyze(write_plain("posm.fq", fastq_text(reads));
                                                               metrics = SeqQC.FastQC.metrics(max_positions = 100)))
end

# FastQC 0.12.1 reference outputs (test/data/fastqc): synthetic inputs and the
# fastqc_data.txt FastQC produced for them; SeqQC.FastQC must agree bit for bit.
function fastqc_modules(file)
    mods = Dict{String,Tuple{Symbol,Vector{Vector{String}}}}()
    name = ""
    for line in eachline(file)
        if startswith(line, ">>END_MODULE")
            name = ""
        elseif startswith(line, ">>")
            parts = split(line[3:end], '	')
            name = parts[1]
            mods[name] = (Symbol(parts[2]), Vector{String}[])
        elseif !isempty(name) && !startswith(line, "#")
            push!(mods[name][2], split(line, '	'))
        end
    end
    return mods
end

same(t::AbstractString, o::AbstractString) = t == o
function same(t::AbstractString, o::Real)
    x = t == "NaN" ? NaN : parse(Float64, t)
    return (isnan(x) && isnan(o)) || x === Float64(o)
end
same_column(rows, j, ours) = length(rows) == length(ours) && all(same(row[j], o) for (row, o) in zip(rows, ours))

@testset "FastQC 0.12.1 compatibility (reference outputs)" begin
    F = SeqQC.FastQC
    dir = joinpath(@__DIR__, "data", "fastqc")
    names = [replace(f, ".fastq" => "") for f in readdir(dir) if endswith(f, ".fastq")]
    @test length(names) == 53
    two = joinpath(dir, "two_contaminants.txt")
    for name in names
        m = fastqc_modules(joinpath(dir, name * ".fastqc_data.txt"))
        contam = startswith(name, "ov_contam") ? two : nothing
        r = analyze(joinpath(dir, name * ".fastq"); metrics = F.metrics(; contaminants = contam), threads = 1)
        ov = F.overrepresented(r)
        orows = m["Overrepresented sequences"][2]
        @test same_column(orows, 1, ov.sequence)
        @test same_column(orows, 2, ov.count)
        @test same_column(orows, 3, ov.percentage)
        contam === nothing || @test same_column(orows, 4, ov.possible_source)
        bs = Dict(row[1] => row[2] for row in m["Basic Statistics"][2])
        b = F.basic_statistics(r)
        @test bs["Encoding"] == b.encoding
        @test parse(Int, bs["Total Sequences"]) == b.total_sequences
        @test bs["Sequence length"] == b.sequence_length
        @test parse(Int, bs["%GC"]) == b.percent_gc
        q = F.per_base_quality(r)
        t = m["Per base sequence quality"][2]
        for (j, col) in enumerate((q.base, q.mean, q.median, q.lower_quartile, q.upper_quartile,
                                   q.percentile_10, q.percentile_90))
            @test same_column(t, j, col)
        end
        sq = F.per_sequence_quality(r)
        @test same_column(m["Per sequence quality scores"][2], 1, string.(sq.quality))
        @test same_column(m["Per sequence quality scores"][2], 2, sq.count)
        c = F.per_base_content(r)
        for (j, col) in enumerate((c.base, c.G, c.A, c.T, c.C))
            @test same_column(m["Per base sequence content"][2], j, col)
        end
        n = F.per_base_n(r)
        @test same_column(m["Per base N content"][2], 1, n.base)
        @test same_column(m["Per base N content"][2], 2, n.n_count)
        gcm = F.per_sequence_gc(r)
        @test same_column(m["Per sequence GC content"][2], 1, string.(gcm.gc_content))
        @test same_column(m["Per sequence GC content"][2], 2, gcm.count)
        ad = F.adapter_content(r)
        @test same_column(m["Adapter Content"][2], 1, ad.position)
        for (j, v) in enumerate(ad.values)
            @test same_column(m["Adapter Content"][2], j + 1, v)
        end
        l = F.length_distribution(r)
        @test same_column(m["Sequence Length Distribution"][2], 1, l.length)
        @test same_column(m["Sequence Length Distribution"][2], 2, l.count)
        fl = F.flags(r)
        for (mod, key) in (("Basic Statistics", :basic_statistics), ("Per base sequence quality", :per_base_quality),
                           ("Per sequence quality scores", :per_sequence_quality),
                           ("Per base sequence content", :per_base_content), ("Per base N content", :per_base_n_content),
                           ("Sequence Length Distribution", :sequence_length_distribution),
                           ("Adapter Content", :adapter_content),
                           ("Overrepresented sequences", :overrepresented_sequences))
            @test m[mod][1] == fl[key]
        end
    end
end

@testset "FastQC grouping and length-bin rules" begin
    F = SeqQC.FastQC
    # first maximum length with each group width (FastQC 0.12.1, bisected)
    for (L, S) in ((75, 1), (76, 2), (139, 2), (140, 5), (334, 5), (335, 10), (659, 10), (660, 20), (1309, 20),
                   (1310, 50), (3259, 50), (3260, 100), (6509, 100), (6510, 200), (13009, 200), (13010, 500),
                   (32509, 500), (32510, 1000), (65009, 1000), (65010, 2000), (130009, 2000), (130010, 5000),
                   (325009, 5000), (325010, 10000))
        g = F.base_groups(L)
        @test (L <= 75 ? 1 : length(g[11])) == S          # g[11]: first full-width group
        @test first(first(g)) == 1 && last(last(g)) == L
        @test all(first(g[i + 1]) == last(g[i]) + 1 for i in 1:length(g) - 1)
    end
    @test [string(first(x), "-", last(x)) for x in F.base_groups(1001)[10:12]] == ["10-19", "20-39", "40-59"]
    @test [string(first(x), "-", last(x)) for x in F.base_groups(100000)[10:11]] == ["10-1999", "2000-3999"]
    # length bins: width changes when max - min reaches 51 S - 2
    for (lo, hi, S) in ((1, 49, 1), (1, 50, 2), (200, 248, 1), (200, 249, 2), (1, 100, 2), (1, 101, 5),
                        (1, 253, 5), (1, 254, 10), (1000, 2018, 50), (1000, 3547, 50), (1000, 3548, 100),
                        (1, 50998, 1000), (1, 50999, 2000))
        w, bins = F.length_bins(lo, hi)
        @test w == S
        @test first(first(bins)) == (lo ÷ S) * S && hi in last(bins)
    end
    @test F.length_bins(0, 49)[1] == 1 && F.length_bins(0, 50)[1] == 2
end

@testset "FastQC GC model rules" begin
    F = SeqQC.FastQC
    @test [F._gc_length(L) for L in (1, 99, 100, 150, 999, 1000, 2850, 19999, 100500)] ==
          [1, 99, 100, 100, 900, 1000, 2000, 19000, 100000]
    m = F._gc_model(10)                       # claims: bins 5, 15, ... shared by two GC counts
    @test m[2] == [(5, 0.5); [(b, 1.0) for b in 6:14]; (15, 0.5)]
    @test m[1][1] == (0, 1.0)                 # clipped at 0: bin 0 claimed once
    @test all(sum(w for (_, w) in [p for c in m for p in c if p[1] == b]) ≈ 1 for b in 0:100)
    # merging adds bin sums
    reads = random_reads(Xoshiro(91), 200; lengths = 50:3000)
    whole = analyze(write_plain("gcm.fq", fastq_text(reads)); metrics = [F.GCModel()])
    merged = merged_states([write_plain("gcm1.fq", fastq_text(reads[1:90])),
                            write_plain("gcm2.fq", fastq_text(reads[91:end]))], [F.GCModel()])
    @test merged[1].fastqc_gc_counts ≈ whole.metrics.fastqc_gc.fastqc_gc_counts
end

include("test_json.jl")
include("test_aggregate.jl")
include("test_fastqc_extra.jl")
include("test_cli_text.jl")

@testset "quality vs length binning" begin
    edges = SeqQC.LENGTH_EDGES
    @test edges[1:3] == [0, 1, 2]
    @test issorted(edges) && allunique(edges)
    @test 10 in edges && 100 in edges && 1000 in edges && 10^9 in edges
    reads = [("a", "A"^10, "5"^10), ("b", "A"^99, "+"^99), ("c", "A"^100, "+"^100)]
    r = analyze(write_plain("qvl.fq", fastq_text(reads)); metrics = [QualityVsLength()])
    m = r.quality_vs_length
    i10 = findfirst(==(10), edges)
    i100 = findfirst(==(100), edges)
    @test m.counts[i10, 21] == 1                   # length 10, Q20 in [20, 21)
    @test m.counts[i100 - 1, 11] == 1              # length 99 below the 100 edge, Q10
    @test m.counts[i100, 11] == 1
    @test sum(m.counts) == 3
end

end # testset
