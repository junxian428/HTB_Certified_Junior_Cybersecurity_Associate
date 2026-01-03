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

Option	Description

rw	Read and write permissions.

insecure	Ports above 1024 will be used.

nohide	If another file system was mounted below an exported directory, this directory is exported by its own exports entry.

no_root_squash	All files created by root are kept with the UID/GID 0.

It is highly recommended to create a local VM and experiment with the settings. We will discover methods that will show us how the NFS server is configured. For this, we can create several folders and assign different options to each one. Then we can inspect them and see what settings can have what effect on the NFS share and its permissions and the enumeration process.

We can take a look at the insecure option. This is dangerous because users can use ports above 1024. The first 1024 ports can only be used by root. This prevents the fact that no users can use sockets above port 1024 for the NFS service and interact with it.

<h3>Footprinting the Service</h3>

When footprinting NFS, the TCP ports 111 and 2049 are essential. We can also get information about the NFS service and the host via RPC, as shown below in the example.

<h3>Nmap</h3>

@htb[/htb]$ sudo nmap 10.129.14.128 -p111,2049 -sV -sC

The rpcinfo NSE script retrieves a list of all currently running RPC services, their names and descriptions, and the ports they use. This lets us check whether the target share is connected to the network on all required ports. Also, for NFS, Nmap has some NSE scripts that can be used for the scans. These can then show us, for example, the contents of the share and its stats.

@htb[/htb]$ sudo nmap --script nfs* 10.129.14.128 -sV -p111,2049

Once we have discovered such an NFS service, we can mount it on our local machine. For this, we can create a new empty folder to which the NFS share will be mounted. Once mounted, we can navigate it and view the contents just like our local system.

<h3>Show Available NFS Shares</h3>

@htb[/htb]$ showmount -e 10.129.14.128

<h3>Mounting NFS Share</h3>

[/htb]$ mkdir target-NFS

[/htb]$ sudo mount -t nfs 10.129.14.128:/ ./target-NFS/ -o nolock

[/htb]$ cd target-NFS

[/htb]$ tree .

There we will have the opportunity to access the rights and the usernames and groups to whom the shown and viewable files belong. Because once we have the usernames, group names, UIDs, and GUIDs, we can create them on our system and adapt them to the NFS share to view and modify the files.

<h3>List Contents with Usernames & Group Names</h3>

@htb[/htb]$ ls -l mnt/nfs/

<h3>List Contents with UIDs & GUIDs</h3>

@htb[/htb]$ ls -n mnt/nfs/

It is important to note that if the root_squash option is set, we cannot edit the backup.sh file even as root.

We can also use NFS for further escalation. For example, if we have access to the system via SSH and want to read files from another folder that a specific user can read, we would need to upload a shell to the NFS share that has the SUID of that user and then run the shell via the SSH user.

After we have done all the necessary steps and obtained the information we need, we can unmount the NFS share.

<h3>Unmounting</h3>

@htb[/htb]$ cd ..

@htb[/htb]$ sudo umount ./target-NFS
