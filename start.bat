@echo off

REM set "SD_ROOT_PATH=E://AI//stable_diffusion_models_and_vae"

set "SD_ROOT_PATH=H://AI//stable_diffusion_models_and_vae"

REM set DREAMBOOTH_SKIP_INSTALL=True

REM set HF_DATASETS_OFFLINE=1
REM set TRANSFORMRRS_OFFLINE=1

set "PYTHON=python"
set GIT=
set VENV_DIR=
set COMMANDLINE_ARGS= --controlnet-dir "%SD_ROOT_PATH%//models//ControlNet" --controlnet-annotator-models-path "%SD_ROOT_PATH%//models//ControlNet//annotator//models" --lora-dir "%SD_ROOT_PATH%//models//Lora" --gfpgan-dir "%SD_ROOT_PATH%//models//GFPGAN" --vae-dir "%SD_ROOT_PATH%//models//VAE" --ckpt-dir "%SD_ROOT_PATH%//models//" --embeddings-dir "%SD_ROOT_PATH%//models//embeddings" --codeformer-models-path "%SD_ROOT_PATH%//models//Codeformer" --gfpgan-models-path "%SD_ROOT_PATH%//models//GFPGAN" --esrgan-models-path "%SD_ROOT_PATH%//models//ESRGAN" --bsrgan-models-path "%SD_ROOT_PATH%//models//ESRGAN" --realesrgan-models-path "%SD_ROOT_PATH%//models//RealESRGAN" --no-download-sd-model --port 4433 --theme=dark --precision autocast --opt-split-attention --medvram --api

REM  --skip-install

REM deprecated, ADDED BACK AND WORKING: --controlnet-dir "%SD_ROOT_PATH%//models//ControlNet" --controlnet-annotator-models-path "%SD_ROOT_PATH%//models//ControlNet//annotator//models"

call webui.bat

