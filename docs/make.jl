using Documenter
using SeqQC

DocMeta.setdocmeta!(SeqQC, :DocTestSetup, :(using SeqQC); recursive=true)

makedocs(;
    modules=[SeqQC],
    sitename="SeqQC.jl",
    authors="Alex Laini",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://alexology.github.io/SeqQC.jl",
        edit_link="main",
        size_threshold_warn=150 * 2^10,
        size_threshold=400 * 2^10,
    ),
    pages=[
        "Home" => "index.md",
        "User guide" => [
            "Metrics" => "METRICS.md",
            "Multi-sample reports" => "MULTISAMPLE.md",
            "Command line" => "CLI.md",
            "JSON reports" => "JSON.md",
            "FastQC compatibility" => "FASTQC.md",
            "Truncation for DADA2" => "TRUNCATION.md",
        ],
        "Development" => [
            "Architecture" => "ARCHITECTURE.md",
            "Benchmarks" => "BENCHMARKS.md",
            "Roadmap" => "ROADMAP.md",
            "Development log" => "DEVELOPMENT.md",
        ],
        "API" => "api.md",
    ],
    checkdocs=:exports,
)

deploydocs(; repo="github.com/alexology/SeqQC.jl", devbranch="main")
