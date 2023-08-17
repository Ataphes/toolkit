

# Functions

function Get-TimeStamp {
    return Get-Date
}

function Get-LocalKey {
    param (
        [string]$SysDrive,
        [switch]$ReturnRecoveryKey,
        [switch]$ReturnKeyProtectorID
    )

    $bitlockerVolume = Get-BitLockerVolume -MountPoint $SysDrive

    if ($ReturnRecoveryKey) {
        $bitlockerVolume.KeyProtector.RecoveryPassword
    }

    if ($ReturnKeyProtectorID) {
        $bitlockerVolume.KeyProtector.KeyProtectorID
    }
}
function Get-RemoteKey {
    param (
        [switch]$ReturnRecoveryKey
    )

    $recoveryInfo = Get-ADObject -Filter 'ObjectClass -eq "msFVE-RecoveryInformation"' -SearchBase $AD_CurrentMachine.DistinguishedName -Properties whenCreated, msFVE-RecoveryPassword | Sort-Object whenCreated -Descending | Select-Object -First 1 -ExpandProperty msFVE-RecoveryPassword

    if ($ReturnRecoveryKey) {
        $recoveryInfo
    }
}
function Display-BitLockerKeys {
    Write-Output @"
    
Local Recovery Key: $(Get-LocalKey -ReturnRecoveryKey)
Remote Recovery Key: $(Get-RemoteKey -ReturnRecoveryKey)
"@
}

Display-BitLockerKeys

# START SCRIPT

Write-Output "$(Get-TimeStamp) | Checking Module Dependencies..."

if (-not (Get-Module -Name ActiveDirectory -ListAvailable)) {
    Write-Output "$(Get-TimeStamp) | Active Directory Module not installed. Installing module..."
    Install-Module -Name RSAT-AD-PowerShell -Force
}

Write-Output "$(Get-TimeStamp) | Importing Active Directory Module..."
Import-Module -Name ActiveDirectory

Write-Output "$(Get-TimeStamp) | Verifying connectivity to DC..."

$DC = (Get-ADDomainController -NextClosestSite -Discover -DomainName "os.oaklandschools.net" -ErrorAction SilentlyContinue).hostname

if (-not $DC) {
    Write-Output "$(Get-TimeStamp) | Unable to connect to DC, Exiting..."
    Exit 1
}
else {
    Write-Output "$(Get-TimeStamp) | Successfully Connected to: $DC"
}

Write-Output "$(Get-TimeStamp) | Checking Recovery Key Status..."

$SysDrive = $ENV:SYSTEMDRIVE
$AD_CurrentMachine = Get-ADComputer $ENV:COMPUTERNAME

# Check if recovery keys are missing or mismatched on local or remote

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
Display-BitLockerKeys