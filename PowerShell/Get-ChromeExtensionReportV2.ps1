## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Purpose: Gather all extensions in all user profiles present on the machine and output the Name and AppID to a CSV

## TO DO
### Associate user account to where the extension was found.
### Omit extensions that are known or label them for output (May be difficult resolving apps for third party websites since they're one offs)

function Get-ExtensionInfo {
    # Lookup the extension in the Store
    $url = "https://chrome.google.com/webstore/detail/" + $ExtID
    try {
        $WebRequest = Invoke-WebRequest -Uri $url -ErrorAction Stop
        
        if ($WebRequest.StatusCode -eq 200) {
            # Get the HTML Page Title but remove ' - Chrome Web Store'
            
            if (-not([string]::IsNullOrEmpty($WebRequest.ParsedHtml.title))) {
                $ExtTitle = $WebRequest.ParsedHtml.title
        
                if ($ExtTitle -match '\s-\s.*$') {
                    $Title = $ExtTitle -replace '\s-\s.*$',''
                } 
                else {
                    $Title = $ExtTitle
                }
            }
        }
    } 
    catch {
        Write-Warning "Error during webstore lookup for '$ExtID' - '$_'"
        }
            
        [PSCustomObject][Ordered]@{
        Name        = $Title
        ID          = $ExtID
        HostName    = $UserProfile.PSComputerName
    }
}

## START SCRIPT ## 

# Get all user profiles in the "Users" directory
$userProfiles = Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.Special -eq $false }

# Initialize an array to store extension IDs
$allExtensionIds = @()

# Iterate through each user profile
foreach ($userProfile in $userProfiles) {
    # Construct the path to the Chrome profiles folder for the current user
    $userChromeProfilesPath = Join-Path -Path $userProfile.LocalPath -ChildPath "AppData\Local\Google\Chrome\User Data" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

    # Check if the Chrome profiles folder exists for the current user
    if (Test-Path $userChromeProfilesPath) {
        # Get all "Profile X" subdirectories under the Chrome profiles folder for the current user
        $profileFolders = Get-ChildItem -Path $userChromeProfilesPath -Directory | Where-Object { $_.Name -match '^Profile \d+$' }

        # Iterate through each profile folder
        foreach ($profileFolder in $profileFolders) {
            # Construct the path to the Chrome extensions folder for the current profile
            $profileChromeExtensionsPath = Join-Path -Path $profileFolder.FullName -ChildPath "Extensions"

            # Check if the Chrome extensions folder exists for the current profile
            if (Test-Path $profileChromeExtensionsPath) {
                # Get all subdirectories (extension IDs) under the Chrome extensions folder for the current profile
                $extensionIds = Get-ChildItem -Path $profileChromeExtensionsPath -Directory | ForEach-Object { $_.Name }

                # Add extension IDs to the array
                $allExtensionIds += $extensionIds
            }
        }
    }
}

# Check all extension ID
    foreach ($ExtId in $allExtensionIds) {
        #Get-ExtensionInfo $ExtId | Export-Csv -Path "\\powershell\Exports\FAR\Export-ChromeExtensionReport\Export-ChromeExtensionReportV2.csv" -NoTypeInformation -Append
        Get-ExtensionInfo $ExtId
    }