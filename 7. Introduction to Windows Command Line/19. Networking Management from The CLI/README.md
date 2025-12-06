<h3>Networking Management from The CLI</h3>

PowerShell has expanded our capabilities within the Windows OS when dealing with Networking settings, applications, and more. This section will cover how to check your network settings, such as IP addresses, adapter settings, and DNS settings. We will also cover How to enable and manage remote host access utilizing WinRM and SSH.

Scenario: To ensure Mr. Tanaka's host is functioning properly and we can manage it from the IT office remotely, we are going to perform a quick checkup, validate his host settings, and enable remote management for the host.

<h3>What Is Networking Within a Windows Network?</h3>

Networking with Windows hosts functions much like any other Linux or Unix-based host. The TCP/IP stack, wireless protocols, and other applications treat most devices the same, so there isn't much to learn there that's new. This module assumes you know basic networking protocols and how typical network traffic traverses the Internet. If you wish for a primer on networking, check out the Introduction to Networking module, or for a more in-depth dissection of network traffic, you can play through the Introduction to Network Traffic Analysis module. Where things get a bit different lies in how Windows hosts communicate with each other, domains, and other Linux hosts. Below we will quickly cover some standard protocols you could run into when administering or pentesting Windows hosts.

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Protocol</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>SMB</td>
      <td>Provides Windows hosts with resource and file sharing, and a standard authentication mechanism. SAMBA is the open-source version for other platforms.</td>
    </tr>
    <tr>
      <td>NetBIOS</td>
      <td>Not a protocol by itself but a conversation mechanism used in networks. Formerly the transport for SMB; now used as an identification fallback when DNS fails. Also referred to as NBT-NS.</td>
    </tr>
    <tr>
      <td>LDAP</td>
      <td>An open-source, cross-platform protocol for authentication and authorization with directory services such as Active Directory.</td>
    </tr>
    <tr>
      <td>LLMNR</td>
      <td>Provides name resolution similar to DNS when DNS is unavailable. Uses multicast and works only on local network segments.</td>
    </tr>
    <tr>
      <td>DNS</td>
      <td>A global naming standard allowing hosts to be referenced by name instead of IP address (e.g., "google.com" instead of "8.8.8.8").</td>
    </tr>
    <tr>
      <td>HTTP/HTTPS</td>
      <td>Protocols used to request and use web resources. HTTP is insecure; HTTPS is the secure version used for encrypted communication.</td>
    </tr>
    <tr>
      <td>Kerberos</td>
      <td>A network authentication protocol most commonly used in Active Directory to allow clients to obtain authorization tickets for domain resources.</td>
    </tr>
    <tr>
      <td>WinRM</td>
      <td>Implementation of the WS-Management protocol used to manage hardware and software on hosts. Common in IT administration and remote automation.</td>
    </tr>
    <tr>
      <td>RDP</td>
      <td>A Windows protocol providing a graphical remote desktop interface, enabling full UI access, including keyboard and mouse input.</td>
    </tr>
    <tr>
      <td>SSH</td>
      <td>A secure protocol for remote access, file transfer, and communication over insecure networks.</td>
    </tr>
  </tbody>
</table>

Of course, this list is not all-encompassing, but it is an excellent general start of what we would typically see when communicating with Windows hosts. Now let's discuss local access vs. remote access.

Local vs. Remote Access?

Local Access

Local host access is when we are directly at the terminal utilizing its resources as you are right now from your PC. Usually, this will not require us to use any specific access protocols except when we request resources from networked hosts or attempt to access the Internet. Below we will showcase some cmdlets and other ways to check and validate network settings on our hosts.

Querying Networking Settings

Before doing anything else, let's validate the network settings on Mr. Tanaka's host. We will start by running the IPConfig command. This isn't a PowerShell native command, but it is compatible.

<h3>IPConfig</h3>

PS C:\htb> ipconfig

As we can see, ipconfig will show us the basic settings of your network interface. We have as output the IPv4/6 addresses, our gateway, subnet masks, and DNS suffix if one is set. We can output the full network settings by appending the /all modifier to the ipconfig command like so:

PS C:\htb> ipconfig /all

Now we can see much more information than before. We are presented with output containing multiple adapters, Host settings, more details about if our IP addresses were manually set or DHCP leases, how long those leases are, and more. So, it appears Mr. Tanaka's host has a proper IP address configuration. Of note, and particularly interesting to us as pentesters, is that this host is dual-homed. We mean it has multiple network interfaces connected to separate networks. This makes Mr. Tanakas host a great target if we are looking for a foothold in the network and wish to have a way to migrate between networks.

Let's look at Arp settings and see if his host has communicated with others on the network. As a refresher, ARP is a protocol utilized to translate IP addresses to Physical addresses. The physical address is used at lower levels of the OSI/TCP-IP models for communication. To have it display the host's current ARP entries, we will use the -a switch.

<h3>ARP</h3>

PS C:\htb> arp -a

The output from Arp -a is pretty simple. We are provided with entries from our network adapters about the hosts it is aware of or has communicated with recently. Not surprisingly, since this host is fairly new, it has yet to communicate with too many hosts. Just the gateways, our remote host, and the host 172.16.5.155, the Domain Controller for Greenhorn.corp. Nothing crazy to be seen here. Now let's validate our DNS configuration is working properly. We will utilize nslookup, a built-in DNS querying tool, to attempt to resolve the IP address / DNS name of the Greenhorn domain controller.

<h3>Nslookup</h3>

PS C:\htb> nslookup ACADEMY-ICL-DC

Now that we have validated Mr. Tanakas DNS settings, let's check the open ports on the host. We can do so using netstat -an. Netstat will display current network connections to our host. The -an switch will print all connections and listening ports and place them in numerical form.

<h3>Netstat</h3>

PS C:\htb> netstat -an

netstat -an

Now, you may need to gain a background in looking at network traffic or an understanding of standard ports and protocols, or else the above may look like gibberish. That's ok, though. Looking above, we can see what ports are open and if we have any active connections. From the output above, the ports open are all commonly used in Windows environments and would be expected. Most deal with Active Directory services and SSH. When looking at the connections, we see only one currently active session: our own SSH connection over TCP port 22.

Most of these commands we have practiced with up to this point are Windows built-in executables and are helpful for quick insight into a host, but not for much more. Below we will cover several cmdlets that are additions from PowerShell that allow us to manage our network connections granularly.

<h3>PowerShell Net Cmdlets</h3>

PowerShell has several powerful built-in cmdlets made to handle networking services and administration. The NetAdapter, NetConnection, and NetTCPIP modules are just a few that we will practice with today.

<h3>Net Cmdlets</h3>

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Cmdlet</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Get-NetIPInterface</td>
      <td>Retrieves all visible network adapter properties.</td>
    </tr>
    <tr>
      <td>Get-NetIPAddress</td>
      <td>Retrieves the IP configurations of each adapter. Similar to <code>ipconfig</code>.</td>
    </tr>
    <tr>
      <td>Get-NetNeighbor</td>
      <td>Retrieves neighbor entries from the cache. Similar to <code>arp -a</code>.</td>
    </tr>
    <tr>
      <td>Get-NetRoute</td>
      <td>Displays the current route table. Similar to <code>route print</code> or Linux <code>ip route</code>.</td>
    </tr>
    <tr>
      <td>Set-NetAdapter</td>
      <td>Configures Layer-2 adapter properties such as VLAN ID, description, and MAC address.</td>
    </tr>
    <tr>
      <td>Set-NetIPInterface</td>
      <td>Modifies interface settings such as DHCP, MTU, and other metrics.</td>
    </tr>
    <tr>
      <td>New-NetIPAddress</td>
      <td>Creates and configures an IP address for an adapter.</td>
    </tr>
    <tr>
      <td>Set-NetIPAddress</td>
      <td>Modifies the IP settings of a network adapter.</td>
    </tr>
    <tr>
      <td>Disable-NetAdapter</td>
      <td>Disables a network adapter interface.</td>
    </tr>
    <tr>
      <td>Enable-NetAdapter</td>
      <td>Re-enables a network adapter interface.</td>
    </tr>
    <tr>
      <td>Restart-NetAdapter</td>
      <td>Restarts a network adapter, often needed after making configuration changes.</td>
    </tr>
    <tr>
      <td>Test-NetConnection</td>
      <td>Runs connectivity diagnostics including ping, TCP tests, and trace route.</td>
    </tr>
  </tbody>
</table>

We aren't going to show each cmdlet in use, but it would be prudent to provide a quick reference for your use. First, we will start with Get-NetIPInterface.

<h3>Get-NetIPInterface</h3>

PS C:\htb> get-netIPInterface

This listing shows us our available interfaces on the host in a bit of a convoluted manner. We are provided plenty of metrics, but the adapters are broken up by AddressFamily. So we see entries for each adapter twice if IPv4 and IPv6 are enabled on that particular interface. The ifindex and InterfaceAlias properties are particularly useful. These properties make it easy for us to use the other cmdlets provided by the NetTCPIP module. Let's get the Adapter information for our Wi-Fi connection at ifIndex 25 utilizing the Get-NetIPAddress cmdlet.

<h3>Get-NetIPAddress</h3>

PS C:\htb> Get-NetIPAddress -ifIndex 25

This cmdlet has returned quite a bit of information as well. Notice how we used the ifIndex number to request the information? We can do the same with the InterfaceAlias as well. This cmdlet returns quite a bit of information, such as the index, alias, DHCP state, interface type, and other metrics. This mirrors most of what we would see if we issued the IPconfig executable from the command prompt. Now, what if we want to modify a setting on the interface? We can do so with the Set-NetIPInterface and Set-NetIPAddress cmdlets. In this example, let's say we want to change the DHCP status of the interface from enabled, to disabled, and change the IP from one automatically assigned by DHCP to one of our choosing manually set. We would accomplish this like so:

<h3>Set-NetIPInterface</h3>

PS C:\htb> Set-NetIPInterface -InterfaceIndex 25 -Dhcp Disabled

By disabling the DHCP property with the Set-NetIPInterface cmdlet, we can now set our manual IP Address. We do that with the Set-NetIPAddress cmdlet.

<h3>Set-NetIPAddress</h3>

PS C:\htb> Set-NetIPAddress -InterfaceIndex 25 -IPAddress 10.10.100.54 -PrefixLength 24

PS C:\htb> Get-NetIPAddress -ifindex 20 | ft InterfaceIndex,InterfaceAlias,IPAddress,PrefixLength

The above command now sets our IP address to 10.10.100.54 and the PrefixLength ( also known as the subnet mask ) to 24. Looking at our checks, we can see that those settings are in place. To be safe, let's restart our network adapter and test our connection to see if it sticks.

<h3>Restart-NetAdapter</h3>

PS C:\htb> Restart-NetAdapter -Name 'Ethernet 3'

As long as nothing goes wrong, you will not receive output. So when it comes to Restart-NetAdapter, no news is good news. The easiest way to tell the cmdlet which interface to restart is with the Name property, which is the same as the InterfaceAlias from previous commands we ran. Now, to ensure we still have a connection, we can use the Test-NetConnection cmdlet.

<h3>Test-NetConnection</h3>

PS C:\htb> Test-NetConnection

The Test-NetConnection is a powerful cmdlet, capable of testing beyond basic network connectivity to determine whether we can reach another host. It can tell us about our TCP results, detailed metrics, route diagnostics and more. It would be worthwhile to look at this article by Microsoft on Test-NetConnection. Now that we have completed our task and validated Mr. Tanaka's network settings on his host, let's discuss remote access connectivity for a bit.

<h3>Remote Access</h3>

When we cannot access Windows systems or need to manage hosts remotely, we can utilize PowerShell, SSH, and RDP, among other tools, to perform our work. Let's cover the main ways we can enable and use remote access. First, we will discuss SSH.

<h3>How to Enable Remote Access? ( SSH, PSSessions, etc.)</h3>

<h3>Enabling SSH Access</h3>

We can use SSH to access PowerShell on a Windows system over the network. Starting in 2018, SSH via the OpenSSH client and server applications has been accessible and included in all Windows Server and Client versions. It makes for an easy-to-use and extensible communication mechanism for our administrative use. Setting up OpenSSH on our hosts is simple. Let's give it a try. We must install the SSH Server component and the client application to access a host via SSH remotely.

<h3>Setting up SSH on a Windows Target</h3>

We can set up an SSH server on a Windows target using the Add-WindowsCapability cmdlet and confirm that it is successfully installed using the Get-WindowsCapability cmdlet.

PS C:\Users\htb-student> Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH\*'

<h3>Starting the SSH Service & Setting Startup Type</h3>

Once we have confirmed SSH is installed, we can use the Start-Service cmdlet to start the SSH service. We can also use the Set-Service cmdlet to configure the startup settings of the SSH service if we choose.

PS C:\Users\htb-student> Start-Service sshd

PS C:\Users\htb-student> Set-Service -Name sshd -StartupType 'Automatic'

Note: Initial setup of remote access services will not be a requirement in this module to complete challenge questions. With each of the challenges in this module, remote access is already set up & configured. However, understanding how to connect and apply concepts covered throughout the module will be required. The setup & configuration steps are provided to help develop an understanding of common configuration mistakes and, in some cases, best security practices. Feel free to try some setup steps on your own personal VM.

<h3>Accessing PowerShell over SSH</h3>

With SSH installed and running on a Windows target, we can connect over the network with an SSH client.

<h3>Connecting from Windows</h3>

PS C:\Users\administrator> ssh htb-student@10.129.224.248

htb-student@10.129.224.248 password:

By default, this will connect us to a CMD session, but we can type powershell to enter a PowerShell session, as mentioned earlier in this section.

WS01\htb-student@WS01 C:\Users\htb-student> powershell

Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

PS C:\Users\htb-student>

We will notice that the steps to connect to a Windows target over SSH using Linux are identical to those when connecting from Windows.

<h3>Connecting from Linux</h3>

PS C:\Users\administrator> ssh htb-student@10.129.224.248

htb-student@10.129.224.248 password:

WS01\htb-student@WS01 C:\Users\htb-student> powershell

Windows PowerShell

Copyright (C) Microsoft Corporation. All rights reserved.

PS C:\Users\htb-student>

Now that we have covered SSH let's spend some time covering enabling and using WinRM for remote access and management.

<h3>Enabling WinRM</h3>

Windows Remote Management (WinRM) can be configured using dedicated PowerShell cmdlets and we can enter into a PowerShell interactive session as well as issue commands on remote Windows target(s). We will notice that WinRM is more commonly enabled on Windows Server operating systems, so IT admins can perform tasks on one or multiple hosts. It's enabled by default in Windows Server.

Because of the increasing demand for the ability to remotely manage and automate tasks on Windows systems, we will likely see WinRM enabled on more & more Windows desktop operating systems (Windows 10 & Windows 11) as well. When WinRM is enabled on a Windows target, it listens on logical ports 5985 & 5986.

<h3>Enabling & Configuring WinRM</h3>

WinRM can be enabled on a Windows target using the following commands:

PS C:\WINDOWS\system32> winrm quickconfig

WinRM service is already running on this machine.

WinRM is not set up to allow remote access to this machine for management.

The following changes must be made:

As can be seen in the above output, running this command will automatically ensure all the necessary configurations are in place to:

Enable the WinRM service

Allow WinRM through the Windows Defender Firewall (Inbound and Outbound)

Grant administrative rights remotely to local users

As long as credentials to access the system are known, anyone who can reach the target over the network can connect after that command is run. IT admins should take further steps to harden these WinRM configurations, especially if the system will be remotely accessible over the Internet. Among some of these hardening options are:

Configure TrustedHosts to include just IP addresses/hostnames that will be used for remote management

Configure HTTPS for transport

Join Windows systems to an Active Directory Domain Environment and Enforce Kerberos Authentication

<h3>Testing PowerShell Remote Access</h3>

Once we have enabled and configured WinRM, we can test remote access using the Test-WSMan PowerShell cmdlet.

<h3>Testing Unauthenticated Access</h3>

PS C:\Users\administrator> Test-WSMan -ComputerName "10.129.224.248"

Running this cmdlet sends a request that checks if the WinRM service is running. Keep in mind that this is unauthenticated, so no credentials are used, which is why no OS version is detected. This shows us that the WinRM service is running on the target.

<h3>Testing Authenticated Access</h3>

PS C:\Users\administrator> Test-WSMan -ComputerName "10.129.224.248" -Authentication Negotiate

We can run the same command with the option -Authentication Negotiate to test if WinRM is authenticated, and we will receive the OS version (10.0.11764).

<h3>PowerShell Remote Sessions</h3>

We also have the option to use the Enter-PSSession cmdlet to establish a PowerShell session with a Windows target.

<h3>Establishing a PowerShell Session</h3>

PS C:\Users\administrator> Enter-PSSession -ComputerName 10.129.224.248 -Credential htb-student -Authentication Negotiate

[10.129.5.129]: PS C:\Users\htb-student\Documents> $PSVersionTable

We can perform this same action from a Linux-based attack host with PowerShell core installed (like in Pwnbox). Remember that PowerShell is not exclusive to Windows and will run on other operating systems now.

<h3>Using Enter-PSSession from Linux</h3>

@htb[/htb]$ [PS]> Enter-PSSession -ComputerName 10.129.224.248 -Credential htb-student -Authentication Negotiate

PowerShell credential request

Enter your credentials.

Password for user htb-student: **\*\***\*\*\***\*\***

[10.129.224.248]: PS C:\Users\htb-student\Documents> $PSVersionTable

Along with being OS agnostic, there are now tons of different tools that we can use to interact remotely with hosts. Picking a means to remotely administer our hosts mostly comes down to what you are comfortable with and what you can use based on the engagement or your environment security settings.

Networking is a pretty straightforward task to manage on Windows hosts. As your environments get more complex with cloud servers, multiple domains, and multiple sites across large geographical distances, network management at the level can get tedious. Luckily, we are only focused on our local host and how to manage a singular host. Moving forward, we will look at how we can interact with the web using PowerShell.

What common protocol is used to resolve names to IP addresses.
DNS

- 0 What PowerShell cmdlet will show us the IP configurations of the hosts network adapters.

  Get-NetIPAddress

- 0 What command can enable and configure Windows Remote Management on a host?

  winrm quickconfig
