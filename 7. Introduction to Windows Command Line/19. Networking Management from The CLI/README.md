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
