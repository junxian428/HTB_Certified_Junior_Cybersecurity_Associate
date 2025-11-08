<h3>Network Services</h3>

When working with Linux, managing various network services is essential. Proficiency in handling these services is crucial for several reasons. Network services are designed to perform specific tasks, many of which enable remote operations. It is important to have the knowledge and skills to communicate with other computers over the network, establish connections, transfer files, analyze network traffic, and configure these services effectively. This expertise allows us to identify potential vulnerabilities during penetration testing. Additionally, understanding the configuration options of each service enhances our overall comprehension of network security.

Consider a scenario where we are conducting a penetration test and encounter a Linux host being assessed for vulnerabilities. By monitoring network traffic, we observe that a user on this Linux host is connecting to another server via an unencrypted FTP server. Consequently, we are able to capture the user's credentials in plain text. This situation would be much less likely if the user were aware that FTP does not encrypt connections or the data transmitted. For a Linux administrator, this represents a critical oversight, as it not only exposes security weaknesses within the network but also reflects poorly on the administrators responsible for maintaining the network's security.

While it is not feasible to cover every network service, we will focus on the most important ones. This approach is beneficial not only for administrators and users, but also for penetration testers who need to understand the interactions between different hosts and their own systems.

<h3>SSH</h3>

Secure Shell (SSH) is a network protocol that allows the secure transmission of data and commands over a network. It is widely used to securely manage remote systems and securely access remote systems to execute commands or transfer files. In order to connect to our or a remote Linux host via SSH, a corresponding SSH server must be available and running.

The most commonly used SSH server is the OpenSSH server. OpenSSH is a free and open-source implementation of the Secure Shell (SSH) protocol that allows the secure transmission of data and commands over a network.

Administrators use OpenSSH to securely manage remote systems by establishing an encrypted connection to a remote host. With OpenSSH, administrators can execute commands on remote systems, securely transfer files, and establish a secure remote connection without the transmission of data and commands being intercepted by third parties.

<h3>Install OpenSSH</h3>

@htb[/htb]$ sudo apt install openssh-server -y

To check if the server is running, we can use the following command:

<h3>Server Status</h3>

@htb[/htb]$ systemctl status ssh

● ssh.service - OpenBSD Secure Shell server

Loaded: loaded (/lib/system/system/ssh.service; enabled; vendor preset: enabled)

Active: active (running) since Sun 2023-02-12 21:15:27 GMT; 1min 22s ago

Docs: man:sshd(8)

man:sshd_config(5)

Main PID: 7740 (sshd)

Tasks: 1 (limit: 9458)

Memory: 2.5M

CPU: 236ms

CGroup: /system.slice/ssh.service

└─7740 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

As penetration testers, we use OpenSSH to securely access remote systems when performing a network audit. To do this, we can use the following command:

<h3>SSH - Logging In</h3>

@htb[/htb]$ ssh cry0l1t3@10.129.17.122

The authenticity of host '10.129.17.122 (10.129.17.122)' can't be established.

ECDSA key fingerprint is SHA256:bKzhv+n2pYqr2r...Egf8LfqaHNxk.

Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

Warning: Permanently added '10.129.17.122' (ECDSA) to the list of known hosts.

cry0l1t3@10.129.17.122's password: \***\*\*\*\*\*\***

OpenSSH can be configured and customized by editing the file /etc/ssh/sshd_config with a text editor. Here we can adjust settings such as the maximum number of concurrent connections, the use of passwords or keys for logins, host key checking, and more. However, it is important for us to note that changes to the OpenSSH configuration file must be done carefully.

For example, we can use SSH to securely log in to a remote system and execute commands or use tunneling and port forwarding to tunnel data over an encrypted connection to verify network settings and other system settings without the possibility of third parties intercepting the transmission of data and commands.

<h3>NFS</h3>

Network File System (NFS) is a network protocol that allows us to store and manage files on remote systems as if they were stored on the local system. It enables easy and efficient management of files across networks. For example, administrators use NFS to store and manage files centrally (for Linux and Windows systems) to enable easy collaboration and management of data. For Linux, there are several NFS servers, including NFS-UTILS (Ubuntu), NFS-Ganesha (Solaris), and OpenNFS (Redhat Linux).

It can also be used to share and manage resources efficiently, e.g., to replicate file systems between servers. It also offers features such as access controls, real-time file transfer, and support for multiple users accessing data simultaneously. We can use this service just like FTP in case there is no FTP client installed on the target system, or NFS is running instead of FTP.

We can install NFS on Linux with the following command:

<h3>Install NFS</h3>

@htb[/htb]$ sudo apt install nfs-kernel-server -y

To check if the server is running, we can use the following command:

<h3>Server Status</h3>

@htb[/htb]$ systemctl status nfs-kernel-server

● nfs-server.service - NFS server and services

Loaded: loaded (/lib/system/system/nfs-server.service; enabled; vendor preset: enabled)

Active: active (exited) since Sun 2023-02-12 21:35:17 GMT; 13s ago

Process: 9234 ExecStartPre=/usr/sbin/exportfs -r (code=exited, status=0/SUCCESS)

Process: 9235 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS (code=exited, status=0/SUCCESS)

Main PID: 9235 (code=exited, status=0/SUCCESS)

CPU: 10ms
