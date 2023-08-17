write-host "
## Activity Check ##
## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us) ##
## Purpose: Get active machines in a selected OU from AD. ##
"

$OU = "OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net"
$DaysSinceLastLogin = "180"
$OutputPath = "~\Desktop\ActiveADComputers.csv"

## Do Not Edit Below This Line ##

Get-ADComputer -Filter * -SearchBase $OU -Properties OperatingSystem, LastLogonDate | 
    Where { $_.LastLogonDate -GT (Get-Date).AddDays(-($DaysSinceLastLogin)) } | 
    Select-Object -Property SAMAccountName,DistinguishedName,OperatingSystem,LastLogonDate | 
    Export-csv -Path $OutputPath -Delimiter ";" -NoTypeInformation
read-host -prompt "Saving CSV to '$OutputPath'...

Press any key to exit...
"