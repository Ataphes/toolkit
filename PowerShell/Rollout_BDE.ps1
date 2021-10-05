## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Summary: Check if device is able to communicate with AD before BitLocker

# Set execution policy for script.
if ((Get-ExecutionPolicy) -ne 'RemoteSigned') {
    Write-Host "Execution Policy Misconfigured, Correcting..."
    Set-ExecutionPolicy RemoteSigned -Force
}
Write-Host "Execution Policy Set to Remote Signed..."

$NetCheck = Test-NetConnection -computername osdc02.os.oaklandschools.net

# Test connectivity to DC
if (($NetCheck).PingSucceeded -ne 'True') {
    Write-Host 'Device not connected to OSLAN'
}

if (($NetCheck).PingSucceeded -eq 'True') {
    Write-Host 'Device Connected to OSLAN, Proceeding with Bitlocker Deployment.'
    gpupdate /force
##    Enable-Bitlocker -MountPoint "C:" -EncryptionMethod AES256 -UsedSpaceOnly –RecoveryPasswordProtector -WhatIf
}