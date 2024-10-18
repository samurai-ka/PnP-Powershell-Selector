# The entraidAppIds variable is a hashtable that contains the name and GUID of your client IDs.
# Please note that the name of an entry cannot contain spaces. You can only use underscores to separate the name.
# Modify this hashtable and the code of the Select-PnPEnvironment function to add and remove entries to your configuration
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

# The simplest example of a menu. 
# Lines 24-33 Menu section. Displays the menu.
# Lines 35-49 Processing section. processes the selection.
# If you add or remove a new entry, you have to edit both sections and the hashtable.
# In the long run, this procedure is very error-prone.
# Sample-2.ps offers the same functionality, but is easier to manage.
function Select-PnPEnvironment {
    "================ Select PnP environment ================" | Write-Host
    "Active PnP environment:" | Write-Host -NoNewline
    Get-PnPEnvironment | Write-Host -ForegroundColor White
    Write-Host
    "1: My Development" | Write-Host
    "2: My Test" | Write-Host
    "3: My Production" | Write-Host
    "4: Customer A" | Write-Host
    "5: Customer B" | Write-Host
    "Q: Press 'Q' to quit." | Write-Host

    $selection = Read-Host "Please make a selection"
    switch ($selection) {
        '1' {
            $env:ENTRAID_APP_ID = $entraidAppIds.Development
        } '2' {
            $env:ENTRAID_APP_ID = $entraidAppIds.Test
        } '3' {
            $env:ENTRAID_APP_ID = $entraidAppIds.Production
        } '4' {
            $env:ENTRAID_APP_ID = $entraidAppIds.Customer_A
        } '5' {
            $env:ENTRAID_APP_ID = $entraidAppIds.Customer_B
        } 'q' {
            return
        }
    }
}

# This entry ensures that a default environment is always set when your Powershell is started
$env:ENTRAID_APP_ID = $entraidAppIds.Development
