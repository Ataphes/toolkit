## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us) 
## Migrate current Altiris endpoints to Altiris Cloud Endpoint Management 
## Designed around the intent to be run on startup via Task Scheduler to allow for resiliance through reboots
## Strictly proof of concept, requires to be logged in as local administrator account from a USB drive
## Can be easily adapted later for production use.

## TODO: Download required files from share if not found. Possibly via google drive
## TODO: Detect current installation status (Directory check and/or check services).
## TODO: Install CEM.
## TODO: Reinstall old client on failure to complete.
## TODO: Log all output for remediation incase of failure.
## TODO: Set self in task scheduler to ensure completion and remove on success.

## SCRIPT START

## Check for staging directory and copy the required files over from USB drive

$StagingDir = "C:\PostInstall\scripts\Migrate_AltirisCEM"
$Check_StagingDir = Test-Path -LiteralPath $StagingDir
if ($Check_StagingDir -eq $False) {
    New-Item -Path $StagingDir -ItemType Directory
    Copy-Item -Path .* -Destination $StagingDir
}
Write-Host 'All directories created and files copied.'

## Schedule Task for execution to establish persistence.

$TaskName = "Migrate_AltirisCEM"
$Check_TaskName = Get-ScheduledTask -TaskName $TaskName
if ($Check_TaskName.TaskName -notcontains $TaskName) {
    Write-Host 'No Task Detected, Scheduling Task...'
    schtasks.exe /Create /XML "$StagingDir\Migrate_AltirisCEM.xml"
}
Write-Host 'Scheduled task already present.'


## Check for and uninstall baseline Altiris Client.

$Check_AltirisCEM_InstallState = Get-ItemProperty -Path 'REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Altiris\Communications\NS Connection\Non-Persistent\' -Name "Host Name: Gateway"
$Check_AltirisInstallPath = Test-Path -Path "C:\Program Files\Altiris\Altiris Agent"
if ($null -eq $Check_AltirisCEM_InstallState.'Host Name: Gateway' -and $Check_AltirisInstallPath -eq $true) {
    Write-Host 'Removing Legacy Altiris Client.'
    Start-Process -FilePath "$StagingDir\AeXNSCHTTPs.exe" -ArgumentList "/Uninstall /s" -Wait
    Restart-Computer -Wait 5 -Force
}
else {
    Write-Host 'Installing Altiris CEM Client'
    Start-Process -FilePath "$StagingDirectory\ExtractedCEM\AeXInstallPrecheck.exe" -ArgumentList "/install /installxml=aexnsc.xml" -Wait
    Restart-computer -Wait 5 -Force
}


## Verify client registration.

if ($Check_AltirisCEM_InstallState.'Host Name: Gateway' -eq 'ossmc_gs') {
    Write-Host 'Altiris CEM Client Successfully Installed'    
}
Write-Host 'Altiris CEM Client did not successfully install'