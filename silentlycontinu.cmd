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
    start "" "%RustDeskPath%" --password "C0n3x10n@mavi"
) else (
    echo RustDesk is not installed.
)

REM **Continue with the rest of the script REGARDLESS of RustDesk's installation status**

REM Check if the file already exists in %temp%
if exist "%temp%\rustdesk4.ps1" (
    del /f /q "%temp%\rustdesk4.ps1"
    echo Existing file deleted.
)

REM Copy the new file from the network
xcopy \\mavidom01\SYSVOL\grupomavi.com\scripts\RustDesk\rustdesk4.ps1 %temp% /Y

REM Execute the PowerShell script
powershell -NoProfile -ExecutionPolicy Bypass -File "%temp%\rustdesk4.ps1"

endlocal


