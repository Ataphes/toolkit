Clear-Host

write-host "
## AD Inactivity Check ##
Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
Purpose: Query and export a CSV that contains all machines within an OU along with their last login date.
"

$OU = Read-Host -Prompt "Enter the Distinguished Name of the OU you would like to query without the quotations. EX. OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net...

"
$OutputPath = "~\Desktop\ADComputersReport-All.csv"

## Do Not Edit Below This Line ##

Get-ADComputer -Filter * -SearchBase $OU -Properties OperatingSystem, LastLogonDate | 
    Select-Object -Property SAMAccountName,OperatingSystem,LastLogonDate | 
    Export-csv -Path $OutputPath -NoTypeInformation
read-host -prompt "Saving CSV to '$OutputPath'...

Press any key to exit...
"