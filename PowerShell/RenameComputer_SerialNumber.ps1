## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Rename script for offsite devices after cloning.

$SerialNumber_BIOS = (Get-CimInstance win32_bios).SerialNumber
$Hostname = (Get-ComputerInfo).CsName

# Check current name
if ($Hostname -ne $SerialNumber_BIOS) {
    Write-Host "Incorrect Hostname Detected, Renaming device to $SerialNumber_BIOS"
    Rename-Computer -NewName $SerialNumber_BIOS -Restart -Force
}

Write-Host 'Hostname is correctly set to serial number, Exiting.'
    exit 1