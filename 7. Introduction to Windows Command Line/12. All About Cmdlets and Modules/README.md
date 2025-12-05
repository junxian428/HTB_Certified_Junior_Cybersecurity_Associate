<h3>All About Cmdlets and Modules</h3>

In this section, we will cover the following:

What are cmdlets and Modules?
How do we interact with them?
How do we install and load new modules from the web?

Understanding these questions is crucial when utilizing PowerShell as both a sysadmin and pentester. PowerShells' ability to be modular and expandable makes it a powerhouse tool to have in our kit. Let us dive into what cmdlets and modules are.

<h3>Cmdlets</h3>

A cmdlet as defined by Microsoft is:

"a single-feature command that manipulates objects in PowerShell."

Cmdlets follow a Verb-Noun structure which often makes it easier for us to understand what any given cmdlet does. With Test-WSMan, we can see the verb is Test and the Noun is Wsman. The verb and noun are separated by a dash (-). After the verb and noun, we would use the options available to us with a given cmdlet to perform the desired action. Cmdlets are similar to functions used in PowerShell code or other programming languages but have one significant difference. Cmdlets are not written in PowerShell. They are written in C# or another language and then compiled for use. As we saw in the last section, we can use the Get-Command cmdlet to view the available applications, cmdlets, and functions, along with a trait labeled "CommandType" that can help us identify its type.

If we want to see the options and functionality available to us with a specific cmdlet, we can use the Get-Help cmdlet as well as the Get-Member cmdlet.

<h3>PowerShell Modules</h3>

A PowerShell module is structured PowerShell code that is made easy to use & share. As mentioned in the official Microsoft docs, a module can be made up of the following:

Cmdlets
Script files
Functions
Assemblies
Related resources (manifests and help files)
Through this section, we are going to use the PowerView project to examine what makes up a module and how to interact with them. PowerView.ps1 is part of a collection of PowerShell modules organized in a project called PowerSploit created by the PowerShellMafia to provide penetration testers with many valuable tools to use when testing Windows Domain/Active Directory environments. Though we may notice this project has been archived, many of the included tools are still relevant and useful in pen-testing today (written in August 2022). We will not extensively cover the usage and implementation of PowerSploit in this module. We will just be using it as a reference to understand PowerShell better. The use of PowerSploit to Enumerate & Attack Windows Domain environments is covered in great depth in the module Active Directory Enumeration & Attacks.

<h3>PowerSploit.psd1</h3>

A PowerShell data file (.psd1) is a Module manifest file. Contained in a manifest file we can often find:

- Reference to the module that will be processed

- Version numbers to keep track of major changes

- The GUID

- The Author of the module

- Copyright

- PowerShell compatibility information

- Modules & cmdlets included

- Metadata

<h3>PowerSploit.psd1</h3>

<h3>PowerSploit.psm1</h3>

A PowerShell script module file (.psm1) is simply a script containing PowerShell code. Think of this as the meat of a module.

<h3>Contents of PowerSploit.psm1</h3>

Get-ChildItem $PSScriptRoot | ? { $_.PSIsContainer -and !('Tests','docs' -contains $_.Name) } | % { Import-Module $_.FullName -DisableNameChecking }

The Get-ChildItem cmdlet gets the items in the current directory (represented by the $PSScriptRoot automatic variable), and the Where-Object cmdlet (aliased as the "?" character) filters those down to only the items that are folders and do not have the names "Tests" or "docs". Finally, the ForEach-Object cmdlet (aliased as the "%" character) executes the Import-Module cmdlet against each of those remaining items, passing the DisableNameChecking parameter to prevent errors if the module contains cmdlets or functions with the same names as cmdlets or functions in the current session.

<h3>Using PowerShell Modules</h3>

Once we decide what PowerShell module we want to use, we will have to determine how and from where we will run it. We also must consider if the chosen module and scripts are already on the host or if we need to get them on to the host. Get-Module can help us determine what modules are already loaded.

<h3>Get-Module</h3>

PS C:\htb> Get-Module 

ModuleType Version    Name                                ExportedCommands

---------- -------    ----                                ----------------

Script     0.0        chocolateyProfile                   {TabExpansion, Update-SessionEnvironment, refreshenv}

Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Computer, Add-Content, Checkpoint-Computer, Clear-Con...

Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Add-Member, Add-Type, Clear-Variable, Compare-Object...}

Script     0.7.3.1    posh-git                            {Add-PoshGitToProfile, Add-SshKey, Enable-GitColors, Expan...

Script     2.0.0      PSReadline                          {Get-PSReadLineKeyHandler, Get-PSReadLineOption, Remove-PS...

<h3>List-Available</h3>

PS C:\htb> Get-Module -ListAvailable 

 Directory: C:\Users\tru7h\Documents\WindowsPowerShell\Modules

The -ListAvailable modifier will show us all modules we have installed but not loaded into our session.

We have already transferred the desired module or scripts onto a target Windows host. We will then need to run them. We can start them through the use of the Import-Module cmdlet.

<h3>Using Import-Module</h3>

The Import-Module cmdlet allows us to add a module to the current PowerShell session.

PS C:\Users\htb-student> Get-Help Import-Module

NAME

    Import-Module

To understand the idea of importing the module into our current PowerShell session, we can attempt to run a cmdlet (Get-NetLocalgroup) that is part of PowerSploit. We will get an error message when attempting to do this without importing a module. Once we successfully import the PowerSploit module (it has been placed on the target host's Desktop for our use), many cmdlets will be available to us, including Get-NetLocalgroup. See this in action in the clip below:

<h3>Importing PowerSploit.psd1</h3>

PS C:\Users\htb-student\Desktop\PowerSploit> Import-Module .\PowerSploit.psd1

PS C:\Users\htb-student\Desktop\PowerSploit> Get-NetLocalgroup

ComputerName GroupName                           Comment

------------ ---------                           -------

WS01         Access Control Assistance Operators Members of this group can remotely query authorization attributes a...

Notice how at the beginning of the clip, Get-NetLocalgroup was not recognized. This event happened because it is not included in the default module path. We see where the default module path is by listing the environment variable PSModulePath.

<h3>Viewing PSModulePath</h3>

PS C:\Users\htb-student> $env:PSModulePath

C:\Users\htb-student\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules

When the PowerSploit.psd1 module is imported, the Get-NetLocalgroup function is recognized. This happens because several modules are included when we load PowerSploit.psd1. It is possible to permanently add a module or several modules by adding the files to the referenced directories in the PSModulePath. This action makes sense if we were using a Windows OS as our primary attack host, but on an engagement, our time would be better off just transferring specific scripts over to the attack host and importing them as needed.

<h3>Execution Policy</h3>

An essential factor to consider when attempting to use PowerShell scripts and modules is PowerShell's execution policy. As outlined in Microsoft's official documentation, an execution policy is not a security control. It is designed to give IT admins a tool to set parameters and safeguards for themselves.

<h3>Execution Policy's Impact</h3>

PS C:\Users\htb-student\Desktop\PowerSploit> Import-Module .\PowerSploit.psd1

Import-Module : File C:\Users\Users\htb-student\PowerSploit.psm1
cannot be loaded because running scripts is disabled on this system. For more information, see
about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1

+ Import-Module .\PowerSploit.psd1

+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    + CategoryInfo          : SecurityError: (:) [Import-Module], 
    PSSecurityException

    + FullyQualifiedErrorId : UnauthorizedAccess,Microsoft.PowerShell.Commands.ImportModuleCommand

The host's execution policy makes it so that we cannot run our script. We can get around this, however. First, let us check our execution policy settings.

<h3>Checking Execution Policy State</h3>

PS C:\htb> Get-ExecutionPolicy 

Restricted  

Our current setting restricts what the user can do. If we want to change the setting, we can do so with the Set-ExecutionPolicy cmdlet.

<h3>Setting Execution Policy</h3>

PS C:\htb> Set-ExecutionPolicy undefined 

By setting the policy to undefined, we are telling PowerShell that we do not wish to limit our interactions. Now we should be able to import and run our script.

<h3>Testing It Out</h3>

PS C:\htb> Import-Module .\PowerSploit.psd1

Import-Module .\PowerSploit.psd1

PS C:\Users\htb> get-module

Looking at our loaded modules, we can see that we successfully loaded PowerSploit. Now we can use the tools as needed.

Note: As a sysadmin, these kinds of changes are common and should always be reverted once we are done with work. As a pentester, us making a change like this and not reverting it could indicate to a defender that the host has been compromised. Be sure to check that we clean up after our actions. Another way we can bypass the execution policy and not leave a persistent change is to change it at the process level using -scope.

<h3>Change Execution Policy By Scope</h3>

PS C:\htb> Set-ExecutionPolicy -scope Process 

PS C:\htb> Get-ExecutionPolicy -list


Scope ExecutionPolicy

        ----- ---------------

MachinePolicy       Undefined

By changing it at the Process level, our change will revert once we close the PowerShell session. Keep the execution policy in mind when working with scripts and new modules. Of course, we want to look at the scripts we are trying to load first to ensure they are safe for use. As penetration testers, we may run into times when we need to be creative about how we bypass the Execution Policy on a host. This blog post has some creative ways that we have used on real-world engagements with great success.

<h3>Calling Cmdlets and Functions From Within a Module</h3>

If we wish to see what aliases, cmdlets, and functions an imported module brought to the session, we can use Get-Command -Module <modulename> to enlighten us.

<h3>Using Get-Command</h3>

PS C:\htb> Get-Command -Module PowerSploit

CommandType     Name                                               Version    Source

-----------     ----                                               -------    ------

Alias           Invoke-ProcessHunter                               3.0.0.0    PowerSploit

Alias           Invoke-ShareFinder                                 3.0.0.0    PowerSploit

Alias           Invoke-ThreadedFunction                            3.0.0.0    PowerSploit

Now we can see what was loaded by PowerSploit. From this point, we can use the scripts and functions as needed. This is the easy part, pick the function and let it run.

<h3>Deep Dive: Finding & Installing Modules from PowerShell Gallery & GitHub</h3>

In today's day and age, sharing information is extremely easy. That goes for solutions and new creations as well. When it comes to PowerShell modules, the PowerShell Gallery Is the best place for that. It is a repository that contains PowerShell scripts, modules, and more created by Microsoft and other users. They can range from anything as simple as dealing with user attributes to solving complex cloud storage issues.

<h3>PowerShell Gallery</h3>

Conveniently for us, There is already a module built into PowerShell meant to help us interact with the PowerShell Gallery called PowerShellGet. Let us take a look at it:

<h3>PowerShellGet</h3>

PS C:\htb> Get-Command -Module PowerShellGet 

CommandType     Name                                               Version    Source

-----------     ----                                               -------    ------

Function        Find-Command                                       1.0.0.1    PowerShellGet

Function        Find-DscResource                                   1.0.0.1    PowerShellGet

This module has many different functions to help us work with and download existing modules from the gallery and make and upload our own. From our function listing, let us give Find-Module a try. One module that will prove extremely useful to system admins is the AdminToolbox module. It is a collection of several other modules with tools meant for Active Directory management, Microsoft Exchange, virtualization, and many other tasks an admin would need on any given day.

<h3>Find-Module</h3>

PS C:\htb> Find-Module -Name AdminToolbox 

Like with many other PowerShell cmdlets, we can also search using wildcards. Once we have found a module we wish to utilize, installing it is as easy as Install-Module. Remember that it requires administrative rights to install modules in this manner.


In the image above, we chained Find-Module with Install-Module to simultaneously perform both actions. This example takes advantage of PowerShell's Pipeline functionality. We will cover this deeper in another section, but for now, it allowed us to find and install the module with one command string. Remember that modern instances of PowerShell will auto-import a module installed the first time we run a cmdlet or function from it, so there is no need to import the module after installing it. This differs from custom modules or modules we bring onto the host (from GitHub, for example). We will have to manually import it each time we want to use it unless we modify our PowerShell Profile. We can find the locations for each specific PowerShell profile Here. Besides creating our own modules and scripts or importing them from the PowerShell Gallery, we can also take advantage of Github and all the amazing content the IT community has come up with externally. Utilizing Git and Github for now requires the installation of other applications and knowledge of other concepts we have yet to cover, so we will save this for later in the module.

<h3>Tools To Be Aware Of</h3>

Below we will quickly list a few PowerShell modules and projects we, as penetration testers and sysadmins, should be aware of. Each of these tools brings a new capability to use within PowerShell. Of course, there are plenty more than just our list; these are just several we find ourselves returning to on every engagement.

AdminToolbox: AdminToolbox is a collection of helpful modules that allow system administrators to perform any number of actions dealing with things like Active Directory, Exchange, Network management, file and storage issues, and more.

ActiveDirectory: This module is a collection of local and remote administration tools for all things Active Directory. We can manage users, groups, permissions, and much more with it.

Empire / Situational Awareness: Is a collection of PowerShell modules and scripts that can provide us with situational awareness on a host and the domain they are apart of. This project is being maintained by BC Security as a part of their Empire Framework.

Inveigh: Inveigh is a tool built to perform network spoofing and Man-in-the-middle attacks.

BloodHound / SharpHound: Bloodhound/Sharphound allows us to visually map out an Active Directory Environment using graphical analysis tools and data collectors written in C# and PowerShell.

Working with PowerShell modules and cmdlets is intuitive and easy to master quickly. This skill will come in handy for the rest of this module since we will be dealing with various tools and topics within PowerShell that may require us to install, import, or examine modules and cmdlets. If you get stuck, be sure to refer back to this section. Now it is time to move on to User and Group management.

hat cmdlet can help us find modules that are loaded into our session?

Get-Module

+ 0  What module provides us with cmdlets built to manage package installation from the PowerShell Gallery?

PowerShellGet

 SSH to with user "htb-student" and password "HTB_@cademy_stdnt!"

+ 0  Take a moment to practice installing and loading modules on the target host. Answer "COMPLETE" when done.

COMPLETE
