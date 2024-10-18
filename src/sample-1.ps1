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
    "1: Tenant 1" | Write-Host
    "2: Tenant 2" | Write-Host
    "3: Tenant 3" | Write-Host
    "4: Tenant 4" | Write-Host
    "Q: Press 'Q' to quit." | Write-Host

    $selection = Read-Host "Please make a selection"
    switch ($selection) {
        '1' {
            $env:ENTRAID_APP_ID = $entraidAppIds.Tenant_1
        } '2' {
            $env:ENTRAID_APP_ID = $entraidAppIds.Tenant_2
        } '3' {
            $env:ENTRAID_APP_ID = $entraidAppIds.Tenant_3
        } '4' {
            $env:ENTRAID_APP_ID = $entraidAppIds.Tenant_4
        } 'q' {
            return
        }
    }
}
