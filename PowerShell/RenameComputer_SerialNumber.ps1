# Rename script for offsite devices after cloning.
$LASTEXITCODE = $null
$SerialNumber_BIOS = (Get-CimInstance win32_bios).SerialNumber
$Hostname = (Get-ComputerInfo).CsName
# $Curr_ExecPol = Get-ExecutionPolicy

# Check execution policy before run.
#if ($Curr_ExecPol -eq "Restricted") {
#Write-Host "
#Execution Policy set to Restricted.
#Please correct this and try again.
#Exiting...
#"
#exit 1
#}

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