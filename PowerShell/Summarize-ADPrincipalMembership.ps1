## Summarize-ADPrincipalMembership
## USAGE ##
## Query an OU for groups and if their occurance is greater than the threshold of the count variable, output the name of the group

## FUTURE CHANGES ##
## Enforce POSH Best Practice guidelines (https://github.com/PoshCode/PowerShellPracticeAndStyle)
## Further extend this in to a proper cmdlet


## Modules
import-module activedirectory

## Vars
$ouInput = 'OU=HelpdeskTest,OU=Testing,OU=OSStaff,OU=OSMain,OU=Oakland Schools,DC=os,DC=oaklandschools,DC=net'
$membershipRatio = .8

## Prompts user to input credentials for use later in the script. Need to find out if creds are stored in plain text or not.
$C = Get-Credential

## Counts how many users are in the selected OU and applys the tunable ratio
$ouUsers = Get-ADUser -Filter * -SearchBase $ouInput -Credential $C
$ouUserCount = $ouUsers.SamAccountName | Measure-Object -Line
$membershipAdjustedRaw = $ouUserCount.Lines * $membershipRatio
$membershipAdjustedRounded = [math]::Round($membershipAdjustedRaw)

## Begin Logic
$ouUsers.SamAccountName | ForEach-Object { get-adprincipalgroupmembership $_ } | group-object -property name | Where-Object {$_.Count -ge $membershipAdjustedRounded} | Select-Object name | sort-object name
## End Logic