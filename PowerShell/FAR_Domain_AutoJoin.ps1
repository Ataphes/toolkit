## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Summary: Domain Join script for machines cloned by your vendor.

## TODO: Add control variables to top of script for ease of use.
## TODO: Add vars for passing checks and verify before triggering domain join.
## TODO: Write a check for  Maybe try to ping localhost with the credentials?

## Check if device able to ping DC to verify on network.
if ({Test-Connection FARDC.OS.OaklandSchools.net -Quiet -Count 1} -eq 'False') {
    Write-Host 'Device not connected to OSLAN. Exiting.'
    exit 1
}
Write-Host 'Device connected to OSLAN...'

## Check if machine is already joined to domain.
if ((Get-WmiObject -Class Win32_ComputerSystem).Domain -eq 'os.oaklandschools.net') {
    write-host 'Machine joined to OSLAN already. Exiting.'
    exit 0
}
Write-Host 'Domain Join Required...'

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
Add-Computer -DomainName 'OSLAN' -server 'OSDC02.os.oaklandschols.net' -Credential $PSCredObj -OUPath 'OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net' -Restart
Write-Host 'Domain Joined. Restarting Now.' -NoNewline