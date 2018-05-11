## Summarize-ADPrincipalMembership
## USAGE ##
## Helps determine the baseline group membership for new users based on OU.

## FUTURE CHANGES ##
## Enforce POSH Best Practice guidelines (https://github.com/PoshCode/PowerShellPracticeAndStyle)
## Further extend this in to a proper cmdlet


## Modules
import-module activedirectory

## Vars
$ouInput = 'Insert OU path here'
## Percentage of users with selected group. Accepts values 0.0 to 1.0 .
$membershipRatio = .8

## Prompts user to input credentials for use later in the script. Need to find out if creds are stored in plain text or not.
$C = Get-Credential

## Counts how many users are in the selected OU, Applys the tunable ratio, 
## and rounds to the nearest whole number
$ouUsers = Get-ADUser -Filter * -SearchBase $ouInput -Credential $C
$ouUserCount = $ouUsers.SamAccountName | Measure-Object -Line
$membershipAdjustedRaw = $ouUserCount.Lines * $membershipRatio
$membershipAdjustedRounded = [math]::Round($membershipAdjustedRaw)

## Fetches the users in the specified OU, Gets a list of their group memberships, Groups the objects, 
## Counts the group occurance to see if it's higher than the Membership ratios minimum,
## and displays the ones that meet the criteria
$ouUsers.SamAccountName | ForEach-Object { get-adprincipalgroupmembership $_ } | group-object -property name | Where-Object {$_.Count -ge $membershipAdjustedRounded} | Select-Object name | sort-object name