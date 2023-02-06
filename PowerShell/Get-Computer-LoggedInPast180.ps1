write-host "
## Activity Check ##
## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us) ##
## Purpose: Get active machines in a selected OU from AD. Tunable with variable at the top of the script. ##
"

$OU = Read-Host -Prompt "Please enter the Distinguished Name of the OU you would like to query. EX. 'OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net'...
"
$DaysSinceLastLogin = Read-Host -Prompt "Enter the amount of days back you want to find machines that have logged in. EX. '180'...
"
$OutputPath = "~\Desktop\ActiveADComputers.csv"

## Do Not Edit Below This Line ##

Get-ADComputer -Filter * -SearchBase $OU -Properties OperatingSystem, LastLogonDate | 
    Where { $_.LastLogonDate -GT (Get-Date).AddDays(-($DaysSinceLastLogin)) } | 
    Select-Object -Property SAMAccountName,DistinguishedName,OperatingSystem,LastLogonDate | 
    Export-csv -Path $OutputPath -Delimiter ";" -NoTypeInformation
read-host -prompt "Saving CSV to '$OutputPath'...

Press any key to exit...
"