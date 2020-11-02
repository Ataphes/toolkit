## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us) ##
## Migrate current Altiris endpoints to Altiris Cloud Endpoint Management ##
## Designed around the intent to be run on startup via Task Scheduler to allow for resiliance through reboots ##

## TODO: Literally everything (lol).
## TODO: Download required files from share if not found. Possibly via google drive
## TODO: Detect current installation status (Directory check and/or check services).
## TODO: Install CEM.
## TODO: Reinstall old client on failure to complete.
## TODO: Log all output for remediation incase of failure.
## TODO: Set self in task scheduler to ensure completion and remove on success.

## VARIABLES
$StagingDir = "C:\PostInstall\scripts\Migrate_AltirisCEM"
$LogDir = "C:\PostInstall\scripts\Migrate_AltirisCEM\logs"


## SCRIPT START ##

## check for directory and copy files to staging location
if ({test-path -path $StagingDir} -false) {
    
}

## Check if Altiris Client is currently installed and configured correctly


## Uninstall old altiris client and restart
## SUBTASK: Create scheduled task for resiliance



## Install CEM