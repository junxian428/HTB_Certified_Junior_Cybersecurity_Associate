<h3>NFS</h3>

Network File System (NFS) is a network file system developed by Sun Microsystems and has the same purpose as SMB. Its purpose is to access file systems over a network as if they were local. However, it uses an entirely different protocol. NFS is used between Linux and Unix systems. This means that NFS clients cannot communicate directly with SMB servers. NFS is an Internet standard that governs the procedures in a distributed file system. While NFS protocol version 3.0 (NFSv3), which has been in use for many years, authenticates the client computer, this changes with NFSv4. Here, as with the Windows SMB protocol, the user must authenticate.

Version	Features

NFSv2	It is older but is supported by many systems and was initially operated entirely over UDP.

NFSv3	It has more features, including variable file size and better error reporting, but is not fully compatible with NFSv2 clients.

NFSv4	It includes Kerberos, works through firewalls and on the Internet, no longer requires portmappers, supports ACLs, applies state-based operations, and provides performance improvements and high security. It is also the first version to have a stateful protocol.

NFS version 4.1 (RFC 8881) aims to provide protocol support to leverage cluster server deployments, including the ability to provide scalable parallel access to files distributed across multiple servers (pNFS extension). In addition, NFSv4.1 includes a session trunking mechanism, also known as NFS multipathing. A significant advantage of NFSv4 over its predecessors is that only one UDP or TCP port 2049 is used to run the service, which simplifies the use of the protocol across firewalls.

NFS is based on the Open Network Computing Remote Procedure Call (ONC-RPC/SUN-RPC) protocol exposed on TCP and UDP ports 111, which uses External Data Representation (XDR) for the system-independent exchange of data. The NFS protocol has no mechanism for authentication or authorization. Instead, authentication is completely shifted to the RPC protocol's options. The authorization is derived from the available file system information. In this process, the server is responsible for translating the client's user information into the file system's format and converting the corresponding authorization details into the required UNIX syntax as accurately as possible.

The most common authentication is via UNIX UID/GID and group memberships, which is why this syntax is most likely to be applied to the NFS protocol. One problem is that the client and server do not necessarily have to have the same mappings of UID/GID to users and groups, and the server does not need to do anything further. No further checks can be made on the part of the server. This is why NFS should only be used with this authentication method in trusted networks.

<h3>Default Configuration</h3>

NFS is not difficult to configure because there are not as many options as FTP or SMB have. The /etc/exports file contains a table of physical filesystems on an NFS server accessible by the clients. The NFS Exports Table shows which options it accepts and thus indicates which options are available to us.

<h3>Exports File</h3>

@htb[/htb]$ cat /etc/exports 

The default exports file also contains some examples of configuring NFS shares. First, the folder is specified and made available to others, and then the rights they will have on this NFS share are connected to a host or a subnet. Finally, additional options can be added to the hosts or subnets.

Option	Description

rw	Read and write permissions.

ro	Read only permissions.

sync	Synchronous data transfer. (A bit slower)

async	Asynchronous data transfer. (A bit faster)

secure	Ports above 1024 will not be used.

insecure	Ports above 1024 will be used.

no_subtree_check	This option disables the checking of subdirectory trees.

root_squash	Assigns all permissions to files of root UID/GID 0 to the UID/GID of anonymous, which prevents root from accessing files on an NFS mount.

Let us create such an entry for test purposes and play around with the settings.

<h3>ExportFS</h3>

root@nfs:~# echo '/mnt/nfs  10.129.14.0/24(sync,no_subtree_check)' >> /etc/exports

root@nfs:~# systemctl restart nfs-kernel-server 

root@nfs:~# exportfs

/mnt/nfs      	10.129.14.0/24

We have shared the folder /mnt/nfs to the subnet 10.129.14.0/24 with the setting shown above. This means that all hosts on the network will be able to mount this NFS share and inspect the contents of this folder.

<h3>Dangerous Settings</h3>

However, even with NFS, some settings can be dangerous for the company and its infrastructure. Here are some of them listed:

