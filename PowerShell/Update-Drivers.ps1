## Purpose: Updates the detected system drivers (Including the BIOS) safely without triggering bitlocker on reboot from the driver library provided by Microsoft's Windows Update servers.
## Author: Joseph Walczak (Joseph.Walczak@Oakland.k12.mi.us)

## Module Import
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PSWindowsUpdate -Force
Install-Module -Name PendingReboot -Force

## Runs Windows Udpate and installs all Drivers found by the tool and reboots the machine if an update flags a reboot as required.
Install-WindowsUpdate -AcceptAll -Category Drivers -Verbose

## Checks if a reboot is pending for whatever reason and if so, restart the machine.
if ($(Test-PendingReboot -SkipConfigurationManagerClientCheck).IsRebootPending) {
    write-host "RebootPending"
}

## Suspend-BitLocker -MountPoint C: -RebootCount 1
