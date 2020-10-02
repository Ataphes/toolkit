do {
    $Service_MSIServer = Get-Service msiserver
    start-sleep 2
} until ($Service_MSIServer.Status -eq "Stopped")