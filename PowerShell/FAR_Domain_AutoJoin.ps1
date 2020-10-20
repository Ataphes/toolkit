## Check if machine is already joined to domain, if so, do nothing. Or maybe add some groups



## Check for AltirisCLI.txt on a USB drive by testing the path. Set VAR if the path comes back true.

$AdminAccount_PublicKey = Get-psdrive -PSProvider 'FileSystem' | ForEach-Object -Process {Join-Path -Path $_.Root -ChildPath 'AltirisCLI.txt' -Resolve -ErrorAction SilentlyContinue}

## Load Secure String and Create PSCred Object from file on USB drive to ensure security in the domain join process.
$AdminAccount_Name = 'OSLAN\AltirisCLI'
$AdminAccount_PasswordText = Get-Content -path $AdminAccount_PublicKey
$AdminAccount_PasswordEncrypted = $AdminAccount_PasswordText | ConvertTo-SecureString
$PSCredObj = New-Object System.Management.Automation.PSCredential -ArgumentList $AdminAccount_Name, $AdminAccount_PasswordEncrypted

## Test if device able to ping DC to verify on network.

## Join Domain without restarting to allow for the addition of groups

Add-Computer -DomainName 'OSLAN' -server 'OSDC02.os.oaklandschools.net' -Credential $PSCredObj -OUPath 'OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net'