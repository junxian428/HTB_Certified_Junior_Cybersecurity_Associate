<h3>Service and Process Management</h3>

Services, also known as daemons, are fundamental components of a Linux system that run silently in the background "without direct user interaction". They perform crucial tasks that keep the system operational and provide additional functionalities. Generally, services can be categorized into two types:

<h3>System Services</h3>

These are internal services required during system startup. They perform essential hardware-related tasks and initialize system components necessary for the operating system to function properly. These are like the engine and transmission systems. They start when you turn the ignition key and are essential for the car to run. Without them, the car wouldn't move.

<h3>User-Installed Services</h3>

These services are added by users and typically include server applications and other background processes that provide specific features or capabilities. These types of services are like the car's air conditioning or GPS navigation system. While not critical for the car to operate, they enhance functionality and provide additional features based on the driver's preferences.

Daemons are often identified by the letter d at the end of their program names, such as sshd (SSH daemon) or systemd. Just as a car relies on both its core components and optional features to provide a complete experience, a Linux system utilizes both system and user-installed services to function efficiently and meet user needs.

In general, there are just a few goals that we have when we deal with a service or a process:

1. Start/Restart a service/process

2. Stop a service/process

3. See what is/was happening with a service/process

4. Enable/Disable a service/process on boot

5. Find a service/process

Most modern Linux distributions have adopted systemd as their initialization system (init system). It is the first process that starts during the boot process and is assigned the Process ID (PID). All processes in a Linux system are assigned a PID and can be viewed under the /proc/ directory, which contains information about each process. Processes may also have a Parent Process ID (PPID), indicating that they were started by another process (the parent), making them child processes.

<h3>Systemctl</h3>

After installing OpenSSH on our VM, we can start the service with the following command.

@htb[/htb]$ systemctl start ssh

After we have started the service, we can now check if it runs without errors.

@htb[/htb]$ systemctl status ssh

● ssh.service - OpenBSD Secure Shell server

Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)

Active: active (running) since Thu 2020-05-14 15:08:23 CEST; 24h ago

Main PID: 846 (sshd)

Tasks: 1 (limit: 4681)

CGroup: /system.slice/ssh.service

└─846 /usr/sbin/sshd -D

Mai 14 15:08:22 inlane systemd[1]: Starting OpenBSD Secure Shell server...

Mai 14 15:08:23 inlane sshd[846]: Server listening on 0.0.0.0 port 22.

Mai 14 15:08:23 inlane sshd[846]: Server listening on :: port 22.

Mai 14 15:08:23 inlane systemd[1]: Started OpenBSD Secure Shell server.

Mai 14 15:08:30 inlane systemd[1]: Reloading OpenBSD Secure Shell server.

Mai 14 15:08:31 inlane sshd[846]: Received SIGHUP; restarting.

Mai 14 15:08:31 inlane sshd[846]: Server listening on 0.0.0.0 port 22.

Mai 14 15:08:31 inlane sshd[846]: Server listening on :: port 22.

To add OpenSSH to the SysV script to tell the system to run this service after startup, we can link it with the following command:

@htb[/htb]$ systemctl enable ssh

Synchronizing state of ssh.service with SysV service script with /lib/systemd/systemd-sysv-install.

Executing: /lib/systemd/systemd-sysv-install enable ssh

Once we reboot the system, the OpenSSH server will automatically run. We can check this with a tool called ps.

@htb[/htb]$ ps -aux | grep ssh

root 846 0.0 0.1 72300 5660 ? Ss Mai14 0:00 /usr/sbin/sshd -D

We can also use systemctl to list all services.

@htb[/htb]$ systemctl list-units --type=service

UNIT LOAD ACTIVE SUB DESCRIPTION

accounts-daemon.service loaded active running Accounts Service

acpid.service loaded active running ACPI event daemon

apache2.service loaded active running The Apache HTTP Server

apparmor.service loaded active exited AppArmor initialization

apport.service loaded active exited LSB: automatic crash repor

avahi-daemon.service loaded active running Avahi mDNS/DNS-SD Stack

bolt.service loaded active running Thunderbolt system service

It is quite possible that the services do not start due to an error. To see the problem, we can use the tool journalctl to view the logs.

@htb[/htb]$ journalctl -u ssh.service --no-pager

-- Logs begin at Wed 2020-05-13 17:30:52 CEST, end at Fri 2020-05-15 16:00:14 CEST. --

Mai 13 20:38:44 inlane systemd[1]: Starting OpenBSD Secure Shell server...

Mai 13 20:38:44 inlane sshd[2722]: Server listening on 0.0.0.0 port 22.

Mai 13 20:38:44 inlane sshd[2722]: Server listening on :: port 22.

Mai 13 20:38:44 inlane systemd[1]: Started OpenBSD Secure Shell server.

Mai 13 20:39:06 inlane sshd[3939]: Connection closed by 10.22.2.1 port 36444 [preauth]

Mai 13 20:39:27 inlane sshd[3942]: Accepted password for master from 10.22.2.1 port 36452 ssh2

Mai 13 20:39:27 inlane sshd[3942]: pam_unix(sshd:session): session opened for user master by (uid=0)

Mai 13 20:39:28 inlane sshd[3942]: pam_unix(sshd:session): session closed for user master

Mai 14 02:04:49 inlane sshd[2722]: Received signal 15; terminating.

Mai 14 02:04:49 inlane systemd[1]: Stopping OpenBSD Secure Shell server...

Mai 14 02:04:49 inlane systemd[1]: Stopped OpenBSD Secure Shell server.

-- Reboot --

<h3>Kill a Process</h3>

A process can be in the following states:

Running

Waiting (waiting for an event or system resource)

Stopped

Zombie (stopped but still has an entry in the process table).

Processes can be controlled using kill, pkill, pgrep, and killall. To interact with a process, we must send a signal to it. We can view all signals with the following command:

@htb[/htb]$ kill -l

1.  SIGHUP 2) SIGINT 3) SIGQUIT 4) SIGILL 5) SIGTRAP
2.  SIGABRT 7) SIGBUS 8) SIGFPE 9) SIGKILL 10) SIGUSR1
3.  SIGSEGV 12) SIGUSR2 13) SIGPIPE 14) SIGALRM 15) SIGTERM
4.  SIGSTKFLT 17) SIGCHLD 18) SIGCONT 19) SIGSTOP 20) SIGTSTP
5.  SIGTTIN 22) SIGTTOU 23) SIGURG 24) SIGXCPU 25) SIGXFSZ
6.  SIGVTALRM 27) SIGPROF 28) SIGWINCH 29) SIGIO 30) SIGPWR
7.  SIGSYS 34) SIGRTMIN 35) SIGRTMIN+1 36) SIGRTMIN+2 37) SIGRTMIN+3
8.  SIGRTMIN+4 39) SIGRTMIN+5 40) SIGRTMIN+6 41) SIGRTMIN+7 42) SIGRTMIN+8
9.  SIGRTMIN+9 44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12 47) SIGRTMIN+13
10. SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14 51) SIGRTMAX-13 52) SIGRTMAX-12
11. SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9 56) SIGRTMAX-8 57) SIGRTMAX-7
12. SIGRTMAX-6 59) SIGRTMAX-5 60) SIGRTMAX-4 61) SIGRTMAX-3 62) SIGRTMAX-2
13. SIGRTMAX-1 64) SIGRTMAX

The most commonly used signals are:

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Signal</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1 SIGHUP</td>
      <td>This is sent to a process when the terminal that controls it is closed.</td>
    </tr>
    <tr>
      <td>2 SIGINT</td>
      <td>Sent when a user presses [Ctrl] + C in the controlling terminal to interrupt a process.</td>
    </tr>
    <tr>
      <td>3 SIGQUIT</td>
      <td>Sent when a user presses [Ctrl] + D to quit.</td>
    </tr>
    <tr>
      <td>9 SIGKILL</td>
      <td>Immediately kill a process with no clean-up operations.</td>
    </tr>
    <tr>
      <td>15 SIGTERM</td>
      <td>Program termination.</td>
    </tr>
    <tr>
      <td>19 SIGSTOP</td>
      <td>Stop the program. It cannot be handled anymore.</td>
    </tr>
    <tr>
      <td>20 SIGTSTP</td>
      <td>Sent when a user presses [Ctrl] + Z to request for a service to suspend. The user can handle it afterward.</td>
    </tr>
  </tbody>
</table>

For example, if a program were to freeze, we could force to kill it with the following command:

@htb[/htb]$ kill 9 <PID>

<h3>Background a Process</h3>

Sometimes it will be necessary to put the scan or process we just started in the background to continue using the current session to interact with the system or start other processes. As we have already seen, we can do this with the shortcut [Ctrl + Z]. As mentioned above, we send the SIGTSTP signal to the kernel, which suspends the process.

@htb[/htb]$ ping -c 10 www.hackthebox.eu

@htb[/htb]$ vim tmpfile

[Ctrl + Z]

[2]+ Stopped vim tmpfile

Now all background processes can be displayed with the following command.

@htb[/htb]$ jobs

[1]+ Stopped ping -c 10 www.hackthebox.eu

[2]+ Stopped vim tmpfile

The [Ctrl] + Z shortcut suspends the processes, and they will not be executed further. To keep it running in the background, we have to enter the command bg to put the process in the background.

htb[/htb]$ bg

@htb[/htb]$

--- www.hackthebox.eu ping statistics ---

10 packets transmitted, 0 received, 100% packet loss, time 113482ms

[ENTER]

[1]+ Exit 1 ping -c 10 www.hackthebox.eu

Another option is to automatically set the process with an AND sign (&) at the end of the command.

@htb[/htb]$ ping -c 10 www.hackthebox.eu &

[1] 10825

PING www.hackthebox.eu (172.67.1.1) 56(84) bytes of data.

Once the process finishes, we will see the results.

@htb[/htb]$

--- www.hackthebox.eu ping statistics ---

10 packets transmitted, 0 received, 100% packet loss, time 9210ms

[ENTER]
[1]+ Exit 1 ping -c 10 www.hackthebox.eu
