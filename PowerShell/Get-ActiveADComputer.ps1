clear

write-host "
## AD Inactivity Check ##
Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
Purpose: Query and export a CSV to the users desktop of devices that have not been logged in to in 180 days or more.
"

$OU = Read-Host -Prompt "Enter the Distinguished Name of the OU you would like to query without the quotations. EX. OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net...

"
$OutputPath = "~\Desktop\InactiveADComputers_180Days.csv"

## Do Not Edit Below This Line ##

Get-ADComputer -Filter * -SearchBase $OU -Properties OperatingSystem, LastLogonDate | 
    Where { $_.LastLogonDate -GT (Get-Date).AddDays(180) } | 
    Select-Object -Property SAMAccountName,DistinguishedName,OperatingSystem,LastLogonDate | 
    Export-csv -Path $OutputPath -Delimiter ";" -NoTypeInformation
read-host -prompt "Saving CSV to '$OutputPath'...

Press any key to exit...
"