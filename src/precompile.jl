# Compile the analysis path for plain and gzip FASTQ at package precompilation,
# so the first `analyze` call in a session does not wait for compilation.
@setup_workload begin
    text = "@r1\nACGTNacgtR\n+\nIIII#####!\n@r2\n\n+\n\n@r3\nGGCC\n+\n5555\n"
    @compile_workload begin
        mktempdir() do dir
            plain = joinpath(dir, "w.fastq")
            write(plain, text)
            gz = joinpath(dir, "w.fastq.gz")
            open(gz, "w") do io
                s = GzipCompressorStream(io)
                write(s, text)
                close(s)
            end
            for p in (plain, gz)
                r = analyze(p; threads = 1)
                show(devnull, MIME"text/plain"(), r)
                yield_by_length(r)
                analyze(p; metrics = [ReadLength()], threads = 1)
                rf = analyze(p; metrics = FastQC.metrics(), threads = 1)
                FastQC.modules(rf)
                to_json(rf; fastqc = true)
                to_json(r)
            end
            # the command line (output discarded)
            redirect_stdout(devnull) do
                redirect_stderr(devnull) do
                    main(["analyze", "-q", "--fastqc", "--html", "-o", joinpath(dir, "cli"), plain])
                end
            end
            # the decompression task used with threads >= 2
            open(raw -> read(NoopStream(BlockPipe(raw))), gz)
        end
    end
end
