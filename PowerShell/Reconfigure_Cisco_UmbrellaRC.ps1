## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Summary: Update JSON file for Cisco Umbrella to the correct organization.

copy-item -Path "\\osshare\ossmc$\Southfield\Scripts\SFD_Reconfigure_Cisco_UmbrellaRC\OrgInfo.json" -Destination "C:\ProgramData\OpenDNS\ERC\OrgInfo.json" -Force -Confirm
Restart-Service -Name "Umbrella_RC"