<h3>FTP</h3>

The File Transfer Protocol (FTP) is one of the oldest protocols on the Internet. The FTP runs within the application layer of the TCP/IP protocol stack. Thus, it is on the same layer as HTTP or POP. These protocols also work with the support of browsers or email clients to perform their services. There are also special FTP programs for the File Transfer Protocol.

Let us imagine that we want to upload local files to a server and download other files using the FTP protocol. In an FTP connection, two channels are opened. First, the client and server establish a control channel through TCP port 21. The client sends commands to the server, and the server returns status codes. Then both communication participants can establish the data channel via TCP port 20. This channel is used exclusively for data transmission, and the protocol watches for errors during this process. If a connection is broken off during transmission, the transport can be resumed after re-established contact.

A distinction is made between active and passive FTP. In the active variant, the client establishes the connection as described via TCP port 21 and thus informs the server via which client-side port the server can transmit its responses. However, if a firewall protects the client, the server cannot reply because all external connections are blocked. For this purpose, the passive mode has been developed. Here, the server announces a port through which the client can establish the data channel. Since the client initiates the connection in this method, the firewall does not block the transfer.

The FTP knows different commands and status codes. Not all of these commands are consistently implemented on the server. For example, the client-side instructs the server-side to upload or download files, organize directories or delete files. The server responds in each case with a status code that indicates whether the command was successfully implemented. A list of possible status codes can be found here.

Usually, we need credentials to use FTP on a server. We also need to know that FTP is a clear-text protocol that can sometimes be sniffed if conditions on the network are right. However, there is also the possibility that a server offers anonymous FTP. The server operator then allows any user to upload or download files via FTP without using a password. Since there are security risks associated with such a public FTP server, the options for users are usually limited.

<h3>TFTP</h3>

Trivial File Transfer Protocol (TFTP) is simpler than FTP and performs file transfers between client and server processes. However, it does not provide user authentication and other valuable features supported by FTP. In addition, while FTP uses TCP, TFTP uses UDP, making it an unreliable protocol and causing it to use UDP-assisted application layer recovery.

This is reflected, for example, in the fact that TFTP, unlike FTP, does not require the user's authentication. It does not support protected login via passwords and sets limits on access based solely on the read and write permissions of a file in the operating system. Practically, this leads to TFTP operating exclusively in directories and with files that have been shared with all users and can be read and written globally. Because of the lack of security, TFTP, unlike FTP, may only be used in local and protected networks.

Let us take a look at a few commands of TFTP:

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>connect</td>
      <td>Sets the remote host, and optionally the port, for file transfers.</td>
    </tr>
    <tr>
      <td>get</td>
      <td>Transfers a file or set of files from the remote host to the local host.</td>
    </tr>
    <tr>
      <td>put</td>
      <td>Transfers a file or set of files from the local host onto the remote host.</td>
    </tr>
    <tr>
      <td>quit</td>
      <td>Exits tftp.</td>
    </tr>
    <tr>
      <td>status</td>
      <td>Shows the current status of tftp, including the current transfer mode (ascii or binary), connection status, time-out value, and more.</td>
    </tr>
    <tr>
      <td>verbose</td>
      <td>Turns verbose mode on or off, allowing additional information to appear during file transfer.</td>
    </tr>
  </tbody>
</table>

Unlike the FTP client, TFTP does not have directory listing functionality.

<h3>Default Configuration</h3>

One of the most used FTP servers on Linux-based distributions is vsFTPd. The default configuration of vsFTPd can be found in /etc/vsftpd.conf, and some settings are already predefined by default. It is highly recommended to install the vsFTPd server on a VM and have a closer look at this configuration.

<h3>Install vsFTPd</h3>

@htb[/htb]$ sudo apt install vsftpd

The vsFTPd server is only one of a few FTP servers available to us. There are many different alternatives to it, which also bring, among other things, many more functions and configuration options with them. We will use the vsFTPd server because it is an excellent way to show the configuration possibilities of an FTP server in a simple and easy-to-understand way without going into the details of the man pages. If we look at the configuration file of vsFTPd, we will see many options and settings that are either commented or commented out. However, the configuration file does not contain all possible settings that can be made. The existing and missing ones can be found on the man page.

@htb[/htb]$ cat /etc/vsftpd.conf | grep -v "#"

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Setting</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>listen=NO</td>
      <td>Run from inetd or as a standalone daemon?</td>
    </tr>
    <tr>
      <td>listen_ipv6=YES</td>
      <td>Listen on IPv6?</td>
    </tr>
    <tr>
      <td>anonymous_enable=NO</td>
      <td>Enable anonymous access?</td>
    </tr>
    <tr>
      <td>local_enable=YES</td>
      <td>Allow local users to login?</td>
    </tr>
    <tr>
      <td>dirmessage_enable=YES</td>
      <td>Display active directory messages when users enter certain directories.</td>
    </tr>
    <tr>
      <td>use_localtime=YES</td>
      <td>Use local time?</td>
    </tr>
    <tr>
      <td>xferlog_enable=YES</td>
      <td>Activate logging of uploads/downloads?</td>
    </tr>
    <tr>
      <td>connect_from_port_20=YES</td>
      <td>Connect from port 20?</td>
    </tr>
    <tr>
      <td>secure_chroot_dir=/var/run/vsftpd/empty</td>
      <td>Name of an empty directory used for secure chroot.</td>
    </tr>
    <tr>
      <td>pam_service_name=vsftpd</td>
      <td>Name of the PAM service that vsftpd will use.</td>
    </tr>
    <tr>
      <td>rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem</td>
      <td>Location of the RSA certificate for SSL encrypted connections.</td>
    </tr>
    <tr>
      <td>rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key</td>
      <td>Location of the RSA private key.</td>
    </tr>
    <tr>
      <td>ssl_enable=NO</td>
      <td>Enable SSL?</td>
    </tr>
  </tbody>
</table>

In addition, there is a file called /etc/ftpusers that we also need to pay attention to, as this file is used to deny certain users access to the FTP service. In the following example, the users guest, john, and kevin are not permitted to log in to the FTP service, even if they exist on the Linux system.

<h3>FTPUSERS</h3>

@htb[/htb]$ cat /etc/ftpusers

guest

john

kevin

<h3>Dangerous Settings</h3>

There are many different security-related settings we can make on each FTP server. These can have various purposes, such as testing connections through the firewalls, testing routes, and authentication mechanisms. One of these authentication mechanisms is the anonymous user. This is often used to allow everyone on the internal network to share files and data without accessing each other's computers. With vsFTPd, the optional settings that can be added to the configuration file for the anonymous login look like this:

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Setting</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>anonymous_enable=YES</td>
      <td>Allowing anonymous login?</td>
    </tr>
    <tr>
      <td>anon_upload_enable=YES</td>
      <td>Allowing anonymous users to upload files?</td>
    </tr>
    <tr>
      <td>anon_mkdir_write_enable=YES</td>
      <td>Allowing anonymous users to create new directories?</td>
    </tr>
    <tr>
      <td>no_anon_password=YES</td>
      <td>Do not ask anonymous users for a password?</td>
    </tr>
    <tr>
      <td>anon_root=/home/username/ftp</td>
      <td>Directory assigned as the root location for anonymous users.</td>
    </tr>
    <tr>
      <td>write_enable=YES</td>
      <td>Allow FTP write-related commands such as STOR, DELE, RNFR, RNTO, MKD, RMD, APPE, and SITE?</td>
    </tr>
  </tbody>
</table>

With the standard FTP client (ftp), we can access the FTP server accordingly and log in with the anonymous user if the settings shown above have been used. The use of the anonymous account can occur in internal environments and infrastructures where the participants are all known. Access to this type of service can be set temporarily or with the setting to accelerate the exchange of files.

As soon as we connect to the vsFTPd server, the response code 220 is displayed with the banner of the FTP server. Often this banner contains the description of the service and even the version of it. It also tells us what type of system the FTP server is. One of the most common configurations of FTP servers is to allow anonymous access, which does not require legitimate credentials but provides access to some files. Even if we cannot download them, sometimes just listing the contents is enough to generate further ideas and note down information that will help us in another approach.

<h3>Anonymous Login</h3>

@htb[/htb]$ ftp 10.129.14.136

However, to get the first overview of the server's settings, we can use the following command:

<h3>vsFTPd Status</h3>

ftp> status

Connected to 10.129.14.136.

Some commands should be used occasionally, as these will make the server show us more information that we can use for our purposes. These commands include debug and trace.

<h3>vsFTPd Detailed Output</h3>

ftp> debug

Debugging on (debug=1).

ftp> trace

Packet tracing on.

ftp> ls

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Setting</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>dirmessage_enable=YES</td>
      <td>Show a message when users first enter a new directory?</td>
    </tr>
    <tr>
      <td>chown_uploads=YES</td>
      <td>Change ownership of anonymously uploaded files?</td>
    </tr>
    <tr>
      <td>chown_username=username</td>
      <td>User who is assigned ownership of anonymously uploaded files.</td>
    </tr>
    <tr>
      <td>local_enable=YES</td>
      <td>Enable local users to log in?</td>
    </tr>
    <tr>
      <td>chroot_local_user=YES</td>
      <td>Place local users inside their home directory?</td>
    </tr>
    <tr>
      <td>chroot_list_enable=YES</td>
      <td>Use a list of local users who will be placed in their home directory?</td>
    </tr>
  </tbody>
</table>

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Setting</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>hide_ids=YES</td>
      <td>All user and group information in directory listings will be shown as "ftp".</td>
    </tr>
    <tr>
      <td>ls_recurse_enable=YES</td>
      <td>Allows the use of recursive directory listings.</td>
    </tr>
  </tbody>
</table>

In the following example, we can see that if the hide_ids=YES setting is present, the UID and GUID representation of the service will be overwritten, making it more difficult for us to identify with which rights these files are written and uploaded.

<h3>Hiding IDs - YES</h3>

ftp> ls

---> TYPE A

This setting is a security feature to prevent local usernames from being revealed. With the usernames, we could attack the services like FTP and SSH and many others with a brute-force attack in theory. However, in reality, fail2ban solutions are now a standard implementation of any infrastructure that logs the IP address and blocks all access to the infrastructure after a certain number of failed login attempts.

Another helpful setting we can use for our purposes is the ls_recurse_enable=YES. This is often set on the vsFTPd server to have a better overview of the FTP directory structure, as it allows us to see all the visible content at once.

<h3>Recursive Listing</h3>

ftp> ls -R

---> PORT 10,10,14,4,222,149

200 PORT command successful. Consider using PASV.

---> LIST -R

150 Here comes the directory listing.

Downloading files from such an FTP server is one of the main features, as well as uploading files created by us. This allows us, for example, to use LFI vulnerabilities to make the host execute system commands. Apart from the files, we can view, download and inspect. Attacks are also possible with the FTP logs, leading to Remote Command Execution (RCE). This applies to the FTP services and all those we can detect during our enumeration phase.

<h3>Download a File</h3>

ftp> ls

200 PORT command successful. Consider using PASV.

@htb[/htb]$ ls | grep Notes.txt

'Important Notes.txt'

We also can download all the files and folders we have access to at once. This is especially useful if the FTP server has many different files in a larger folder structure. However, this can cause alarms because no one from the company usually wants to download all files and content all at once.

<h3>Download All Available Files</h3>

@htb[/htb]$ wget -m --no-passive ftp://anonymous:anonymous@10.129.14.136

--2021-09-19 14:45:58-- ftp://anonymous:_password_@10.129.14.136/

Once we have downloaded all the files, wget will create a directory with the name of the IP address of our target. All downloaded files are stored there, which we can then inspect locally.

@htb[/htb]$ tree .

.
└── 10.129.14.136

Next, we can check if we have the permissions to upload files to the FTP server. Especially with web servers, it is common that files are synchronized, and the developers have quick access to the files. FTP is often used for this purpose, and most of the time, configuration errors are found on servers that the administrators think are not discoverable. The attitude that internal network components cannot be accessed from the outside means that the hardening of internal systems is often neglected and leads to misconfigurations.

The ability to upload files to the FTP server connected to a web server increases the likelihood of gaining direct access to the webserver and even a reverse shell that allows us to execute internal system commands and perhaps even escalate our privileges.

<h3>Upload a File</h3>

@htb[/htb]$ touch testupload.txt

With the PUT command, we can upload files in the current folder to the FTP server.

ftp> put testupload.txt

local: testupload.txt remote: testupload.txt

---> PORT 10,10,14,4,184,33

<h3>Footprinting the Service</h3>

Footprinting using various network scanners is also a handy and widespread approach. These tools make it easier for us to identify different services, even if they are not accessible on standard ports. One of the most widely used tools for this purpose is Nmap. Nmap also brings the Nmap Scripting Engine (NSE), a set of many different scripts written for specific services. More information on the capabilities of Nmap and NSE can be found in the Network Enumeration with Nmap module. We can update this database of NSE scripts with the command shown.

<h3>Nmap FTP Scripts</h3>

@htb[/htb]$ sudo nmap --script-updatedb

Starting Nmap 7.80 ( https://nmap.org ) at 2021-09-19 13:49 CEST

All the NSE scripts are located on the Pwnbox in /usr/share/nmap/scripts/, but on our systems, we can find them using a simple command.

@htb[/htb]$ find / -type f -name ftp\* 2>/dev/null | grep scripts

/usr/share/nmap/scripts/ftp-syst.nse

/usr/share/nmap/scripts/ftp-vsftpd-backdoor.nse

/usr/share/nmap/scripts/ftp-vuln-cve2010-4221.nse

/usr/share/nmap/scripts/ftp-proftpd-backdoor.nse

/usr/share/nmap/scripts/ftp-bounce.nse

/usr/share/nmap/scripts/ftp-libopie.nse

/usr/share/nmap/scripts/ftp-anon.nse

/usr/share/nmap/scripts/ftp-brute.nse

As we already know, the FTP server usually runs on the standard TCP port 21, which we can scan using Nmap. We also use the version scan (-sV), aggressive scan (-A), and the default script scan (-sC) against our target 10.129.14.136.

<h3>Nmap</h3>

@htb[/htb]$ sudo nmap -sV -p21 -sC -A 10.129.14.136

Starting Nmap 7.80 ( https://nmap.org ) at 2021-09-16 18:12 CEST

The default script scan is based on the services' fingerprints, responses, and standard ports. Once Nmap has detected the service, it executes the marked scripts one after the other, providing different information. For example, the ftp-anon NSE script checks whether the FTP server allows anonymous access. If so, the contents of the FTP root directory are rendered for the anonymous user.

The ftp-syst, for example, executes the STAT command, which displays information about the FTP server status. This includes configurations as well as the version of the FTP server. Nmap also provides the ability to trace the progress of NSE scripts at the network level if we use the --script-trace option in our scans. This lets us see what commands Nmap sends, what ports are used, and what responses we receive from the scanned server.

<h3>Nmap Script Trace</h3>

@htb[/htb]$ sudo nmap -sV -p21 -sC -A 10.129.14.136 --script-trace

The scan history shows that four different parallel scans are running against the service, with various timeouts. For the NSE scripts, we see that our local machine uses other output ports (54226, 54228, 54230, 54232) and first initiates the connection with the CONNECT command. From the first response from the server, we can see that we are receiving the banner from the server to our second NSE script (54228) from the target FTP server. If necessary, we can, of course, use other applications such as netcat or telnet to interact with the FTP server.

<h3>Service Interaction</h3>

@htb[/htb]$ nc -nv 10.129.14.136 21

@htb[/htb]$ telnet 10.129.14.136 21

It looks slightly different if the FTP server runs with TLS/SSL encryption. Because then we need a client that can handle TLS/SSL. For this, we can use the client openssl and communicate with the FTP server. The good thing about using openssl is that we can see the SSL certificate, which can also be helpful.

@htb[/htb]$ openssl s_client -connect 10.129.14.136:21 -starttls ftp

This is because the SSL certificate allows us to recognize the hostname, for example, and in most cases also an email address for the organization or company. In addition, if the company has several locations worldwide, certificates can also be created for specific locations, which can also be identified using the SSL certificate.

Which version of the FTP server is running on the target system? Submit the entire banner as the answer.

InFreight FTP v1.1

- 0 Enumerate the FTP server and find the flag.txt file. Submit the contents of it as the answer.

  HTB{b7skjr4c76zhsds7fzhd4k3ujg7nhdjre}
