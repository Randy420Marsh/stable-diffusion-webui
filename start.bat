@echo off

REM set "SD_ROOT_PATH=E://AI//stable_diffusion_models_and_vae"

set "SD_ROOT_PATH=F://AI//stable_diffusion_models_and_vae"

set "PYTHON=python"
set GIT=
set VENV_DIR=
set COMMANDLINE_ARGS= --controlnet-dir "%SD_ROOT_PATH%//models//ControlNet" --controlnet-annotator-models-path "%SD_ROOT_PATH%//models//ControlNet//annotator//models" --lora-dir "%SD_ROOT_PATH%//models//Lora" --gfpgan-dir "%SD_ROOT_PATH%//models//GFPGAN" --vae-dir "%SD_ROOT_PATH%//models//VAE" --ckpt-dir "%SD_ROOT_PATH%//models//" --embeddings-dir "%SD_ROOT_PATH%//models//embeddings" --codeformer-models-path "%SD_ROOT_PATH%//models//Codeformer" --gfpgan-models-path "%SD_ROOT_PATH%//models//GFPGAN" --esrgan-models-path "%SD_ROOT_PATH%//models//ESRGAN" --bsrgan-models-path "%SD_ROOT_PATH%//models//ESRGAN" --realesrgan-models-path "%SD_ROOT_PATH%//models//RealESRGAN" --no-download-sd-model --port 4433 --opt-split-attention --medvram --theme=dark --precision autocast --api

REM deprecated, ADDED BACK AND WORKING: --controlnet-dir "%SD_ROOT_PATH%//models//ControlNet" --controlnet-annotator-models-path "%SD_ROOT_PATH%//models//ControlNet//annotator//models"

call webui.bat
