## Load Secure String and Create PSCred Object from file on USB drive to ensure security in the domain join process.
$AdminAccount_Name = 'OSLAN\AltirisCLI'
$AdminAccount_PasswordText = Get-Content 'D:\AltirisCLI.txt'
$AdminAccount_PasswordEncrypted = $AdminAccount_PasswordText | ConvertTo-SecureString
$PSCredObj = New-Object System.Management.Automation.PSCredential -ArgumentList $AdminAccount_PasswordText, $AdminAccount_PasswordEncrypted