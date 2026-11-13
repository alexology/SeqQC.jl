# JSON report (included from runtests.jl; uses its helpers and TMP).

@testset "JSON report" begin
    reads = random_reads(Xoshiro(55), 300; lengths = 20:200)
    p = write_plain("json.fq", fastq_text(reads))
    r = analyze(p; metrics = SeqQC.FastQC.metrics(), threads = 1)
    js = to_json(r)
    d = JSON3.read(js)                                    # independent parser: the document is valid JSON
    @test d.schema == "seqqc-result" && d.schema_version == "1.0.0"
    @test d.total_reads == r.total_reads && d.total_bases == r.total_bases
    @test d.metrics.read_length.n50 == r.n50
    @test d.metrics.read_length.length_histogram.lengths == r.length_histogram.lengths
    @test d.metrics.quality.mean_read_quality == r.mean_read_quality          # shortest round-trip repr
    @test d.metrics.quality.reads_at_least.Q20 == r.metrics.quality.reads_at_least.Q20
    @test d.settings.phred_offset == 33 && d.settings.max_reads === nothing
    @test d.settings.definitions.read_length == definition(ReadLength())
    @test d.input.compression == "none" && d.software.name == "SeqQC"

    # matrices as arrays of rows
    bc = r.metrics.per_position.per_position.base_counts
    @test length(d.metrics.per_position.per_position.base_counts) == size(bc, 1)
    @test collect(d.metrics.per_position.per_position.base_counts[3]) == bc[3, :]

    # omitted fields are dropped and declared
    @test !occursin("\"raw_quality_histograms\":", js)
    @test d.omitted_fields == ["raw_quality_histograms"]
    full = JSON3.read(to_json(r; omit = ()))
    @test length(full.metrics.per_position.per_position.raw_quality_histograms) == 94
    @test isempty(full.omitted_fields)

    # FastQC tables on request; NaN written as null
    f = JSON3.read(to_json(r; fastqc = true))
    @test d.fastqc === nothing
    @test f.fastqc.modules.flags.per_base_quality == string(SeqQC.FastQC.flags(r).per_base_quality)
    @test f.fastqc.modules.per_base_quality.base == SeqQC.FastQC.per_base_quality(r).base
    q = SeqQC.FastQC.per_base_quality(r).median
    @test any(isnan, q)
    @test all((isnan(x) && y === nothing) || x == y for (x, y) in zip(q, f.fastqc.modules.per_base_quality.median))

    # deterministic apart from runtime
    strip_runtime(s) = replace(s, r"\"runtime\":\{[^}]*\}" => "")
    again = to_json(analyze(p; metrics = SeqQC.FastQC.metrics(), threads = 1))
    @test strip_runtime(again) == strip_runtime(js)

    # string escaping, checked with an independent parser
    tricky = "a\"b\\c\nd\te\u01f\u7f é€😀"
    io = IOBuffer()
    SeqQC._json_string(io, tricky)
    @test JSON3.read("[" * String(take!(io)) * "]")[1] == tricky

    # empty input: undefined statistics are null
    e = JSON3.read(to_json(analyze(write_plain("json_empty.fq", ""))))
    @test e.metrics.read_length.n50 === nothing && e.total_reads == 0

    # files and report()
    dir = mkpath(joinpath(TMP, "json_out"))
    out = joinpath(dir, "r.json")
    @test report(r, out) == out
    @test JSON3.read(read(out, String)).total_reads == r.total_reads
    write(out, "old")
    write_json(out, r)
    @test startswith(read(out, String), "{\"schema\"")
    @test readdir(dir) == ["r.json"]                                          # no temporary left behind
    @test_throws ArgumentError report(r, joinpath(dir, "r.pdf"))
    @test_throws ArgumentError write_json(joinpath(dir, "no_such_dir", "r.json"), r)
    @test_throws ArgumentError SeqQC._json(IOBuffer(), (x = 1im,), ())
end
