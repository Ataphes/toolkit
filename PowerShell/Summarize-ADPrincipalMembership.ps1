## Summarize-ADPrincipalMembership
## USAGE ##
## Query an OU for groups and if their occurance is greater than the threshold of the count variable, output the name of the group

## FUTURE CHANGES ##
## Enforce POSH Best Practice guidelines (https://github.com/PoshCode/PowerShellPracticeAndStyle)
## Further extend this in to a proper cmdlet


## Modules
import-module activedirectory

# Vars
$membershipRatio = 10
$ouInput = Get-ADUser -Filter * -SearchBase 'OU=Insert,OU=OU,DC=Here'

## Begin Logic
$ouInput.SamAccountName | ForEach-Object { get-adprincipalgroupmembership $_ } | group-object -property name | Where-Object {$_.Count -ge $membershipRatio} | Select-Object name | sort-object name
## End Logic