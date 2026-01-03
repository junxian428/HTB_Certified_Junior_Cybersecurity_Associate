<h3>SMB</h3>

Server Message Block (SMB) is a client-server protocol that regulates access to files and entire directories and other network resources such as printers, routers, or interfaces released for the network. Information exchange between different system processes can also be handled based on the SMB protocol. SMB first became available to a broader public, for example, as part of the OS/2 network operating system LAN Manager and LAN Server. Since then, the main application area of the protocol has been the Windows operating system series in particular, whose network services support SMB in a downward-compatible manner - which means that devices with newer editions can easily communicate with devices that have an older Microsoft operating system installed. With the free software project Samba, there is also a solution that enables the use of SMB in Linux and Unix distributions and thus cross-platform communication via SMB.

The SMB protocol enables the client to communicate with other participants in the same network to access files or services shared with it on the network. The other system must also have implemented the network protocol and received and processed the client request using an SMB server application. Before that, however, both parties must establish a connection, which is why they first exchange corresponding messages.

In IP networks, SMB uses TCP protocol for this purpose, which provides for a three-way handshake between client and server before a connection is finally established. The specifications of the TCP protocol also govern the subsequent transport of data. We can take a look at some examples here.

An SMB server can provide arbitrary parts of its local file system as shares. Therefore the hierarchy visible to a client is partially independent of the structure on the server. Access rights are defined by Access Control Lists (ACL). They can be controlled in a fine-grained manner based on attributes such as execute, read, and full access for individual users or user groups. The ACLs are defined based on the shares and therefore do not correspond to the rights assigned locally on the server.

<h3>Samba</h3>

As mentioned earlier, there is an alternative implementation of the SMB server called Samba, which is developed for Unix-based operating systems. Samba implements the Common Internet File System (CIFS) network protocol. CIFS is a dialect of SMB, meaning it is a specific implementation of the SMB protocol originally created by Microsoft. This allows Samba to communicate effectively with newer Windows systems. Therefore, it is often referred to as SMB/CIFS.

However, CIFS is considered a specific version of the SMB protocol, primarily aligning with SMB version 1. When SMB commands are transmitted over Samba to an older NetBIOS service, connections typically occur over TCP ports 137, 138, and 139. In contrast, CIFS operates over TCP port 445 exclusively. There are several versions of SMB, including newer versions like SMB 2 and SMB 3, which offer improvements and are preferred in modern infrastructures, while older versions like SMB 1 (CIFS) are considered outdated but may still be used in specific environments.

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>SMB Version</th>
      <th>Supported</th>
      <th>Features</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>CIFS</td>
      <td>Windows NT 4.0</td>
      <td>Communication via NetBIOS interface</td>
    </tr>
    <tr>
      <td>SMB 1.0</td>
      <td>Windows 2000</td>
      <td>Direct connection via TCP</td>
    </tr>
    <tr>
      <td>SMB 2.0</td>
      <td>Windows Vista, Windows Server 2008</td>
      <td>Performance upgrades, improved message signing, caching feature</td>
    </tr>
    <tr>
      <td>SMB 2.1</td>
      <td>Windows 7, Windows Server 2008 R2</td>
      <td>Locking mechanisms</td>
    </tr>
    <tr>
      <td>SMB 3.0</td>
      <td>Windows 8, Windows Server 2012</td>
      <td>Multichannel connections, end-to-end encryption, remote storage access</td>
    </tr>
    <tr>
      <td>SMB 3.0.2</td>
      <td>Windows 8.1, Windows Server 2012 R2</td>
      <td>-</td>
    </tr>
    <tr>
      <td>SMB 3.1.1</td>
      <td>Windows 10, Windows Server 2016</td>
      <td>Integrity checking, AES-128 encryption</td>
    </tr>
  </tbody>
</table>

With version 3, the Samba server gained the ability to be a full member of an Active Directory domain. With version 4, Samba even provides an Active Directory domain controller. It contains several so-called daemons for this purpose - which are Unix background programs. The SMB server daemon (smbd) belonging to Samba provides the first two functionalities, while the NetBIOS message block daemon (nmbd) implements the last two functionalities. The SMB service controls these two background programs.

We know that Samba is suitable for both Linux and Windows systems. In a network, each host participates in the same workgroup. A workgroup is a group name that identifies an arbitrary collection of computers and their resources on an SMB network. There can be multiple workgroups on the network at any given time. IBM developed an application programming interface (API) for networking computers called the Network Basic Input/Output System (NetBIOS). The NetBIOS API provided a blueprint for an application to connect and share data with other computers. In a NetBIOS environment, when a machine goes online, it needs a name, which is done through the so-called name registration procedure. Either each host reserves its hostname on the network, or the NetBIOS Name Server (NBNS) is used for this purpose. It also has been enhanced to Windows Internet Name Service (WINS).

<h3>Default Configuration</h3>

As we can imagine, Samba offers a wide range of settings that we can configure. Again, we define the settings via a text file where we can get an overview of some of the settings. These settings look like the following when filtered out:

<h3>Default Configuration</h3>

@htb[/htb]$ cat /etc/samba/smb.conf | grep -v "#\|\;"

We see global settings and two shares that are intended for printers. The global settings are the configuration of the available SMB server that is used for all shares. In the individual shares, however, the global settings can be overwritten, which can be configured with high probability even incorrectly. Let us look at some of the settings to understand how the shares are configured in Samba.

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Setting</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[sharename]</td>
      <td>The name of the network share.</td>
    </tr>
    <tr>
      <td>workgroup = WORKGROUP/DOMAIN</td>
      <td>Workgroup that will appear when clients query.</td>
    </tr>
    <tr>
      <td>path = /path/here/</td>
      <td>The directory to which user is to be given access.</td>
    </tr>
    <tr>
      <td>server string = STRING</td>
      <td>The string that will show up when a connection is initiated.</td>
    </tr>
    <tr>
      <td>unix password sync = yes</td>
      <td>Synchronize the UNIX password with the SMB password?</td>
    </tr>
    <tr>
      <td>usershare allow guests = yes</td>
      <td>Allow non-authenticated users to access defined share?</td>
    </tr>
    <tr>
      <td>map to guest = bad user</td>
      <td>Action taken when a user login request does not match a valid UNIX user.</td>
    </tr>
    <tr>
      <td>browseable = yes</td>
      <td>Should this share be shown in the list of available shares?</td>
    </tr>
    <tr>
      <td>guest ok = yes</td>
      <td>Allow connecting to the service without using a password?</td>
    </tr>
    <tr>
      <td>read only = yes</td>
      <td>Allow users to read files only?</td>
    </tr>
    <tr>
      <td>create mask = 0700</td>
      <td>Permissions set for newly created files.</td>
    </tr>
  </tbody>
</table>

<h3>Dangerous Settings</h3>

Some of the above settings already bring some sensitive options. However, suppose we question the settings listed below and ask ourselves what the employees could gain from them, as well as attackers. In that case, we will see what advantages and disadvantages the settings bring with them. Let us take the setting browseable = yes as an example. If we as administrators adopt this setting, the company's employees will have the comfort of being able to look at the individual folders with the contents. Many folders are eventually used for better organization and structure. If the employee can browse through the shares, the attacker will also be able to do so after successful access.

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Setting</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>browseable = yes</td>
      <td>Allow listing available shares in the current share?</td>
    </tr>
    <tr>
      <td>read only = no</td>
      <td>Forbid the creation and modification of files?</td>
    </tr>
    <tr>
      <td>writable = yes</td>
      <td>Allow users to create and modify files?</td>
    </tr>
    <tr>
      <td>guest ok = yes</td>
      <td>Allow connecting to the service without using a password?</td>
    </tr>
    <tr>
      <td>enable privileges = yes</td>
      <td>Honor privileges assigned to specific SID?</td>
    </tr>
    <tr>
      <td>create mask = 0777</td>
      <td>Permissions assigned to newly created files.</td>
    </tr>
    <tr>
      <td>directory mask = 0777</td>
      <td>Permissions assigned to newly created directories.</td>
    </tr>
    <tr>
      <td>logon script = script.sh</td>
      <td>Script executed on the user's login.</td>
    </tr>
    <tr>
      <td>magic script = script.sh</td>
      <td>Script executed when the script file is closed.</td>
    </tr>
    <tr>
      <td>magic output = script.out</td>
      <td>Location where the output of the magic script is stored.</td>
    </tr>
  </tbody>
</table>

Let us create a share called [notes] and a few others and see how the settings affect our enumeration process. We will use all of the above settings and apply them to this share. For example, this setting is often applied, if only for testing purposes. If it is then an internal subnet of a small team in a large department, this setting is often retained or forgotten to be reset. This leads to the fact that we can browse through all the shares and, with high probability, even download and inspect them.

<h3>Example Share</h3>

...SNIP...

[notes]

comment = CheckIT

path = /mnt/notes/

    browseable = yes

    read only = no

    writable = yes

    guest ok = yes

    enable privileges = yes

    create mask = 0777

    directory mask = 0777

It is highly recommended to look at the man pages for Samba and configure it ourselves and experiment with the settings. We will then discover potential aspects that will be interesting for us as a penetration tester. In addition, the more familiar we become with the Samba server and SMB, the easier it will be to find our way around the environment and use it for our purposes. Once we have adjusted /etc/samba/smb.conf to our needs, we have to restart the service on the server.

<h3>Restart Samba</h3>

root@samba:~# sudo systemctl restart smbd

Now we can display a list (-L) of the server's shares with the smbclient command from our host. We use the so-called null session (-N), which is anonymous access without the input of existing users or valid passwords.

<h3>SMBclient - Connecting to the Share</h3>

@htb[/htb]$ smbclient -N -L //10.129.14.128

        Sharename       Type      Comment

        ---------       ----      -------

        print$          Disk      Printer Drivers

        home            Disk      INFREIGHT Samba

        dev             Disk      DEVenv

        notes           Disk      CheckIT

        IPC$            IPC       IPC Service (DEVSM)

SMB1 disabled -- no workgroup available

We can see that we now have five different shares on the Samba server from the result. Thereby print$ and an IPC$ are already included by default in the basic setting, as we have already seen. Since we deal with the [notes] share, let us log in and inspect it using the same client program. If we are not familiar with the client program, we can use the help command on successful login, listing all the possible commands we can execute.

@htb[/htb]$ smbclient //10.129.14.128/notes

Enter WORKGROUP\<username>'s password:

Anonymous login successful

Try "help" to get a list of possible commands.

Once we have discovered interesting files or folders, we can download them using the get command. Smbclient also allows us to execute local system commands using an exclamation mark at the beginning (!<cmd>) without interrupting the connection.


<h3>Download Files from SMB</h3>

smb: \> get prep-prod.txt 

smb: \> !ls

From the administrative point of view, we can check these connections using smbstatus. Apart from the Samba version, we can also see who, from which host, and which share the client is connected. This is especially important once we have entered a subnet (perhaps even an isolated one) that the others can still access.

For example, with domain-level security, the samba server acts as a member of a Windows domain. Each domain has at least one domain controller, usually a Windows NT server providing password authentication. This domain controller provides the workgroup with a definitive password server. The domain controllers keep track of users and passwords in their own NTDS.dit and Security Authentication Module (SAM) and authenticate each user when they log in for the first time and wish to access another machine's share.

<h3>Samba Status</h3>

root@samba:~# smbstatus

<h3>Footprinting the Service</h3>

Let us go back to one of our enumeration tools. Nmap also has many options and NSE scripts that can help us examine the target's SMB service more closely and get more information. The downside, however, is that these scans can take a long time. Therefore, it is also recommended to look at the service manually, mainly because we can find much more details than Nmap could show us. First, however, let us see what Nmap can find on our target Samba server, where we created the [notes] share for testing purposes.

<h3>Nmap</h3>

@htb[/htb]$ sudo nmap 10.129.14.128 -sV -sC -p139,445

We can see from the results that it is not very much that Nmap provided us with here. Therefore, we should resort to other tools that allow us to interact manually with the SMB and send specific requests for the information. One of the handy tools for this is rpcclient. This is a tool to perform MS-RPC functions.

The Remote Procedure Call (RPC) is a concept and, therefore, also a central tool to realize operational and work-sharing structures in networks and client-server architectures. The communication process via RPC includes passing parameters and the return of a function value.

@htb[/htb]$ rpcclient -U "" 10.129.14.128

Enter WORKGROUP\'s password:

rpcclient $> 

The rpcclient offers us many different requests with which we can execute specific functions on the SMB server to get information. A complete list of all these functions can be found on the man page of the rpcclient.

Query	Description

srvinfo	Server information.

enumdomains	Enumerate all domains that are deployed in the network.

querydominfo	Provides domain, server, and user information of deployed domains.

netshareenumall	Enumerates all available shares.

netsharegetinfo <share>	Provides information about a specific share.

enumdomusers	Enumerates all domain users.

queryuser <RID>	Provides information about a specific user.

<h3>RPCclient - Enumeration</h3>

rpcclient $> srvinfo

rpcclient $> enumdomains

rpcclient $> querydominfo

rpcclient $> netshareenumall

rpcclient $> netsharegetinfo notes

These examples show us what information can be leaked to anonymous users. Once an anonymous user has access to a network service, it only takes one mistake to give them too many permissions or too much visibility to put the entire network at significant risk.

Most importantly, anonymous access to such services can also lead to the discovery of other users, who can be attacked with brute-forcing in the most aggressive case. Humans are more error-prone than properly configured computer processes, and the lack of security awareness and laziness often leads to weak passwords that can be easily cracked. Let us see how we can enumerate users using the rpcclient.

<h3>Rpcclient - User Enumeration</h3>

rpcclient $> enumdomusers

rpcclient $> queryuser 0x3e9

rpcclient $> queryuser 0x3e8


We can then use the results to identify the group's RID, which we can then use to retrieve information from the entire group.

<h3>Rpcclient - Group Information</h3>

rpcclient $> querygroup 0x201


However, it can also happen that not all commands are available to us, and we have certain restrictions based on the user. However, the query queryuser <RID> is mostly allowed based on the RID. So we can use the rpcclient to brute force the RIDs to get information. Because we may not know who has been assigned which RID, we know that we will get information about it as soon as we query an assigned RID. There are several ways and tools we can use for this. To stay with the tool, we can create a For-loop using Bash where we send a command to the service using rpcclient and filter out the results.

<h3>Brute Forcing User RIDs</h3>

@htb[/htb]$ for i in $(seq 500 1100);do rpcclient -N -U "" 10.129.14.128 -c "queryuser 0x$(printf '%x\n' $i)" | grep "User Name\|user_rid\|group_rid" && echo "";done

An alternative to this would be a Python script from Impacket called samrdump.py.

<h3>Impacket - Samrdump.py</h3>

@htb[/htb]$ samrdump.py 10.129.14.128

The information we have already obtained with rpcclient can also be obtained using other tools. For example, the SMBMap and CrackMapExec tools are also widely used and helpful for the enumeration of SMB services.

<h3>SMBmap</h3>

@htb[/htb]$ smbmap -H 10.129.14.128

<h3>CrackMapExec</h3>

@htb[/htb]$ crackmapexec smb 10.129.14.128 --shares -u '' -p ''

Another tool worth mentioning is the so-called enum4linux-ng, which is based on an older tool, enum4linux. This tool automates many of the queries, but not all, and can return a large amount of information.

<h3>Enum4Linux-ng - Installation</h3>

@htb[/htb]$ git clone https://github.com/cddmp/enum4linux-ng.git

@htb[/htb]$ cd enum4linux-ng

@htb[/htb]$ pip3 install -r requirements.txt

<h3>Enum4Linux-ng - Enumeration</h3>

@htb[/htb]$ ./enum4linux-ng.py 10.129.14.128 -A

ENUM4LINUX - next generation

We need to use more than two tools for enumeration. Because it can happen that due to the programming of the tools, we get different information that we have to check manually. Therefore, we should never rely only on automated tools where we do not know precisely how they were written.

 What version of the SMB server is running on the target system? Submit the entire banner as the answer.
 
Samba smbd 4.6.2

+ 0  What is the name of the accessible share on the target?
  
sambashare

+ 0  Connect to the discovered share and find the flag.txt file. Submit the contents as the answer
  
HTB{o873nz4xdo873n4zo873zn4fksuhldsf}

+ 0  Find out which domain the server belongs to.
  
DEVOPS

+ 0  Find additional information about the specific share we found previously and submit the customized version of that specific share as the answer.
  
InFreight SMB v3.1

+ 0  What is the full system path of that specific share? (format: "/directory/names")
  
/home/sambauser
