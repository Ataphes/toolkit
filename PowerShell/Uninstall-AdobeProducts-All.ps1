$RegApps = @( "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" )
$AllApps = Get-ItemProperty $RegApps -EA 0
$AD_Apps = $AllApps | Where { ($_.Publisher -like "*Adobe*") -and ($_.PSChildName) -match "{" }
$Arr_AD_ProdID = Out-String -InputObject $AD_Apps.PSChildName -Stream -Width 38

foreach ($ProdID in $Arr_AD_ProdID) {
    $Args = "/x $ProdID /qn"
    Write-Output Attempting to uninstall Product ID: $ProdID ...
    Start-Process -FilePath C:\Windows\System32\msiexec.exe -ArgumentList $Args -NoNewWindow -Wait
}