## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Purpose: Collect Chrome Extension usage data within my environment. 
### The intent it to run this script at start up once a week to collect this information. 
### That data can then be further processed in your chosen spreadsheet program.

## To Do
### Add weekly datestamp to the file name
### Maybe - Timestamp the output?
### Build retry loop for sending data to the CSV if it is locked by another user.

## Dependencies
Import-Module "\\powershell\PSScripts\FAR\Get-ChromeExtension.ps1"

## Variables
$OutCSV = "\\powershell\Exports\FAR\Export-ChromeExtensionReport.csv"

## Script
$Query = Get-ChromeExtension -WarningAction SilentlyContinue
$Output = Select-Object -InputObject $Query Name, Version, ID, Computername, Username

$Output | Export-Csv -Path $OutCSV -NoTypeInformation -Append