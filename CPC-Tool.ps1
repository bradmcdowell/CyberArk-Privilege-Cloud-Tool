# CyberArk Privilege Cloud Tool
$version = "23.03.01"

###########################################
Import-Module .\CPC-Modules.psm1

# Prompt user for ISPSS URL
$CPCSubdomain = Read-Host -Prompt 'Input your CyberArk Privilege Cloud Subdomain'

function Show-Menu {
    param (
        [string]$Title = 'CyberArk Privilege Cloud Tool - Version'
    )
    Clear-Host
    Write-Host "================ $Title $version ================"
    #Add comment here
    Write-Host "1: Press '1' Authenticate to ISPSS"
    Write-Host "2: Press '2' Create Personal Safe"
    Write-Host "3: Press '3' Create Shared Safe"
    Write-Host "4: Press '4' List All Safes"
    Write-Host "5: Press '5' Show System Health"
    Write-Host "6: Press '6' List PSM Servers"
    Write-Host "7: Press '7' List CPM Servers"
    Write-Host "Q: Press 'Q' to quit."
}

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
    # Start Option 1        
    Write-Host 'You chose option #1 - Authenticate to ISPSS'
    Write-host $ISPSSURL
    .\Auth.ps1
    # End Option 1
    ###########################################
    } '2' {
    # Start Option 2        
    Write-Host 'You chose option #2 - Create Personal Safe'
    # End Option 2
    ###########################################
    } '3' {
    # Start Option 3        
    Write-Host 'You chose option #3 - Create Shared Safe'
    # End Option 3
    ###########################################
    } '4' {
    # Start Option 3        
    Write-Host 'You chose option #4 - List All Safes'
    # End Option 3
    ###########################################    
    } '5' {
    # Start Option 3        
    Write-Host 'You chose option #5 - Show System Health'
    # End Option 3
    ###########################################   
    } '6' {
    # Start Option 3        
    Write-Host 'You chose option #6 - List PSM Servers'
    # End Option 3
    ###########################################   
    } '7' {
    # Start Option 3        
    Write-Host 'You chose option #7 - List CPM Servers'
    # End Option 3
    ###########################################
    }
    }
    pause
 }
 until ($selection -eq 'q')

# Reset Values
$CPCSubdomain = $null



