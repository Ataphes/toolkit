## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Purpose: Check a machine for total uptime and restart if it exceeds a certian amount of time.

## Custom Variables

$Limit_Days = 3

## Script Start

$Uptime = (get-date) - (gcim Win32_OperatingSystem).LastBootUpTime

if ( $Uptime.Days -ge $Limit_Days ) {
    Restart-Computer
}
exit