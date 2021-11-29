## AutoDesk Removal Script
## Get all AutoDesk products on machine and add to object
## Author: Joseph Walczak

## Find all AutoDesk based MSI install files on the machine and put their product IDs in to an array.
$Reg = @( "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" )
$InstalledApps = Get-ItemProperty $Reg -EA 0
$WantedApp = $InstalledApps | Where { ($_.Publisher -like "*Autodesk*") -and ($_.PSChildName) -match "{" }
$MSI_ProdID = Out-String -InputObject $WantedApp.PSChildName -Stream -Width 38

## Stop all AutoDesk related services.
## $AutoDesk_Service = Get-Service -Name "*AutoDesk*"



foreach ($i in $MSI_ProdID) {
##    do {
##       $Service_MSIServer = Get-Service msiserver
##        start-sleep 15
##    } until ($Service_MSIServer.Status -eq "Stopped")
Write-Host Attempting to uninstall Product ID: $i ...
Start-Process -FilePath C:\Windows\System32\msiexec.exe -ArgumentList "/x $i /qn /LI+ C:\AutoDesk_Uninstall.log" -NoNewWindow -Wait
}
## Restart-Computer -Wait 0