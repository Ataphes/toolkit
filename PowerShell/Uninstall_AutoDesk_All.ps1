## AutoDesk Purge Script
## Purge ALL AutoDesk Products from a machine with EXTREME gusto.
## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)

## Safety Off, Full Send.
$ErrorActionPreference = "SilentlyContinue"

## Stop all AutoDesk related Processes
Write-Host "Stopping All AutoDesk Processes..."
$AD_Proc = Get-Process | Where {$_.Product -Like "*AutoDesk*"}
Stop-Process -InputObject $AD_Proc -Force
Write-Host "Done.`n"

## Stop all AutoDesk related services.
Write-Host "Stopping all AutoDesk Services..."
$AD_Svc = Get-Service | Where {$_.DisplayName -like "*AutoDesk*"}
Stop-Service -InputObject $AD_Svc -Force -NoWait
Write-Host "Done.`n"

## Uninstall Fusion 360 if installed.
Write-Host "Uninstalling Fusion 360 (If Present)."
Start-process -FilePath "C:\Program Files\Autodesk\webdeploy\meta\streamer\streamer.exe" -ArgumentList "--globalinstall --process uninstall --quiet -f C:\PostInstall\Update_F360.log" -NoNewWindow -Wait
Write-Host "Done.`n"

## Autodesk Provided command to remove Autodesk App Manager
Write-Host "Removing AutoDesk App Manager..."
Remove-item "C:\Programdata\Autodesk\SDS" -Recurse -Force
Start-process -FilePath "C:\Program Files (x86)\Autodesk\Autodesk Desktop App\removeAdAppMgr.exe" -ArgumentList "--mode unattended" -NoNewWindow -Wait 
Write-Host "Done.`n"

## Find all AutoDesk based MSI install files on the machine and put their product IDs in to an array.
Write-Host "Starting AutoDesk Suite Removal..."
$RegApps = @( "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" )
$AllApps = Get-ItemProperty $RegApps -EA 0
$AD_Apps = $AllApps | Where { ($_.Publisher -like "*Autodesk*") -and ($_.PSChildName) -match "{" }
$Arr_AD_ProdID = Out-String -InputObject $AD_Apps.PSChildName -Stream -Width 38

foreach ($ProdID in $Arr_AD_ProdID) {
Write-Host Attempting to uninstall Product ID: $ProdID ...
Start-Process -FilePath C:\Windows\System32\msiexec.exe -ArgumentList "/x $ProdID /qn /LI+ C:\AutoDesk_Uninstall.log" -NoNewWindow -Wait
}
Write-Host "Done. Please check C:\AutoDesk_Uninstall.log for more details.`n"

## Clean up residual files
Write-Host "Cleaning up residual files and folders..."
Remove-item -Path "C:\ProgramData\FLEXnet" -Recurse -Force
Remove-item -Path "C:\Program Files\Autodesk" -Recurse -Force
Remove-item -Path "C:\ProgramData\Autodesk" -Recurse -Force
Remove-item -Path "C:\Windows\Temp\*" -Recurse -Force
Write-Host "Done.`n"

## Clean up registry keys relating to AutoDesk Products including uninstall records since we purge the remainder of the files in the previous step.
Write-Host "Cleaning up remaining registry entries."
Remove-Item -Path HKLM:\SOFTWARE\Autodesk -Recurse -Force
foreach ($ProdID in $Arr_AD_ProdID) {
    Remove-Item -Path HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$ProdID -Recurse -Force
    Remove-Item -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$ProdID -Recurse -Force
}
Write-Host "Done.`n"

Restart-Computer -Wait 0