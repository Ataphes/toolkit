## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Summary: Check if device is able to communicate with AD before BitLocker

# Variables

$NetCheck = (Test-NetConnection -ComputerName "OSDC02.OS.Oaklandschools.net" -WarningAction SilentlyContinue).PingSucceeded

# Set execution policy for script.
if ((Get-ExecutionPolicy) -ne 'RemoteSigned') {
    Write-Host "Execution Policy Misconfigured, Correcting..."
    Set-ExecutionPolicy RemoteSigned -Force
} else {
    Write-Host "Execution Policy Set to Remote Signed, no action required."
}

if ($NetCheck -eq $true) {
    Write-Host "Device Connected to OSLAN, Updating Group Policy..."
    Invoke-GPUpdate -Force
    Write-Host "Done."
    Write-Host "Enabling Bitlocker Disk Encryption..."
    Enable-Bitlocker -MountPoint C: -EncryptionMethod AES256 -UsedSpaceOnly -RecoveryPasswordProtector
    Write-Host "Enabled."
    exit 0
} else {
    Write-Host "Not connected to OSLAN, Exiting"
    exit 1
}