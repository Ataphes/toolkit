## Query-SupportStaff
## USAGE ##
## Pulls all support staff and roles in to a CSV.

# Import the Active Directory module
Import-Module ActiveDirectory

## VARIABLES ##

# Specify the main AD group name
$mainGroupName = "G_FPS_Google_AllStaff"

# Specify the exclusion AD group name
$excludeGroupName = "G_FPS_Google_ALLFEA"

## SCRIPT START ##

# Get the main group object
$mainGroup = Get-ADGroup $mainGroupName

# Get the exclude group object
$excludeGroup = Get-ADGroup $excludeGroupName

# Check if both groups exist
if ($mainGroup -and $excludeGroup) {
    # Get user information for members of the main group, excluding users from the exclude group
    Get-ADGroupMember -Identity $mainGroupName |
    Where-Object { $_.DistinguishedName -notin (Get-ADGroupMember -Identity $excludeGroupName).DistinguishedName } |
    Get-ADUser -Properties Name, SamAccountName, Department, Title |
    Export-Csv -Path C:\Users\walczakj\Desktop\SupportStaff.csv -Append -NoTypeInformation
    Write-Host "Query Suceeeded for $_.SamAccountName"
}
