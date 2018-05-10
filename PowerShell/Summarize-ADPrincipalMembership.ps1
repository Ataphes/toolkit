## Summarize-ADPrincipalMembership
## USAGE ##
## Query an OU for groups and if their occurance is greater than the threshold of the count variable, output the name of the group

## FUTURE CHANGES ##
## Enforce POSH Best Practice guidelines (https://github.com/PoshCode/PowerShellPracticeAndStyle)
## Further extend this in to a proper cmdlet


## Modules
import-module activedirectory

$ouInput = 'OU=HelpdeskTest,OU=Testing,OU=OSStaff,OU=OSMain,OU=Oakland Schools,DC=os,DC=oaklandschools,DC=net'
$membershipRatio = .8

# Vars
$C = Get-Credential
$ouUsers = Get-ADUser -Filter * -SearchBase $ouInput -Credential $C
$ouUserCount = $ouUsers.SamAccountName | Measure-Object -Line
$membershipAdjustedRaw = $ouUserCount.Lines * $membershipRatio
$membershipAdjustedRounded = [math]::Round($membershipAdjustedRaw)

$membershipAdjustedRounded

## Begin Logic
## $ouUsers.SamAccountName | ForEach-Object { get-adprincipalgroupmembership $_ } | group-object -property name | Where-Object {$_.Count -ge $membershipAdjustedRatio} | Select-Object name | sort-object name
## End Logic