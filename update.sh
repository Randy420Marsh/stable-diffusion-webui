#!/bin/bash

set -e  # Exit on any error
set -o pipefail

echo "This script is updated 2025..."

# Pull latest changes
git pull

export CC=/usr/bin/gcc-12

# Set Python command
python_cmd="python3"

AUTOMATIC1111_DIR="$(pwd)"
echo "AUTOMATIC1111_DIR: $AUTOMATIC1111_DIR"

EXTENSIONS_DIR="$AUTOMATIC1111_DIR/extensions"
echo "EXTENSIONS_DIR: $EXTENSIONS_DIR"


# Check for NVIDIA GPU
if lspci | grep -i nvidia > /dev/null; then
    echo "NVIDIA GPU detected."
else
    echo "No NVIDIA GPU detected."
fi

pip uninstall -y torch torchvision torchaudio xformers

#pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128

# Prompt user for choice
while true; do
    read -p "Do you want to update the GPU or CPU version (G/C)? " user_choice
    case "$user_choice" in
        [Gg]* )
            venv_dir="venv"
            install_cmd='pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu128'
            install_xformers=true
            break;;
        [Cc]* )
            venv_dir="venv-cpu"
            install_cmd='pip3 install "torch==2.1.2" "torchvision==0.16.2" --index-url https://download.pytorch.org/whl/cpu'
            install_xformers=false
            break;;
        * )
            echo "Invalid choice. Please enter G for GPU version or C for CPU version.";;
    esac
done

$python_cmd --version

# Create and activate virtual environment
if [ ! -d "$venv_dir" ]; then
    $python_cmd -m venv "$venv_dir"
fi

source "$venv_dir/bin/activate"

$python_cmd -m pip install --upgrade pip

cd "$AUTOMATIC1111_DIR"

mkdir -p $EXTENSIONS_DIR

pip uninstall -y torch torchvision torchaudio xformers
eval "$install_cmd"

pip install -r requirements.txt
pip install -r requirements_versions.txt

if $install_xformers; then
    pip install xformers --index-url https://download.pytorch.org/whl/cu128
fi

cd "$EXTENSIONS_DIR" || exit

echo "We should now be inside the extensions directory..."

# Clone or update extensions
EXTENSION_REPOS=(
    "https://github.com/Randy420Marsh/sd-webui-llul.git"
    "https://github.com/Randy420Marsh/SD-latent-mirroring.git"
    "https://github.com/Randy420Marsh/a1111-sd-webui-haku-img.git"
    "https://github.com/Randy420Marsh/sd-webui-stablesr.git"
    "https://github.com/Randy420Marsh/gif2gif.git"
    "https://github.com/Randy420Marsh/multi-subject-render.git"
    "https://github.com/Randy420Marsh/openOutpaint-webUI-extension.git"
    "https://github.com/Randy420Marsh/sd-dynamic-thresholding.git"
    "https://github.com/Randy420Marsh/sd-extension-steps-animation.git"
    "https://github.com/Randy420Marsh/sd-webui-3d-open-pose-editor.git"
    "https://github.com/Randy420Marsh/sd-webui-ar.git"
    "https://github.com/Randy420Marsh/sd-webui-controlnet.git"
    "https://github.com/Randy420Marsh/sd-webui-model-converter.git"
    "https://github.com/Randy420Marsh/sd_save_intermediate_images.git"
    "https://github.com/Randy420Marsh/stable-diffusion-webui-rembg.git"
    "https://github.com/Randy420Marsh/stable-diffusion-webui-sonar.git"
    "https://github.com/Randy420Marsh/ultimate-upscale-for-automatic1111.git"
    "https://github.com/Randy420Marsh/video_loopback_for_webui.git"
    "https://github.com/Randy420Marsh/multidiffusion-upscaler-for-automatic1111.git"
    "https://github.com/Randy420Marsh/stable-diffusion-webui-dataset-tag-editor.git"
    "https://github.com/Randy420Marsh/sd_dreambooth_extension.git"
    "https://github.com/Randy420Marsh/sd-webui-gelbooru-prompt.git"
    "https://github.com/Randy420Marsh/a1111-sd-webui-tagcomplete.git"
    "https://github.com/Randy420Marsh/model-keyword.git"
    "https://github.com/Randy420Marsh/sd-dynamic-prompts.git"
)

#conflicting on linux
    #"https://github.com/Randy420Marsh/stable-diffusion-webui-aesthetic-image-scorer.git"
    #"https://github.com/Randy420Marsh/sd-webui-nsfw-filter.git"

for repo in "${EXTENSION_REPOS[@]}"; do
    repo_name=$(basename "$repo" .git)
    if [ -d "$repo_name" ]; then
        echo "Updating $repo_name..."
        cd "$repo_name" && git pull && cd ..
    else
        echo "Cloning $repo_name..."
        git clone "$repo" "$repo_name"
    fi
done

cd "$AUTOMATIC1111_DIR"

# Wildcards
if [ -d "./wildcards" ]; then
    cd wildcards && git reset --hard && git pull && echo "Updated wildcards" && cd ..
else
    git clone https://github.com/Randy420Marsh/WC-SDVN.git wildcards && echo "Downloaded/Installed wildcards"
fi

cd "$AUTOMATIC1111_DIR"

if [ -d "./extensions/stable-diffusion-webui-rembg" ]; then
    pip uninstall -y watchdog opencv-python-headless
    pip install "opencv-python-headless>=4.9.0" "watchdog==2.1.9" "rembg==2.0.50" "onnx==1.17.0" pymatting pooch
else
    echo "Nothing to do, rembg does not exist..."
fi

if [ -d "./extensions/sd_dreambooth_extension" ]; then
    pip uninstall -y watchdog opencv-python-headless
    pip install -r ./extensions/sd_dreambooth_extension/requirements.txt
else
    echo "Nothing to do, sd_dreambooth_extension does not exist..."
fi

if [ -d "./extensions/sd-dynamic-prompts" ]; then
    pip install -r ./extensions/sd-dynamic-prompts/requirements.txt
else
    echo "Nothing to do, sd-dynamic-prompts does not exist..."
fi

if [ -d "./extensions/a1111-sd-webui-haku-img" ]; then
    pip install -r ./extensions/a1111-sd-webui-haku-img/requirements.txt
else
    echo "Nothing to do, haku-img extension does not exist..."
fi

if [ -d "./extensions/sd-webui-controlnet" ]; then
    pip install -r ./extensions/sd-webui-controlnet/requirements.txt
else
    echo "Nothing to do, sd-webui-controlnet extension does not exist..."
fi

echo "Fixing dependencies..."

pip install \
    "bs4" \
    "xformers"
    

pip install --upgrade \
    "watchdog==2.1.9" \
    "rembg==2.0.50" \
    "pymatting" \
    "pooch" \
    "albumentations==1.4.3" \
    "opencv-python-headless>=4.9.0" \
    "open-clip-torch==2.24.0" \
    "scikit-learn-intelex" \
    "numpy<2.0.0,>=1.0.0" \
    "thinc" \
    "openai-clip" \
    "protobuf<5,>=4.25.3" \
    "inference==0.45.1" \
    "onnxruntime<1.20.0,>=1.15.1" \
    "picologging"

echo "Installing diffusers..."
#pip install --upgrade "diffusers<0.32.0,>=0.31.0"

pip install --upgrade "diffusers<0.32.0,>=0.31.0" tokenizers "transformers==4.32.1" inference inference-gpu

pip install --upgrade "scikit-image<=0.24.0,>=0.19.0" "fastapi<0.111,>=0.100"

pip install "pytorch-lightning<=1.9.5"

echo "Running accelerate config..."
#accelerate config

echo "Update/install finished!"

