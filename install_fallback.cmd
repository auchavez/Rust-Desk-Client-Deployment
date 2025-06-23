@echo off
setlocal

REM ==========================================================
REM RustDesk Client Deployment (Legacy CMD Method)
REM ----------------------------------------------------------
REM ⚠️ NOTICE: This method is considered deprecated.
REM The current PowerShell script (Client-Deployment.ps1)
REM handles installation, configuration, and password setup.
REM This .cmd file is retained for fallback use only in
REM environments where .ps1 execution is restricted.
REM
REM 📌 NOTE: The --password parameter below is no longer
REM required or used by the PowerShell script. It is handled
REM internally in the updated RustdeskFinal.ps1 version.
REM ==========================================================

REM Set PowerShell execution policy to allow script execution
powershell Set-ExecutionPolicy RemoteSigned -Force

REM Define RustDesk installation path
set "RustDeskPath=C:\Program Files\RustDesk\rustdesk.exe"

REM Check if RustDesk is installed
if exist "%RustDeskPath%" (
    echo RustDesk is installed. Attempting to apply password...

    REM Terminate RustDesk process if running
    taskkill /F /IM rustdesk.exe >nul 2>nul
    timeout /t 3 /nobreak >nul

    REM 🔒 DEPRECATED: This password command is no longer needed
    REM The updated PowerShell script applies password internally
    start "" "%RustDeskPath%" --password "NewPassword"
) else (
    echo RustDesk is not installed.
)

REM === Continue deployment regardless of RustDesk state ===

REM Clean up previous script from temp folder if exists
if exist "%temp%\Client-Deployment.ps1" (
    del /f /q "%temp%\Client-Deployment.ps1"
    echo Existing PowerShell script removed from temp.
)

REM Copy latest PowerShell script from network location
xcopy \\RUTA\DEL\ARCHIVO\Client-Deployment.ps1 %temp% /Y

REM Execute the deployment PowerShell script
powershell -NoProfile -ExecutionPolicy Bypass -File "%temp%\Client-Deployment.ps1"

endlocal
