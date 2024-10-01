::get-python-win.bat

@echo off

set "url=https://github.com/Randy420Marsh/cpython/releases/download/v3.10.12/Python-3.10.12.zip"
set "filename=Python-3.10.12.zip"
set "extracted_folder=Python-3.10.12"

REM Check if the file already exists
if exist "%filename%" (
    echo python already exists. Exiting...
)

REM If the file does not exist, download it first
echo Downloading python...
curl -LO %url%
cmd /k tar -xf "%filename%" "%extracted_folder%"
