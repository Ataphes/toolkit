## Test if device able to ping DC to verify on network.

## Check if machine is already joined to domain.
if ((Get-WMI -Class Win32_ComputerSystem).Domain -eq 'oaklandschools.net') {
write-host 'Machine joined to OSLAN already, exiting'
exit 0
}
Write-Host 'Domain Join Required'

## Check for AltirisCLI.txt on a USB drive by testing the path. Set VAR if the path comes back true.
$AdminAccount_PublicKey = Get-psdrive -PSProvider 'FileSystem' | ForEach-Object -Process {Join-Path -Path $_.Root -ChildPath 'AltirisCLI.txt' -Resolve -ErrorAction SilentlyContinue}

## Load Secure String and Create PSCred Object from file on USB drive to ensure security in the domain join process.
$AdminAccount_Name = 'OSLAN\AltirisCLI'
$AdminAccount_PasswordText = Get-Content -path $AdminAccount_PublicKey
$AdminAccount_PasswordEncrypted = $AdminAccount_PasswordText | ConvertTo-SecureString
$PSCredObj = New-Object System.Management.Automation.PSCredential -ArgumentList $AdminAccount_Name, $AdminAccount_PasswordEncrypted



## Join Domain without restarting to allow for the addition of groups

Add-Computer -DomainName 'OSLAN' -server 'OSDC02.os.oaklandschools.net' -Credential $PSCredObj -OUPath 'OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net'