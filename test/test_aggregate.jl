# JSON reader and multi-sample aggregation (included from runtests.jl).

@testset "JSON reader" begin
    # JSON3 returns its own container types: normalise them before comparing
    plain(x::JSON3.Object) = Dict{String,Any}(String(k) => plain(v) for (k, v) in pairs(x))
    plain(x::JSON3.Array) = Any[plain(v) for v in x]
    plain(x) = x
    for txt in ("{}", "[]", "0", "-0", "1.5e-3", "-12", "true", "null", "\"a\\u00e9\\ud83d\\ude00\\n\"",
                "{\"a\":[1,2.5,{\"b\":null}],\"c\":\"x\\\"y\\\\z\\/\"}", " [ 1 , 2 ] ", "9223372036854775807",
                "1E5", "[1e-320]")
        @test plain(JSON3.read(txt)) == SeqQC.parse_json(txt)
    end
    # typed fast path for numeric arrays, with fallback for anything else
    @test SeqQC.parse_json("[1,2,3]") isa Vector{Int}
    @test SeqQC.parse_json("[1,2.5,-3]") == [1.0, 2.5, -3.0] && SeqQC.parse_json("[1,2.5]") isa Vector{Float64}
    @test SeqQC.parse_json("[1,null,2]") == Any[1, nothing, 2]
    @test SeqQC.parse_json("[1.5,\"a\",[2]]") == Any[1.5, "a", [2]]
    @test SeqQC.parse_json("[1,92233720368547758070]") isa Vector{Float64}
    @test SeqQC.parse_json("[null,1]") == Any[nothing, 1]
    @test_throws SeqQC.JSONParseError SeqQC.parse_json("[1,2")
    @test SeqQC.parse_json("\"\\ud83d\\ude00\"") == "😀"
    @test SeqQC.parse_json("9223372036854775807") === typemax(Int)
    @test SeqQC.parse_json("92233720368547758070") isa Float64
    @test SeqQC.parse_json("{\"a\":{\"b\":[true,false,null]}}")["a"]["b"] == Any[true, false, nothing]
    for bad in ("", "[1,]", "{\"a\":1,}", "'a'", "NaN", "01", "1.", ".5", "[1 2]", "\"abc", "{\"a\" 1}",
                "\"\\x\"", "\"\\ud83d\"", "[1] x", "tru", "\"a\nb\"")
        @test_throws SeqQC.JSONParseError SeqQC.parse_json(bad)
    end
    # round trip of a full SeqQC document
    r = analyze(write_plain("jr.fq", fastq_text(random_reads(Xoshiro(3), 50; lengths = 10:90))))
    js = to_json(r; fastqc = false)
    @test SeqQC.parse_json(js)["metrics"]["read_length"]["n50"] == r.n50
    @test SeqQC.parse_json(js)["metrics"]["quality"]["mean_read_quality"] == r.mean_read_quality
end

@testset "aggregate" begin
    F = SeqQC.FastQC
    ms = vcat(default_metrics(), [PerPositionStats(), F.GCModel()])
    dir = mkpath(joinpath(TMP, "agg_in"))
    files = String[]
    for (k, n) in enumerate((200, 150, 180))
        p = joinpath(dir, "barcode$(k == 3 ? 10 : k).fastq.gz")
        write(p, gzip_bytes(fastq_text(random_reads(Xoshiro(100 + k), n; lengths = 30:400))))
        push!(files, p)
    end
    small = joinpath(dir, "tiny.fastq")
    write(small, fastq_text(random_reads(Xoshiro(9), 5; lengths = 30:40)))
    push!(files, small)
    rs = [analyze(f; metrics = ms, threads = 1) for f in files]

    s = aggregate(rs)
    @test s.samples == ["barcode1", "barcode2", "barcode10", "tiny"]
    @test s.table.reads == [200, 150, 180, 5]
    @test s.table.n50 == [r.n50 for r in rs]
    @test s.table.gc_percent ≈ [100 * r.gc_content for r in rs]
    @test s.table.mean_read_quality == [r.mean_read_quality for r in rs]
    @test s.table.percent_reads_q20 ≈ [100 * r.metrics.quality.reads_at_least.Q20 / r.total_reads for r in rs]
    @test all(f !== nothing for f in s.table.fastqc_flags)
    @test s.table.fastqc_flags[1]["per_base_quality"] == string(F.flags(rs[1]).per_base_quality)
    @test any(occursin("tiny: 5 reads, below", w) for w in s.warnings)          # low-reads heuristic
    @test isempty(aggregate(rs; low_reads_fraction = 0.0).warnings)
    # distributions are fractions per sample
    @test all(sum(filter(isfinite, s.series.length.fraction[i, :])) ≈ 1 for i in 1:4)
    @test all(s.series.length.yield[i, 1] ≈ 1 for i in 1:4)
    @test all(sum(s.series.gc.fraction[i, :]) ≈ 1 for i in 1:4)

    # quality by position: pooled mean of the bases of each bin, independent calculation
    pq = s.series.position_quality
    reads1 = random_reads(Xoshiro(101), 200; lengths = 30:400)
    cov = zeros(Int, 400); qs = zeros(Int, 400)
    for (_, sq, q) in reads1, (k, ch) in enumerate(q)
        cov[k] += 1; qs[k] += Int(ch) - 33
    end
    for k in 1:length(pq.edges) - 1
        ps = [p for p in pq.edges[k]:pq.edges[k+1]-1 if p <= 400 && cov[p] >= 100]
        exp = isempty(ps) ? NaN : sum(qs[ps]) / sum(cov[ps])
        @test (isnan(exp) && isnan(pq.mean_quality[1, k])) || pq.mean_quality[1, k] ≈ exp
    end
    @test all(isnan, aggregate([analyze(small)]).series.position_quality.mean_quality)   # no PerPositionStats

    # the same samples from saved JSON reports, read back from a directory
    jdir = mkpath(joinpath(TMP, "agg_json"))
    for (f, r) in zip(files, rs)
        report(r, joinpath(jdir, sample_name(f) * ".seqqc.json"); fastqc = true)
    end
    write(joinpath(jdir, "notes.json"), "{\"something\": 1}")
    write(joinpath(jdir, "broken.json"), "{")
    s2 = aggregate(jdir)
    @test s2.samples == ["barcode1", "barcode2", "barcode10", "tiny"]                # natural order
    @test s2.table.reads == s.table.reads && s2.table.mean_read_quality == s.table.mean_read_quality
    @test s2.series.read_quality.fraction == s.series.read_quality.fraction
    @test any(occursin("skipped notes.json", w) for w in s2.warnings)
    @test any(occursin("skipped broken.json", w) for w in s2.warnings)
    @test aggregate([rs[1], joinpath(jdir, "barcode2.seqqc.json")]).samples == ["barcode1", "barcode2"]

    # names
    @test sample_name("a/b/ONT_barcode01.fastq.gz") == "ONT_barcode01"
    @test sample_name("x.seqqc.json") == "x" && sample_name("y.fq.bz2") == "y"
    d1 = mkpath(joinpath(TMP, "agg_names", "barcode01")); d2 = mkpath(joinpath(TMP, "agg_names", "barcode02"))
    pa = joinpath(d1, "reads.fastq"); pb = joinpath(d2, "reads.fastq")
    write(pa, fastq_text([("a", "ACGT", "IIII")])); write(pb, fastq_text([("b", "ACGT", "IIII")]))
    ra, rb = analyze(pa), analyze(pb)
    @test aggregate([ra, rb]).samples == ["barcode01/reads", "barcode02/reads"]
    @test aggregate([ra, rb]; names = ["A", "B"]).samples == ["A", "B"]
    @test aggregate([ra, rb]; names = Dict(pa => "first")).samples == ["first", "barcode02/reads"]
    @test_throws ArgumentError aggregate([ra, ra])
    @test_throws ArgumentError aggregate([ra, rb]; names = ["A"])
    @test_throws ArgumentError aggregate(String[])
    @test_throws ArgumentError aggregate(joinpath(TMP, "does_not_exist"))
    bad = joinpath(TMP, "v2.json"); write(bad, "{\"schema\":\"seqqc-result\",\"schema_version\":\"2.0.0\"}")
    @test_throws ArgumentError aggregate(bad)

    # outputs
    tsv = report(s, joinpath(TMP, "agg.tsv"))
    lines = readlines(tsv)
    @test length(lines) == 5
    hdr = split(lines[1], '\t')
    @test hdr[1:3] == ["sample", "reads", "bases"] && "fastqc_per_base_quality" in hdr
    @test split(lines[2], '\t')[2] == "200"
    ja = JSON3.read(read(report(s, joinpath(TMP, "agg.json")), String))
    @test ja.schema == "seqqc-aggregate" && ja.samples == s.samples
    @test ja.table.reads == s.table.reads

    html = read(report(s, joinpath(TMP, "agg.html")), String)
    @test occursin("<svg class=\"chart line\"", html) && !occursin("chart heat", html)
    @test occursin("class=\"legend\"", html)
    @test !occursin("NaN", replace(html, r"<script>.*?</script>"s => ""))
    @test count("<section class=\"card\">", html) == 6
    # names are escaped everywhere (table, legend, embedded data)
    evil = aggregate([ra, rb]; names = ["<script>alert(1)</script>", "a&b\"c"])
    eh = read(report(evil, joinpath(TMP, "evil.html")), String)
    @test !occursin("<script>alert(1)", eh)
    @test occursin("&lt;script&gt;alert(1)&lt;/script&gt;", eh) && occursin("\\u003cscript>alert(1)", eh)
    # more than 8 samples: heatmaps
    many = aggregate(fill(rs[1], 9); names = ["s$(i)" for i in 1:9])
    mh = read(report(many, joinpath(TMP, "many.html")), String)
    @test count("<svg class=\"chart heat\"", mh) == 6 && !occursin("class=\"legend\"", mh)
    @test occursin(r"<span>Q[0-9.]+</span><span class=\"bar\">", mh)              # quality heatmap legend in Q
    @test_throws ArgumentError report(s, joinpath(TMP, "agg.pdf"))
end
