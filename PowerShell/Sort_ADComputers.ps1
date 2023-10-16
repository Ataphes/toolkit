## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Purpose: Sort computers in to the correct OU based on input from a sorted CSV file

## Modules ## 

Import-Module -Name ActiveDirectory -ErrorAction Stop

## Variables ##

## Import Data
$InventoryCSV = Import-Csv -Path "C:\Users\walczakj\Desktop\Staff Laptop Move\Staff_Devices.csv"

## Location Table
