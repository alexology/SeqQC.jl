# Adapter content and overrepresented sequences: merging and arguments
# (included from runtests.jl).

@testset "FastQC adapters and overrepresented: merging, arguments" begin
    F = SeqQC.FastQC
    rng = Xoshiro(202)
    reads = random_reads(rng, 400; lengths = 20:120)
    for i in 1:40                                          # adapters at varying positions
        id, s, q = reads[i]
        p = rand(rng, 1:max(1, length(s) - 12))
        reads[i] = (id, s[1:p-1] * "AGATCGGAAGAG" * s[p+12:end], q)
    end
    whole = analyze(write_plain("adm.fq", fastq_text(reads)); metrics = [F.AdapterContent()])
    merged = merged_states([write_plain("adm1.fq", fastq_text(reads[1:150])),
                            write_plain("adm2.fq", fastq_text(reads[151:end]))], [F.AdapterContent()])
    @test merged[1].fastqc_adapters.first_occurrence_starts ==
          whole.metrics.fastqc_adapters.fastqc_adapters.first_occurrence_starts
    @test merged[1].fastqc_adapters.reads == 400
    @test_throws ArgumentError merged_states([write_plain("adm1.fq", fastq_text(reads[1:150])),
                                              write_plain("adm2.fq", fastq_text(reads[151:end]))], [F.Overrepresented()])
    # custom adapters: names and sequences validated
    @test_throws ArgumentError F.AdapterContent(adapters = ["x" => "ACGN"])
    @test_throws ArgumentError F.AdapterContent(adapters = ["x" => "ACGT", "x" => "TTTT"])
    @test_throws ArgumentError F.AdapterContent(adapters = ["x" => "A"^33])
    r = analyze(write_plain("adc.fq", fastq_text([("a", "TTTTACGTACGT" * "T"^18, "I"^30), ("b", "G"^30, "I"^30)]));
                metrics = [F.AdapterContent(adapters = ["mine" => "acgtacgt"])])
    t = F.adapter_content(r)
    @test t.names == ["mine"] && t.values[1][end] == 50.0               # 1 of 2 reads, starting at 5
    # contaminant list parsing and the "No Hit" / hit format
    two = F.read_contaminants(joinpath(@__DIR__, "data", "fastqc", "two_contaminants.txt"))
    @test length(two) == 2 && first(two[1]) == "Illumina Paired End PCR Primer 2"
    @test F._possible_source("ACGT"^12, two) == "No Hit"
    seq = last(two[1])[6:55]
    @test F._possible_source(seq, two) == "Illumina Paired End PCR Primer 2 (100% over 50bp)"
    @test F._possible_source(F._revcomp(seq), two) == "Illumina Paired End PCR Primer 2 (100% over 50bp)"
    @test F._possible_source(seq, nothing) === nothing
    # Java String.hashCode reference values
    @test F._java_hash("ACGT") == UInt32(2003087)                       # 65*31^3 + 67*31^2 + 71*31 + 84
    @test F._java_hash("") == 0x00000000
    @test F._java_capacity(12) == 16 && F._java_capacity(13) == 32 && F._java_capacity(100_000) == 262144
end
