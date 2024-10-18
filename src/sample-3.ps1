# The entraidAppIds variable is a hashtable that contains the name and GUID of your client IDs.
# Please note that the name of an entry cannot contain spaces. You can only use underscores to separate the name.
# Modify this hashtable to add and remove entries to your configuration
$entraidAppIds = @{
    Development = "12345678-1234-1234-1234-123456789012"
    Test = "23456789-2345-2345-2345-234567890123"
    Production = "34567890-3456-3456-3456-345678901234"
    Customer_A = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxA"
    Customer_B = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxB"
}

# The variable $env:ENTRAID_APP_ID contains a GUID. Find the GUID in the keys and return name.
function Get-PnPEnvironment {
    return $entraidAppIds.Keys.Where({$entraidAppIds[$PSItem] -eq $env:ENTRAID_APP_ID})
}

# A graphical menu. 
# If you add or remove a new entry, you only need to edit the hashtable.
function Select-PnPEnvironment {
    $selection = $entraidAppIds | Out-GridView -PassThru -Title "Select PnP environment"
    $clientid = $selection.value

    "Client ID set to {0}" -f $clientid | Write-Host
    $env:ENTRAID_APP_ID = $clientid
}

# This entry ensures that a default environment is always set when your Powershell is started
$env:ENTRAID_APP_ID = $entraidAppIds.Development
