## Summarize-ADPrincipalMembership
## USAGE ##
## Query an OU for groups and if their occurance is greater than the threshold of the count variable, output the name of the group

## FUTURE CHANGES ##
## Enforce POSH Best Practice guidelines (https://github.com/PoshCode/PowerShellPracticeAndStyle)
## Make $Count in to a tunable option based on a ratio of total users rather than a static number that needs to be adjust each time the script is run.
## Further extend this in to a proper cmdlet


## Modules
import-module activedirectory

# Vars
$count = 10
$ouInput = Get-ADUser -Filter * -SearchBase 'OU=Insert,OU=OU,DC=Here'

## Begin Logic
$ouInput.SamAccountName | foreach { get-adprincipalgroupmembership $_ } | group-object -property name | where {$_.Count -ge $count} | select name | sort-object name
## End Logic