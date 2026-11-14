# Exact comparison of SeqQC's truncation profile with DADA2.jl's read filter.
#
#   julia validation/truncation_compare.jl DADA2_JL_PATH R1.fastq[.gz] R2.fastq[.gz] [R1 R2 ...]
#
# DADA2_JL_PATH is a local checkout of DADA2.jl (module Dada2). For every input
# pair and a grid of trimLeft / truncQ / minLen / truncLen / maxEE values, the
# reads and pairs kept by `Dada2.filtered` (rmPhix = false) are counted and
# compared with `kept_reads`. A synthetic file with low qualities, N, short
# reads and expected errors close to the thresholds is added. Exits with an
# error on the first difference.

using Pkg
length(ARGS) >= 3 && isodd(length(ARGS)) ||
    error("usage: julia truncation_compare.jl DADA2_JL_PATH R1 R2 [R1 R2 ...]")
Pkg.activate(; temp = true, io = devnull)
Pkg.develop([PackageSpec(path = dirname(@__DIR__)), PackageSpec(path = ARGS[1])]; io = devnull)
using SeqQC, Dada2, Random

function synthetic(dir)
    rng = MersenneTwister(20261114)
    f1, f2 = joinpath(dir, "syn_R1.fastq"), joinpath(dir, "syn_R2.fastq")
    open(f1, "w") do o1
        open(f2, "w") do o2
            for i in 1:3000
                for o in (o1, o2)
                    n = rand(rng) < 0.1 ? rand(rng, 1:60) : 150
                    seq = [rand(rng) < 0.003 ? 'N' : rand(rng, "ACGT") for _ in 1:n]
                    base = rand(rng, (8, 15, 25, 35))
                    q = [clamp(base + rand(rng, -8:8) - (j ÷ 15), 0, 41) for j in 1:n]
                    rand(rng) < 0.05 && n > 0 && (q[rand(rng, 1:n)] = rand(rng, 0:2))
                    println(o, "@r", i, i % 2 == 0 ? "/$(o === o1 ? 1 : 2)" : "", " extra")
                    println(o, String(seq), "\n+\n", String(Char.(q .+ 33)))
                end
            end
        end
    end
    return f1, f2
end

read_all(path) = collect(Dada2.FastqReader(path))

function compare(f1, f2)
    recs = (read_all(f1), read_all(f2))
    n = length(recs[1])
    maxlen = maximum(length(r.sequence) for rs in recs for r in rs)
    grid = unique([0; 20:10:maxlen; maxlen])
    thresholds = [0.5, 1.0, 1.7, 2.0, 3.0, Inf]
    checked = 0
    for tl in (0, 7), tq in (2, 11), ml in (20, 50)
        p1 = truncation_profile(f1; max_ee = thresholds, trim_left = tl, trunc_q = tq, min_len = ml)
        pp = truncation_profile(f1, f2; max_ee = thresholds, trim_left = (tl, 0), trunc_q = tq, min_len = ml)
        for e in thresholds
            # pass[j][read, L index]
            pass = map(1:2) do j
                [Dada2.filtered(recs[j][i], Dada2.FilterOptions(trimLeft = j == 1 ? tl : 0, truncLen = L,
                    truncQ = tq, maxEE = e, minLen = ml, rmPhix = false)) !== nothing for i in 1:n, L in grid]
            end
            for (a, L) in enumerate(grid)
                want = count(view(pass[1], :, a))
                got = kept_reads(p1, L, e)
                want == got || error("single-end $(f1) trimLeft=$(tl) truncQ=$(tq) minLen=$(ml) truncLen=$(L) maxEE=$(e): DADA2.jl $(want), SeqQC $(got)")
                checked += 1
                for (b, L2) in enumerate(grid)
                    (L <= tl) == (L2 <= 0) || continue            # both truncated or neither
                    want2 = count(view(pass[1], :, a) .& view(pass[2], :, b))
                    got2 = kept_reads(pp, (L, L2), e)
                    want2 == got2 || error("paired $(f1) trimLeft=$(tl) truncQ=$(tq) minLen=$(ml) truncLen=($(L),$(L2)) maxEE=$(e): DADA2.jl $(want2), SeqQC $(got2)")
                    checked += 1
                end
            end
        end
    end
    println(basename(f1), " + ", basename(f2), ": ", n, " pairs, ", checked, " counts identical")
    return checked
end

total = 0
mktempdir() do dir
    pairs = [(ARGS[i], ARGS[i + 1]) for i in 2:2:length(ARGS)]
    push!(pairs, synthetic(dir))
    for (a, b) in pairs
        global total += compare(a, b)
    end
end
println("all ", total, " counts identical")
