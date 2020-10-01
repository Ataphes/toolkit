#$Service_MSIServer = Get-Service msiserver
#while ($Service_MSIServer.Status -ne "Stopped" ) {
#    $Service_MSIServer = Get-Service msiserver
#    Start-Sleep 5
#}
#exit

do {
    $Service_MSIServer = Get-Service msiserver
    start-sleep 2
} until ($Service_MSIServer.Status -eq "Stopped")