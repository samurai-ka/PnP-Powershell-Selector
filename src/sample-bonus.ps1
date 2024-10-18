# A Powershell Module to produce eye-candy outputs in the terminal.
# https://github.com/Yves848/psCandy
using module psCandy

# The definition of the various entries in the menu.
# In contrast to a hashtable, psCandy is also able to define an icon.
# To select an icon, use Keys: Windows+. (dot)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$items = [System.Collections.Generic.List[ListItem]]::new()
$items.Add([ListItem]::new("Development", "12345678-1234-1234-1234-123456789012", "⛏️"))
$items.Add([ListItem]::new("Test", "23456789-2345-2345-2345-234567890123", "⚙️"))
$items.Add([ListItem]::new("Production", "34567890-3456-3456-3456-345678901234", "🧠"))
$items.Add([ListItem]::new("Customer A", "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxA", "👽"))
$items.Add([ListItem]::new("Customer B", "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxB", "🤨"))

# The variable $env:ENTRAID_APP_ID contains a GUID. Find the GUID in the keys and return name.
function Get-PnPEnvironment {
    return ($items | Where-Object { $_.value -eq $env:ENTRAID_APP_ID}).text
}

function Select-PnPEnvironment {
    $list = [List]::new($items)
    $list.SetHeight(10)
    $list.SetTitle( ("<White>Select PnP environment</White> | <White>Active:</White> <Green>{0}</Green>" -f (Get-PnPEnvironment)) )
    $list.SetLimit($true)
    
    $selection = $list.Display()
    $env:ENTRAID_APP_ID = $selection.value
    
    ("Environment set to {0}" -f $selection.text) | Write-Host
}

# This entry ensures that a default environment is always set when your Powershell is started
$env:ENTRAID_APP_ID = $items[0].value
