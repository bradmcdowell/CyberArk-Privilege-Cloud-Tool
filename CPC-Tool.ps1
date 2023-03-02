# CyberArk Privilege Cloud Tool
$version = "23.03.02"

###########################################
Import-Module .\CPC-Modules.psm1
Import-Module .\IdentityAuth.psm1

New-Item -ItemType Directory -Force -Path .\var
New-Item -ItemType Directory -Force -Path .\logs
$CPCSubdomain = Get-Content -Path .\var\subdomain.txt


Write-Host "============= Pick the Subdomain =============="
Write-Host "1: Press '1' To use the subdomain $CPCSubdomain"
Write-Host "2: Press '2' Select a different Subdoamin"
Write-Host "Q: Press 'Q' to Quit."
Write-Host "========================================================"
$SubDomainChoice = Read-Host "Enter Choice"

switch ($SubDomainChoice) {
    '1'{
          Write-Host "`You have slected 1 $CPCSubdomain"
    }
    '2'{
          Write-Host "`You want a differnt subdomain"
          $CPCSubdomain = Read-Host -Prompt 'Input your CyberArk Privilege Cloud Subdomain'
          Write-Host "Save $CPCSubdomain to .\var\subdomain.txt for next time"
          Clear-Content -Path .\var\subdomain.txt
          $CPCSubdomain | Add-Content -Path .\var\subdomain.txt
    }
    'Q'{Return}
 }

 $global:CPCSubdomain = $CPCSubdomain
 $global:PVWAURL = "https://$CPCSubdomain.privilegecloud.cyberark.cloud/PasswordVault"

# Prompt user for ISPSS URL
$decisionSubDomain = Get-Choice -Title "What is your subdomain" -Options "$CPCSubdomain", "No Something Else" -DefaultChoice 1
            if ($decisionSubDomain -eq "No Something Else")
            {
                $CPCSubdomain = Read-Host -Prompt 'Input your CyberArk Privilege Cloud Subdomain'
                Write-Host "Save $CPCSubdomain to .\var\subdomain.txt"
                
                $CPCSubdomain | Add-Content -Path .\var\subdomain.txt
            }


function Show-Menu {
    param (
        [string]$Title = 'CyberArk Privilege Cloud Tool - Version'
    )
    Clear-Host
    Write-Host "================ $Title $version ============================="
    Write-Host "================ https://$CPCSubdomain.cyberark.cloud ========="
    #Add comment here
    Write-Host "1: Press '1' Authenticate to ISPSS Non Interactive"
    Write-Host "2: Press '2' Authenticate to ISPSS Interactive Mode"
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
    Write-Host 'You chose option #1 - Authenticate to ISPSS Non Interactive Mode'
    Write-host $ISPSSURL
    .\Auth.ps1
    # End Option 1
    ###########################################
    } '2' {
    # Start Option 2
    $global:BearerToken = $null        
    Write-Host 'You chose option #2 - Authenticate to ISPSS Interactive Mode'
    $IdentityTenantId = Read-Host -Prompt 'Input your CyberArk Identity ID'
    $CPCUsername = Read-Host -Prompt 'Input your CyberArk Privilege Cloud Username'
    $header = Get-IdentityHeader -IdentityTenantURL "$IdentityTenantId.id.cyberark.cloud" -IdentityUserName $CPCUsername
    $global:BearerToken = $header.Authorization
  
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
    .\SafeManagement\Safe-Management.ps1 -List -logonToken $global:BearerToken -PVWAURL $PVWAURL
    # End Option 3
    ###########################################    
    } '5' {
    # Start Option 5       
    Write-Host 'You chose option #5 - Show System Health'
    # 
    $Uri = "$global:PVWAURL/API/ComponentsMonitoringSummary/"
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $global:BearerToken)
    $headers.Add("Content-Type", "application/json")
    $response = Invoke-RestMethod $Uri -Method 'GET' -Headers $headers
    $response.Components
    Pause
    $response.Components = $null

    # End Option 5
    ###########################################   
    } '6' {
    # Start Option 6       
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
$global:headers.Values = $null



