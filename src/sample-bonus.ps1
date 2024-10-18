# A Powershell Module to produce eye-candy outputs in the terminal.
# https://github.com/Yves848/psCandy
using module psCandy

# The entraidAppIds variable is a hashtable that contains the name and GUID of your client IDs.
# Please note that the name of an entry cannot contain spaces. You can only use underscores to separate the name.
$entraidAppIds = @{
    Tenant1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx1"
    Tenant2 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx2"
    Tenant3 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx3"
    Tenant4 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx4"
}

# The variable $env:ENTRAID_APP_ID contains a GUID. Find the GUID in the keys and return name.
function Get-PnPEnvironment {
    return $entraidAppIds.Keys.Where({$entraidAppIds[$PSItem] -eq $env:ENTRAID_APP_ID})
}

function Select-PnPEnvironment {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $items = [System.Collections.Generic.List[ListItem]]::new()
    $items.Add([ListItem]::new("Tenant 1", $entraidAppIds.Tenant1, "⛏️"))
    $items.Add([ListItem]::new("Tenant 2", $entraidAppIds.Tenant2, "⚙️"))
    $items.Add([ListItem]::new("Tenant 3", $entraidAppIds.Tenant3, "🧠"))
    $items.Add([ListItem]::new("Tenant 4", $entraidAppIds.Tenant4, "👽"))

    $list = [List]::new($items)
    $list.SetHeight(10)
    $list.SetTitle( ("<White>Select PnP environment</White> | <White>Active:</White> <Green>{0}</Green>" -f (Get-PnPEnvironment)) )
    $list.SetLimit($true)
    
    $selection = $list.Display()
    $env:ENTRAID_APP_ID = $selection.value
    
    ("Environment set to {0}" -f $selection.text) | Write-Host
}

# This entry ensures that a default environment is always set when your Powershell is started
$env:ENTRAID_APP_ID = $entraidAppIds.Development
