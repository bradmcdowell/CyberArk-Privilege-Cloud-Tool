Write-Host "Auth PS1 is running"
Get-Token -subdomain $global:CPCSubdomain
Write-Host $global:headers.Values
pause
