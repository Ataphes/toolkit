Get-Aduser -filter * -SearchBase "OU=Farmington,DC=os,DC=oaklandschools,DC=net" -properties GivenName,Surname,Pager,EmailAddress,Company,title | Select-Object -Property GivenName,Surname,Pager,EmailAddress,Company,title,distinguishedname | Export-Csv -Path C:\AD_UserData_10_31_23.csv -NoTypeInformation -Force