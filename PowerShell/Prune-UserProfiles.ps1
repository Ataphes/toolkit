## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Purpose: Find and delete user profiles that have not been in use for a specified amount of time.

## Enumerate all user profiles to verify when they were last used.

## How you ACTUALLY find out when users roughly logged in last.
get-eventlog -LogName System -InstanceId 1501,1503 -AsBaseObject | Select-Object -Property UserName,TimeGenerated | Sort-Object -Property UserName -unique | Sort-Object -Property TimeGenerated -Descending

$UserProfiles = Get-CimInstance -ClassName Win32_UserProfile -Property * | Where-Object {$_.LocalPath -like "C:\Users*"}

foreach ($Profile in $UserProfiles) {
    <# $Profile is $UserProfiles item #>
    Select-Object -InputObject $Profile -Property LocalPath, 
    LastUseTime, 
    @{Name='Folder Date';Expression={Get-Item -Path $_.LocalPath | Select-Object -ExpandProperty }},
    @{Name='NTUser Date';Expression={Get-Item -Path ($_.LocalPath + "\NTUSER.DAT") -Force | Select-Object -ExpandProperty LastAccessTime}}
}


get-eventlog -LogName System -InstanceId 1501,1503 -AsBaseObject | Select-Object -Property UserName,TimeGenerated