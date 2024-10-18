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
    $selection = $entraidAppIds | Out-GridView -PassThru -Title "Select PnP environment"
    $clientid = $selection.value

    "Client ID set to {0}" -f $clientid | Write-Host
    $env:ENTRAID_APP_ID = $clientid
}
