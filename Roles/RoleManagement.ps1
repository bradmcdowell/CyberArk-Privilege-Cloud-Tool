function Show-RoleMenu {
    param (
        [string]$Title = 'CyberArk Privilege Cloud Tool - Version'
    )
    Clear-Host
    Write-Host "================ $Title $version ================================================"
    Write-Host "================ https://$CPCSubdomain.cyberark.cloud ===== Identity Tenant $IdentityTenantId ===="
    #Add comment here
    Write-Host "================ Role Management Menu =================="
    Write-Host "1: Press '1' List Roles in Identity Tenant $CPCSubdomain"
    Write-Host "2: Press '2' List Role Members"
    Write-Host "3: Press '3' List Active Directory Users in Identity"
    Write-Host "4: Press '4' Add AD User to Idenity Role"
    Write-Host "Q: Press 'Q' to Quit."
    Write-Host "========================================================"
}

do
 {
    Show-RoleMenu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
    # Start Option 1        
    Write-Host "`You have selected '1' List Roles in Identity Tenant $CPCSubdomain"

    $headers = @{}
    $headers.Add("User-Agent", "Thunder Client (https://www.thunderclient.com)")
    $headers.Add("Content-Type", "application/json")
    $headers.Add("Authorization", $global:BearerToken)
    $reqUrl = "https://$IdentityTenantId.id.cyberark.cloud/Redrock/query"
    $body = '{
        "Script":"SELECT Role.ID, Role.Name, Role.OrgId, Role.RoleType FROM Role"
    }'
    $headers.Add("Accept", "*/*")
    $response = Invoke-RestMethod -Uri $reqUrl -Method Post -Headers $headers -ContentType 'application/json' -Body $body
    $response.Result.Results.Row | Select-Object ID,Name | FT


    # End Option 1
    ###########################################
    } '2' {
    # Start Option 2
    Write-Host "`You have selected '2' List Role Members"
    # End Option 2
    ##########################################
    } '3' {
    # Start Option 3
    Write-Host "`You have selected '3' List Active Directory Users in Identity"
    $headers = @{}
    $headers.Add("User-Agent", "Thunder Client (https://www.thunderclient.com)")
    $headers.Add("Content-Type", "application/json")
    $headers.Add("Authorization", $global:BearerToken)
    $reqUrl = "https://$IdentityTenantId.id.cyberark.cloud/Redrock/query"
    $body = '{
        "Script":"SELECT ADUser.ObjectGUID, ADUser.UserPrincipalName FROM ADUser"
    }'
    $headers.Add("Accept", "*/*")
    
$response = Invoke-RestMethod -Uri $reqUrl -Method Post -Headers $headers -ContentType 'application/json' -Body $body

Write-Host "Found $response.Result.Count results"
$response.Result.Results.Row
# $response.Result.Results.Row | Out-GridView
#$response | ConvertTo-Json
    # End Option 3
    ###########################################CP
    } '4' {
    # Start Option 3
    Write-Host "`You have selected '4' Add AD User to Idenity Role"
    # End Option 3
    ###########################################
    }
    }
    pause
 }
 until ($selection -eq 'q')

# Reset Values







###==================




switch ($RoleMenuChoice) {
    '1'{
          Write-Host "`You have selected '1' List Roles in Identity Tenant $CPCSubdomain"
    }
    '2'{
          Write-Host "`You have selected '2' List Role Members"
    }
    '3'{
        Write-Host "`You have selected '3' List Active Directory Users in Identity"
    }  
    '4'{
        Write-Host "`You have selected '3' List Active Directory Users in Identity"
    }   
    'Q'{Return}
 }