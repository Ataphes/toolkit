$Path = Test-Path -Path 'C:\Program Files\Autodesk\AutoCAD 2021'
if ($Path -eq 'True') {
    Write-Host 'Installed'
    exit 1
}
Write-Host 'Not Installed'
exit 0