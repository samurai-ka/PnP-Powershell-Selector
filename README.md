# PnP-Powershell-Selector

![Powershell](doc/SelectPnPEnvironment-480.gif)

## What is this all about

This repository contains sample Powershell scripts that can be used in your own profile for easy client ID selection.

![PnP Logo](doc/logo.svg)

### Managing and selecting your client IDs for PnP Powershell

One common question when working with multiple tenants is how to handle client IDs for each tenant, especially since you now need to register your own Entra ID Application Registration since version 2.12.0. This scenario arises when you have separate environments for development and production, or when working with multiple customer tenants. This can be challenging because each tenant requires its own application registration, with its own client ID.

- Here you'll find some sample scripts you can use in your Powershell profile
- Adds two cmdlets for easy selection of your client ID
- Choose the solution that fits your needs best
- Small footprint, huge impact

The _src_ folder contains three examples with different approaches. The content of each file can be inserted into your own Powershell profile as it is. The function of the scripts is added as a comment in the scripts. The comments do not have to be included.

As a bonus I have added an additional script, which requires another Powershell module to work properly.

## How to use the script

``` powershell
Get-PnPEnvironment
```

A very simple cmdlet that only serves to read the current value from the environment variable. However, as the environment variable contains a GUID, in most cases it is not obvious in what specific environment you are currently using. For this reason, the GUID is converted into a more readable output.

---

``` powershell
Select-PnPEnvironment
```

The actual menu to select the environment. Each menu is self-explanatory, which is why there is no need to go into further detail about the function at this point.

All examples write the GUID of the selected client IDs to the environment variable **ENTRAID_APP_ID** and remain there until another environment is selected or the console is closed. Therefore, you no longer need to specify the _-ClientID_ parameter when connecting with _Connect-PnPOnline_, as this is used by the environment variable.

---

### Adding the cmdlets to your Powershell profile

Open your Powershell profile with an editor of your choice. In this case we'll use Visual Studio Code.

``` powershell
code $PROFILE
```

> You can find information about Powershell Profiles here [learn.microsoft.com | about_Profiles](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.4)

The content from one of the sample files can be added anywhere in the Powershell profile. Simply copy and paste one of the examples and then customize the hashtable with the GUIDs. You may want to place the hashtable higher up in your profile if you want to add or delete client IDs in the future to have faster access to the content.

## About the different scripts

The **first and second examples** are very similar. In fact, the menu shown is almost identical. The menu is only displayed in the console and can therefore be used in all Powershell environments. However, I find the second example much more elegant, as it does not require any changes to the code when the configuration is changed. I have therefore added the first example to provide a better understanding of how the second example works.

The **third example** uses _Out-GridView_ to select the configured client IDs. It is also the shortest script and therefore probably the easiest to understand. However, because _Out-GridView_ opens in a separate window, this cmdlet is not available to MacOS and Linux users.

The **bonus example** uses the Powershell module psCandy. A Powershell Module to produce eye-candy outputs in the terminal. The module offers some nice functions to create a selection menu and is written entirely in Powershell. Especially if you have to work with a lot of configurations, you can use filters to find entries in the list more quickly.
