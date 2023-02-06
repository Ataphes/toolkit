## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Purpose: Find and delete user profiles that have not been in use for a specified amount of time.

## Enumerate all user profiles to verify when they were last used.

$UserProfiles = Get-CimInstance -ClassName Win32_UserProfile -Property * -Filter "Special ='False'"

Select LocalPath, 
       LastUseTime,
       @{Name='Folder Date';Expression={Get-Item -Path $_.LocalPath | Select -ExpandProperty LastAccessTime}},
       @{Name='NTUser Date';Expression={Get-Item -Path ($_.LocalPath + "\NTUSER.DAT") -Force | Sel

