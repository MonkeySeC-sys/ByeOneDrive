# Requires -RunAsAdmin

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "       ByeOneDrive - made by MonkeySeC - SyS    " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

Write-Host "`n[1/4] Stopping OneDrive processes..." -ForegroundColor Yellow
Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "[2/4] Executing system uninstaller..." -ForegroundColor Yellow
$OSArchitecture = (Get-WmiObject Win32_OperatingSystem).OSArchitecture

if ($OSArchitecture -eq "64-bit") {
    $Uninstaller = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
} else {
    $Uninstaller = "$env:SystemRoot\System32\OneDriveSetup.exe"
}

if (Test-Path $Uninstaller) {
    Start-Process -FilePath $Uninstaller -ArgumentList "/uninstall" -NoNewWindow -Wait
    Write-Host "Uninstaller executed successfully." -ForegroundColor Green
} else {
    Write-Host "OneDrive uninstaller not found. It may already be uninstalled." -ForegroundColor Gray
}

Write-Host "`n[3/4] Purging leftover data and cache folders..." -ForegroundColor Yellow
$TargetFolders = @(
    "$env:UserProfile\OneDrive",
    "$env:LocalAppFolder\Microsoft\OneDrive",
    "$env:ProgramData\Microsoft OneDrive",
    "$env:SystemDrive\OneDriveTemp"
)

foreach ($Folder in $TargetFolders) {
    if (Test-Path $Folder) {
        try {
            Remove-Item -Path $Folder -Recurse -Force -ErrorAction Stop
            Write-Host "Deleted: $Folder" -ForegroundColor Green
        } catch {
            Write-Host "Could not fully delete $Folder (files may be locked). It will clear after a reboot." -ForegroundColor DarkYellow
        }
    }
}

Write-Host "`n[4/4] Removing File Explorer sidebar icons and registry registry keys..." -ForegroundColor Yellow
$RegistryPaths = @(
    "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}",
    "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
)

foreach ($RegPath in $RegistryPaths) {
    if (Test-Path $RegPath) {
        Remove-Item -Path $RegPath -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Removed Registry Key: $RegPath" -ForegroundColor Green
    }
}

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "  Done! Please restart your PC to finish. " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
