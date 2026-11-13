@echo off
rem Launcher for the SeqQC command line. Threads: SEQQC_THREADS (default: auto).
if "%SEQQC_THREADS%"=="" (set "_SEQQC_T=auto") else (set "_SEQQC_T=%SEQQC_THREADS%")
julia --project="%~dp0.." --startup-file=no -t %_SEQQC_T% "%~dp0seqqc.jl" %*
exit /b %ERRORLEVEL%
