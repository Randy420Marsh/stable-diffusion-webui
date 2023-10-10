#!/bin/bash

AUTOMATIC1111_DIR=$(pwd)

echo "AUTOMATIC1111_DIR:"
echo $AUTOMATIC1111_DIR

EXTENSIONS_DIR="$AUTOMATIC1111_DIR/extensions"

echo "EXTENSIONS_DIR:"
echo $EXTENSIONS_DIR

if [ -d "./venv" ]; then
    source ./venv/scripts/activate
else
    python -m venv venv && source ./venv/scripts/activate
fi

python --version

read -p "Press Enter to continue..."

python -m pip install --upgrade pip

pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118

pip install xformers --pre

cd $AUTOMATIC1111_DIR

git pull

pip install -r requirements.txt

pip install -r requirements_versions.txt

cd $EXTENSIONS_DIR
echo "We should be in extensions dir..."

repos=("https://github.com/Randy420Marsh/sd-webui-llul.git"
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
       "https://github.com/Randy420Marsh/sd-webui-controlnet.git"
       "https://github.com/Randy420Marsh/sd-webui-model-converter.git"
       "https://github.com/Randy420Marsh/sd_save_intermediate_images.git"
       "https://github.com/Randy420Marsh/stable-diffusion-webui-rembg.git"
       "https://github.com/Randy420Marsh/ultimate-upscale-for-automatic1111.git"
       "https://github.com/Randy420Marsh/video_loopback_for_webui.git"
       "https://github.com/Randy420Marsh/multidiffusion-upscaler-for-automatic1111.git"
       "https://github.com/Randy420Marsh/sd-webui-openpose-editor.git"
       "https://github.com/Randy420Marsh/adetailer"
       "https://github.com/Randy420Marsh/sd-webui-reactor")

for repo_url in "${repos[@]}"; do
    repo_name=$(basename "$repo_url" .git)
    
    if [ -d "$repo_name$1" ]; then
        echo "Updating $repo_name..."
        pushd "$repo_name$1"
        git pull
        popd
    else
        echo "Cloning $repo_name..."
        git clone "$repo_url" "$repo_name$1"
    fi
done

cd $AUTOMATIC1111_DIR

if [ -d "./extensions/stable-diffusion-webui-rembg" ]; then
    pip uninstall -y opencv-python-headless watchdog rembg asyncer filetype imagehash
    pip install "opencv-python-headless==4.6.0.66" "watchdog==2.1.9" "rembg==2.0.38" "asyncer>=0.0.2" "filetype>=1.2.0" "imagehash>=4.3.1"
else
    echo "Nothing to do rembg does not exist..."
fi

if [ -d "./extensions/sd-webui-reactor" ]; then
    pip install -r "./extensions/sd-webui-reactor/requirements.txt"
else
    echo "Nothing to do sd-webui-reactor does not exist..."
fi

echo "Update/install finished..."
read -p "Press Enter to exit..."
