Client Deployment Using PowerShell
Automate the deployment and configuration of RustDesk clients with this PowerShell-based solution. This script is ideal for environments requiring remote access management with custom server configurations and fallback mechanisms.

🎯 Features
Automated Installation: Downloads and installs the latest RustDesk client silently.

Custom Configuration: Prepares the client to connect to your own rendezvous and relay servers.

Predefined Passwords: Automatically sets a secure password for remote access.

Version Control: Skips reinstallation if the desired version is already installed.

Fallback Mechanism: Includes a silentlycontinu.cmd file to ensure compatibility with environments where PowerShell scripts cannot be executed directly.

Detailed Logs: Generates log files for tracking the installation process.

🚀 How It Works
Version Check: Determines if the installed version matches the desired version (1.3.7). If it does, the script exits to avoid redundant installations.

Silent Installation: Downloads and installs RustDesk in the background if an update is required.

Server Configuration: Configures the client to use your custom rendezvous and relay servers.

Password Setup: Automatically applies a predefined secure password for remote connections.

Fallback Support: Copies the included silentlycontinu.cmd file to the %temp% directory and executes it if .ps1 files are restricted.

📄 Included Files
rustdesk_deployment.ps1: The main PowerShell script for automating installation and configuration.

silentlycontinu.cmd: A fallback CMD file to ensure execution in restricted environments.

📋 Requirements
Windows with PowerShell 5.1 or higher.

Administrator privileges.

Internet access to download the RustDesk installer.

Access to custom rendezvous and relay servers.

📜 Change Log
March 25, 2025
Hotfix Applied: Added --password parameter to enforce password setup upon execution.

Improved Compatibility: Ensured the script runs even if RustDesk is already installed.

Bug Fixes: Addressed an issue where the script would exit prematurely in some environments.

📆 Latest Update
Last Updated: March 25, 2025

💬 Feedback & Contributions
Your feedback is invaluable! If you encounter issues or have suggestions for improvements, feel free to:

Open an issue in this repository.

Submit a pull request with your proposed changes.
