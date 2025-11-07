@echo off
REM Run app with local venv without manual activation, relative to this script
setlocal
set SCRIPT_DIR=%~dp0
set VENV_PY=%SCRIPT_DIR%\.venv\Scripts\python.exe
if not exist "%VENV_PY%" (
  echo Virtual environment not found. Run install.ps1 first.
  exit /b 1
)
pushd "%SCRIPT_DIR%"
"%VENV_PY%" -m streamlit run app_v2.py
popd
