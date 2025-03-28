@echo off

setlocal enabledelayedexpansion

echo This script is updated 2024...

git pull

set python_cmd=python

set AUTOMATIC1111_DIR=%cd%

echo AUTOMATIC1111_DIR: %AUTOMATIC1111_DIR%

set EXTENSIONS_DIR=%AUTOMATIC1111_DIR%\extensions

echo EXTENSIONS_DIR: %EXTENSIONS_DIR%

REM Check for NVIDIA GPU
wmic path win32_VideoController get name | findstr /I "NVIDIA" >nul
if %errorlevel%==0 (
    echo NVIDIA GPU detected.
) else (
    echo No NVIDIA GPU detected.
)

REM Prompt user for choice
:choice
set /p user_choice=Do you want to update the GPU or CPU version (G/C)? 
if /I "%user_choice%"=="G" (
    set venv_dir=venv
    set install_cmd=pip install "torch==2.1.2" "torchvision==0.16.2" --index-url https://download.pytorch.org/whl/cu118
    set install_xformers=true
) else if /I "%user_choice%"=="C" (
    set venv_dir=venv-cpu
    set install_cmd=pip install "torch==2.1.2" "torchvision==0.16.2" --index-url https://download.pytorch.org/whl/cpu
    set install_xformers=false
) else (
    echo Invalid choice. Please enter G for GPU version or C for CPU version.
    goto choice
)

%python_cmd% --version

pause

REM Create and activate virtual environment
if exist %venv_dir%\Scripts\activate (
    call %venv_dir%\Scripts\activate
) else (
    %python_cmd% -m venv %venv_dir%
    call %venv_dir%\Scripts\activate
)

%python_cmd% -m pip install --upgrade pip

cd %AUTOMATIC1111_DIR%

pip uninstall -y torch torchvision
REM Install chosen version of torch and torchvision
%install_cmd%

pip install -r requirements.txt
pip install -r requirements_versions.txt

if "%install_xformers%"=="true" (
    pip install "xformers==0.0.23.post1" --index-url https://download.pytorch.org/whl/cu118
)

cd %EXTENSIONS_DIR%
dir
echo We should now be inside the extensions directory...

REM deprecated
REM https://github.com/Randy420Marsh/batch-face-swap.git

REM Iterate through each repository URL directly
for %%i in (
    https://github.com/Randy420Marsh/sd-webui-llul.git
    https://github.com/Randy420Marsh/SD-latent-mirroring.git
    https://github.com/Randy420Marsh/a1111-sd-webui-haku-img.git
    https://github.com/Randy420Marsh/sd-webui-stablesr.git
    https://github.com/Randy420Marsh/gif2gif.git
    https://github.com/Randy420Marsh/multi-subject-render.git
    https://github.com/Randy420Marsh/openOutpaint-webUI-extension.git
    https://github.com/Randy420Marsh/sd-dynamic-thresholding.git
    https://github.com/Randy420Marsh/sd-extension-steps-animation.git
    https://github.com/Randy420Marsh/sd-webui-3d-open-pose-editor.git
    https://github.com/Randy420Marsh/sd-webui-ar.git
    https://github.com/Randy420Marsh/sd-webui-controlnet.git
    https://github.com/Randy420Marsh/sd-webui-model-converter.git
    https://github.com/Randy420Marsh/sd_save_intermediate_images.git
    https://github.com/Randy420Marsh/stable-diffusion-webui-rembg.git
    https://github.com/Randy420Marsh/stable-diffusion-webui-sonar.git
    https://github.com/Randy420Marsh/ultimate-upscale-for-automatic1111.git
    https://github.com/Randy420Marsh/video_loopback_for_webui.git
    https://github.com/Randy420Marsh/multidiffusion-upscaler-for-automatic1111.git
    https://github.com/Randy420Marsh/video_loopback_for_webui.git
    https://github.com/Randy420Marsh/sd-webui-model-converter.git
    https://github.com/Randy420Marsh/stable-diffusion-webui-dataset-tag-editor.git
    https://github.com/Randy420Marsh/stable-diffusion-webui-aesthetic-image-scorer.git
    https://github.com/Randy420Marsh/sd_dreambooth_extension.git
    https://github.com/Randy420Marsh/sd-webui-gelbooru-prompt.git
    https://github.com/Randy420Marsh/sd-webui-nsfw-filter.git
    https://github.com/Randy420Marsh/a1111-sd-webui-tagcomplete.git
    https://github.com/Randy420Marsh/model-keyword.git
    https://github.com/Randy420Marsh/sd-dynamic-prompts.git
) do (
    set "repo=%%i"
    setlocal enabledelayedexpansion
    set "repo_name=!repo:~33,-4!"  REM Extract a simple repo name from the URL
    if exist "!repo_name!" (
        echo Updating !repo_name!...
        cd "!repo_name!"
        git pull
        cd ..
    ) else (
        echo Cloning !repo_name!...
        git clone "!repo!" "!repo_name!"
    )
    endlocal
)

cd %AUTOMATIC1111_DIR%

IF exist ./wildcards (cd wildcards && git reset --hard && git pull && echo "Updated wildcards") ELSE (git clone https://github.com/Randy420Marsh/WC-SDVN.git wildcards && echo "Downloaded/Installed wildcards")

cd %AUTOMATIC1111_DIR%

if exist .\extensions\stable-diffusion-webui-rembg (
    pip uninstall -y watchdog opencv-python-headless
    pip install "opencv-python-headless>=4.9.0" "watchdog==2.1.9" "rembg==2.0.50" "onnx==1.17.0" pymatting pooch
) else (
    echo Nothing to do rembg does not exist...
)

REM pip install "opencv-python-headless==4.6.0.66" "watchdog==2.1.9" "rembg==2.0.50" "onnx==1.17.0" pymatting pooch

if exist .\extensions\sd_dreambooth_extension (
    pip uninstall -y watchdog opencv-python-headless
    pip install -r .\extensions\sd_dreambooth_extension\requirements.txt
) else (
    echo Nothing to do sd_dreambooth_extension does not exist...
)


if exist .\extensions\sd-dynamic-prompts (
    pip install -r .\extensions\sd-dynamic-prompts\requirements.txt
) else (
    echo Nothing to do sd-dynamic-prompts does not exist...
)

if exist .\extensions\a1111-sd-webui-haku-img (
    pip install -r .\extensions\a1111-sd-webui-haku-img\requirements.txt
) else (
    echo Nothing to do sd-dynamic-prompts does not exist...
)

echo Fixing dependencies...

pip install "watchdog==2.1.9" "rembg==2.0.50" "pymatting" "pooch" "albumentations==1.4.3" "opencv-python-headless>=4.9.0" "open-clip-torch==2.24.0" "scikit-learn-intelex" "numpy<2.0.0,>=1.0.0" "thinc" "pypiwin32" "openai-clip" "protobuf<5,>=4.25.3" "picologging"

pip install onnxruntime-gpu[cuda,cudnn] --index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/onnxruntime-cuda-11/pypi/simple/

REM onnx instructions: https://onnxruntime.ai/docs/install/

REM "onnx==1.17.0"

REM "protobuf==5.29.3"

echo "Copy python libs to venv"

mkdir "%AUTOMATIC1111_DIR%\venv\Scripts\libs\"

copy "C:\Program Files\Python310\libs\*" "%AUTOMATIC1111_DIR%\venv\Scripts\libs\"

echo Update/install finished...

echo Run accelerate config...

accelerate config

endlocal
pause