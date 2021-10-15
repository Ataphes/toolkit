## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Summary: Check if device is able to communicate with AD before BitLocker

# TO DO
## Check BitLocker implementation state.
### Check if BDE is enabled, if so, end script there with 0 error code
### If it's enabled, check AD for key status. If no key, sync key with AD and end script with 0 exit code.

#Variables

$DC = "osdc02.os.oaklandschools.net"

# Set execution policy for script.
if ((Get-ExecutionPolicy) -ne 'RemoteSigned') {
    Write-Host "Execution Policy Misconfigured, Correcting..."
    Set-ExecutionPolicy RemoteSigned -Force
} else {
    Write-Host "Execution Policy Set to Remote Signed, no action required."
}

# Check if the machine is able to reach the Domain Controller and if so, enable BitLocker.
Write-Host "Testing Connectivity to: $DC"
if (-not $(Test-Connection $DC -ErrorAction SilentlyContinue)) {
    Write-Host "Unable to communicate with the domain controller, Exiting"
    exit 1
} else {
    Write-Host "Device Connected to OSLAN, Updating Group Policy..."
    Invoke-GPUpdate -Force
    Write-Host "Done."
    Write-Host "Enabling Bitlocker Disk Encryption..."
    Enable-Bitlocker -MountPoint C: -EncryptionMethod AES256 -UsedSpaceOnly -RecoveryPasswordProtector
    Write-Host "Enabled."
    exit 0    
}