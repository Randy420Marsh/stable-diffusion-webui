::get-python-win.bat

@echo off

set "url=https://github.com/Randy420Marsh/cpython/releases/download/v3.10.12/Python-3.10.12.zip"
set "filename=Python-3.10.12.zip"
set "extracted_folder=Python-3.10.12"

REM Check if the file already exists
if exist "%filename%" (
    echo File already exists. Exiting...
    exit /b
)

REM If the file does not exist, download it first
echo Downloading the file...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%url%', '%filename%')"

REM Extract the downloaded file
echo Extracting the downloaded file...
tar -xf "%filename%" -C "%extracted_folder%"
