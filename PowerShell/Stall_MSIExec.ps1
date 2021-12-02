## Name: MSIExec Stall
## Summary: Kills any MSIEXEC processes temporarily on boot to allow for Altiris Policies to process.
## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)

# Set duration of run in seconds.
$Duration_Seconds = 600
do {
    Stop-Process -Name "msiexec" -ErrorAction SilentlyContinue
    $Duration_Seconds--
    Start-Sleep -Seconds 1
} until ($Duration_Seconds -eq 0)
Exit 0
