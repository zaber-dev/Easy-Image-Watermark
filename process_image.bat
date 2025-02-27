@echo off
setlocal enabledelayedexpansion

:: Define Paths
set "python_exe=python"
set "batch_dir=%~dp0"
set "script_path=%batch_dir%add_image.py"
set "folder_path=%batch_dir%raw_images"
set "image_to_add_path=%batch_dir%copyright.png"
set "output_folder=%batch_dir%copyrighted_images"

:: Ensure Python is Installed
echo Checking for Python...
%python_exe% --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python not found. Installing now...
    powershell -Command "& {Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe -OutFile python_installer.exe}"
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1
    del python_installer.exe
    set "python_exe=python"
)

:: Ensure Pillow is Installed
echo Checking for Pillow...
%python_exe% -c "import PIL" 2>nul
if errorlevel 1 (
    echo Installing Pillow...
    %python_exe% -m pip install --quiet pillow
    if errorlevel 1 (
        echo ERROR: Failed to install Pillow.
        pause
        exit /b
    ) else (
        echo Pillow installed successfully.
    )
) else (
    echo Pillow is already installed.
)

:: Ensure Required Folders Exist
if not exist "%folder_path%" mkdir "%folder_path%"
if not exist "%output_folder%" mkdir "%output_folder%"

:: Ensure Watermark Image Exists
if not exist "%image_to_add_path%" (
    echo ERROR: Watermark image '%image_to_add_path%' not found!
    pause
    exit /b
)

:: Display Menu
:MENU
cls
echo ========================================================
echo          Image Processing Tool - Developer: Md Mahedi Zaman Zaber
echo                    Powered By: ZealTyro
echo                 Website: www.zealtyro.com
echo ========================================================
echo(
echo [1] Process Images
echo [2] About
echo [3] Exit
echo(
set /p choice="Enter your choice: "

if "%choice%"=="1" goto PROCESS_IMAGES
if "%choice%"=="2" goto ABOUT
if "%choice%"=="3" goto EXIT
goto MENU

:PROCESS_IMAGES
cls
echo Processing images in "%folder_path%"...

set "count=0"

for %%I in ("%folder_path%\*.jpg" "%folder_path%\*.jpeg" "%folder_path%\*.png" "%folder_path%\*.bmp" "%folder_path%\*.gif" "%folder_path%\*.webp" "%folder_path%\*.tiff") do (
    set /a count+=1
    echo Processing: %%~nxI
    %python_exe% "%script_path%" "%%~fI" "%image_to_add_path%" "%output_folder%"
)

if %count%==0 (
    echo No images found in "%folder_path%". Please add images and try again.
) else (
    echo ========================================================
    echo                Image Processing Complete
    echo ========================================================
)

pause
goto MENU

:ABOUT
cls
echo ========================================================
echo          Image Processing Tool - Developer: Md Mahedi Zaman Zaber
echo                    Powered By: ZealTyro
echo                 Website: www.zealtyro.com
echo ========================================================
echo(
echo This tool applies a watermark to images in the 'raw_images' folder.
echo 1. Place images in 'raw_images'
echo 2. Ensure 'copyright.png' exists
echo 3. Run this tool and select option 1
echo 4. Watermarked images will be saved in 'copyrighted_images'
pause
goto MENU

:EXIT
exit
