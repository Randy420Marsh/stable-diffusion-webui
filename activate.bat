@echo off

set current_path=%CD%

cd %current_path%

setlocal enabledelayedexpansion

set "python=python"

IF exist ./venv (cmd /k call %current_path%\venv\scripts\activate.bat)  ELSE (cmd /k python -m venv venv && cmd /k call .%current_path%\venv\scripts\activate.bat)