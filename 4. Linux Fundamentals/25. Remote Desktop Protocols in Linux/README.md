<h3>Remote Desktop Protocols in Linux</h3>

Remote desktop protocols are used in Windows, Linux, and macOS to provide graphical remote access to a system. These protocols allow administrators to manage, troubleshoot, and update systems remotely, making them essential tools for such scenarios. To do this, an administrator connects to the remote system using the appropriate protocol depending on the operating system they are managing.

For example, when administrators need to install software or manage a remote system, they use the relevant protocol to establish a graphical session. Two of the most common protocols for this type of access are:

1. Remote Desktop Protocol (RDP): Primarily used in Windows environments. RDP allows administrators to connect remotely and interact with the desktop of a Windows machine as if they were sitting right in front of it.

2. Virtual Network Computing (VNC): A popular protocol in Linux environments, although it is also cross-platform. VNC provides graphical access to remote desktops, allowing administrators to perform tasks on Linux systems in a similar way to RDP on Windows.

Think of remote desktop protocols like having different sets of keys for different types of buildings. RDP is like having a key specifically made for Windows buildings, allowing you to access and manage the rooms (desktops) remotely, as if you were inside. VNC, on the other hand, is more like a universal key that can work on many buildings, but it’s often used for Linux structures. Just as you would use the appropriate key depending on the building, administrators choose the right protocol depending on the system they need to access and control.

<h3>XServer</h3>

The XServer is the user-side part of the X Window System network protocol (X11 / X). The X11 is a fixed system that consists of a collection of protocols and applications that allow us to call application windows on displays in a graphical user interface. X11 is predominant on Unix systems, but X servers are also available for other operating systems. Nowadays, the XServer is a part of almost every desktop installation of Ubuntu and its derivatives and does not need to be installed separately.

When a desktop is started on a Linux computer, the communication of the graphical user interface with the operating system happens via an X server. The computer's internal network is used, even if the computer should not be in a network. The practical thing about the X protocol is network transparency. This protocol mainly uses TCP/IP as a transport base but can also be used on pure Unix sockets. The ports that are utilized for X server are typically located in the range of TCP/6001-6009, allowing communication between the client and server. When starting a new desktop session via X server the TCP port 6000 would be opened for the first X display :0. This range of ports enables the server to perform its tasks such as hosting applications, as well as providing services to clients. They are often used to provide remote access to a system, allowing users to access applications and data from anywhere in the world. Additionally, these ports are also essential for the secure sharing of files and data, making them an integral part of the Open X Server. Thus an X server is not dependent on the local computer, it can be used to access other computers, and other computers can use the local X server. Provided that both local and remote computers contain Unix/Linux systems, additional protocols such as VNC and RDP are superfluous. VNC and RDP generate the graphical output on the remote computer and transport it over the network. Whereas with X11, it is rendered on the local computer. This saves traffic and a load on the remote computer. However, X11's significant disadvantage is the unencrypted data transmission. However, this can be overcome by tunneling the SSH protocol.

For this, we have to allow X11 forwarding in the SSH configuration file (/etc/ssh/sshd_config) on the server that provides the application by changing this option to yes.

<h3>X11Forwarding</h3>

@htb[/htb]$ cat /etc/ssh/sshd_config | grep X11Forwarding

X11Forwarding yes

With this we can start the application from our client with the following command:

@htb[/htb]$ ssh -X htb-student@10.129.23.11 /usr/bin/firefox

htb-student@10.129.14.130's password: **\*\*\*\***

<SKIP>

<h3>X11 Security</h3>

As we mentioned earlier, X11 is not a secure protocol by default because its communication is unencrypted. As such, we should pay attention and look for the those TCP ports (6000-6010) when we deal with Linux-based targets. Without proper security measures, an open X server can expose sensitive data over the network. For example, an attacker on the same network could read the contents of the X server's windows without the user's knowledge, making it unnecessary for them to even perform traditional network sniffing. This vulnerability allows for serious security breaches. An attacker could potentially intercept sensitive information, such as passwords or personal data, by simply using standard X11 tools like xwd (which captures screenshots of X windows) and xgrabsc.

On top of this, there have been other security vulnerabilities discovered over the years, relating to XServer libraries and the software itself. For example, in 2017, a collection of vulnerabilities were found in XOrg Server, an open source implementation of the X Window System. Stemming from weak, predictable, or brute-forceable session keys, the exploitation of which could allow an attacker to execute arbitrary code in another user’s Xorg session. A wide range of systems were affected, such as Unix, Red Hat Enterprise Linux, Ubuntu Linux, and SUSE Linux. These vulnerabilities became known as as CVE-2017-2624, CVE-2017-2625, and CVE-2017-2626. This article provides an excellent summary.
