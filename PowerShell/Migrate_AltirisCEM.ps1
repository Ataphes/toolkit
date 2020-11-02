## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us) 
## Migrate current Altiris endpoints to Altiris Cloud Endpoint Management 
## Designed around the intent to be run on startup via Task Scheduler to allow for resiliance through reboots
## Strictly proof of concept, requires to be logged in as local administrator account from a USB drive
## Can be easily adapted later for production use.

## TODO: Literally everything.
## TODO: Download required files from share if not found. Possibly via google drive
## TODO: Detect current installation status (Directory check and/or check services).
## TODO: Install CEM.
## TODO: Reinstall old client on failure to complete.
## TODO: Log all output for remediation incase of failure.
## TODO: Set self in task scheduler to ensure completion and remove on success.

Clear-Host



## Check for staging directory and copy the required files over from USB drive
$StagingDir = "C:\PostInstall\scripts\Migrate_AltirisCEM"
$Check_StagingDir = Test-Path -LiteralPath $StagingDir
if ($Check_StagingDir -eq $False) {
    New-Item -Path $StagingDir -ItemType Directory
    Copy-Item -Path .* -Destination $StagingDir
}

## Schedule Task for execution.

$TaskName = "Migrate_AltirisCEM"
$Check_TaskName = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
if ($Check_TaskName.state -eq '') {
    Write-Host 'You Done Goofed Correctly'
}