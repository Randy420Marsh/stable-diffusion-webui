@echo off

set "SD_ROOT_PATH=C://AI//stable_diffusion_models_and_vae"

set "PYTHON=python"
set GIT=
set VENV_DIR=
set COMMANDLINE_ARGS= --lora-dir "%SD_ROOT_PATH%//models//Lora" --gfpgan-dir "%SD_ROOT_PATH%//models//GFPGAN" --vae-dir "%SD_ROOT_PATH%//models//VAE" --ckpt-dir "%SD_ROOT_PATH%//models//" --embeddings-dir "%SD_ROOT_PATH%//models//embeddings" --codeformer-models-path "%SD_ROOT_PATH%//models//Codeformer" --gfpgan-models-path "%SD_ROOT_PATH%//models//GFPGAN" --esrgan-models-path "%SD_ROOT_PATH%//models//ESRGAN" --bsrgan-models-path "%SD_ROOT_PATH%//models//ESRGAN" --realesrgan-models-path "%SD_ROOT_PATH%//models//RealESRGAN" --controlnet-dir "%SD_ROOT_PATH%//models//ControlNet" --controlnet-annotator-models-path "%SD_ROOT_PATH%//models//ControlNet//annotator//models" --no-download-sd-model --port 4433 --opt-sdp-attention --medvram --theme=dark --precision autocast --api

REM use --opt-sdp-attention or --xformers

REM deprecated: --controlnet-dir "%SD_ROOT_PATH%//models//ControlNet" --controlnet-annotator-models-path "%SD_ROOT_PATH%//models//ControlNet//annotator//models"

call webui.bat
