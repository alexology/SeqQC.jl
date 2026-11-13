# Process-level comparison of SeqQC.jl and FastQC (Windows PowerShell 5.1).
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File bench/compare_fastqc.ps1 -WorkDir <dir> -FastQC D:\FastQC `
#       -Inputs "label1=path1|label2=path2" -Julia <path to julia.exe> [-Reps 2]
#
# Inputs are separated by "|"; only labels are printed (no paths in results).
# FastQC exits with code 0 even when it fails (e.g. missing file), so a FastQC
# run counts as successful only if its zip report exists; "reads" is read from
# the report (FastQC) or printed by bench/seqqc_once.jl (SeqQC) as a cross-check.
#
# -ExecutionPolicy Bypass applies to that PowerShell process only.
# -Julia must be the real julia.exe (joinpath(Sys.BINDIR, "julia.exe")), not
# the juliaup launcher, which starts a child process and would hide its memory.
#
# Every run is a fresh process: wall-clock time includes JVM / Julia start-up.
# Peak memory = largest PeakWorkingSet64 seen while polling every 50 ms.
# FastQC is run with the JVM options of its own launcher (-Xmx512m), once with
# its default modules and once with only the modules that have a SeqQC
# counterpart; the reduced limits file is generated in WorkDir from FastQC's
# own Configuration/limits.txt (it is not stored in this repository).
param(
    [Parameter(Mandatory = $true)][string]$WorkDir,
    [Parameter(Mandatory = $true)][string]$FastQC,
    [Parameter(Mandatory = $true)][string]$Inputs,
    [int]$Reps = 2,
    [switch]$SkipFastQC,
    [Parameter(Mandatory = $true)][string]$Julia
)
$inv = [System.Globalization.CultureInfo]::InvariantCulture
$ErrorActionPreference = "Stop"
$pkg = Split-Path -Parent $PSScriptRoot
New-Item -ItemType Directory -Force $WorkDir | Out-Null
$out = Join-Path $WorkDir "fastqc_out"
New-Item -ItemType Directory -Force $out | Out-Null

# Reduced FastQC configuration: keep Basic Statistics (always on),
# per-sequence quality, per-sequence GC and length distribution.
$keep = @("quality_sequence", "gc_sequence", "sequence_length")
$limits = Join-Path $WorkDir "limits_reduced.txt"
$lines = Get-Content (Join-Path $FastQC "Configuration\limits.txt")
$new = foreach ($l in $lines) {
    if ($l -match '^\s*(\w+)\s+ignore\s+\d') {
        $m = $Matches[1]
        if ($keep -contains $m) { "$m`tignore`t0" } else { "$m`tignore`t1" }
    } else { $l }
}
[System.IO.File]::WriteAllLines($limits, [string[]]$new)

$cp = "$FastQC;$FastQC\htsjdk.jar;$FastQC\jbzip2-0.9.jar;$FastQC\cisd-jhdf5.jar"

function Measure-Run([string]$exe, [string]$argline) {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $exe
    $psi.Arguments = $argline
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $p = [System.Diagnostics.Process]::Start($psi)
    $so = $p.StandardOutput.ReadToEndAsync()
    $se = $p.StandardError.ReadToEndAsync()
    $peak = 0
    while (-not $p.HasExited) {
        try { $p.Refresh(); if ($p.PeakWorkingSet64 -gt $peak) { $peak = $p.PeakWorkingSet64 } } catch {}
        Start-Sleep -Milliseconds 50
    }
    $p.WaitForExit()
    $sw.Stop()
    return [pscustomobject]@{ wall = $sw.Elapsed.TotalSeconds; peak_mb = [math]::Round($peak / 1MB, 0);
                              code = $p.ExitCode; stdout = $so.Result.Trim(); stderr = $se.Result }
}

Add-Type -AssemblyName System.IO.Compression.FileSystem

# FastQC names its report after the file name without .gz and .fastq/.fq.
function FastQC-Reads([string]$path) {
    $name = [System.IO.Path]::GetFileName($path)
    $name = $name -replace '\.gz$', '' -replace '\.(fastq|fq)$', ''
    $zip = Join-Path $out ($name + "_fastqc.zip")
    if (-not (Test-Path $zip)) { return $null }
    $z = [System.IO.Compression.ZipFile]::OpenRead($zip)
    try {
        $e = $z.Entries | Where-Object { $_.FullName -like "*/fastqc_data.txt" } | Select-Object -First 1
        $rd = New-Object System.IO.StreamReader($e.Open())
        $text = $rd.ReadToEnd(); $rd.Close()
    } finally { $z.Dispose() }
    if ($text -match "Total Sequences	(\d+)") { return $Matches[1] } else { return "?" }
}

function Clear-Report([string]$path) {
    $name = [System.IO.Path]::GetFileName($path) -replace '\.gz$', '' -replace '\.(fastq|fq)$', ''
    foreach ($ext in @("_fastqc.zip", "_fastqc.html")) {
        $f = Join-Path $out ($name + $ext)
        if (Test-Path $f) { Remove-Item $f -Force -Confirm:$false }
    }
}

Write-Output "| input | tool | configuration | runs (s) | min wall (s) | peak memory (MB) | reads | ok |"
Write-Output "|---|---|---|---|---:|---:|---:|---|"
foreach ($item in $Inputs.Split("|")) {
    $k = $item.IndexOf("=")
    $label = $item.Substring(0, $k)
    $path = $item.Substring($k + 1)
    $configs = @(
        @{ tool = "FastQC 0.12.1"; conf = "default modules"; exe = "java";
           args = "-Xmx512m -XX:+ExitOnOutOfMemoryError -Djava.awt.headless=true -cp `"$cp`" -Dfastqc.output_dir=`"$out`" uk.ac.babraham.FastQC.FastQCApplication -q `"$path`"" },
        @{ tool = "FastQC 0.12.1"; conf = "reduced modules"; exe = "java";
           args = "-Xmx512m -XX:+ExitOnOutOfMemoryError -Djava.awt.headless=true -cp `"$cp`" -Dfastqc.output_dir=`"$out`" -Dfastqc.limits_file=`"$limits`" uk.ac.babraham.FastQC.FastQCApplication -q `"$path`"" },
        @{ tool = "SeqQC.jl"; conf = "default metrics, 1 thread"; exe = $Julia;
           args = "--project=`"$pkg`" --threads=1 `"$pkg\bench\seqqc_once.jl`" `"$path`" 1" },
        @{ tool = "SeqQC.jl"; conf = "default metrics, threads=2"; exe = $Julia;
           args = "--project=`"$pkg`" --threads=2 `"$pkg\bench\seqqc_once.jl`" `"$path`" 2" }
    )
    foreach ($c in $configs) {
        if ($SkipFastQC -and $c.tool -like "FastQC*") { continue }
        $walls = @(); $peaks = @(); $ok = $true; $reads = "?"
        for ($i = 0; $i -lt $Reps; $i++) {
            if ($c.tool -like "FastQC*") { Clear-Report $path }
            $r = Measure-Run $c.exe $c.args
            $walls += $r.wall; $peaks += $r.peak_mb
            if ($c.tool -like "FastQC*") { $reads = FastQC-Reads $path } else { $reads = ($r.stdout -split "`t")[0] }
            if ($r.code -ne 0 -or $null -eq $reads -or $reads -eq "") {
                $ok = $false
                [Console]::Error.WriteLine("failed: " + $c.tool + " " + $c.conf + " on " + $label + "`n" + $r.stderr)
            }
        }
        $runs = ($walls | ForEach-Object { $_.ToString("F2", $inv) }) -join " / "
        $min = (($walls | Measure-Object -Minimum).Minimum).ToString("F2", $inv)
        $pk = ($peaks | Measure-Object -Maximum).Maximum
        Write-Output "| $label | $($c.tool) | $($c.conf) | $runs | $min | $pk | $reads | $ok |"
    }
}
