## Find all software with a certian publisher name based MSI install files on the machine and put their product IDs in to an array.
## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)

## Control Vars

$PubName = "*Check Point Software*"

## Do Not Modify Below This Line

$RegApps = @( "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" )
$AllApps = Get-ItemProperty $RegApps -EA 0
$AD_Apps = $AllApps | Where { ($_.Publisher -like $PubName) -and ($_.PSChildName) -match "{" }
$Arr_AD_ProdID = Out-String -InputObject $AD_Apps.PSChildName -Stream -Width 38

foreach ($ProdID in $Arr_AD_ProdID) {
Write-Host Attempting to uninstall Product ID: $ProdID ...
Start-Process -FilePath C:\Windows\System32\msiexec.exe -ArgumentList "/x $ProdID /qn /norestart /LI+ C:\Pub_Uninstall.log" -NoNewWindow -Wait
}