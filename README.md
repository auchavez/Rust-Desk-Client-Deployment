# RustDesk Client Deployment Using PowerShell

Automate the installation and configuration of RustDesk clients with this unified PowerShell script. This solution is ideal for environments requiring remote access, custom server configuration, and secure password provisioning.

---

## 🎯 Features

- **Automated Installation**: Downloads and silently installs the desired RustDesk version.
- **Custom Configuration**: Applies a predefined `RustDesk2.toml` with your rendezvous and relay server settings.
- **Secure Password Setup**: Automatically sets a remote access password using the `--password` parameter.
- **Version Check**: Skips installation if the correct version is already installed.
- **Log-Based Validation**: Confirms configuration success by parsing RustDesk logs.
- **Executable Option**: The script can be compiled into a `.exe` using tools like [PS2EXE](https://www.powershellgallery.com/packages/ps2exe).

---

## 🚀 How It Works

1. **Admin Check**: If not run as administrator, the script will prompt for elevation.
2. **Version Detection**: Skips installation if the current version matches the target.
3. **Silent Install**: Downloads and installs RustDesk without user interaction.
4. **Configuration Setup**: Writes the configuration file to both user and service paths.
5. **Password Assignment**: Uses `--password '$variable'` (correctly quoted) to apply access credentials.
6. **Validation via Logs**: Reviews recent logs to confirm that the password and configuration were applied.

---

## 📄 Included Files

- `RustdeskFinal.ps1`: Main PowerShell script for installation, configuration, and password setup.

> ⚠️ **Note**: The previous fallback `silentlycontinu.cmd` is no longer required and has been removed.

---

## 📋 Requirements

- Windows with PowerShell 5.1 or newer.
- Administrator privileges.
- Internet access to download the RustDesk installer.
- Access to your custom rendezvous and relay server.

---

## 📜 Change Log

**June 23, 2025**
- ✅ Script fully rewritten and unified.
- 🛠️ Fixed quoting issue in the `--password` parameter (line 83 resolved).
- 🧹 Removed the `.cmd` fallback (no longer needed).
- 🧪 Successfully tested using both `.ps1` and compiled `.exe`.

---

## 📆 Latest Update

**Last Updated:** June 23, 2025

---

## 💬 Feedback & Contributions

Your feedback is welcome! If you encounter issues or have suggestions:
