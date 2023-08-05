@echo off

SET current_path=%CD%

cd %current_path%

setlocal enabledelayedexpansion

set "python=%current_path%\Python-3.10.12\python"

IF exist ./venv (cmd /k call %current_path%\venv\scripts\activate.bat)  ELSE (cmd /k %current_path%\Python-3.10.12\python -m venv venv && cmd /k call .%current_path%\venv\scripts\activate.bat)