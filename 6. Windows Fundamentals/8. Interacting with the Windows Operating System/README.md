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
