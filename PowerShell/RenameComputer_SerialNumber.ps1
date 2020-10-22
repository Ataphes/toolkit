## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Rename script for offsite devices after cloning.

$SerialNumber_BIOS = (Get-CimInstance win32_bios).SerialNumber
$Hostname = (Get-ComputerInfo).CsName

# Check current name
if ($SerialNumber_BIOS -eq $Hostname) {
    Write-Host "
Hostname is correctly set to serial number
No further action required
Exiting...
"
exit 1
}

# Check if exit code is still null, and rename computer.
if ($LASTEXITCODE -eq $null) {
    Write-Host "
Incorrect Hostname Detected, Renaming device to $SerialNumber_BIOS
"
}