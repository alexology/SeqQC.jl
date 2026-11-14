# Truncation profiles and suggestions, checked against an independent
# per-read implementation of DADA2's filterAndTrim rules.

# Reference filter (R dada2 1.36 / DADA2.jl `filtered`, rm.phix = FALSE).
function ref_pass(seq, qual, trunc_len, max_ee; trim_left = 0, trunc_q = 2, max_n = 0, min_len = 20)
    last = length(qual)
    first = trim_left + 1
    last >= first || return false
    low = findnext(q -> q <= trunc_q, qual, first)
    low === nothing || (last = low - 1)
    if trunc_len >= first
        last < trunc_len && return false
        last = trunc_len
    end
    last - first + 1 >= min_len || return false
    count(==('N'), seq[first:last]) <= max_n || return false
    ee = 0.0
    for i in first:last
        ee += 10.0^(-qual[i] / 10)
    end
    return ee <= max_ee
end

function write_reads(path, reads; id_suffix = "")
    open(path, "w") do io
        for (i, (s, q)) in enumerate(reads)
            println(io, "@read", i, id_suffix, " x\n", s, "\n+\n", String(Char.(q .+ 33)))
        end
    end
    return path
end

function random_reads(rng, n)
    map(1:n) do _
        len = rand(rng) < 0.15 ? rand(rng, 0:40) : 100
        base = rand(rng, (10, 20, 30, 38))
        q = [clamp(base + rand(rng, -6:6) - j ÷ 12, 0, 41) for j in 1:len]
        rand(rng) < 0.1 && len > 0 && (q[rand(rng, 1:len)] = rand(rng, 0:3))
        s = String([rand(rng) < 0.004 ? 'N' : rand(rng, "ACGT") for _ in 1:len])
        (s, q)
    end
end

@testset "truncation profile" begin
    rng = MersenneTwister(7)
    dir = mktempdir()
    r1, r2 = random_reads(rng, 400), random_reads(rng, 400)
    f1 = write_reads(joinpath(dir, "s_R1.fastq"), r1; id_suffix = "/1")
    f2 = write_reads(joinpath(dir, "s_R2.fastq"), r2; id_suffix = "/2")
    thr = [0.3, 1.0, 2.0, Inf]
    for (tl, tq, mn, ml) in ((0, 2, 0, 20), (5, 11, 1, 10), (0, 0, 0, 50))
        kw = (trim_left = tl, trunc_q = tq, max_n = mn, min_len = ml)
        p = truncation_profile(f1; max_ee = thr, kw...)
        pp = truncation_profile(f1, f2; max_ee = thr, kw...)
        @test p.reads == 400 && pp.reads == 400 && pp.paired && !p.paired
        for e in thr, L in [0; 1:5:101]
            want = count(r -> ref_pass(r[1], r[2], L, e; kw...), r1)
            @test kept_reads(p, L, e) == want
            for L2 in (L <= tl ? (0,) : (tl + 1, 30, 77, 100, 101))
                pass2 = [ref_pass(a[1], a[2], L, e; kw...) && ref_pass(b[1], b[2], L2, e; kw...) for (a, b) in zip(r1, r2)]
                @test kept_reads(pp, (L, L2), e) == count(pass2)
            end
        end
    end
    p = truncation_profile(f1; max_ee = [2, 1, 2])                # sorted, duplicates removed
    @test p.max_ee == [1.0, 2.0]
    @test p.max_length == [100]
    @test 0 < p.modal_length_fraction[1] < 1
    @test_throws ArgumentError kept_reads(p, 50, 3.0)
    @test_throws ArgumentError kept_reads(truncation_profile(f1, f2), (50, 0), 2.0)
    @test_throws ArgumentError kept_reads(truncation_profile(f1; max_positions = 50), 80, 2.0)
    @test kept_reads(truncation_profile(f1; max_positions = 50), 50, 2.0) == kept_reads(p, 50, 2.0)
    @test truncation_profile(f1; max_reads = 10).reads == 10
    # mismatched pairs
    f3 = write_reads(joinpath(dir, "bad_R2.fastq"), r2[1:399])
    @test_throws SeqQCInputError truncation_profile(f1, f3)
    f4 = write_reads(joinpath(dir, "other_R2.fastq"), [(s, q) for (s, q) in r2]; id_suffix = "b")
    @test_throws SeqQCInputError truncation_profile(f1, f4)
    @test_throws ArgumentError truncation_profile(f1; trim_left = (1, 2))
    @test_throws ArgumentError truncation_profile(f1; min_len = 0)
    @test_throws ArgumentError truncation_profile(f1, f2, f1)
    # empty input
    e = write_reads(joinpath(dir, "empty.fastq"), Tuple{String,Vector{Int}}[])
    @test truncation_profile(e).reads == 0
    @test_throws ArgumentError suggest_truncation(truncation_profile(e))
end

@testset "truncation suggestion" begin
    # 300 pairs of 150 bp; quality drops after position 100 (R1) and 60 (R2)
    mk(n, good) = [(String(rand(MersenneTwister(i), "ACGT", 150)), [j <= good ? 36 : 12 for j in 1:150]) for i in 1:n]
    dir = mktempdir()
    f1 = write_reads(joinpath(dir, "a_R1.fastq"), mk(300, 100))
    f2 = write_reads(joinpath(dir, "a_R2.fastq"), mk(300, 60))
    s = suggest_truncation(f1; max_ee = 2.0)
    @test !s.profile.paired && s.kept == 300 && s.fraction == 1.0
    # EE = 100 * 10^-3.6 + k * 10^-1.2 <= 2 -> k = 31 extra bases
    @test s.trunc_len == [131]
    @test any(a -> a.max_ee == Inf && a.trunc_len == [150], s.alternatives)
    p = truncation_profile(f1, f2)
    sp = suggest_truncation(p; amplicon_length = 200, min_overlap = 20)
    @test sp.trunc_len[1] + sp.trunc_len[2] >= 220 && sp.kept == 300
    @test sp.overlap == sp.trunc_len[1] + sp.trunc_len[2] - 200
    @test sp.trunc_len == [131, 91] || sp.trunc_len[1] + sp.trunc_len[2] == 222
    @test_throws ArgumentError suggest_truncation(p)                    # amplicon_length required
    @test_throws ArgumentError suggest_truncation(p; amplicon_length = 400)
    @test_throws ArgumentError suggest_truncation(p; amplicon_length = 200, max_ee = 4.0)
    c = truncation_commands(sp)
    @test occursin("truncLen = c($(sp.trunc_len[1]), $(sp.trunc_len[2]))", c.dada2_r)
    @test occursin("optionsR = FilterOptions(trimLeft = 0, truncLen = $(sp.trunc_len[2])", c.dada2_jl)
    @test startswith(c.vsearch, "#")
    c1 = truncation_commands(s)
    @test occursin("--fastq_trunclen 131", c1.vsearch) && occursin("--fastq_maxee 2", c1.vsearch)
    @test occursin("maxEE = 2,", c1.dada2_r)
    txt = sprint(show, MIME"text/plain"(), sp)
    @test occursin("truncLen = c(", txt) && occursin("warning: PhiX", txt)
    @test occursin("TruncationProfile: 300 pairs", sprint(show, MIME"text/plain"(), p))
    # min_trunc_len and variable lengths
    @test suggest_truncation(f1; min_trunc_len = 140, max_ee = Inf).trunc_len == [150]
    @test_throws ArgumentError suggest_truncation(f1; min_trunc_len = 140)     # nothing passes maxEE 2 that long
    short = [(s[1:rand(MersenneTwister(i), 60:150)], q[1:rand(MersenneTwister(i), 60:150)]) for (i, (s, q)) in enumerate(mk(100, 150))]
    fv = write_reads(joinpath(dir, "var.fastq"), short)
    @test any(w -> occursin("most frequent length", w), suggest_truncation(fv).warnings)
    # reports
    j = report(sp, joinpath(dir, "t.json"))
    d = JSON3.read(read(j, String))
    @test d.schema == "seqqc-truncation" && d.suggestion.trunc_len == sp.trunc_len && d.paired
    @test length(d.alternatives) == length(sp.alternatives)
    t = readlines(report(sp, joinpath(dir, "t.tsv")))
    @test startswith(t[1], "trunc_len_r1\ttrunc_len_r2\toverlap\tkept_ee0.5")
    @test length(split(t[2], '\t')) == 3 + length(p.max_ee)
    t1 = readlines(report(s, joinpath(dir, "s.tsv")))
    @test t1[1] == "trunc_len\t" * join(["kept_ee" * x for x in ("0.5", "1", "2", "3", "5", "Inf")], '\t')
    @test_throws ArgumentError report(s, joinpath(dir, "s.html"))
    # command line
    out = joinpath(dir, "cli.json")
    @test redirect_stdout(devnull) do
        SeqQC.main(["truncation", f1, f2, "--amplicon-length", "200", "--max-ee", "2.5", "-o", out,
                    "-o", joinpath(dir, "cli.tsv")])
    end == 0
    dc = JSON3.read(read(out, String))
    @test dc.suggestion.max_ee == 2.5 && isfile(joinpath(dir, "cli.tsv"))
    @test redirect_stderr(devnull) do
        SeqQC.main(["truncation", f1, f2])
    end == 2
    @test redirect_stderr(devnull) do
        SeqQC.main(["truncation", f1, "-o", joinpath(dir, "x.html")])
    end == 2
    @test redirect_stdout(devnull) do
        SeqQC.main(["truncation", f1, "--trim-left", "5", "--quiet"])
    end == 0
end
