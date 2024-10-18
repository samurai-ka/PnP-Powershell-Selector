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

# A simple console menu. 
# Lines 22-30 Menu section. Displays the menu.
# Lines 32-37 Processing section. processes the selection.
# If you add or remove a new entry, you only need to edit the hashtable.
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

# This entry ensures that a default environment is always set when your Powershell is started
$env:ENTRAID_APP_ID = $entraidAppIds.Development
