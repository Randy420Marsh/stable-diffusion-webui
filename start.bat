@echo off

set BNB_CUDA_VERSION=118

set "SD_ROOT_PATH=H://AI//stable_diffusion_models_and_vae"

set DREAMBOOTH_SKIP_INSTALL=True

set HF_DATASETS_OFFLINE=1
set TRANSFORMRRS_OFFLINE=1

set "PYTHON=python"
set GIT=
set VENV_DIR=venv
set COMMANDLINE_ARGS= --controlnet-dir "%SD_ROOT_PATH%//models//ControlNet" --controlnet-annotator-models-path "%SD_ROOT_PATH%//models//ControlNet//annotator//models" --lora-dir "%SD_ROOT_PATH%//models//Lora" --gfpgan-dir "%SD_ROOT_PATH%//models//GFPGAN" --vae-dir "%SD_ROOT_PATH%//models//VAE" --ckpt-dir "%SD_ROOT_PATH%//models//" --embeddings-dir "%SD_ROOT_PATH%//models//embeddings" --codeformer-models-path "%SD_ROOT_PATH%//models//Codeformer" --gfpgan-models-path "%SD_ROOT_PATH%//models//GFPGAN" --esrgan-models-path "%SD_ROOT_PATH%//models//ESRGAN" --bsrgan-models-path "%SD_ROOT_PATH%//models//ESRGAN" --realesrgan-models-path "%SD_ROOT_PATH%//models//RealESRGAN" --no-download-sd-model --port 4433 --theme=dark --precision autocast --opt-split-attention --lowvram --api --skip-install --loglevel ERROR --xformers

call webui.bat

