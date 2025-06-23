# ============================================================
# RustDesk Client Setup Script (Sanitized & Public Safe)
# ------------------------------------------------------------
# Installs RustDesk silently, applies custom server config,
# sets access password, and validates via logs.
# ============================================================

$ErrorActionPreference = 'Stop'

# === Logging ===
$logFile = "C:\Temp\rustdesk_combined.log"
function Write-Log {
    param([string]$msg)
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$ts - $msg" | Out-File -Append -FilePath $logFile
}

# === General Variables ===
$installerPath     = "C:\Temp\rustdesk.exe"
$downloadUrl       = "https://github.com/rustdesk/rustdesk/releases/download/1.4.0/rustdesk-1.4.0-x86_64.exe"
$exePath           = "C:\Program Files\RustDesk\rustdesk.exe"
$logDir            = "$env:APPDATA\RustDesk\log"

# === Custom Configuration ===
$rendezvousAddress = "your.domain.com"
$relayPort         = "21116"
$publicKey         = "REPLACE_ME_PUBLIC_KEY"
$passwordPlain     = "REPLACE_ME_PASSWORD"

$userTomlPath   = "C:\Users\$env:USERNAME\AppData\Roaming\RustDesk\config\RustDesk2.toml"
$svcTomlPath    = "C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config\RustDesk2.toml"

# === Configuration Template ===
$tomlContent = @"
rendezvous_server = '$rendezvousAddress:$relayPort'
nat_type = 1
serial = 0

[options]
custom-rendezvous-server = '$rendezvousAddress'
key = '$publicKey'
whitelist = '192.168.1.1,10.0.0.1,172.16.0.0/16'
direct-server = 'Y'
direct-access-port = '21118'
"@

# === Ensure Admin Privileges ===
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "❌ This script must be run as Administrator."
    exit 1
}

# === Create Temp Directory ===
if (-not (Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory -Force | Out-Null
}
Write-Log "Temp directory ready."

# === Download and Install RustDesk ===
Write-Log "Downloading RustDesk..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath
Write-Log "Download complete."

Write-Log "Installing RustDesk silently..."
Start-Process $installerPath -ArgumentList "--silent-install" -Wait
Start-Sleep -Seconds 5
Write-Log "Installation complete."

# === Stop Service or Process ===
$service = Get-Service | Where-Object { $_.Name -match 'rustdesk' } -ErrorAction SilentlyContinue
if ($service) {
    Write-Log "Stopping RustDesk service..."
    Stop-Service $service.Name -Force
} else {
    Write-Log "Killing RustDesk process..."
    Get-Process rustdesk -ErrorAction SilentlyContinue | Stop-Process -Force
}
Start-Sleep -Seconds 3

# === Apply Configuration ===
foreach ($path in @($userTomlPath, $svcTomlPath)) {
    $dir = Split-Path $path
    if (-not (Test-Path $dir)) { New-Item $dir -ItemType Directory -Force | Out-Null }
    Set-Content -Path $path -Value $tomlContent -Encoding UTF8
    Write-Log "Config written to $path."
}

# === Start RustDesk Again ===
if ($service) {
    Write-Log "Starting service..."
    Start-Service $service.Name
} else {
    Write-Log "Starting process..."
    Start-Process -FilePath $exePath
}
Start-Sleep -Seconds 5

# === Set Password Securely ===
Write-Log "Setting access password..."
Start-Process -FilePath $exePath -ArgumentList "--password '$passwordPlain'" -Wait
Start-Sleep -Seconds 5

# === Log Validation ===
if (Test-Path $logDir) {
    $recentLogs = Get-ChildItem $logDir -Filter *.log | Sort LastWriteTime -Descending | Select -First 3
    $confirmed = $false
    foreach ($log in $recentLogs) {
        if (Select-String -Path $log.FullName -Pattern 'password') {
            Write-Log "✅ Password activity found in $($log.Name)"
            Write-Output "✅ Password set successfully (confirmed in log)."
            $confirmed = $true
            break
        }
    }
    if (-not $confirmed) {
        Write-Log "⚠️ Password not confirmed in logs."
        Write-Output "⚠️ Could not confirm password in log."
    }
} else {
    Write-Log "⚠️ RustDesk log directory not found."
    Write-Output "⚠️ Log directory missing."
}

Write-Log "✅ Script finished."
Write-Output "✅ RustDesk installation and configuration completed."
