## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Purpose: Check a machine for total uptime and restart if it exceeds a certian amount of time.

## Customizable Variables

$Limit_Days = 3

## SCRIPT START

$Uptime = (get-date) - (gcim Win32_OperatingSystem).LastBootUpTime

if ( $Uptime.Days -ge $Limit_Days ) {
    Restart-Computer
}
exit

## SCRIPT END