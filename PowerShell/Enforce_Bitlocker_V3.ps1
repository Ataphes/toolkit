# Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
# Summary: Enforces Bitlocker encryption and ensure the keys are synced correctly to Active Directory.

## FUNCTIONS

# Allow for timestamps for each phase of log.
function Get-TimeStamp {
    return Get-Date
}
# Get key data.
function Get-LocalKey {
    ((Get-BitLockerVolume -MountPoint $SysDrive ).KeyProtector).RecoveryPassword
}
function Get-RemoteKey {
    Get-ADObject -Filter 'ObjectClass -eq "msFVE-RecoveryInformation"' -SearchBase $AD_CurrentMachine.DistinguishedName -Properties whenCreated, msFVE-RecoveryPassword | Sort-Object whenCreated -Descending | Select-Object -First 1 -ExpandProperty msFVE-RecoveryPassword
}
# Used for debugging and verification of output. Can be removed if/when script is minified.
function Show-CurrentKeys {
    Write-Output "
Local Recovery Key: $(Get-LocalKey)
Remote Recovery Key: $(Get-RemoteKey)
"
}

## START SCRIPT

Write-Output "$(Get-TimeStamp) | Checking Module Dependencies..."
$InstalledFeatures = Get-WindowsCapability -Name *Rsat.ActiveDirectory* -Online

if ($InstalledFeatures.State -ne "Installed") {
    Write-output "$(Get-TimeStamp) | Active Directory Feature not installed, Installing Feature..."
    $InstalledFeatures | Add-WindowsCapability -Online > $null
    Write-Output "$(Get-TimeStamp) | Installed Active Directory Feature. Importing Active Directory Module..."
    Import-Module -Name ActiveDirectory
}
else {
    Write-Output "$(Get-TimeStamp) | Active Directory Feature is Installed, Importing Active Directory Module..."
    Import-Module -Name ActiveDirectory
}

Write-Output "$(Get-TimeStamp) | Verifying connectivity to DC..."
$DC = (Get-ADDomainController -NextClosestSite -Discover -DomainName "os.oaklandschools.net" -ErrorAction SilentlyContinue).hostname

if ($null -eq $DC) {
    Write-Output  "$(Get-TimeStamp) | Unable to connect to DC, Exiting..."
    Exit 1
}
else {
    Write-Output "$(Get-TimeStamp) | Successfully Connected to: $DC"
}

Write-Output "$(Get-TimeStamp) | Checking Recovery Key Status..."

$SysDrive = $ENV:SYSTEMDRIVE
$AD_CurrentMachine = Get-ADComputer $ENV:COMPUTERNAME

# Verifies and resolves key pair mismatches.
if (-not $(Get-RemoteKey -ReturnRecoveryKey) -or -not $(Get-RemoteKey -ReturnRecoveryKey) -or $(Get-LocalKey -ReturnRecoveryKey) -ne $(Get-RemoteKey -ReturnRecoveryKey)) {
    Write-Output "$(Get-TimeStamp) | BitLocker Recovery Keys are Mismatched or Missing. Attempting to Generate and Sync New Recovery Key..."
    # Enables Bitlocker Locally, piped to null to hide ugly output.
    if (-not $(Get-LocalKey -ReturnRecoveryKey)) {
        Write-Output "$(Get-TimeStamp) | Enabling and Bitlocker and generating new Local Recovery Key..."
        Enable-Bitlocker -MountPoint $SysDrive -EncryptionMethod AES256 -UsedSpaceOnly -RecoveryPasswordProtector -WarningAction SilentlyContinue > $Null
    }
    # Checks key sync status and sends the updated key to AD if not correct.
    if (-not $(Get-RemoteKey -ReturnRecoveryKey) -or $(Get-LocalKey -ReturnRecoveryKey) -ne $(Get-RemoteKey -ReturnRecoveryKey)) {
        Write-Output "$(Get-TimeStamp) | Communicating Recovery Key to Active Directory..."
        Backup-BitLockerKeyProtector -MountPoint $SysDrive -KeyProtectorId $(Get-LocalKey -ReturnKeyProtectorID)
    }
}
# Instrumentation, Can be removed if script is minified.
$(Show-CurrentKeys)
Exit 0

## END SCRIPT ##