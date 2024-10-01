#!/bin/bash
#########################################################
# Uncomment and change the variables below to your need:#

# Determine the maximum number of available CPU threads
MAX_THREADS=$(nproc)

# Set the environment variables
export OMP_NUM_THREADS=$MAX_THREADS
export MKL_NUM_THREADS=$MAX_THREADS

echo "Using $MAX_THREADS threads for OMP and MKL"

export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so:$LD_PRELOAD
export MALLOC_CONF="oversize_threshold:1,background_thread:true,metadata_thp:auto,dirty_decay_ms: 60000,muzzy_decay_ms:60000"
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libiomp5.so:$LD_PRELOAD

# Install directory without trailing slash
#install_dir="/home/$(whoami)"

# Name of the subdirectory
#clone_dir="stable-diffusion-webui"

# Commandline arguments for webui.py, for example: export COMMANDLINE_ARGS="--medvram --opt-split-attention"
export COMMANDLINE_ARGS="--no-download-sd-model --port 4433 --theme=dark --api --precision autocast"

# python3 executable
python_cmd="python3.10"

# git executable
#export GIT="git"

# python3 venv without trailing slash (defaults to ${install_dir}/${clone_dir}/venv)
venv_dir="venv"

# script to launch to start the app
#export LAUNCH_SCRIPT="launch.py"

# install command for torch
export TORCH_COMMAND="pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118"

#export TORCH_COMMAND="pip install torch==2.0.1 torchvision==0.15.2 --index-url https://download.pytorch.org/whl/cu118"

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
