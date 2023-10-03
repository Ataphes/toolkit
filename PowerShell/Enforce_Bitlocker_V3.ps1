# Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
# Summary: Check for and enforce bitlocker disk encryption on hosts.

# Functions

# Allow for timestamps for each phase of log.
function Time {
    return Get-Date
}
# Check key status.
function L_BitLockerRecoveryKey {
    ((Get-BitLockerVolume -MountPoint $SysDrive ).KeyProtector).RecoveryPassword
}
function R_BitLockerRecoveryKey {
    Get-ADObject -Filter 'ObjectClass -eq "msFVE-RecoveryInformation"' -SearchBase $AD_CurrentMachine.DistinguishedName -Properties whenCreated, msFVE-RecoveryPassword | Sort-Object whenCreated -Descending | Select-Object -First 1 -ExpandProperty msFVE-RecoveryPassword
}
function Display_BitLockerRecoveryKeys {
    Write-Output "
Local Recovery Key: $(L_BitLockerRecoveryKey)
Remote Recovery Key: $(R_BitLockerRecoveryKey)
"
}

# START SCRIPT

Write-Output "$(Time) | Checking Module Dependencies..."
$InstalledFeatures = Get-WindowsCapability -Name *Rsat.ActiveDirectory* -Online

if ($InstalledFeatures.State -ne "Installed") {
    Write-output "$(Time) | Active Directory Feature not installed, Installing Feature..."
    $InstalledFeatures | Add-WindowsCapability -Online > $null
    Write-Output "$(Time) | Installed Active Directory Feature. Importing Active Directory Module..."
    Import-Module -Name ActiveDirectory
}
else {
    Write-Output "$(Time) | Active Directory Feature is Installed, Importing Active Directory Module..."
    Import-Module -Name ActiveDirectory
}

Write-Output "$(Time) | Verifying connectivity to DC..."

$DC = (Get-ADDomainController -NextClosestSite -Discover -DomainName "os.oaklandschools.net" -ErrorAction SilentlyContinue).hostname

if ($null -eq $DC) {
    Write-Output  "$(Time) | Unable to connect to DC, Exiting..."
    Exit 1
}
else {
    Write-Output "$(Time) | Successfully Connected to: $DC"
}

Write-Output "$(Time) | Checking Recovery Key Status..."

$SysDrive = $ENV:SYSTEMDRIVE
$AD_CurrentMachine = Get-ADComputer $ENV:COMPUTERNAME

if ($(L_BitLockerRecoveryKey) -eq $(R_BitLockerRecoveryKey)) {
    Write-Output "$(Time) | Local Recovery Key matches Remote Recovery Key, No Action Required. Exiting..."
    $(Display_BitLockerRecoveryKeys)
    Exit 0
}
else {
    Write-Output "$(Time) | BitLocker Recovery Keys are Mismatched or Missing. Attempting to Generate and Sync New Recovery Key..."
    $(Display_BitLockerRecoveryKeys)
}

if (-not $(Get-RemoteKey -ReturnRecoveryKey) -or -not $(Get-RemoteKey -ReturnRecoveryKey) -or $(Get-LocalKey -ReturnRecoveryKey) -ne $(Get-RemoteKey -ReturnRecoveryKey)) {
    Write-Output "$(Get-TimeStamp) | BitLocker Recovery Keys are Mismatched or Missing. Attempting to Generate and Sync New Recovery Key..."
    if (-not $(Get-RemoteKey -ReturnRecoveryKey)) {
        Write-Output "$(Get-TimeStamp) | Enabling and Bitlocker and generating new Local Recovery Key..."
        Enable-Bitlocker -MountPoint $SysDrive -EncryptionMethod AES256 -UsedSpaceOnly -RecoveryPasswordProtector
    }
    if (-not $(Get-RemoteKey -ReturnRecoveryKey) -or $(Get-LocalKey -ReturnRecoveryKey) -ne $(Get-RemoteKey -ReturnRecoveryKey)) {
        Write-Output "$(Get-TimeStamp) | Communicating Recovery Key to Active Directory..."
        Backup-BitLockerKeyProtector -MountPoint $SysDrive -KeyProtectorId $(Get-LocalKey -ReturnKeyProtectorID)
    }
}

## Enabling Bitlocker if all other checks are passed.
##Write-Output "$(Time) | Enabling Bitlocker Disk Encryption, Please wait..."
##Enable-Bitlocker -MountPoint $SysDrive -EncryptionMethod AES256 -UsedSpaceOnly -RecoveryPasswordProtector -WarningAction SilentlyContinue -ErrorAction SilentlyContinue > $null
##Write-Output "$(Time) | Bitlocker Enabled, Recovery Key Communicated to Active Directory"
##$(Display_BitLockerRecoveryKeys)
##exit 0
