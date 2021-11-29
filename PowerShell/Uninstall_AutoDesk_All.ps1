## AutoDesk Removal Script
## Get all AutoDesk products on machine and add to object
## Author: Joseph Walczak

##$AutoDeskSoftware_Detected = $True

##if ($AutoDesk_Install_Status -eq $True) {
    
    $Reg = @( "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" )
    $InstalledApps = Get-ItemProperty $Reg -EA 0
    $WantedApp = $InstalledApps | Where { ($_.Publisher -like "*Autodesk*") -and ($_.PSChildName) -match "{" }
    $MSI_ProdID = Out-String -InputObject $WantedApp.PSChildName -Stream -Width 38

    ##if (MSI_ProdID -eq $Null) {
    ##    Write-Host "No AutoDesk Products detected, exiting..."
    ##    $AutoDeskSoftware_Detected = $false
    ##}

    foreach ($i in $MSI_ProdID) {
        do {
            $Service_MSIServer = Get-Service msiserver
            start-sleep 2
        } until ($Service_MSIServer.Status -eq "Stopped")
    msiexec.exe /x $i
    }
##}



## Start-process $WantedApp.UninstallString -NoNewWindow -Wait

## Output Test: Needs improvement, need to filter for anything not starting with '{' in PSChildName
##Format-Table -InputObject $WantedApp -Property DisplayName, PSChildName


## $WantedApp

##$WantedApp | ForEach-Object {
##    MSIEXEC.EXE /x$WantedApp
##}

## Check properties of output
## Get-Member -InputObject $WantedApp

## Output Test: Needs improvement, need to filter for anything not starting with '{' in PSChildName
##Format-Table -InputObject $WantedApp -Property DisplayName, PSChildName

## Test Loop that iterates until the list is empty, works like shit because I'm bad.
## ForEach ($i in $WantedApp)
## {
##    MSIEXEC.exe /x($WantedApp).PSChildName
## }