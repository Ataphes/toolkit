## Check if device able to ping DC to verify on network.
if ({Test-Connection FARDC.OS.OaklandSchools.net -Quiet -Count 1} -eq 'False') {
    Write-Host 'Device not connected to OSLAN, Exiting.'
    exit 1
}
Write-Host 'Device connected to OSLAN...'

## Check if machine is already joined to domain.
if ((Get-WmiObject -Class Win32_ComputerSystem).Domain -eq 'os.oaklandschools.net') {
    write-host 'Machine joined to OSLAN already, Exiting.'
    exit 0
}
Write-Host 'Domain Join Required...'

## Locate Public Key and set VAR
$AdminAccount_PublicKey = Get-psdrive -PSProvider 'FileSystem' | ForEach-Object -Process {Join-Path -Path $_.Root -ChildPath 'AltirisCLI.txt' -Resolve -ErrorAction SilentlyContinue}

## Load Secure String and Create PSCred Object from file on USB drive to ensure security in the domain join process.
$AdminAccount_Name = 'OSLAN\AltirisCLI'
$AdminAccount_PasswordText = Get-Content -path $AdminAccount_PublicKey
$AdminAccount_PasswordEncrypted = $AdminAccount_PasswordText | ConvertTo-SecureString
$PSCredObj = New-Object System.Management.Automation.PSCredential -ArgumentList $AdminAccount_Name, $AdminAccount_PasswordEncrypted

Add-Computer -DomainName 'OSLAN' -server 'OSDC02.os.oaklandschools.net' -Credential $PSCredObj -OUPath 'OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net'