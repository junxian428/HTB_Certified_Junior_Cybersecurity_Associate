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
