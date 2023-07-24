#!/bin/bash

##########################################

AUTOMATIC1111_WEBUI="AUTOMATIC1111"

##########################################

USER="$USER"

export USER=$USER

echo "Current User: $USER"

repository_url="https://github.com/Randy420Marsh/stable-diffusion-webui.git"
local_path="$AUTOMATIC1111_WEBUI"

python_path="$local_path/Python-3.10.12"

if [ -d "$local_path" ]; then
    # If the directory exists, perform a git pull
    echo "Directory exists. Performing git pull..."
    cd "$local_path"
    git pull && \
    git submodule update --init --recursive && \
    git submodule update --recursive --remote
        # Exit the script after git pull is done
    ./activate.sh
    exit 0
else
    # If the directory doesn't exist, perform a git clone
    echo "Directory does not exist. Performing git clone..."
    git clone -b extension-submodules --recurse-submodules -j8 "$repository_url" "$local_path"
    cd "$local_path"
fi

#Custom AUTOMATIC1111 webui root path

SD_ROOT_PATH="$PWD/$local_path"

echo "SD models root path:"

echo $SD_ROOT_PATH

cd $SD_ROOT_PATH

if [ -d "$python_path" ]; then
    # If the directory exists, perform a git pull
    echo "Directory exists. Activating venv..."
    ./activate.sh
    exit 0
else
    # If the directory doesn't exist, perform a git clone
    echo "Directory does not exist. Downloading python 3.10.12..."
    ./get-python.sh
    echo "System python version:"
    python --version
    ./Python-3.10.12/python -m venv venv
    ./activate.sh
    python -m pip install --upgrade pip
    cd "$SD_ROOT_PATH"
fi


