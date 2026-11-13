# FastQC-format text outputs, single-sample HTML and command line
# (included from runtests.jl).

@testset "FastQC text: number formats" begin
    J = SeqQC._jdouble
    @test J(21.0) == "21.0" && J(0.0) == "0.0" && J(-0.0) == "-0.0" && J(NaN) == "NaN"
    @test J(0.7000000000000001) == "0.7000000000000001" && J(58.333333333333336) == "58.333333333333336"
    @test J(6.666666666666666e-4) == "6.666666666666666E-4" && J(0.001) == "0.001" && J(1.0e-4) == "1.0E-4"
    @test J(1.0e7) == "1.0E7" && J(9.999999e6) == "9999999.0" && J(1.2345e7) == "1.2345E7" && J(123.0) == "123.0"
    @test J(Inf) == "Infinity" && J(-2.5e-5) == "-2.5E-5" && J(5) == "5.0"
    B = SeqQC._fastqc_bases
    @test [B(x) for x in (0, 999, 1000, 1050, 1099, 1999, 2051, 6_992_319, 150_000_000, 275_021_198, 1_588_340_593)] ==
          ["0 bp", "999 bp", "1 kbp", "1 kbp", "1 kbp", "1.9 kbp", "2 kbp", "6.9 Mbp", "150 Mbp", "275 Mbp", "1.5 Gbp"]
end

# Normalise a fastqc_data.txt for comparison: drop the header line and the
# modules SeqQC does not write, mask the per-sequence GC status and, when no
# contaminant list was used, the "Possible Source" column.
function fastqc_text_lines(lines; mask_source::Bool)
    out = String[]
    skip = false
    inover = false
    for l in lines[2:end]
        l = String(l)
        if startswith(l, ">>END_MODULE")
            inover = false
            if skip
                skip = false
                continue
            end
        elseif startswith(l, ">>")
            name = split(l[3:end], '\t')[1]
            skip = name in ("Per tile sequence quality", "Sequence Duplication Levels")
            inover = name == "Overrepresented sequences"
            name == "Per sequence GC content" && (l = ">>Per sequence GC content\t<status>")
        elseif startswith(l, "Filename	")
            l = "Filename	<name>"                      # fixtures were renamed when copied
        elseif inover && mask_source && !startswith(l, "#")
            l = join(split(l, '\t')[1:3], '\t')
        end
        skip || push!(out, l)
    end
    return out
end

@testset "FastQC text: fastqc_data.txt and summary.txt vs FastQC 0.12.1" begin
    F = SeqQC.FastQC
    dir = joinpath(@__DIR__, "data", "fastqc")
    two = joinpath(dir, "two_contaminants.txt")
    for name in [replace(f, ".fastq" => "") for f in readdir(dir) if endswith(f, ".fastq")]
        contam = startswith(name, "ov_contam") ? two : nothing
        r = analyze(joinpath(dir, name * ".fastq"); metrics = F.metrics(; contaminants = contam), threads = 1)
        io = IOBuffer()
        write_fastqc_data(io, r; filename = name * ".fastq")
        text = String(take!(io))
        @test startswith(text, "##SeqQC\t")
        ours = fastqc_text_lines(split(text, '\n'; keepempty = false); mask_source = contam === nothing)
        theirs = fastqc_text_lines(readlines(joinpath(dir, name * ".fastqc_data.txt")); mask_source = contam === nothing)
        @test ours == theirs
        io = IOBuffer()
        write_fastqc_summary(io, r; filename = name * ".fastq")
        lines = split(String(take!(io)), '\n'; keepempty = false)
        @test length(lines) == 9 && startswith(lines[1], "PASS\tBasic Statistics\t")
        @test any(l -> startswith(l, "NA\tPer sequence GC content"), lines)
    end
    io = IOBuffer()
    r = analyze(joinpath(dir, "group.fastq"); metrics = F.metrics())
    write_fastqc_data(io, r; fastqc_header = true)
    @test startswith(String(take!(io)), "##FastQC\t0.12.1\n")
    @test_throws ArgumentError write_fastqc_data(IOBuffer(), analyze(joinpath(dir, "group.fastq")))   # no FastQC metrics
end

@testset "single-sample HTML" begin
    F = SeqQC.FastQC
    dir = joinpath(@__DIR__, "data", "fastqc")
    r = analyze(joinpath(dir, "ov_contam_e.fastq");
                metrics = vcat(default_metrics(), F.metrics(; contaminants = joinpath(dir, "two_contaminants.txt"))[3:end]))
    html = read(report(r, joinpath(TMP, "single.html")), String)
    @test occursin("FastQC-compatible modules", html) && occursin("Quality per base", html)
    @test occursin("Overrepresented sequences", html) && occursin("Illumina Paired End PCR Primer 2", html)
    @test count("<section class=\"card", html) >= 8
    @test !occursin("NaN", replace(html, r"<script>.*?</script>"s => ""))
    plain = read(report(analyze(joinpath(dir, "group.fastq")), joinpath(TMP, "plain.html")), String)
    @test !occursin("<h2>FastQC-compatible modules</h2>", plain) && occursin("Read length distribution", plain)
    @test occursin("class=\"tiles\"", plain)
    # FastQC tables unavailable: the page says why instead of failing
    long = analyze(write_plain("longread.fq", fastq_text([("a", "A"^300, "I"^300)]));
                   metrics = vcat(default_metrics(), F.metrics(; max_positions = 100)[3:end]))
    lh = read(report(long, joinpath(TMP, "long.html")), String)
    @test occursin("Not available", lh)
end

@testset "command line" begin
    dir = joinpath(@__DIR__, "data", "fastqc")
    out = mkpath(joinpath(TMP, "cli_out"))
    quietly(f) = redirect_stdout(devnull) do
        redirect_stderr(devnull) do
            f()
        end
    end
    @test quietly(() -> SeqQC.main(["--version"])) == 0
    @test quietly(() -> SeqQC.main(["--help"])) == 0
    @test quietly(() -> SeqQC.main(String[])) == 2
    @test quietly(() -> SeqQC.main(["frobnicate"])) == 2
    @test quietly(() -> SeqQC.main(["analyze"])) == 2
    @test quietly(() -> SeqQC.main(["analyze", "--bogus", "x.fq"])) == 2
    @test quietly(() -> SeqQC.main(["analyze", "--phred-offset", "40", "x.fq"])) == 2
    @test quietly(() -> SeqQC.main(["analyze", "--contaminants", "x.txt", "x.fq"])) == 2      # needs --fastqc
    files = [joinpath(dir, f) for f in ("group.fastq", "ov_contam_e.fastq")]
    @test quietly(() -> SeqQC.main(["analyze", "-q", "--fastqc", "--html", "--contaminants",
                                    joinpath(dir, "two_contaminants.txt"), "-o", out, files...])) == 0
    produced = Set(readdir(out))
    for n in ("group", "ov_contam_e"), suffix in (".seqqc.json", "_fastqc_data.txt", "_summary.txt", ".html")
        @test n * suffix in produced
    end
    @test issubset(["seqqc_report.html", "seqqc_report.tsv", "seqqc_report.json"], produced)
    @test read_json(joinpath(out, "group.seqqc.json"))["total_reads"] == analyze(files[1]).total_reads
    # a missing input: reported, the others still analysed, exit code 1
    out2 = mkpath(joinpath(TMP, "cli_out2"))
    @test quietly(() -> SeqQC.main(["analyze", "-q", "-o", out2, files[1], joinpath(dir, "missing.fastq")])) == 1
    @test isfile(joinpath(out2, "group.seqqc.json")) && isfile(joinpath(out2, "seqqc_report.html"))
    # --no-report and report from saved JSON
    out3 = mkpath(joinpath(TMP, "cli_out3"))
    @test quietly(() -> SeqQC.main(["analyze", "-q", "--no-report", "-o", out3, files...])) == 0
    @test !isfile(joinpath(out3, "seqqc_report.html"))
    @test quietly(() -> SeqQC.main(["report", "-q", "-o", joinpath(out3, "all.html"), out3])) == 0
    @test isfile(joinpath(out3, "all.html")) && isfile(joinpath(out3, "all.tsv")) && isfile(joinpath(out3, "all.json"))
    @test quietly(() -> SeqQC.main(["report", "-o", "x.pdf", out3])) == 2
end
