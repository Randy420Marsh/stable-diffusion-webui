#!/bin/bash
#################################################
# Please do not make any changes to this file,  #
# change the variables in webui-user.sh instead #
#################################################

# Determine the maximum number of available CPU threads
MAX_THREADS=$(nproc)

# Set the environment variables
export omp_set_max_active_levels=$MAX_THREADS
export MKL_NUM_THREADS=$MAX_THREADS

#export DREAMBOOTH_SKIP_INSTALL=True

#export HF_DATASETS_OFFLINE=1
#export TRANSFORMRRS_OFFLINE=1

echo "Using $MAX_THREADS threads for OMP and MKL"

export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so:$LD_PRELOAD
export MALLOC_CONF="oversize_threshold:1,background_thread:true,metadata_thp:auto,dirty_decay_ms: 60000,muzzy_decay_ms:60000"
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libiomp5.so:$LD_PRELOAD

#Uncomment as needed...
#and change the webui.sh to point to this file instead of webui-user.sh
##########################################

AUTOMATIC1111_WEBUI="AUTOMATIC1111"

##########################################

# python3 executable
python_cmd="./venv/bin/python"

##########################################

cd $PWD

# "/media/your-username/your-drive-uuid/AUTOMATIC1111-dir"

SD_ROOT_PATH="/media/john/A024FBBA24FB9210/AI/stable_diffusion_models_and_vae"

export SD_ROOT_PATH="/media/john/A024FBBA24FB9210/AI/stable_diffusion_models_and_vae"

echo "Current active SD root path:"

echo $SD_ROOT_PATH

##########################################

USER="$USER"

export USER=$USER

echo "Current User: $USER"

#Custom AUTOMATIC1111 webui root path

export SAFETENSORS_FAST_GPU=1

export PYTORCH_CUDA_ALLOC_CONF=garbage_collection_threshold:0.9,max_split_size_mb:512

##########################################

#echo "loading models from default path:"

#export COMMANDLINE_ARGS="--port 4433 --opt-split-attention --theme=dark --precision autocast --api"

##########################################

echo "loading models from custom path:"

export COMMANDLINE_ARGS="--controlnet-dir "%SD_ROOT_PATH%/models/ControlNet" --controlnet-annotator-models-path "%SD_ROOT_PATH%/models/ControlNet/annotator/models" --lora-dir "%SD_ROOT_PATH%/models/Lora" --gfpgan-dir "%SD_ROOT_PATH%/models/GFPGAN" --vae-dir "%SD_ROOT_PATH%/models/VAE" --ckpt-dir "%SD_ROOT_PATH%/models/" --embeddings-dir "%SD_ROOT_PATH%/models/embeddings" --codeformer-models-path "%SD_ROOT_PATH%/models/Codeformer" --gfpgan-models-path "%SD_ROOT_PATH%/models/GFPGAN" --esrgan-models-path "%SD_ROOT_PATH%/models/ESRGAN" --bsrgan-models-path "%SD_ROOT_PATH%/models/ESRGAN" --realesrgan-models-path "%SD_ROOT_PATH%/models/RealESRGAN" --no-download-sd-model --port 4433 --theme=dark --precision autocast --opt-split-attention --lowvram --api --loglevel ERROR"

##########################################


# Install directory without trailing slash
#install_dir="/home/$(whoami)"

# Name of the subdirectory
#clone_dir="stable-diffusion-webui"

# Commandline arguments for webui.py, for example: export COMMANDLINE_ARGS="--medvram --opt-split-attention"
#export COMMANDLINE_ARGS=""

# git executable
#export GIT="git"

# python3 venv without trailing slash (defaults to ${install_dir}/${clone_dir}/venv)
#venv_dir="venv"

# script to launch to start the app
#export LAUNCH_SCRIPT="launch.py"

# install command for torch
export TORCH_COMMAND="pip install "torch==2.1.2+cu121" "torchvision==0.16.2+cu121" --index-url https://download.pytorch.org/whl/cu121"

# Requirements file to use for stable-diffusion-webui
#export REQS_FILE="requirements_versions.txt"

# Fixed git repos
#export K_DIFFUSION_PACKAGE=""
#export GFPGAN_PACKAGE=""

# Fixed git commits
#export STABLE_DIFFUSION_COMMIT_HASH=""
#export CODEFORMER_COMMIT_HASH=""
#export BLIP_COMMIT_HASH=""

# Uncomment to enable accelerated launch
#export ACCELERATE="True"

# Uncomment to disable TCMalloc
#export NO_TCMALLOC="True"

###########################################
