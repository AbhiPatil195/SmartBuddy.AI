Param(
    [string]$Python = "python",
    [switch]$UseLock
)

$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here

Write-Host "==> Working directory: $here" -ForegroundColor DarkGray
Write-Host "==> Creating venv .venv (if missing)" -ForegroundColor Cyan

$venvDir = Join-Path -Path $here -ChildPath ".venv"
$venvPython = Join-Path -Path $venvDir -ChildPath "Scripts/python.exe"

if (!(Test-Path $venvDir)) {
    & $Python -m venv $venvDir
}

Write-Host "==> Upgrading pip/setuptools/wheel" -ForegroundColor Cyan
& $venvPython -m pip install --upgrade pip setuptools wheel
if ($LASTEXITCODE -ne 0) { throw "pip upgrade failed" }

$req = if ($UseLock) { "requirements.lock.txt" } else { "requirements.txt" }
if (!(Test-Path $req)) { throw "Requirements file not found: $req" }
Write-Host "==> Installing deps from $req" -ForegroundColor Cyan
& $venvPython -m pip install -r $req
if ($LASTEXITCODE -ne 0) { throw "Dependency installation failed" }

Write-Host "==> Done. To run:" -ForegroundColor Green
Write-Host "    .\.venv\Scripts\python -m streamlit run app.py" -ForegroundColor Green
