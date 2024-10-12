@echo off

echo "This script is updated 2024..."

setlocal enabledelayedexpansion

set python_cmd=python

set AUTOMATIC1111_DIR=%CD%

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
    set install_cmd=pip install "torch==2.1.0" "torchvision==0.16.0" --index-url https://download.pytorch.org/whl/cu118
    echo "Disabling xformers install because of dependency problems..."
    set install_xformers=false
) else if /I "%user_choice%"=="C" (
    set venv_dir=venv-cpu
    set install_cmd=pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu
    set install_xformers=false
) else (
    echo "Invalid choice. Please enter G for GPU version or C for CPU version."
    goto choice
)

%python_cmd% --version

pause

git pull

REM Create and activate virtual environment
if exist %venv_dir%\Scripts\activate (
    call %venv_dir%\Scripts\activate
) else (
    %python_cmd% -m venv %venv_dir%
    call %venv_dir%\Scripts\activate
)

%python_cmd% -m pip install --upgrade pip

cd %AUTOMATIC1111_DIR%

pip uninstall -y torch torchvision xformers torchaudio

REM Install chosen version of torch and torchvision
%install_cmd%

pip install -r requirements.txt

if "%install_xformers%"=="true" (
    pip install xformers
)

cd %EXTENSIONS_DIR%
dir
echo We should now be inside the extensions directory...

REM Iterate through each repository URL directly
for %%i in (
    ::https://github.com/Randy420Marsh/adetailer.git
    https://github.com/Randy420Marsh/sd-webui-llul.git
    https://github.com/Randy420Marsh/SD-latent-mirroring.git
    https://github.com/Randy420Marsh/a1111-sd-webui-haku-img.git
    https://github.com/Randy420Marsh/sd-webui-stablesr.git
    https://github.com/Randy420Marsh/batch-face-swap.git
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
    ::https://github.com/Randy420Marsh/sd_civitai_extension.git
    https://github.com/Randy420Marsh/stable-diffusion-webui-dataset-tag-editor.git
    ::https://github.com/Randy420Marsh/webui-stability-api.git
    https://github.com/Randy420Marsh/stable-diffusion-webui-aesthetic-image-scorer.git
) do (
    set "repo=%%i"
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
)

cd %AUTOMATIC1111_DIR%

pip install fastapi -U

pip install albumentations -U

pip uninstall -y watchdog opencv-python-headless

REM Install rembg dependencies
if exist .\extensions\stable-diffusion-webui-rembg (
    echo Installing rembg dependencies
    REM pip install opencv-python-headless==4.6.0.66 watchdog==2.1.9 rembg==2.0.50 onnxruntime pymatting pooch
    pip install opencv-python-headless>=4.9.0.80 watchdog==2.1.9 rembg==2.0.50 onnxruntime pymatting pooch
) else (
    echo Nothing to do; rembg does not exist...
)

echo Fixing dependencies...

REM Deprecated: pip install "opencv-python-headless>=4.9.0" "albumentations==1.4.3"

echo Update/install finished...

pause
endlocal
