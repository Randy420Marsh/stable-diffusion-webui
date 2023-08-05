@echo off

SET current_path=%CD%

cd %current_path%

setlocal enabledelayedexpansion

set "python=%current_path%\Python-3.10.12\python"

IF exist ./venv (cmd /k call .\venv\scripts\activate.bat)  ELSE (cmd /k .\Python-3.10.12\python -m venv venv && cmd /k call .\venv\scripts\activate.bat)