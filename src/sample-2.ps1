$entraidAppIds = @{
    Tenant_1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx1"
    Tenant_2 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx2"
    Tenant_3 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx3"
    Tenant_4 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx4"
}

function Get-PnPEnvironment {
    return $entraidAppIds.Keys.Where({$entraidAppIds[$PSItem] -eq $env:ENTRAID_APP_ID})
}

function Select-PnPEnvironment {
    "================ Select PnP environment ================" | Write-Host
    "Active PnP environment:" | Write-Host -NoNewline
    Get-PnPEnvironment | Write-Host -ForegroundColor White
    Write-Host

    for ($i = 0; $i -lt $entraidAppIds.Count; $i++) {
        ("{0} | {1}" -f $i,([array]$entraidAppIds.Keys)[$i]) | Write-Host
    }
    "Q | Press 'Q' to quit." | Write-Host

    $selection = Read-Host "Please make a selection"

    $clientid = ([array]$entraidAppIds.Values)[$selection]
    if (-not (([string]::IsNullOrEmpty($clientid)) -or ($selection -eq 'q'))) {
        "Client ID set to {0}" -f $clientid | Write-Host
        $env:ENTRAID_APP_ID = $clientid
    }
}
