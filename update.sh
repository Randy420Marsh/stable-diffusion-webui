#!/bin/bash

echo "This script is updated 2024..."

git pull

python_cmd="python3.10"

AUTOMATIC1111_DIR=$(pwd)

echo "AUTOMATIC1111_DIR: $AUTOMATIC1111_DIR"

EXTENSIONS_DIR="$AUTOMATIC1111_DIR/extensions"

echo "EXTENSIONS_DIR: $EXTENSIONS_DIR"

# Check for NVIDIA GPU
gpu_info=$(lspci | grep -i nvidia)

if [ -n "$gpu_info" ]; then
    echo "NVIDIA GPU detected: $gpu_info"
else
    echo "No NVIDIA GPU detected."
fi

# Prompt user for choice
while true; do
    read -p "Do you want to update the GPU or CPU version (G/C)? " user_choice

    case $user_choice in
        [Gg]* )
            venv_dir="venv"
            install_cmd="pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118"
            install_xformers=true
            break
            ;;
        [Cc]* )
            venv_dir="venv-cpu"
            install_cmd="pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu"
            install_xformers=false
            break
            ;;
        * )
            echo "Invalid choice. Please enter G for GPU version or C for CPU version."
            ;;
    esac
done

$python_cmd --version

read -p "Press Enter to continue..."

sudo apt install -y libjemalloc-dev intel-mkl gperf

# Create and activate virtual environment
if [ -d "./$venv_dir" ]; then
    source ./$venv_dir/bin/activate
else
    $python_cmd -m venv $venv_dir
    source ./$venv_dir/bin/activate
fi

$python_cmd -m pip install --upgrade pip

cd "$AUTOMATIC1111_DIR"

pip uninstall -y torch torchvision xformers

# Install chosen version of torch and torchvision
$install_cmd

pip install -r requirements.txt
pip install -r requirements_versions.txt

if [ "$install_xformers" = true ]; then
    pip install xformers
fi

cd "$EXTENSIONS_DIR"
ls
echo "We should now be inside the extensions directory..."

repos=(
    "https://github.com/Randy420Marsh/sd-webui-llul.git"
    "https://github.com/Randy420Marsh/SD-latent-mirroring.git"
    "https://github.com/Randy420Marsh/a1111-sd-webui-haku-img.git"
    "https://github.com/Randy420Marsh/sd-webui-stablesr.git"
    "https://github.com/Randy420Marsh/batch-face-swap.git"
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
    "https://github.com/Randy420Marsh/video_loopback_for_webui.git"
    "https://github.com/Randy420Marsh/sd-webui-model-converter.git"
    "https://github.com/Randy420Marsh/sd_civitai_extension.git"
    "https://github.com/Randy420Marsh/stable-diffusion-webui-dataset-tag-editor.git"
    "https://github.com/Randy420Marsh/webui-stability-api.git"
)

for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    
    if [ -d "$repo_name" ]; then
        echo "Updating $repo_name..."
        cd "$repo_name"
        git pull
        cd ..
    else
        echo "Cloning $repo_name..."
        git clone "$repo" "$repo_name"
    fi
done

cd "$AUTOMATIC1111_DIR"

if [ -d "./extensions/stable-diffusion-webui-rembg" ]; then
    pip uninstall -y watchdog opencv-python-headless
    pip install "opencv-python-headless==4.6.0.66" "watchdog==2.1.9" "rembg==2.0.50" onnxruntime pymatting pooch
else
    echo "Nothing to do rembg does not exist..."
fi

echo "Update/install finished..."
