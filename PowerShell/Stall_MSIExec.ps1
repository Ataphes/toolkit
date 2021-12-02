## Name: MSIExec Stall
## Summary: Kills any MSIEXEC processes temporarily on boot to allow for Altiris Policies to process.
## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)

# Set duration of run in seconds.
$Duration_Seconds = 600

do {
    $TargetProc = Get-Process | where { $_.Name -like "*MSIExec*" }
    if ($TargetProc -ne $Null) {
        Stop-Process -InputObject $TargetProc -Force
        Write-Host "Stopped MSIExec at $(Get-Date -Format "MM/dd/yy HH:MM:ss")"
    }
    $Duration_Seconds--
    Start-Sleep -Seconds 1
} until ($Duration_Seconds -eq 0)
Exit 0
