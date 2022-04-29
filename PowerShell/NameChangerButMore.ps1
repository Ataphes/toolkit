## Author: Joseph Walczak
## Summary: Rename only certain files meeting certain criterion

## CONFIG ##

$DirectoryRoot = "C:\Users\walczakj\git"
$OldName = "Powershell"
$NewName = "NotPowershell"
$DNCDesignation = "pi-init2"

## END CONFIG ##

## Collect directories to be acted on.
$A_Work = (Get-ChildItem -Path $DirectoryRoot -Recurse -Attributes Directory).FullName

## Act on each directory to check if it meets the critereon and then do "Things"
foreach ($Dir in $A_Work) {
    if ($Dir -notmatch $DNCDesignation -and $Dir -match $OldName ) {
        Write-Host "I will replace $OldName with $NewName on $Dir"
    }
}