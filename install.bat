@ECHO OFF
REM Windows is utterly absurd.
REM Powershell has an execution policy, set by default to block all scripts.
REM It can be bypassed trivially, even to run as admin.
REM This BAT file will run any PS1 file with the same name, as admin.
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dpn0.ps1""' -Verb RunAs}";

