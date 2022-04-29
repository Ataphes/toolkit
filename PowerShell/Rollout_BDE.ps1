## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Summary: Check if device is able to communicate with AD before BitLocker

# TO DO
## Check BitLocker implementation state. 
### If it's enabled, check AD for key status. If no key, sync key with AD and end script with 0 exit code.
## Check for Service Account presence in the Local Administrators group.
## Check for closest site server and use that for ping check.

#Variables

$DC = "osdc02.os.oaklandschools.net"

## Detect if Bitlocker has already been enabled and if so, do nothing. Else, fix it or something.

## Check presence of BitLocker recovery key and store for later use and for testing for null values
$L_BitLockerRecoveryKey = ((Get-BitLockerVolume -MountPoint $env.SystemDrive).KeyProtector).RecoveryPassword

write-output "Checking Bitlocker Status..."
if ($L_BitLockerRecoveryKey -eq $null) {
    write-output "No Bitlocker Recovery Key present, enabling BitLocker..."
}
else {
    write-output "Bitlocker Key Found, No further action required. Exiting now..."
    exit 0
    throw "Bitlocker Key Found, No further action required. Exiting now..."
}

# Set execution policy for script.
if ((Get-ExecutionPolicy) -ne 'RemoteSigned') {
    write-output "Execution Policy Misconfigured, Correcting..."
    Set-ExecutionPolicy RemoteSigned -Force
} else {
    write-output "Execution Policy Set to Remote Signed, no action required."
}

# Check if the machine is able to reach the Domain Controller and if so, enable BitLocker.
write-output "Testing Connectivity to: $DC"
if (-not $(Test-Connection $DC -ErrorAction SilentlyContinue)) {
    write-output "Unable to communicate with the domain controller, Exiting"
    exit 1
} else {
    write-output "Done."
    write-output "Enabling Bitlocker Disk Encryption..."
    Enable-Bitlocker -MountPoint C: -EncryptionMethod AES256 -UsedSpaceOnly -RecoveryPasswordProtector
    write-output "Enabled."
    exit 0    
}