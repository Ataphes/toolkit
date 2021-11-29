## AutoDesk Removal Script
## Get all AutoDesk products on machine and add to object
## Author: Joseph Walczak
    
$Reg = @( "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" )
$InstalledApps = Get-ItemProperty $Reg -EA 0
$WantedApp = $InstalledApps | Where { ($_.Publisher -like "*Autodesk*") -and ($_.PSChildName) -match "{" }
$MSI_ProdID = Out-String -InputObject $WantedApp.PSChildName -Stream -Width 38

foreach ($i in $MSI_ProdID) {
    do {
        $Service_MSIServer = Get-Service msiserver
        start-sleep 2
    } until ($Service_MSIServer.Status -eq "Stopped")
Write-Host Attempting to uninstall Product ID: $i ...
msiexec.exe /x $i /qb
}