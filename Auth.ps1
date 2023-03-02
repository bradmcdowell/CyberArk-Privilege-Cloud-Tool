Write-Host "Auth PS1 is running"
$global:BearerToken = $null
Get-Token -subdomain $global:CPCSubdomain
$global:BearerToken = $headers.Values
$PrintBearerToken = read-host "Do you want to Print Bearer Token (Y/N)?"
Switch ($PrintBearerToken) 
 { 
   Y {
    Write-host "Continuing with validation"
    Write-Host $global:BearerToken
    Pause
    } 
   N {Write-Host "Continue"} 
 }