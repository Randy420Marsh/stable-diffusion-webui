@echo off

setlocal enabledelayedexpansion

set "AUTOMATIC1111_DIR=%CD%"

echo AUTOMATIC1111_DIR: 
echo %AUTOMATIC1111_DIR%

set "EXTENSIONS_DIR=%AUTOMATIC1111_DIR%\extensions"

echo EXTENSIONS_DIR: 
echo %EXTENSIONS_DIR%

IF exist ./venv (call .\venv\scripts\activate.bat)  ELSE (.\Python-3.10.12\python -m venv venv && call .\venv\scripts\activate.bat)

python --version

pause

python.exe -m pip install --upgrade pip

cd %AUTOMATIC1111_DIR%

git pull

pip install -r requirements.txt

pip install -r requirements_versions.txt

::#pip uninstall torch torchvision xformers

pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118

pip install xformers

cd %EXTRENSIONS_DIR%
IF exist sd-webui-llul (cd %EXTENSIONS_DIR%\sd-webui-llul && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/sd-webui-llul.git)
cd %EXTRENSIONS_DIR%
IF exist SD-latent-mirroring (cd %EXTENSIONS_DIR%\SD-latent-mirroring && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/SD-latent-mirroring.git)
cd %EXTRENSIONS_DIR%
IF exist a1111-sd-webui-haku-img (cd %EXTENSIONS_DIR%\a1111-sd-webui-haku-img && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/a1111-sd-webui-haku-img.git)
cd %EXTRENSIONS_DIR%
IF exist a1111-sd-webui-lycoris (cd %EXTENSIONS_DIR%\a1111-sd-webui-lycoris && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/a1111-sd-webui-lycoris.git)
cd %EXTRENSIONS_DIR%
IF exist batch-face-swap (cd %EXTENSIONS_DIR%\batch-face-swap && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/batch-face-swap.git)
cd %EXTRENSIONS_DIR%
IF exist gif2gif (cd %EXTENSIONS_DIR%\gif2gif && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/gif2gif.git)
cd %EXTRENSIONS_DIR%
IF exist multi-subject-render (cd %EXTENSIONS_DIR%\multi-subject-render && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/multi-subject-render.git)
cd %EXTRENSIONS_DIR%
IF exist openOutpaint-webUI-extension (cd %EXTENSIONS_DIR%\openOutpaint-webUI-extension && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/openOutpaint-webUI-extension.git)
cd %EXTRENSIONS_DIR%
IF exist sd-dynamic-thresholding (cd %EXTENSIONS_DIR%\sd-dynamic-thresholding && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/sd-dynamic-thresholding.git)
cd %EXTRENSIONS_DIR%
IF exist sd-extension-steps-animation (cd %EXTENSIONS_DIR%\sd-extension-steps-animation && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/sd-extension-steps-animation.git)
cd %EXTRENSIONS_DIR%
IF exist sd-webui-3d-open-pose-editor (cd %EXTENSIONS_DIR%\sd-webui-3d-open-pose-editor && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/sd-webui-3d-open-pose-editor.git)
cd %EXTRENSIONS_DIR%
IF exist sd-webui-ar (cd %EXTENSIONS_DIR%\sd-webui-ar && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/sd-webui-ar.git)
cd %EXTRENSIONS_DIR%
IF exist sd-webui-controlnet (cd %EXTENSIONS_DIR%\sd-webui-controlnet && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/sd-webui-controlnet.git)
cd %EXTRENSIONS_DIR%
IF exist sd-webui-model-converter (cd %EXTENSIONS_DIR%\sd-webui-model-converter && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/sd-webui-model-converter.git)
cd %EXTRENSIONS_DIR%
IF exist sd_save_intermediate_images (cd %EXTENSIONS_DIR%\sd_save_intermediate_images && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/sd_save_intermediate_images.git)
cd %EXTRENSIONS_DIR%
IF exist stable-diffusion-webui-rembg (cd %EXTENSIONS_DIR%\stable-diffusion-webui-rembg && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/stable-diffusion-webui-rembg.git)
cd %EXTRENSIONS_DIR%
IF exist stable-diffusion-webui-sonar(cd %EXTENSIONS_DIR%\stable-diffusion-webui-sonar && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/stable-diffusion-webui-sonar.git)
cd %EXTRENSIONS_DIR%
IF exist ultimate-upscale-for-automatic1111 (cd %EXTENSIONS_DIR%\ultimate-upscale-for-automatic1111 && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/ultimate-upscale-for-automatic1111.git)
cd %EXTRENSIONS_DIR%
IF exist video_loopback_for_webui (cd %EXTENSIONS_DIR%\video_loopback_for_webui && git pull) ELSE (cd %EXTRENSIONS_DIR% && git clone https://github.com/Randy420Marsh/video_loopback_for_webui.git)

cd %AUTOMATIC1111_DIR%

echo "Update/install finished..."
pause