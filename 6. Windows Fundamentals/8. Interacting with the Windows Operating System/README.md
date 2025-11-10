<h3>Interacting with the Windows Operating System</h3>

<h3>Graphical User Interface</h3>

The concept of a graphical user interface (GUI) was introduced in the late 1970s by the Xerox Palo Alto research laboratory. It was added to Apple and Microsoft operating systems to address usability concerns for everyday users that would likely have difficulty navigating the command line. Most casual Windows computer users do not ever need to interact with the operating system via the command line. As the name alludes to, a GUI provides users with an interactive point and click interface for interacting with the operating system and installed applications and services.

The introduction of the GUI opened up widespread appeal and access to computers across many demographics since users would be able to interact with their computer without having to memorize commands or know any programming language. Systems administrators commonly use GUI-based systems for administering Active Directory, configuring IIS, or interacting with databases.

<h3>Remote Desktop Protocol (RDP)</h3>

RDP is a proprietary Microsoft protocol which allows a user to connect to a remote system over a network connection and obtain a graphical user interface. The user connects using RDP client software to a target system running RDP server software. RDP uses port 3389 to open a dedicated network channel for sending data back and forth. When connecting via RDP, a user can access the GUI as if they were actually sitting at the computer and logging into it locally. RDP is often used by system administrators to administer remote systems quickly. It can also allow users to access their work computers when traveling or working from home after connecting to a Virtual Private Network (VPN).

<h3>Windows Command Line</h3>

Command-line interfaces give users greater control over their systems and can be used to perform a wide variety of day-to-day, administrative, and troubleshooting tasks. It can be leveraged to introduce automation to perform certain tasks quickly (such as adding many users to a domain at once). In Windows operating systems, the main two ways to interact with the system from the command line are via the Command Prompt (CMD) and PowerShell.

The Windows Command Reference from Microsoft is a comprehensive A-Z command reference which includes an overview, usage examples, and command syntax for most Windows commands, and familiarity with it is recommended.

<h3>CMD</h3>

The Command Prompt (cmd.exe) is used to enter and execute commands. A user can enter one-off commands such as ipconfig to view IP address information or perform more advanced tasks such as setting up scheduled tasks or creating scripts and batch files. The Command prompt can be opened from the Start Menu, by typing cmd in the run dialogue box, or by directly launching the binary from C:\Windows\system32\cmd.exe.

After launching cmd.exe we can type help to see a listing of available commands.

C:\htb> help

For more information on a specific command, type HELP command-name

ASSOC Displays or modifies file extension associations.

ATTRIB Displays or changes file attributes.

BREAK Sets or clears extended CTRL+C checking.

BCDEDIT Sets properties in boot database to control boot loading.

CACLS Displays or modifies access control lists (ACLs) of files.

CALL Calls one batch program from another.

CD Displays the name of or changes the current directory.

CHCP Displays or sets the active code page number.

CHDIR Displays the name of or changes the current directory.

CHKDSK Checks a disk and displays a status report.

CHKNTFS Displays or modifies the checking of disk at boot time.

CLS Clears the screen.

CMD Starts a new instance of the Windows command interpreter.

COLOR Sets the default console foreground and background colors.

COMP Compares the contents of two files or sets of files.

COMPACT Displays or alters the compression of files on NTFS partitions.

CONVERT Converts FAT volumes to NTFS. You cannot convert the

current drive.

COPY Copies one or more files to another location.

<SNIP>

For more information about a specific command, we can type help <command name>.

C:\htb> help schtasks

SCHTASKS /parameter [arguments]

Description:

Enables an administrator to create, delete, query, change, run and
end scheduled tasks on a local or remote system.

Parameter List:

/Create Creates a new scheduled task.

    /Delete         Deletes the scheduled task(s).

    /Query          Displays all scheduled tasks.

    /Change         Changes the properties of scheduled task.

    /Run            Runs the scheduled task on demand.

    /End            Stops the currently running scheduled task.

    /ShowSid        Shows the security identifier corresponding to a scheduled task name.

    /?              Displays this help message.

Examples:

SCHTASKS

SCHTASKS /?

SCHTASKS /Run /?

SCHTASKS /End /?

SCHTASKS /Create /?

SCHTASKS /Delete /?

SCHTASKS /Query /?

SCHTASKS /Change /?

SCHTASKS /ShowSid /?

Note that certain commands have their own help menus, which can be accessed by typing <command> /?. For example, information about the ipconfig command can be seen below.

C:\htb> ipconfig /?

USAGE:

ipconfig [/allcompartments] [/? | /all |

/renew [adapter] | /release [adapter] |

/renew6 [adapter] | /release6 [adapter] |

/flushdns | /displaydns | /registerdns |

/showclassid adapter |

/setclassid adapter [classid] |

/showclassid6 adapter |

/setclassid6 adapter [classid] ]

where

adapter Connection name

(wildcard characters \* and ? allowed, see examples)

    Options:

       /?               Display this help message

       /all             Display full configuration information.

       /release         Release the IPv4 address for the specified adapter.

       /release6        Release the IPv6 address for the specified adapter.

       /renew           Renew the IPv4 address for the specified adapter.

       /renew6          Renew the IPv6 address for the specified adapter.

       /flushdns        Purges the DNS Resolver cache.

       /registerdns     Refreshes all DHCP leases and re-registers DNS names

       /displaydns      Display the contents of the DNS Resolver Cache.

       /showclassid     Displays all the dhcp class IDs allowed for adapter.

       /setclassid      Modifies the dhcp class id.

       /showclassid6    Displays all the IPv6 DHCP class IDs allowed for adapter.

       /setclassid6     Modifies the IPv6 DHCP class id.

<SNIP

<h3>PowerShell</h3>

Windows PowerShell is a command shell that was designed by Microsoft to be more geared towards system administrators. PowerShell, like the Windows command line, has an interactive command prompt as well as a powerful scripting environment. PowerShell is built on top of the .NET Framework, which is used for building and running applications on Windows. This makes it a very powerful tool for interfacing directly with the operating system.

Like the command prompt, PowerShell gives us direct access to the file system, and we run the majority of the same commands that we can within a cmd shell.

<h3>Cmdlets</h3>

PowerShell utilizes cmdlets, which are small single-function tools built into the shell. There are more than 100 core cmdlets, and many additional ones have been written, or we can author our own to perform more complex tasks. PowerShell also supports both simple and complex scripts used for system administration tasks, automation, and more.

Cmdlets are in the form of Verb-Noun. For example, the command Get-ChildItem can be used to list our current directory. Cmdlets also take arguments or flags. We can type Get-ChildItem - and hit the tab key to iterate through the arguments. A command such as Get-ChildItem -Recurse will show us the contents of our current working directory and all subdirectories. Another example would be Get-ChildItem -Path C:\Users\Administrator\Documents to get the contents of another directory. Finally, we can combine arguments such as this to list all subdirectories' contents within another directory recursively: Get-ChildItem -Path C:\Users\Administrator\Downloads -Recurse.

<h3>Aliases</h3>

Many cmdlets in PowerShell also have aliases. For example, the aliases for the cmdlet Set-Location, to change directories, is either cd or sl. Meanwhile, the aliases for Get-ChildItem are ls and gci. We can view all available aliases by typing Get-Alias.

PS C:\htb> get-alias

CommandType Name Version Source

---

Alias % -> ForEach-Object

Alias ? -> Where-Object

Alias ac -> Add-Content

Alias asnp -> Add-PSSnapin

Alias cat -> Get-Content

Alias cd -> Set-Location

Alias CFS -> ConvertFrom-String 3.1.0.0 Microsoft.PowerShell.Utility

Alias chdir -> Set-Location

Alias clc -> Clear-Content

Alias clear -> Clear-Host

Alias clhy -> Clear-History

Alias cli -> Clear-Item

Alias clp -> Clear-ItemProperty

We can also set up our own aliases with New-Alias and get the alias for any cmdlet with Get-Alias -Name.

PS C:\htb> New-Alias -Name "Show-Files" Get-ChildItem

PS C:\> Get-Alias -Name "Show-Files"

CommandType Name Version Source

---

Alias Show-Files

PowerShell has a help system for cmdlets, functions, scripts, and concepts. This is not installed by default, but we can either run the Get-Help <cmdlet-name> -Online command to open the online help for a cmdlet or function in our web browser. We can type Update-Help to download and install help files locally.
