@echo off

setlocal enabledelayedexpansion

set "AUTOMATIC1111_DIR=%CD%"

echo AUTOMATIC1111_DIR: 
echo %AUTOMATIC1111_DIR%

set "EXTENSIONS_DIR=%AUTOMATIC1111_DIR%\extensions"

echo EXTENSIONS_DIR: 
echo %EXTENSIONS_DIR%

IF exist .\venv (call .\venv\scripts\activate.bat) else (C:\Python-3.10\PCbuild\amd64\python.exe -m venv venv && call .\venv\scripts\activate.bat)

python --version

pause

python.exe -m pip install --upgrade pip

cd %AUTOMATIC1111_DIR%

git pull

pip install -r requirements.txt

pip install -r requirements_versions.txt

REM pip uninstall torch torchvision xformers

pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118

pip install xformers

cd %EXTENSIONS_DIR%
dir
echo We should be in extensions dir...

set "repos[0]=https://github.com/Randy420Marsh/sd-webui-llul.git"
set "repos[1]=https://github.com/Randy420Marsh/SD-latent-mirroring.git"
set "repos[2]=https://github.com/Randy420Marsh/a1111-sd-webui-haku-img.git"
set "repos[3]=https://github.com/Randy420Marsh/sd-webui-stablesr.git"
set "repos[4]=https://github.com/Randy420Marsh/batch-face-swap.git"
set "repos[5]=https://github.com/Randy420Marsh/gif2gif.git"
set "repos[6]=https://github.com/Randy420Marsh/multi-subject-render.git"
set "repos[7]=https://github.com/Randy420Marsh/openOutpaint-webUI-extension.git"
set "repos[8]=https://github.com/Randy420Marsh/sd-dynamic-thresholding.git"
set "repos[9]=https://github.com/Randy420Marsh/sd-extension-steps-animation.git"
set "repos[10]=https://github.com/Randy420Marsh/sd-webui-3d-open-pose-editor.git"
set "repos[11]=https://github.com/Randy420Marsh/sd-webui-ar.git"
set "repos[12]=https://github.com/Randy420Marsh/sd-webui-controlnet.git"
set "repos[13]=https://github.com/Randy420Marsh/sd-webui-model-converter.git"
set "repos[14]=https://github.com/Randy420Marsh/sd_save_intermediate_images.git"
set "repos[15]=https://github.com/Randy420Marsh/stable-diffusion-webui-rembg.git"
set "repos[16]=https://github.com/Randy420Marsh/stable-diffusion-webui-sonar.git"
set "repos[17]=https://github.com/Randy420Marsh/ultimate-upscale-for-automatic1111.git"
set "repos[18]=https://github.com/Randy420Marsh/video_loopback_for_webui.git"
set "repos[18]=https://github.com/Randy420Marsh/multidiffusion-upscaler-for-automatic1111.git"

for %%i in (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19) do (
    set "repo_url=!repos[%%i]!"
    for %%j in ("!repo_url!") do (
        set "repo_name=%%~nj"
        
        if exist "!repo_name!%~1" (
            echo Updating !repo_name!...
            pushd "!repo_name!%~1"
            git pull
            popd
        ) else (
            echo Cloning !repo_name!...
            git clone "%%j" "!repo_name!%~1"
        )
    )
)

cd %AUTOMATIC1111_DIR%

IF exist .\extensions\stable-diffusion-webui-rembg (pip uninstall watchdog opencv-python-headless && pip install "opencv-python-headless==4.6.0.66" "watchdog==2.1.9" rembg) else (echo "Nothing to do rembg does not exist...")

::IF exist .\extensions\stable-diffusion-webui-rembg (pip uninstall watchdog opencv-python-headless && pip install "opencv-python-headless==4.6.0.66" "watchdog==2.1.9" && python .\extensions\stable-diffusion-webui-rembg\install.py) else (echo "Nothing to do rembg does not exist...")

endlocal

echo "Update/install finished..."
pause