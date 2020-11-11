## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us) 
## Migrate current Altiris endpoints to Altiris Cloud Endpoint Management 
## Designed around the intent to be run on startup via Task Scheduler to allow for resiliance through reboots
## Strictly proof of concept, requires to be logged in as local administrator account from a USB drive
## Can be easily adapted later for production use.


## TODO: Set up persistence via Registry Keys for script location to cross over the escalation and run correctly

## Global Variables

## Copy the required files over from USB drive.

## Check and self escalate script to administrator. WILL TRIGGER UAC PROMPT.

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    # Relaunch as an elevated process:
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
    exit
  }
  # Now running elevated so launch the script:
  & "$StagingDir\Migrate_AltirisCEM.ps1"

$StagingDir_Dest = "C:\PostInstall\scripts\Migrate_AltirisCEM"
$ErrorActionPreference = "SilentlyContinue"

Remove-Item -Path $StagingDir -Recurse -Force
New-Item -Path $StagingDir -ItemType Directory
Copy-Item -Path "$StagingDir_Source\*" -Destination $StagingDir_Dest -Recurse -Force

Write-Host 'All directories created and files copied.'

$Check_AltirisCEM_InstallState = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Altiris\Communications\NS Connection\Non-Persistent' -Name "Host Name: Gateway"
$Check_AltirisInstallPath = Test-Path -Path "C:\Program Files\Altiris\Altiris Agent"

if ({$Check_AltirisCEM_InstallState}.'Host Name: Gateway' -ne 'ossmc_gw' -and $Check_AltirisInstallPath -eq $True) {
    Write-Host 'Removing Legacy Altiris Client.'
    Start-Process -FilePath "$StagingDir\AeXNSCHTTPs.exe" -ArgumentList "/Uninstall /s" -Wait
    Write-Host 'Installing Altiris CEM Client'
    Start-Process -FilePath "$StagingDir\ExtractedCEM\AeXNSAgentInst.exe" -ArgumentList "/install /installxml=$StagingDir\ExtractedCEM\aexnsc.xml /s" -Wait
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Altiris\Communications\NS Connection\Non-Persistent' -Name 'Host Name: Gateway' -Value 'ossmc_gw' -PropertyType 'REG_SZ' -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Altiris\Communications\NS Connection\Non-Persistent' -Name 'Host Name: IP Address: Remote' -Value '216.11.97.201' -PropertyType 'REG_SZ' -Force
    Restart-Computer
    Exit 0
}
Write-Host 'Altiris CEM Client Installed... Exiting.'