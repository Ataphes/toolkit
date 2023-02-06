$global:newname = ""
$fpath = "\\Osshare\ossmc$\Farmington\Name_Serial.csv"
$csv = Import-Csv -Path $fpath 

$csv | ForEach-Object {
    
    if ("%SERIALNUMBER%" -eq $_.Serial) {
        $global:newname = $_.Name
    }
    
}

Rename-Computer -NewName $global:newname -Force