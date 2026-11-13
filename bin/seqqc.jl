# SeqQC command line.
#   julia --project=<path to SeqQC.jl> -t auto bin/seqqc.jl analyze [options] FILE...
# or use the launchers bin/seqqc (Unix) and bin/seqqc.cmd (Windows).
using SeqQC
exit(SeqQC.main(ARGS))
