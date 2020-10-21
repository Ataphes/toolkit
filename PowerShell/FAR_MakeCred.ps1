## Author: Joseph Walczak (Joseph.Walczak@oakland.k12.mi.us)
## Summary: Allows Creation of PSCred Public Key for use with other scripts.

## TODO: Make control variables.
## TODO: Make interactive prompts to allow for user account and password input.
## TODO: Make output an interactive component to choose destination.

# Define clear text password
[string]$userPassword = ''

# Crete credential Object
[SecureString]$secureString = $userPassword | ConvertTo-SecureString -AsPlainText -Force 

# Get content of the string
[string]$stringObject = Convert-FromSecureString

# Save Content to file
$stringObject | Set-Content -Path ''