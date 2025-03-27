@echo off
setlocal

REM Set PowerShell execution policy
powershell Set-ExecutionPolicy RemoteSigned -Force

REM RustDesk installation path
set "RustDeskPath=C:\Program Files\RustDesk\rustdesk.exe"

REM Check if RustDesk is installed
if exist "%RustDeskPath%" (
    echo RustDesk is installed. Changing the password...

    REM Close RustDesk if it is running
    taskkill /F /IM rustdesk.exe >nul 2>nul
    timeout /t 3 /nobreak >nul

    REM Apply the new password and restart RustDesk
    start "" "%RustDeskPath%" --password "NewPassword"
) else (
    echo RustDesk is not installed.
)

REM **Continue with the rest of the script REGARDLESS of RustDesk's installation status**

REM Check if the file already exists in %temp%
if exist "%temp%\Client-Deployment.ps1" (
    del /f /q "%temp%\Client-Deployment.ps1"
    echo Existing file deleted.
)

REM Copy the new file from the network
xcopy \\RUTA\DEL\ARCHIVO\Client-Deployment.ps1 %temp% /Y

REM Execute the PowerShell script
powershell -NoProfile -ExecutionPolicy Bypass -File "%temp%\Client-Deployment.ps1"

endlocal


