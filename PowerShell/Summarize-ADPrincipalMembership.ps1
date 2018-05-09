## Summarize-ADPrincipalMembership
## Written By: Ryan Stafford | Modified By: Joseph Walczak
## USAGE ##
## Query an OU for groups and if their occurance is greater than the threshold of the count variable, output the name of the group.

## CHANGES ##
## 0.1 | StaffordR
## Proof of concept and testing
## 0.2 | StaffordR
## Simplified to a single line
## 0.3 | WalczakJ
## Changed the input from individual user to pulling a whole OU group in.
## Moved variables to the top of the script for ease of use.
## Versioned and commented out bits here and there.

## FUTURE CHANGES ##
## Enforce POSH Best Practice guidelines (https://github.com/PoshCode/PowerShellPracticeAndStyle)
## This includes proper versioning because I'm a bad.
## Make $Count in to a tunable option based on a ratio of total users rather than a static number that needs to be adjust each time the script is run.
## Further extend this in to a proper cmdlet


## Modules
import-module activedirectory

# Vars
$count = 10
$ouInput = Get-ADUser -Filter * -SearchBase 'OU=VLACStaff,OU=VLAC,OU=Oakland Schools,DC=os,DC=oaklandschools,DC=net'

## Begin Logic
$ouInput.SamAccountName | foreach { get-adprincipalgroupmembership $_ } | group-object -property name | where {$_.Count -ge $count} | select name | sort-object name
## End Logic