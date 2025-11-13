<h3>Getting Help</h3>

In the previous section, we were introduced to the general concepts of the Command Prompt and how we can access it. This section will expand upon the previous one by introducing the help functionality within Command Prompt, example output, and some additional resources and concepts.

The Command Prompt has a built-in help function that can provide us with detailed information about the available commands on our system and how to utilize those functions. In this section, we are going to cover the following in greater detail:

How do we utilize the help functionality within Command Prompt?

Why utilizing the help functionality is essential?

Where can we find additional external resources for help?

How to utilize additional tips and tricks in the Command Prompt?

<h3>How to Get Help</h3>

When first looking at the Command Prompt interface, it can be overwhelming to stare at a blank prompt. Some initial questions might emerge, such as:

What commands do I have access to?

How do I use these commands?

Let's work on answering the initial question first. While utilizing the Command Prompt, finding help is as easy as typing help. Without any additional parameters, this command provides a list of built-in commands and basic information about each displayed command's usage. Let's take a look at it below.

<h3>Default Help Usage</h3>

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

<snip>

From this output, we can see that it prints out a list of system commands (built-ins) and provides a basic description of its functionality. This is important because we can quickly and efficiently parse the list of built-in functions provided by the command prompt to find the function that suits our needs. From here, we can transition into answering the second question on how these commands are used. To print out detailed information about a particular command, we can issue the following: help <command name>.

C:\htb> help time

Displays or sets the system time.

TIME [/T | time]

Type TIME with no parameters to display the current time setting and a prompt
for a new one. Press ENTER to keep the same time.

If Command Extensions are enabled, the TIME command supports
the /T switch which tells the command to just output the
current time, without prompting for a new time.
