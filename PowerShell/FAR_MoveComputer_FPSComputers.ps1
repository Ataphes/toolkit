Import-Module "\\osshare\ossmc$\Farmington\Scripts\FAR_ADPoSH\Microsoft.ActiveDirectory.Management.dll"
get-adcomputer $env:COMPUTERNAME | Move-ADObject -TargetPath "OU=FPSComputers,OU=Farmington,DC=os,DC=oaklandschools,DC=net"