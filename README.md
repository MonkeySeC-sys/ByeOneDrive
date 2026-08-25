# Completely Remove OneDrive from Windows

A lightweight, automated PowerShell script that stops, uninstalls, and completely purges Microsoft OneDrive from your Windows system. 

It executes the native system uninstaller, deletes residual cache directories, and scrubs registry keys to remove the stubborn OneDrive icon from the File Explorer sidebar.

---

## ⚡ Features
* **Process Killer:** Forcefully terminates all active and hidden background `OneDrive.exe` processes.
* **Arch-Specific Detection:** Automatically locates the correct native uninstaller for both 64-bit and 32-bit Windows systems.
* **Residual Data Purge:** Deletes leftover folders, telemetry data, and temporary synchronization caches (`OneDriveTemp`).
* **Registry Scrubbing:** Cleans out the specific CLSID registry entries responsible for pinning the empty OneDrive shortcut to your File Explorer side panel.

---

## ⚠️ Important Warning Before Running
OneDrive frequently takes over your standard library paths. Before executing this script:
1. Open your `C:\Users\<YourUsername>\OneDrive\` folder.
2. Manually **move/copy any important files** (from Desktop, Documents, or Pictures) back to a safe local path (like `C:\Users\<YourUsername>\Desktop`). 
3. Failure to backup your local files before running may result in Windows hiding or revoking access to your local folders when the sync engine is uninstalled.

---

## 🚀 How to Use

### 1. Open PowerShell as Administrator
Click your Windows **Start** menu, search for **PowerShell**, right-click **Windows PowerShell**, and select **Run as administrator**.

### 2. Bypass Execution Policy (Temporary)
Windows blocks script execution by default. Allow the script to run in your current session by entering:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
```

### 3. Run the Script
Navigate to the directory where you saved `Remove-OneDrive.ps1` and execute it:
```powershell
.\Remove-OneDrive.ps1
```

### 4. Reboot Your PC
**Restart your computer immediately** after the script finishes. This forces Windows to reload the registry and fully wipe the OneDrive icon from File Explorer.

---

## 🛠️ Requirements
* **Operating System:** Windows 10 or Windows 11
* **Permissions:** Administrative Privileges (Run as Administrator)

---
