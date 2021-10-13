## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Purpose: Maintain a list of group members from an aggregate of AD groups and add them to an active directory group.

# Variables
$GroupList = @('G_FPS_Google_ALLAdministrators', 'G_FPS_Google_ALLESP', 'G_FPS_Google_ALLFASA', 'G_FPS_Google_ALLFEA', 'G_FPS_Google_AllNonUnit', 'G_FPS_Google_ALLSecretaries')
$TargetGroup = 'G_FPS_Google_Education_License'

# Get unsorted user list from GroupList
$UList = foreach ($Group in $GroupList) {
    (Get-ADGroupMember -Identity $Group).SamAccountName
}

# Sort, Deduplicate, and add users to target group.
$UList_Sorted = $UList | Sort-Object | Get-Unique
Add-ADGroupMember -Identity $TargetGroup -Members $UList_Sorted