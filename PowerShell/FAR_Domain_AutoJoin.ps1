## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Summary: Domain Join script for machines cloned by your vendor.

## TODO: Add control variables to top of script for ease of use.
## TODO: Add vars for passing checks and verify before triggering domain join.
## TODO: Write a check for credentials, maybe try to ping localhost with the credentials via Test-Connection?
## TODO: Add an AD Machine Group check and join routine.


###### RENAME TO: SERIAL NUMBER ######

## Set test variables
$SerialNumber_BIOS = (Get-CimInstance win32_bios).SerialNumber
$Hostname = (Get-ComputerInfo).CsName

# Check current name
if ($Hostname -ne $SerialNumber_BIOS) {
    Write-Host "Incorrect Hostname Detected, Renaming device to $SerialNumber_BIOS"
    Rename-Computer -NewName $SerialNumber_BIOS -Restart -Force
    Exit 0
}
Write-Host "Hostname is correctly set to $SerialNumber_BIOS"

###### DOMAIN JOIN ######

## Check if machine is already joined to domain.
if ((Get-WmiObject -Class Win32_ComputerSystem).Domain -ne 'os.oaklandschools.net') {
    Write-Host 'Domain Join Required...'
    
    ## Check if device able to ping DC to verify on network.

    ## Set Variables
    $NetworkTest = Test-Connection osdc02.os.oaklandschools.net -Quiet -Count 1
    $NetworkTest_Attempts = 0
    
    ## Allow a window of time the script will wait for network connectivity.
    do {
        $NetworkTest
        if ($OSDC02_NetworkTest -eq 'False') {
            $NetworkTest_Attempts++
            Start-Sleep -Seconds 10
            Write-Host 'Retrying in Ten Seconds...'
        }
    } until ($NetworkTest -eq 'True' -or $NetworkTest_Attempts -ge '18')

    if ({Test-Connection osdc02.os.oaklandschools.net -Quiet -Count 1} -eq 'False') {
        Write-Host 'Device not connected to Oakland Schools internal network. Exiting.'
        exit 1
    }
    Write-Host 'Device connected to Oakland Schools internal network...'

    ## Locate Public Key on USB drive and set VAR, and throw error if it's not found.
    $AdminAccount_PublicKey = Get-psdrive -PSProvider 'FileSystem' | ForEach-Object -Process {Join-Path -Path $_.Root -ChildPath 'AltirisCLI.txt' -Resolve -ErrorAction SilentlyContinue}
    if ($AdminAccount_PublicKey -eq '') {
        Write-Host 'No public key found, Contact your STSS for information. Exiting.'
        exit 1
    }
    Write-Host "Public Key found at $AdminAccount_PublicKey..."

    ## Load Public Key and Create PSCred Object.
    $AdminAccount_Name = 'OSLAN\AltirisCLI'
    $AdminAccount_PasswordText = Get-Content -path $AdminAccount_PublicKey
    $AdminAccount_PasswordEncrypted = $AdminAccount_PasswordText | ConvertTo-SecureString
    $PSCredObj = New-Object System.Management.Automation.PSCredential -ArgumentList $AdminAccount_Name, $AdminAccount_PasswordEncrypted

    ## Join to domain
    Write-Host 'Joining to domain... '
    Add-Computer -DomainName 'OSLAN' -server 'OSDC02.os.oaklandschools.net' -Credential $PSCredObj -OUPath 'OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net' -Restart
    Write-Host 'Domain Joined. Restarting Now.' -NoNewline
    }
write-host 'Machine joined to OSLAN already. Exiting.'
exit 0
