## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Summary: Check for and enforce bitlocker disk encryption on hosts.

# TO DO
## check AD for key status. If key is mismatched or does not exist, send updated recovery key.
## Check for closest site server and use that for ping check.
## Actually write proper error handling.

## Check for connectivity to nearest domain controller.

$DC = (Get-ADDomainController -NextClosestSite -Discover -DomainName "os.oaklandschools.net").hostname
$SysDrive = $ENV:SYSTEMDRIVE
$L_BitLockerRecoveryKey = ((Get-BitLockerVolume -MountPoint $SysDrive ).KeyProtector).RecoveryPassword

## Detect if Bitlocker has already been enabled and if so, do nothing. Else, fix it or something.

write-output "Checking Bitlocker Status..."
if ($L_BitLockerRecoveryKey -eq $null) {
    write-output "No Bitlocker Recovery Key present, enabling BitLocker..."
## Check for DC connectivity before proceeding.
    write-output "Testing Connectivity to: $DC"
    if (-not $(Test-Connection $DC -ErrorAction SilentlyContinue)) {
        Write-Output "Unable to communicate with the domain controller, exiting."
        exit 1
        throw
    }
    else {
        Write-Output "Connection to $DC Successful!"
    }
## Enabling Bitlocker if all other checks are passed.
    Write-Output "Enabling Bitlocker Disk Encryption, Please wait..."
    Enable-Bitlocker -MountPoint $SysDrive -EncryptionMethod AES256 -UsedSpaceOnly -RecoveryPasswordProtector > out-null
    Write-Output "Bitlocker enabled on host, key will be communicated automatically"
    exit 0
    throw
}
else {
    Write-Output "Bitlocker Key Found, No further action required. Exiting now..."
    exit 0
    throw
}