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
