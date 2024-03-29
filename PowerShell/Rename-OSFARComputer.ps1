﻿$global:newname = ""
$fpath = "\\Osshare\ossmc$\Farmington\Name_Serial.csv"
$csv = Import-Csv -Path $fpath 
$csv | ForEach-Object {
    if ("%SERIALNUMBER%" -eq $_.Serial) {
        $global:newname = $_.Name
    }
}
# SIG # Begin signature block
# MIISeAYJKoZIhvcNAQcCoIISaTCCEmUCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCsj1/9J6dmBt+L
# gX7BFrbhXw1DsnI8SmHz8rFPhjkCsqCCDp8wggawMIIEmKADAgECAhAIrUCyYNKc
# TJ9ezam9k67ZMA0GCSqGSIb3DQEBDAUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNV
# BAMTGERpZ2lDZXJ0IFRydXN0ZWQgUm9vdCBHNDAeFw0yMTA0MjkwMDAwMDBaFw0z
# NjA0MjgyMzU5NTlaMGkxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwg
# SW5jLjFBMD8GA1UEAxM4RGlnaUNlcnQgVHJ1c3RlZCBHNCBDb2RlIFNpZ25pbmcg
# UlNBNDA5NiBTSEEzODQgMjAyMSBDQTEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQDVtC9C0CiteLdd1TlZG7GIQvUzjOs9gZdwxbvEhSYwn6SOaNhc9es0
# JAfhS0/TeEP0F9ce2vnS1WcaUk8OoVf8iJnBkcyBAz5NcCRks43iCH00fUyAVxJr
# Q5qZ8sU7H/Lvy0daE6ZMswEgJfMQ04uy+wjwiuCdCcBlp/qYgEk1hz1RGeiQIXhF
# LqGfLOEYwhrMxe6TSXBCMo/7xuoc82VokaJNTIIRSFJo3hC9FFdd6BgTZcV/sk+F
# LEikVoQ11vkunKoAFdE3/hoGlMJ8yOobMubKwvSnowMOdKWvObarYBLj6Na59zHh
# 3K3kGKDYwSNHR7OhD26jq22YBoMbt2pnLdK9RBqSEIGPsDsJ18ebMlrC/2pgVItJ
# wZPt4bRc4G/rJvmM1bL5OBDm6s6R9b7T+2+TYTRcvJNFKIM2KmYoX7BzzosmJQay
# g9Rc9hUZTO1i4F4z8ujo7AqnsAMrkbI2eb73rQgedaZlzLvjSFDzd5Ea/ttQokbI
# YViY9XwCFjyDKK05huzUtw1T0PhH5nUwjewwk3YUpltLXXRhTT8SkXbev1jLchAp
# QfDVxW0mdmgRQRNYmtwmKwH0iU1Z23jPgUo+QEdfyYFQc4UQIyFZYIpkVMHMIRro
# OBl8ZhzNeDhFMJlP/2NPTLuqDQhTQXxYPUez+rbsjDIJAsxsPAxWEQIDAQABo4IB
# WTCCAVUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUaDfg67Y7+F8Rhvv+
# YXsIiGX0TkIwHwYDVR0jBBgwFoAU7NfjgtJxXWRM3y5nP+e6mK4cD08wDgYDVR0P
# AQH/BAQDAgGGMBMGA1UdJQQMMAoGCCsGAQUFBwMDMHcGCCsGAQUFBwEBBGswaTAk
# BggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEEGCCsGAQUFBzAC
# hjVodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9v
# dEc0LmNydDBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsMy5kaWdpY2VydC5j
# b20vRGlnaUNlcnRUcnVzdGVkUm9vdEc0LmNybDAcBgNVHSAEFTATMAcGBWeBDAED
# MAgGBmeBDAEEATANBgkqhkiG9w0BAQwFAAOCAgEAOiNEPY0Idu6PvDqZ01bgAhql
# +Eg08yy25nRm95RysQDKr2wwJxMSnpBEn0v9nqN8JtU3vDpdSG2V1T9J9Ce7FoFF
# UP2cvbaF4HZ+N3HLIvdaqpDP9ZNq4+sg0dVQeYiaiorBtr2hSBh+3NiAGhEZGM1h
# mYFW9snjdufE5BtfQ/g+lP92OT2e1JnPSt0o618moZVYSNUa/tcnP/2Q0XaG3Ryw
# YFzzDaju4ImhvTnhOE7abrs2nfvlIVNaw8rpavGiPttDuDPITzgUkpn13c5Ubdld
# AhQfQDN8A+KVssIhdXNSy0bYxDQcoqVLjc1vdjcshT8azibpGL6QB7BDf5WIIIJw
# 8MzK7/0pNVwfiThV9zeKiwmhywvpMRr/LhlcOXHhvpynCgbWJme3kuZOX956rEnP
# LqR0kq3bPKSchh/jwVYbKyP/j7XqiHtwa+aguv06P0WmxOgWkVKLQcBIhEuWTatE
# QOON8BUozu3xGFYHKi8QxAwIZDwzj64ojDzLj4gLDb879M4ee47vtevLt/B3E+bn
# KD+sEq6lLyJsQfmCXBVmzGwOysWGw/YmMwwHS6DTBwJqakAwSEs0qFEgu60bhQji
# WQ1tygVQK+pKHJ6l/aCnHwZ05/LWUpD9r4VIIflXO7ScA+2GRfS0YW6/aOImYIbq
# yK+p/pQd52MbOoZWeE4wggfnMIIFz6ADAgECAhAD5xEXk9pZs5BFJQyg/kyTMA0G
# CSqGSIb3DQEBCwUAMGkxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwg
# SW5jLjFBMD8GA1UEAxM4RGlnaUNlcnQgVHJ1c3RlZCBHNCBDb2RlIFNpZ25pbmcg
# UlNBNDA5NiBTSEEzODQgMjAyMSBDQTEwHhcNMjIxMDE0MDAwMDAwWhcNMjUxMDE1
# MjM1OTU5WjCBvzELMAkGA1UEBhMCVVMxETAPBgNVBAgTCE1pY2hpZ2FuMRswGQYD
# VQQHExJXYXRlcmZvcmQgVG93bnNoaXAxGDAWBgNVBAoTD09ha2xhbmQgU2Nob29s
# czEcMBoGA1UECxMTVGVjaG5vbG9neSBTZXJ2aWNlczEYMBYGA1UEAxMPT2FrbGFu
# ZCBTY2hvb2xzMS4wLAYJKoZIhvcNAQkBFh9hbmRyZXcueWVkbGluQG9ha2xhbmQu
# azEyLm1pLnVzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA4nT+BIv2
# TnpCy+gOQhv32WVACbMJBKQBrRZyXWEChsgGG1VrH7gHp1D0wv8vECzrZpXpTiEX
# cc7+X0NGMRJhPbLdBvPVga9Q4hk0J+qL2Rj8N4W6X1T96Ch62SwI4I6336GL3V1g
# UI4eBpkC2bNtmOKfPbGEOcXbx6VVai9YYnIkUAxZrXz27ElIrKtOYrSpcg4zeSsT
# S96Kw0dEARFEk4uBWXx0k8p9Lr6Iaw5+++EfJ+9ylWzHFNUBiLq3L3PGwQDKRqUJ
# F2PoJI86osttMneb0r04B0/bqbAqmehXqsAvcbFudR7+C67Wk4d9Lap2V3RM1dyx
# jpoHsXL8XUSQPMyOR5Tj9ScWSAVgjKiLOCd0EctCGVLPz1rHPb+ehTuNnxGzq90S
# fl/WMUxixoi3oFAmdjUFLksMnMR/fwOs35FPitXO93PC0TSp1cIv32vgWUNjlt/i
# ow1VunZiFRbLf8y30OVzZG0c5RSFY4QXwYylc941eADTQP/hXYC/1IEW+RIxKxD5
# Zu06AEc7PSs5n0iKQLhpE67r3EACd6dneFOXP0u1kKy/bgMnJhPf9dg0hJYt9Tu4
# c4wVOXpN6FiZQKdQd/OhY/BOXyfkDRltQ0JtnffA5YStE5XKC/S3gR16EvP7h3Nf
# ZRloOYED9T3UkxiM4eF2TY7QaRNkYgxOJDkCAwEAAaOCAjIwggIuMB8GA1UdIwQY
# MBaAFGg34Ou2O/hfEYb7/mF7CIhl9E5CMB0GA1UdDgQWBBS60EVfFWKhOKujJxO9
# jS0lupP1CjAqBgNVHREEIzAhgR9hbmRyZXcueWVkbGluQG9ha2xhbmQuazEyLm1p
# LnVzMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzCBtQYDVR0f
# BIGtMIGqMFOgUaBPhk1odHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRU
# cnVzdGVkRzRDb2RlU2lnbmluZ1JTQTQwOTZTSEEzODQyMDIxQ0ExLmNybDBToFGg
# T4ZNaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZEc0Q29k
# ZVNpZ25pbmdSU0E0MDk2U0hBMzg0MjAyMUNBMS5jcmwwPgYDVR0gBDcwNTAzBgZn
# gQwBBAEwKTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5kaWdpY2VydC5jb20vQ1BT
# MIGUBggrBgEFBQcBAQSBhzCBhDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGln
# aWNlcnQuY29tMFwGCCsGAQUFBzAChlBodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5j
# b20vRGlnaUNlcnRUcnVzdGVkRzRDb2RlU2lnbmluZ1JTQTQwOTZTSEEzODQyMDIx
# Q0ExLmNydDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBCwUAA4ICAQCQTjyErVyX
# bHmstiL4QQK1ONRaDCaT5a1cX0oteBv02Yz2SGq3Q+AWhPomH6FfFSXRE6X5BQrg
# df681lU6F/g/2Z1Gu6TTXVHypW1FGAZ8jmzGVfLTv0n/W7GThIX+9f8wrqhRKby2
# /gNdSB0YCLXGmoX0utX7oXt7JL/tMc8TiiGOb0XhTfyV/T6Un9g8FuurU09g7Tad
# AhUEJx9FGkNXeqNM+V93idnq88aOQTJXuFE0v9Xn6gj4e09h8x4ru1yO5aaqY/Nm
# cuymr/0+YI3c8II+nLgJJXJ8kMjAuKQDPpgNFJZSu87mk4zF9djmtWclQwQEmKPl
# yNYUdOn0XEZSkX3SiEJjYGT+OSnDRzyd4TnYE5SJ701x0PLzwhaFjANMCik+PLZt
# g6Ftb4o6dAmfz9i5OWVGskc7hOYLBdBC6ubvasdJEHawcgUMkv6LAvZPNkqnMa7O
# Rj4PhtuwAp5uwutZWkM8vtOHiuVsKAKpyaDF3Ggb5sbJctqqvTQku4gMJ2g9jbhZ
# YkaET9ntd21iThRM8LBv1BFeGLuRA9nMP9laiY1B3Gz/+49/40IxUkLj0X/oakVH
# ekrlNf0APDz6fXR2RPhZJ1BliUagL08zZhN4AvlnGnjMwmRnvFAVg97vskbHri6a
# rKfYu3EpQzobtefYKveoSxzlr7/Aj4Nx1DGCAy8wggMrAgEBMH0waTELMAkGA1UE
# BhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMUEwPwYDVQQDEzhEaWdpQ2Vy
# dCBUcnVzdGVkIEc0IENvZGUgU2lnbmluZyBSU0E0MDk2IFNIQTM4NCAyMDIxIENB
# MQIQA+cRF5PaWbOQRSUMoP5MkzANBglghkgBZQMEAgEFAKCBhDAYBgorBgEEAYI3
# AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisG
# AQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEiBCCIXLkhCVgr
# V4wX4yyqwjLwCex2P7h6jGXAcPUhZ7slKjANBgkqhkiG9w0BAQEFAASCAgAEZCQg
# xVKQYSjqS8iZQRoOBVyByqbqUt+GvPmsmhjCpdGtXKz6jr/0rNdGjSffSr9xAeuw
# pGFOYxI2xNpXe0NJ4X6ta12na3jMswT0ypl5vnhrNNAplC1zCjIYiC9FROMVaTiZ
# 5idqxr5F65gglxE/DG3tiH66NTnX8MTzsMkA6xWfiXn6xXPn8nM0woP/qwDacwFj
# 4ZD8G+PMd0k/Hl5ecMAbbsUwUHce3jcWfbeaX8XaAqWWUO4GnkSeUECToqzHPdcS
# G2L+VQsjkvEeEgLRI+1SpWrRDPwaFQNZJLfX0R/WvWRkIV/QjUDnTSYP2Ui507NC
# IoYeYqsbkpXtkYqLqx+TKJj9dafEMHznoOKVAGygZ3YesG/oj7mhUW176zvppMg/
# bCWnmqzuu5vRi1Ois2xpn/9LhvEECLIuV2QzSHgPLoEqTHSog5KnytZTi8BjYrCi
# bCB0HZVhH87KgiX1PZtWpDptEmCOF4gC8KiUWa+21khV62QUvwk3jpDr+0f4HDsJ
# re/+Sh5N/34H93NZoSXsy4t1vTi23dBwt5Yr56axKZNkl3pPeOsMQwQ2BnvAVeFI
# q5QJ6aopaSvOcgk21tZizhMpUljgT9ZDr9Fpgg6SgSIkKeN9H7tRN/a9h6HXiIuf
# cHVrGsVWahSKRK5idztfwn747O4r1d8e2vdc+A==
# SIG # End signature block
