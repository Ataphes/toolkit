# Specify target OU. This is where users will be moved.
$TargetOU =  "OU=Districts,OU=IT,DC=enterprise,DC=com"
# Specify CSV path. Import CSV file and assign it to a variable. 
$Imported_csv = Import-Csv -Path "C:\temp\MoveList.csv" 

$Imported_csv | ForEach-Object {
     # Retrieve DN of user.
     $UserDN  = (Get-ADUser -Identity $_.Name).distinguishedName
     # Move user to target OU.
     Move-ADObject  -Identity $UserDN  -TargetPath $TargetOU
   
 }