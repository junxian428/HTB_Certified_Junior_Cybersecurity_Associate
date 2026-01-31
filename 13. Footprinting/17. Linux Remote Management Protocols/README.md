<h3>Linux Remote Management Protocols</h3>

In the world of Linux distributions, there are many ways to manage the servers remotely. For example, let us imagine that we are in one of many locations and one of our employees who just went to a customer in another city needs our help because of an error that he cannot solve. Efficient troubleshooting will look difficult over a phone call in most cases, so it is beneficial if we know how to log onto the remote system to manage it.

These applications and services can be found on almost every server in the public network. It is time-saving since we do not have to be physically present at the server, and the working environment still looks the same. These protocols and applications for remote systems management are an exciting target for these reasons. If the configuration is incorrect, we, as penetration testers, can even quickly gain access to the remote system. Therefore, we should familiarize ourselves with the most important protocols, servers, and applications for this purpose.

<h3>SSH</h3>

Secure Shell (SSH) enables two computers to establish an encrypted and direct connection within a possibly insecure network on the standard port TCP 22. This is necessary to prevent third parties from intercepting the data stream and thus intercepting sensitive data. The SSH server can also be configured to only allow connections from specific clients. An advantage of SSH is that the protocol runs on all common operating systems. Since it is originally a Unix application, it is also implemented natively on all Linux distributions and MacOS. SSH can also be used on Windows, provided we install an appropriate program. The well-known OpenBSD SSH (OpenSSH) server on Linux distributions is an open-source fork of the original and commercial SSH server from SSH Communication Security. Accordingly, there are two competing protocols: SSH-1 and SSH-2.

SSH-2, also known as SSH version 2, is a more advanced protocol than SSH version 1 in encryption, speed, stability, and security. For example, SSH-1 is vulnerable to MITM attacks, whereas SSH-2 is not.

We can imagine that we want to manage a remote host. This can be done via the command line or GUI. Besides, we can also use the SSH protocol to send commands to the desired system, transfer files, or do port forwarding. Therefore, we need to connect to it using the SSH protocol and authenticate ourselves to it. In total, OpenSSH has six different authentication methods:

1. Password authentication

2. Public-key authentication

3. Host-based authentication

4. Keyboard authentication

5. Challenge-response authentication

6. GSSAPI authentication

We will take a closer look at and discuss one of the most commonly used authentication methods. In addition, we can learn more about the other authentication methods here among others.

<h3>Public Key Authentication</h3>

In a first step, the SSH server and client authenticate themselves to each other. The server sends its public host key to the client, which the client uses to verify the server's identity. Only when contact is first established there is a risk of a third party interposing itself between the two participants and thus intercepting the connection. A host key cannot be imitated because it is a unique public-private key pair, and an attacker cannot forge the private key’s signature without access to it, assuming the client properly verifies the public key against a trusted source.

After server authentication, however, the client must also prove to the server that it has access authorization. However, the SSH server is already in possession of the encrypted hash value of the password set for the desired user. As a result, users have to enter the password every time they log on to another server during the same session. For this reason, an alternative option for client-side authentication is the use of a public key and private key pair.

The private key is created individually for the user's own computer and secured with a passphrase that should be longer than a typical password. The private key is stored exclusively on our own computer and always remains secret. If we want to establish an SSH connection, we first enter the passphrase and thus open access to the private key.

Public keys are also stored on the server. The server creates a cryptographic problem with the client's public key and sends it to the client. The client, in turn, decrypts the problem with its own private key, sends back the solution, and thus informs the server that it may establish a legitimate connection. During a session, users only need to enter the passphrase once to connect to any number of servers. At the end of the session, users log out of their local machines, ensuring that no third party who gains physical access to the local machine can connect to the server.

<h3>Default Configuration</h3>

The sshd_config file, responsible for the OpenSSH server, has only a few of the settings configured by default. However, the default configuration includes X11 forwarding, which contained a command injection vulnerability in version 7.2p1 of OpenSSH in 2016. Nevertheless, we do not need a GUI to manage our servers.

<h3>Default Configuration</h3>

@htb[/htb]$ cat /etc/ssh/sshd_config  | grep -v "#" | sed -r '/^\s*$/d'

Most settings in this configuration file are commented out and require manual configuration.

<h3>Dangerous Settings</h3>

Despite the SSH protocol being one of the most secure protocols available today, some misconfigurations can still make the SSH server vulnerable to easy-to-execute attacks. Let us take a look at the following settings:

<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>Setting</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>PasswordAuthentication yes</td>
      <td>Allows password-based authentication.</td>
    </tr>
    <tr>
      <td>PermitEmptyPasswords yes</td>
      <td>Allows the use of empty passwords.</td>
    </tr>
    <tr>
      <td>PermitRootLogin yes</td>
      <td>Allows to log in as the root user.</td>
    </tr>
    <tr>
      <td>Protocol 1</td>
      <td>Uses an outdated version of encryption.</td>
    </tr>
    <tr>
      <td>X11Forwarding yes</td>
      <td>Allows X11 forwarding for GUI applications.</td>
    </tr>
    <tr>
      <td>AllowTcpForwarding yes</td>
      <td>Allows forwarding of TCP ports.</td>
    </tr>
    <tr>
      <td>PermitTunnel</td>
      <td>Allows tunneling.</td>
    </tr>
    <tr>
      <td>DebianBanner yes</td>
      <td>Displays a specific banner when logging in.</td>
    </tr>
  </tbody>
</table>

Allowing password authentication allows us to brute-force a known username for possible passwords. Many different methods can be used to guess the passwords of users. For this purpose, specific patterns are usually used to mutate the most commonly used passwords and, frighteningly, correct them. This is because we humans are lazy and do not want to remember complex and complicated passwords. Therefore, we create passwords that we can easily remember, and this leads to the fact that, for example, numbers or characters are added only at the end of the password. Believing that the password is secure, the mentioned patterns are used to guess precisely such "adjustments" of these passwords. However, some instructions and hardening guides can be used to harden our SSH servers.

<h3>Footprinting the Service</h3>

One of the tools we can use to fingerprint the SSH server is ssh-audit. It checks the client-side and server-side configuration and shows some general information and which encryption algorithms are still used by the client and server. Of course, this could be exploited by attacking the server or client at the cryptic level later.

<h3>SSH-Audit</h3>

@htb[/htb]$ git clone https://github.com/jtesta/ssh-audit.git && cd ssh-audit

@htb[/htb]$ ./ssh-audit.py 10.129.14.132

The first thing we can see in the first few lines of the output is the banner that reveals the version of the OpenSSH server. The previous versions had some vulnerabilities, such as CVE-2020-14145, which allowed the attacker the capability to Man-In-The-Middle and attack the initial connection attempt. The detailed output of the connection setup with the OpenSSH server can also often provide important information, such as which authentication methods the server can use.

<h3>Change Authentication Method</h3>

@htb[/htb]$ ssh -v cry0l1t3@10.129.14.132

For potential brute-force attacks, we can specify the authentication method with the SSH client option PreferredAuthentications.

htb[/htb]$ ssh -v cry0l1t3@10.129.14.132 -o PreferredAuthentications=password

Even with this obvious and secure service, we recommend setting up our own OpenSSH server on our VM, experimenting with it, and familiarizing ourselves with the different settings and options.

We may encounter various banners for the SSH server during our penetration tests. By default, the banners start with the version of the protocol that can be applied and then the version of the server itself. For example, with SSH-1.99-OpenSSH_3.9p1, we know that we can use both protocol versions SSH-1 and SSH-2, and we are dealing with OpenSSH server version 3.9p1. On the other hand, for a banner with SSH-2.0-OpenSSH_8.2p1, we are dealing with an OpenSSH version 8.2p1 which only accepts the SSH-2 protocol version.

<h3>Rsync</h3>

Rsync is a fast and efficient tool for locally and remotely copying files. It can be used to copy files locally on a given machine and to/from remote hosts. It is highly versatile and well-known for its delta-transfer algorithm. This algorithm reduces the amount of data transmitted over the network when a version of the file already exists on the destination host. It does this by sending only the differences between the source files and the older version of the files that reside on the destination server. It is often used for backups and mirroring. It finds files that need to be transferred by looking at files that have changed in size or the last modified time. By default, it uses port 873 and can be configured to use SSH for secure file transfers by piggybacking on top of an established SSH server connection.

This guide covers some of the ways Rsync can be abused, most notably by listing the contents of a shared folder on a target server and retrieving files. This can sometimes be done without authentication. Other times we will need credentials. If you find credentials during a pentest and run into Rsync on an internal (or external) host, it is always worth checking for password re-use as you may be able to pull down some sensitive files that could be used to gain remote access to the target.

Let's do a bit of quick footprinting. We can see that Rsync is in use using protocol 31.

<h3>Scanning for Rsync</h3>

@htb[/htb]$ sudo nmap -sV -p 873 127.0.0.1

Starting Nmap 7.92 ( https://nmap.org ) at 2022-09-19 09:31 EDT

Nmap scan report for localhost (127.0.0.1)

<h3>Probing for Accessible Shares</h3>

We can next probe the service a bit to see what we can gain access to.

@htb[/htb]$ nc -nv 127.0.0.1 873

<h3>Enumerating an Open Share</h3>

Here we can see a share called dev, and we can enumerate it further.

@htb[/htb]$ rsync -av --list-only rsync://127.0.0.1/dev

From the above output, we can see a few interesting files that may be worth pulling down to investigate further. We can also see that a directory likely containing SSH keys is accessible. From here, we could sync all files to our attack host with the command rsync -av rsync://127.0.0.1/dev. If Rsync is configured to use SSH to transfer files, we could modify our commands to include the -e ssh flag, or -e "ssh -p2222" if a non-standard port is in use for SSH. This guide is helpful for understanding the syntax for using Rsync over SSH.

<h3>R-Services</h3>

R-Services are a suite of services hosted to enable remote access or issue commands between Unix hosts over TCP/IP. Initially developed by the Computer Systems Research Group (CSRG) at the University of California, Berkeley, r-services were the de facto standard for remote access between Unix operating systems until they were replaced by the Secure Shell (SSH) protocols and commands due to inherent security flaws built into them. Much like telnet, r-services transmit information from client to server(and vice versa.) over the network in an unencrypted format, making it possible for attackers to intercept network traffic (passwords, login information, etc.) by performing man-in-the-middle (MITM) attacks.

R-services span across the ports 512, 513, and 514 and are only accessible through a suite of programs known as r-commands. They are most commonly used by commercial operating systems such as Solaris, HP-UX, and AIX. While less common nowadays, we do run into them from time to time during our internal penetration tests so it is worth understanding how to approach them.

The R-commands suite consists of the following programs:

- rcp (remote copy)

- rexec (remote execution)

- rlogin (remote login)

- rsh (remote shell)

- rstat

- ruptime

- rwho (remote who)

Each command has its intended functionality; however, we will only cover the most commonly abused r-commands. The table below will provide a quick overview of the most frequently abused commands, including the service daemon they interact with, over what port and transport method to which they can be accessed, and a brief description of each.

<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>Command</th>
      <th>Service Daemon</th>
      <th>Port</th>
      <th>Transport Protocol</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>rcp</td>
      <td>rshd</td>
      <td>514</td>
      <td>TCP</td>
      <td>Copy a file or directory bidirectionally from the local system to the remote system (or vice versa) or from one remote system to another. It works like the cp command on Linux but provides no warning to the user for overwriting existing files on a system.</td>
    </tr>
    <tr>
      <td>rsh</td>
      <td>rshd</td>
      <td>514</td>
      <td>TCP</td>
      <td>Opens a shell on a remote machine without a login procedure. Relies upon the trusted entries in the /etc/hosts.equiv and .rhosts files for validation.</td>
    </tr>
    <tr>
      <td>rexec</td>
      <td>rexecd</td>
      <td>512</td>
      <td>TCP</td>
      <td>Enables a user to run shell commands on a remote machine. Requires authentication through the use of a username and password through an unencrypted network socket. Authentication is overridden by the trusted entries in the /etc/hosts.equiv and .rhosts files.</td>
    </tr>
    <tr>
      <td>rlogin</td>
      <td>rlogind</td>
      <td>513</td>
      <td>TCP</td>
      <td>Enables a user to log in to a remote host over the network. It works similarly to telnet but can only connect to Unix-like hosts. Authentication is overridden by the trusted entries in the /etc/hosts.equiv and .rhosts files.</td>
    </tr>
  </tbody>
</table>

The /etc/hosts.equiv file contains a list of trusted hosts and is used to grant access to other systems on the network. When users on one of these hosts attempt to access the system, they are automatically granted access without further authentication.

<h3>/etc/hosts.equiv</h3>

@htb[/htb]$ cat /etc/hosts.equiv

# <hostname> <local username>

pwnbox cry0l1t3

Now that we have a basic understanding of r-commands, let's do some quick footprinting using Nmap to determine if all necessary ports are open.

<h3>Scanning for R-Services</h3>

@htb[/htb]$ sudo nmap -sV -p 512,513,514 10.0.17.2

Starting Nmap 7.80 ( https://nmap.org ) at 2022-12-02 15:02 EST

Nmap scan report for 10.0.17.2

<h3>Access Control & Trusted Relationships</h3>

The primary concern for r-services, and one of the primary reasons SSH was introduced to replace it, is the inherent issues regarding access control for these protocols. R-services rely on trusted information sent from the remote client to the host machine they are attempting to authenticate to. By default, these services utilize Pluggable Authentication Modules (PAM) for user authentication onto a remote system; however, they also bypass this authentication through the use of the /etc/hosts.equiv and .rhosts files on the system. The hosts.equiv and .rhosts files contain a list of hosts (IPs or Hostnames) and users that are trusted by the local host when a connection attempt is made using r-commands. Entries in either file can appear like the following:

Note: The hosts.equiv file is recognized as the global configuration regarding all users on a system, whereas .rhosts provides a per-user configuration.

<h3>Sample .rhosts File</h3>

@htb[/htb]$ cat .rhosts

As we can see from this example, both files follow the specific syntax of <username> <ip address> or <username> <hostname> pairs. Additionally, the + modifier can be used within these files as a wildcard to specify anything. In this example, the + modifier allows any external user to access r-commands from the htb-student user account via the host with the IP address 10.0.17.10.

Misconfigurations in either of these files can allow an attacker to authenticate as another user without credentials, with the potential for gaining code execution. Now that we understand how we can potentially abuse misconfigurations in these files let's attempt to try logging into a target host using rlogin.

<h3>Logging in Using Rlogin</h3>

@htb[/htb]$ rlogin 10.0.17.2 -l htb-student

Last login: Fri Dec  2 16:11:21 from localhost

[htb-student@localhost ~]$

We have successfully logged in under the htb-student account on the remote host due to the misconfigurations in the .rhosts file. Once successfully logged in, we can also abuse the rwho command to list all interactive sessions on the local network by sending requests to the UDP port 513.

<h3>Listing Authenticated Users Using Rwho</h3>

@htb[/htb]$ rwho

root     web01:pts/0 Dec  2 21:34

htb-student     workstn01:tty1  Dec  2 19:57  2:25   

From this information, we can see that the htb-student user is currently authenticated to the workstn01 host, whereas the root user is authenticated to the web01 host. We can use this to our advantage when scoping out potential usernames to use during further attacks on hosts over the network. However, the rwho daemon periodically broadcasts information about logged-on users, so it might be beneficial to watch the network traffic.

<h3>Listing Authenticated Users Using Rusers</h3>

To provide additional information in conjunction with rwho, we can issue the rusers command. This will give us a more detailed account of all logged-in users over the network, including information such as the username, hostname of the accessed machine, TTY that the user is logged in to, the date and time the user logged in, the amount of time since the user typed on the keyboard, and the remote host they logged in from (if applicable).

@htb[/htb]$ rusers -al 10.0.17.5

htb-student     10.0.17.5:console          Dec 2 19:57     2:25

As we can see, R-services are less frequently used nowadays due to their inherent security flaws and the availability of more secure protocols such as SSH. To be a well-rounded information security professional, we must have a broad and deep understanding of many systems, applications, protocols, etc. So, file away this knowledge about R-services because you never know when you may encounter them.

<h3>Final Thoughts</h3>

Remote management services can provide us with a treasure trove of data and often be abused for unauthorized access through either weak/default credentials or password re-use. We should always probe these services for as much information as we can gather and leave no stone unturned, especially when we have compiled a list of credentials from elsewhere in the target network.

