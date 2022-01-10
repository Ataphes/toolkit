Dim WshShell
Set WshShell = WScript.CreateObject("WScript.Shell" )
Dim TypeLib, sNewGuid
Set TypeLib = CreateObject("Scriptlet.TypeLib" )
sNewGUID = TypeLib.Guid
Set TypeLib = Nothing
sNewGuid = left(sNewGUID, len(sNewGUID)-2)

' wscript.echo " # Guid Generated " + sNewGuid

WshShell.RegWrite "HKLM\Software\Altiris\Altiris Agent\MachineGuid" ,sNewGuid, "REG_SZ"
WshShell.RegWrite "HKLM\SOFTWARE\Altiris\Client Service\NSMachineGuid" ,sNewGuid, "REG_SZ"
WshShell.RegWrite "HKLM\SOFTWARE\Altiris\eXpress\MachineGuid" ,sNewGuid, "REG_SZ"
WshShell.RegWrite "HKLM\SOFTWARE\Altiris\eXpress\NS Client\MachineGuid" ,sNewGuid, "REG_SZ"
WshShell.RegWrite "HKLM\SOFTWARE\Computing Edge\Notification Server\MachineGuid" ,sNewGuid, "REG_SZ"

Dim client
Set client=WScript.CreateObject ("Altiris.AeXNSClient" )
ignoreBlockouts=1
sendIfUnchanged = 1
client.SendBasicInventory sendIfUnchanged, ignoreBlockouts
client.UpdatePolicies ignoreBlockouts