# Compare the counts of truncation_compare_r.R (R dada2 filterAndTrim) with
# SeqQC's kept_reads.
#   julia --project=. validation/truncation_compare_r.jl dada2_r_counts.tsv DADA2_EXTDATA_DIR
# DADA2_EXTDATA_DIR: Rscript -e 'cat(system.file("extdata", package = "dada2"))'

using SeqQC
tsv, dir = ARGS
rows = [split(l, '\t') for l in readlines(tsv)[2:end] if !isempty(l)]
cache = Dict{Any,TruncationProfile}()
n = 0
for r in rows
    s, paired, tl, tq, ml, L1, L2, ee, kept = r
    paired = paired == "TRUE"
    tl, tq, ml, L1, L2, kept = parse.(Int, (tl, tq, ml, L1, L2, kept))
    e = ee == "Inf" ? Inf : parse(Float64, ee)
    f1, f2 = joinpath(dir, s * "F.fastq.gz"), joinpath(dir, s * "R.fastq.gz")
    key = (s, paired, tl, tq, ml)
    p = get!(cache, key) do
        kw = (max_ee = [0.5, 1, 2, 5, Inf], trunc_q = tq, min_len = ml)
        paired ? truncation_profile(f1, f2; trim_left = (tl, 0), kw...) : truncation_profile(f1; trim_left = tl, kw...)
    end
    got = paired ? kept_reads(p, (L1, L2), e) : kept_reads(p, L1, e)
    got == kept || error("$(join(r, ' ')): R dada2 $(kept), SeqQC $(got)")
    global n += 1
end
println("all ", n, " counts identical to R dada2")
