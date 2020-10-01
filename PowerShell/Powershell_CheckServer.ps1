$RAC_ServerConfigPath = "C:\ProgramData\JWrapper-Remote Access\JWAppsSharedConfig\serviceconfig.xml"
$RAC_ServerConfigHostname = (Select-Xml -Path $RAC_ServerConfigPath -XPath /).Node.SimpleGatewayService.ConnectTo.'#text'
$RAC_IsInstalled = Test-Path -Path $RAC_ServerConfigPath
$RAC_IsConfigCorrect = $RAC_ServerConfigHostname -ne "http://ossimplehelp.os.oaklandschools.net:80"

# Check if RAC is installed.
Write-Host '-----
Starting Script...
Checking for Simple Help Remote Access Client... ' -NoNewline
if ($RAC_IsInstalled -ne "True") {
    Write-Host 'Not Installed. 
No Action Required, Exiting.
-----'
    exit 0
}
Write-Host 'Verified Installation.'

# Check RAC Gateway 
Write-Host 'Checking Simple Help Remote Access Client Configuration... ' -NoNewline
if ($RAC_IsConfigCorrect -ne "True") {
    Write-Host 'Verified Configuration.
No Action Required, Exiting
-----'
    exit 1
}

# Uninstall client if all above true.
Write-Host 'Incorrect Configuration Detected.
Uninstalling Simple Help Remote Access Client... ' -NoNewline
Get-Process -Name 'SimpleService','Remote Access*' | Stop-Process -Force | Out-Null
sleep 3
Get-Service -Name 'Remote Access Service' | Stop-Service -Force | Out-Null
sleep 3
remove-item -Path "C:\ProgramData\JWrapper-Remote Access" -Recurse -Force
sleep 3
Write-Host 'Uninstallation Completed.
Exiting...
-----' 
exit 0