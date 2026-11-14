# Reads kept by R dada2's filterAndTrim (rm.phix = FALSE) on its own example
# data, for a grid of settings; printed as TSV for truncation_compare_r.jl.
#   Rscript validation/truncation_compare_r.R > dada2_r_counts.tsv
suppressMessages(library(dada2))
d <- system.file("extdata", package = "dada2")
out <- tempfile(); dir.create(out)
cat("sample\tpaired\ttrim_left\ttrunc_q\tmin_len\ttrunc1\ttrunc2\tmax_ee\tkept\n")
for (s in c("sam1", "sam2")) {
  f <- file.path(d, paste0(s, "F.fastq.gz")); r <- file.path(d, paste0(s, "R.fastq.gz"))
  for (tl in c(0, 10)) for (tq in c(2, 11)) for (ee in c(0.5, 1, 2, 5, Inf))
    for (L in list(c(0, 0), c(240, 160), c(200, 200), c(150, 120), c(250, 250), c(30, 0))) {
      if ((L[1] > tl) != (L[2] > 0)) next
      o1 <- file.path(out, paste0("a", sample.int(1e9, 1), ".fastq.gz"))
      o2 <- file.path(out, paste0("b", sample.int(1e9, 1), ".fastq.gz"))
      x <- filterAndTrim(f, o1, r, o2, truncLen = L, trimLeft = c(tl, 0), truncQ = tq, maxN = 0,
                         maxEE = c(ee, ee), minLen = 20, rm.phix = FALSE, verbose = FALSE)
      cat(s, TRUE, tl, tq, 20, L[1], L[2], ee, x[1, "reads.out"], sep = "\t"); cat("\n")
      y <- filterAndTrim(f, o1, truncLen = L[1], trimLeft = tl, truncQ = tq, maxN = 0,
                         maxEE = ee, minLen = 20, rm.phix = FALSE, verbose = FALSE)
      cat(s, FALSE, tl, tq, 20, L[1], 0, ee, y[1, "reads.out"], sep = "\t"); cat("\n")
      unlink(c(o1, o2))
    }
}
