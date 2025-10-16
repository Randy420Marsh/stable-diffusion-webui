@echo off

set PATH=C:\Users\John\AppData\Local\Programs\Python\Python310;%PATH%

set PYTHON=
set GIT=
set VENV_DIR=
set "COMMANDLINE_ARGS= --no-download-sd-model --port 4433 --theme=dark --api --use-cpu all --precision full --no-half --skip-torch-cuda-test"

call webui.bat
