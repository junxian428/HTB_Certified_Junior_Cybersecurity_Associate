<h3>System Information</h3>

Now, let’s dive into some hands-on practice to get comfortable with using the terminal and the shell. Keep in mind that you can always use the -h, --help, or man commands to access help if needed.

Since we’ll be working with various Linux systems, it's important to understand their structure, including system details, processes, network configurations, users/user settings, and directories, along with their related parameters. Below is a list of essential tools to help gather this information. Most of these tools come pre-installed. However, this knowledge is not only crucial for routine Linux tasks, but also plays a key role when assessing security configurations, identifying vulnerabilities, or preventing potential security risks in Linux operating systems.

<table border="1">
  <tr>
    <th>Command</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>whoami</td>
    <td>Displays current username.</td>
  </tr>
  <tr>
    <td>id</td>
    <td>Returns users identity.</td>
  </tr>
  <tr>
    <td>hostname</td>
    <td>Sets or prints the name of current host system.</td>
  </tr>
  <tr>
    <td>uname</td>
    <td>Prints basic information about the operating system name and system hardware.</td>
  </tr>
  <tr>
    <td>pwd</td>
    <td>Returns working directory name.</td>
  </tr>
  <tr>
    <td>ifconfig</td>
    <td>The ifconfig utility is used to assign or to view an address to a network interface and/or configure network interface parameters.</td>
  </tr>
  <tr>
    <td>ip</td>
    <td>Ip is a utility to show or manipulate routing, network devices, interfaces and tunnels.</td>
  </tr>
  <tr>
    <td>netstat</td>
    <td>Shows network status.</td>
  </tr>
  <tr>
    <td>ss</td>
    <td>Another utility to investigate sockets.</td>
  </tr>
  <tr>
    <td>ps</td>
    <td>Shows process status.</td>
  </tr>
  <tr>
    <td>who</td>
    <td>Displays who is logged in.</td>
  </tr>
  <tr>
    <td>env</td>
    <td>Prints environment or sets and executes command.</td>
  </tr>
  <tr>
    <td>lsblk</td>
    <td>Lists block devices.</td>
  </tr>
  <tr>
    <td>lsusb</td>
    <td>Lists USB devices.</td>
  </tr>
  <tr>
    <td>lsof</td>
    <td>Lists opened files.</td>
  </tr>
  <tr>
    <td>lspci</td>
    <td>Lists PCI devices.</td>
  </tr>
</table>

Let us scroll to the bottom of the page, spawn the target machine, then connect to it using SSH. Then, try to follow along and reproduce as many of the example shown in the section.

<h3>Logging In via SSH</h3>

Secure Shell (SSH) refers to a protocol that allows clients to access and execute commands or actions on remote computers. On Linux-based hosts and servers, as well as other Unix-like operating systems, SSH is one of the permanently installed standard tools and is the preferred choice for many administrators to configure and maintain a computer through remote access. It is an older and very proven protocol that does not require or offer a graphical user interface (GUI). For this reason, it works very efficiently and occupies very few resources. We use this type of connection in the following sections, and in most of the other module lab exercises, to offer the possibility to try out the learned commands and actions in a safe environment.

We can connect to our targets with the following command:

@htb[/htb]$ ssh htb-student@[IP address]

Now, let us look at a few examples on the machine we have just logged in.

<h3>Hostname</h3>

The hostname command is pretty self-explanatory and will just print the name of the computer that we are logged into

@htb[/htb]$ hostname

nixfund

<h3>Whoami</h3>

This quick and easy command can be used on both Windows and Linux systems to get our current username. During a security assessment, we obtain reverse shell access on a host, and one of the first bits of situational awareness we should do is figuring out what user we are running as. From there, we can figure out if the user has any special privileges/access.

cry0l1t3@htb[/htb]$ whoami

cry0l1t3

<h3>Id</h3>

The id command expands on the whoami command and prints out our effective group membership and IDs. This can be of interest to penetration testers looking to see what access a user may have and sysadmins looking to audit account permissions and group membership. In this output, the hackthebox group is of interest because it is non-standard, the adm group means that the user can read log files in /var/log and could potentially gain access to sensitive information, membership in the sudo group is of particular interest as this means our user can run some or all commands as the all-powerful root user. Sudo rights could help us escalate privileges or could be a sign to a sysadmin that they may need to audit permissions and group memberships to remove any access that is not required for a given user to carry out their day-to-day tasks.

cry0l1t3@htb[/htb]$ id

uid=1000(cry0l1t3) gid=1000(cry0l1t3) groups=1000(cry0l1t3),1337(hackthebox),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),116(lpadmin),126(sambashare)

<h3> Uname</h3>

Let's dig into the uname command a bit more. If we type man uname in our terminal, we will bring up the man page for the command, which will show the possible options we can run with the command and the results.

UNAME(1) User Commands UNAME(1)

NAME

uname - print system information

SYNOPSIS

uname [OPTION]...

DESCRIPTION

Print certain system information. With no OPTION, same as -s.

       -a, --all
              print all information, in the following order, except omit -p and -i if unknown:

       -s, --kernel-name
              print the kernel name

       -n, --nodename
              print the network node hostname

       -r, --kernel-release
              print the kernel release

       -v, --kernel-version
              print the kernel version

       -m, --machine
              print the machine hardware name

       -p, --processor
              print the processor type (non-portable)

       -i, --hardware-platform
              print the hardware platform (non-portable)

       -o, --operating-system

Running uname -a will print all information about the machine in a specific order: kernel name, hostname, the kernel release, kernel version, machine hardware name, and operating system. The -a flag will omit -p (processor type) and -i (hardware platform) if they are unknown.

cry0l1t3@htb[/htb]$ uname -a

Linux box 4.15.0-99-generic #100-Ubuntu SMP Wed Apr 22 20:32:56 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

From the above command, we can see that the kernel name is Linux, the hostname is box, the kernel release is 4.15.0-99-generic, the kernel version is #100-Ubuntu SMP Wed Apr 22 20:32:56 UTC 2020, and so on. Running any of these options on their own will give us the specific bit output we are interested in.

<h3>Uname to Obtain Kernel Release</h3>

Suppose we want to print out the kernel release to search for potential kernel exploits quickly. We can type uname -r to obtain this information.

cry0l1t3@htb[/htb]$ uname -r

4.15.0-99-generic

With this info, we could go and search for "4.15.0-99-generic exploit," and the first result immediately appears useful to us.

It is highly recommended to study the commands and understand what they are for and what information they can provide. Though a bit tedious, we can learn much from studying the manpages for common commands. We may even find out things that we did not even know were possible with a given command. This information is not only used for working with Linux. However, it will also be used later to discover vulnerabilities and misconfigurations on the Linux system that may contribute to privilege escalation. Here are a few optional exercises that we can solve for practice purposes, which will help us become familiar with some of the commands.

<h3>About Linux Exercises</h3>

The exercises provided for studying the Linux OS and its commands might not always be immediately clear in terms of what you need to do, and that's perfectly fine—it's even unavoidable. As you’ve learned from the Learning Process module, learning something new can feel uncomfortable and may cause stress. You can think of it like the first time you sat behind the wheel of a car and had to drive on your own. It was stressful because there were many things you had to focus on at once. But now, with experience, driving is easier, though you're not learning as much anymore. Similarly, in this module, you may find yourself in situations where you’re unsure of what to do, but that’s okay. In your cybersecurity journey, you’ll often face such moments, and they’re a positive indicator that you’re learning something new. Overcoming these challenges helps you improve, even if you haven’t fully solved the exercise yet. That’s the ultimate goal—progress through learning.

The exercises are intentionally designed to gradually push you out of your current knowledge and into unfamiliar territory. This progression is deliberate and ensures that as you continue practicing, your experience and knowledge will naturally expand. While it may feel uncomfortable at times, this process is essential for growth. With each new challenge, you’ll stretch beyond what you already know, and with consistent effort, you’ll find that your understanding and skills develop almost automatically. Keep practicing, and you’ll steadily grow more confident and capable in navigating the unknown.
