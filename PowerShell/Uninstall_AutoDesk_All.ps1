## AutoDesk Removal Script
## Remove ALL AutoDesk Products from a machine with EXTREME gusto.
## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)

## Safety Off, Full Send.
$ErrorActionPreference = "SilentlyContinue"

## Stop all AutoDesk related Processes
$AD_Proc = Get-Process | Where {$_.Product -Like "*AutoDesk*"}
Stop-Process -InputObject $AD_Proc -Force

## Stop all AutoDesk related services.
$AD_Svc = Get-Service | Where {$_.DisplayName -like "*AutoDesk*"}
Stop-Service -InputObject $AD_Svc -Force -NoWait

## Autodesk Provided command to remove Autodesk App Manager
Remove-item "C:\Programdata\Autodesk\SDS" -Recurse -Force
Start-process -FilePath "C:\Program Files (x86)\Autodesk\Autodesk Desktop App\removeAdAppMgr.exe" -ArgumentList "--mode unattended" -NoNewWindow -Wait 

## Find all AutoDesk based MSI install files on the machine and put their product IDs in to an array.
$RegApps = @( "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" )
$AllApps = Get-ItemProperty $RegApps -EA 0
$AD_Apps = $AllApps | Where { ($_.Publisher -like "*Autodesk*") -and ($_.PSChildName) -match "{" }
$Arr_AD_ProdID = Out-String -InputObject $AD_Apps.PSChildName -Stream -Width 38

foreach ($i in $Arr_AD_ProdID) {
Write-Host Attempting to uninstall Product ID: $i ...
Start-Process -FilePath C:\Windows\System32\msiexec.exe -ArgumentList "/x $i /qn /LI+ C:\AutoDesk_Uninstall.log" -NoNewWindow -Wait
}

## Clean up residual files
Remove-item -Path "C:\ProgramData\FLEXnet" -Recurse -Force
Remove-item -Path "C:\Program Files\Autodesk" -Recurse -Force
Remove-item -Path "C:\ProgramData\Autodesk" -Recurse -Force
Remove-item -Path "C:\Windows\Temp\*" -Recurse -Force

## Clean up registry keys relating to AutoDesk Products.
Remove-Item -Path HKLM:\SOFTWARE\Autodesk -Recurse -Force

## Restart-Computer -Wait 0