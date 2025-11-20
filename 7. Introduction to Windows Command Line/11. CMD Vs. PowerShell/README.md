<h3>CMD Vs. PowerShell</h3>

Up to this point, we have discussed the built-in Windows Command-line interpreter cmd.exe. Moving forward, we will look at Windows' modern successor to CMD, PowerShell. This section will cover what PowerShell is, the differences between PowerShell and CMD, how to get help within the CLI, and basic navigation within the CLI.

<h3>Differences</h3>

PowerShell and CMD are included natively on any Windows host, so we may ask ourselves, "Why would I use one over the other?" Let's address this quickly. Below is a table with some differences between PowerShell and CMD.

<h3>PowerShell and CMD Compared</h3>


<table border="1">
  <tr>
    <th>Feature</th>
    <th>CMD</th>
    <th>PowerShell</th>
  </tr>
  <tr>
    <td>Language</td>
    <td>Batch and basic CMD commands only.</td>
    <td>PowerShell can interpret Batch, CMD, PS cmdlets, and aliases.</td>
  </tr>
  <tr>
    <td>Command utilization</td>
    <td>The output from one command cannot be passed into another directly as a structured object, due to the limitation of handling the text output.</td>
    <td>The output from one command can be passed into another directly as a structured object, resulting in more sophisticated commands.</td>
  </tr>
  <tr>
    <td>Command Output</td>
    <td>Text only.</td>
    <td>PowerShell outputs in object formatting.</td>
  </tr>
  <tr>
    <td>Parallel Execution</td>
    <td>CMD must finish one command before running another.</td>
    <td>PowerShell can multi-thread commands to run in parallel.</td>
  </tr>
</table>

Most notably, PowerShell has been built to be extensible and to integrate with many other tools and functionality as needed. Most think of it as just another CLI, but it is much more. Did you know it is also a scripting language? While CMD has been the default command-line interpreter for Windows hosts only, PowerShell has been released as an open-source project and has an extensive offering of capabilities that support its use with Linux-based systems as well. Using the .NET framework has also made PowerShell capable of utilizing an object base model of interaction and output instead of text-based only.

<h3>Why Choose PowerShell Over cmd.exe?</h3>

Why does PowerShell matter for IT admins, Offensive & Defensive Infosec pros?

PowerShell has become increasingly prominent among IT and Infosec professionals. It has widespread utility for System Administrators, Penetration Testers, SOC Analysts, and many other technical disciplines where ever Windows systems are administered. Consider IT admins and Windows system administrators administering IT environments made up of Windows servers, desktops (Windows 10 & 11), Azure, and Microsoft 365 cloud-based applications. Many of them are using PowerShell to automate tasks they must accomplish daily. Among some of these tasks are:

Provisioning servers and installing server roles

Creating Active Directory user accounts for new employees

Managing Active Directory group permissions

Disabling and deleting Active Directory user accounts

Managing file share permissions

Interacting with Azure AD and Azure VMs

Creating, deleting, and monitoring directories & files

Gathering information about workstations and servers

Setting up Microsoft Exchange email inboxes for users (in the cloud &/or on-premises)

There are countless ways to use PowerShell from an IT admin context, and being mindful of that context can be helpful for us as penetration testers and even as defenders. As a sysadmin, PowerShell can provide us with much more capability than CMD. It is expandable, built for automation and scripting, has a much more robust security implementation, and can handle many different tasks that CMD simply cannot. As a pentester, many well-known capabilities are built into PowerShell. PowerShell's module import capability makes it easy to bring our tools into the environment and ensure they will work. However, from a stealth perspective, PowerShell's logging and history capability is powerful and will log more of our interactions with the host. So if we do not need PowerShell's capabilities and wish to be more stealthy, we should utilize CMD.

<h3>Calling PowerShell</h3>

We can access PowerShell directly on a host through the peripherals attached to the local machine or through RDP over the network through various methods.

1. Using Windows Search

We can type PowerShell in Windows Search to find and launch the PowerShell application and command console.

2. Using the Windows Terminal Application

Windows Terminal is a newer terminal emulator application developed by Microsoft to give anyone using the Windows command line a way to access multiple different command line interfaces, systems, and sub-systems through a single app. This application will likely become the default terminal emulator on Windows operating systems.

3. Using Windows PowerShell ISE
The Windows PowerShell Integrated Scripting Environment (ISE) is like an IDE for PowerShell. It can make it easier to develop, debug and test the PowerShell scripts we create. Using PowerShell ISE can be incredibly useful when learning PowerShell.

4. Using PowerShell in CMD

We can also launch PowerShell from within CMD. This action may seem trivial, but there will undoubtedly come a time when we can get a shell on a vulnerable Windows target's CLI via CMD and will benefit from attempting to use PowerShell to further our access on the host and across the network.

<h3>Taking a Look at the Shell</h3>

One of the first things we may examine when accessing PowerShell on a local or remote system is the prompt.

<h3>PowerShell Prompt</h3>

PS C:\Users\htb-student> ipconfig 

Ethernet adapter VMware Network Adapter VMnet8:

   Connection-specific DNS Suffix  . :

   The prompt is almost identical to what we see in CMD.

- PS is short for PowerShell, followed by the current working directory C:\Users\htb-student>.

- This is followed by the cmdlet or string we want to execute, ipconfig.

- Finally, below that, we see the output results of our command.

Also similar to CMD, PowerShell gives us many commands and cmdlets to utilize. Almost all commands that work in CMD will work in PowerShell. We will only cover some possible commands in this module. It is essential to understand that there is very little utility in memorizing commands. Focus more on understanding context, concepts, and what is possible. Memorization will naturally happen with time spent practicing and repetition.


<h3>Get-Help</h3>

Using the Help function. If we want to see the options and functionality available to us with a specific cmdlet, we can use the Get-Help cmdlet.

<h3>Using Get-Help</h3>

PS C:\Users\htb-student> Get-Help Test-Wsman

NAME
    Test-WSMan

SYNTAX

    Test-WSMan [[-ComputerName] <string>] [-Authentication {None | Default | Digest | Negotiate | Basic | Kerberos |
    
    ClientCertificate | Credssp}] [-Port <int>] [-UseSSL] [-ApplicationName <string>] [-Credential <pscredential>]

    [-CertificateThumbprint <string>]  [<CommonParameters>]

Get-Help can give helpful information about a cmdlet. Notice that the Syntax output shows us several available options and additional keywords that can be used with each option. Aliases are also mentioned, essentially shorter names for our commands. We will discuss Aliases in more depth later in this section. The Remarks output provides us with further information about the cmdlet and even additional options we can use to learn more about the cmdlet. One of these additional options is -online, which will open a Microsoft docs webpage for the corresponding cmdlet if the host has Internet access.

We can also use a helpful cmdlet called Update-Help to ensure we have the most up-to-date information for each cmdlet on the Windows system.

<h3>Using Update-Help</h3>

PS C:\Windows\system32> Update-Help

Notice how much more information was populated regarding Test-Wsman after running Update-Help. Feel free to compare this output to the output shown earlier when we first covered Get-Help.

<h3>Using Get-Help After Running Update-Help</h3>

PS C:\Windows\system32> Get-Help  Test-Wsman

NAME
    Test-WSMan

SYNOPSIS

    Tests whether the WinRM service is running on a local or remote computer.

<h3>Getting Around in PowerShell</h3>

Now that we have covered what PowerShell is and the basics of the built-in help features, let us get into basic navigation and usage of PowerShell.

<h3>Where Are We?</h3>

We can only move around if we know where we are already, right? We can determine our current working directory (in relation to the host system) by utilizing the Get-Location cmdlet.

<h3>Get-Location</h3>

PS C:\Users\DLarusso> Get-Location

Path

----

C:\Users\DLarusso

We can see it printed the full path of the directory we are currently working from; in this case, that would be C:\Users\DLarusso. Now that we have our bearings let us look at what objects and files exist within this directory.

<h3>List the Directory</h3>

The Get-ChildItem cmdlet can display the contents of our current directory or the one we specify.

<h3>Get-ChildItem</h3>


PS C:\htb> Get-ChildItem 

Directory: C:\Users\DLarusso


Mode                 LastWriteTime         Length Name

----                 -------------         ------ ----

d-----        10/26/2021  10:26 PM                .ssh

d-----         1/28/2021   7:05 PM                .vscode

We can see several other directories within our current working directory. Let's explore one.


<h3>Move to a New Directory</h3>

Changing our location is simple; we can do so utilizing the Set-Location cmdlet.

<h3>Set-Location</h3>

PS C:\htb>  Set-Location .\Documents\

PS C:\Users\tru7h\Documents> Get-Location

Path

----

C:\Users\DLarusso\Documents

We fed the parameters .\Documents\ to the Set-Location cmdlet, telling PowerShell that we want to move into the Documents directory, which resides within our current working directory. We could have also given it the full file path like this:

Set-Location C:\Users\DLarusso\Documents  

<h3>Display Contents of a File</h3>

Now, if we wish to see the contents of a file, we can use Get-Content. Looking in the Documents directory, we notice a file called Readme.md. Let us check it out.

<h3>Get-Content</h3>

PS C:\htb> Get-Content Readme.md  

# ![logo][] PowerShell

Welcome to the PowerShell GitHub Community!

PowerShell Core is a cross-platform (Windows, Linux, and macOS) automation and configuration tool/framework that works well with your existing tools and is optimized
for dealing with structured data (e.g., JSON, CSV, XML, etc.), REST APIs, and object models.
It includes a command-line shell, an associated scripting language and a framework for processing cmdlets. 

<SNIP> 

It looks like the Readme file was from the PowerShell GitHub page. Utilizing the Get-Content cmdlet is as simple as that. Navigating within the PowerShell CLI is pretty straightforward. Now that we have that skill down, let us look at a few helpful tips and tricks that can make utilizing the CLI even smoother.

<h3>Tips & Tricks for PowerShell Usage</h3>

<h3>Get-Command</h3>

Get-Command is a great way to find a pesky command that might be slipping from our memory right when we need to use it. With PowerShell using the verb-noun convention for cmdlets, we can search on either.

<h3>Get-Command Usage</h3>

PS C:\htb> Get-Command

CommandType     Name                                               Version    Source

-----------     ----                                               -------    ------

Alias           Add-AppPackage                                     2.0.1.0    Appx

Alias           Add-AppPackageVolume                               2.0.1.0    Appx

The output above was snipped for the sake of saving screen space. Using Get-Command without additional modifiers will perform a complete output of each cmdlet currently loaded into the PowerShell session. We can trim this down more by filtering on the verb or the noun portion of the cmdlet.

<h3>Get-Command (verb)</h3>

PS C:\htb> Get-Command -verb get

<SNIP>

Cmdlet          Get-Acl                                            3.0.0.0    Microsoft.Pow...

Using the -verb modifier and looking for any cmdlet, alias, or function with the term get in the name, we are provided with a detailed list of everything PowerShell is currently aware of. We can also perform the exact search using the filter get* instead of the -verb get. The Get-Command cmdlet recognizes the * as a wildcard and shows each variant of get(anything). We can do something similar by searching on the noun as well.

<h3>Get-Command (noun)</h3>

  CMD Vs. PowerShell
  
PS C:\htb> Get-Command -noun windows*  

CommandType     Name                                               Version    Source

-----------     ----                                               -------    ------

Alias           Apply-WindowsUnattend                              3.0        Dism

Function        Get-WindowsUpdateLog                               1.0.0.0    WindowsUpdate