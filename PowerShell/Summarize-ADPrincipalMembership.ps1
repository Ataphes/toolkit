## Summarize-ADPrincipalMembership
## USAGE ##
## Query an OU for groups and if their occurance is greater than the threshold of the count variable, output the name of the group

## FUTURE CHANGES ##
## Enforce POSH Best Practice guidelines (https://github.com/PoshCode/PowerShellPracticeAndStyle)
## Further extend this in to a proper cmdlet


## Modules
import-module activedirectory

# Vars
$C = Get-Credential
$ouInput = 'OU=HelpdeskTest,OU=Testing,OU=OSStaff,OU=OSMain,OU=Oakland Schools,DC=os,DC=oaklandschools,DC=net'
$ouUsers = Get-ADUser -Filter * -SearchBase $ouInput -Credential $C
$membershipRatio = 3

## Begin Logic
$ouUsers.SamAccountName | ForEach-Object { get-adprincipalgroupmembership $_ } | group-object -property name | Where-Object {$_.Count -ge $membershipRatio} | Select-Object name | sort-object name
## End Logic