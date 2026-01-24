<h3>SNMP</h3>

Simple Network Management Protocol (SNMP) was created to monitor network devices. In addition, this protocol can also be used to handle configuration tasks and change settings remotely. SNMP-enabled hardware includes routers, switches, servers, IoT devices, and many other devices that can also be queried and controlled using this standard protocol. Thus, it is a protocol for monitoring and managing network devices. In addition, configuration tasks can be handled, and settings can be made remotely using this standard. The current version is SNMPv3, which increases the security of SNMP in particular, but also the complexity of using this protocol.

In addition to the pure exchange of information, SNMP also transmits control commands using agents over UDP port 161. The client can set specific values in the device and change options and settings with these commands. While in classical communication, it is always the client who actively requests information from the server, SNMP also enables the use of so-called traps over UDP port 162. These are data packets sent from the SNMP server to the client without being explicitly requested. If a device is configured accordingly, an SNMP trap is sent to the client once a specific event occurs on the server-side.

For the SNMP client and server to exchange the respective values, the available SNMP objects must have unique addresses known on both sides. This addressing mechanism is an absolute prerequisite for successfully transmitting data and network monitoring using SNMP.

<h3>MIB</h3>

To ensure that SNMP access works across manufacturers and with different client-server combinations, the Management Information Base (MIB) was created. MIB is an independent format for storing device information. A MIB is a text file in which all queryable SNMP objects of a device are listed in a standardized tree hierarchy. It contains at least one Object Identifier (OID), which, in addition to the necessary unique address and a name, also provides information about the type, access rights, and a description of the respective object. MIB files are written in the Abstract Syntax Notation One (ASN.1) based ASCII text format. The MIBs do not contain data, but they explain where to find which information and what it looks like, which returns values for the specific OID, or which data type is used.

<h3>OID</h3>

An OID represents a node in a hierarchical namespace. A sequence of numbers uniquely identifies each node, allowing the node's position in the tree to be determined. The longer the chain, the more specific the information. Many nodes in the OID tree contain nothing except references to those below them. The OIDs consist of integers and are usually concatenated by dot notation. We can look up many MIBs for the associated OIDs in the Object Identifier Registry.

<h3>SNMPv1</h3>

SNMP version 1 (SNMPv1) is used for network management and monitoring. SNMPv1 is the first version of the protocol and is still in use in many small networks. It supports the retrieval of information from network devices, allows for the configuration of devices, and provides traps, which are notifications of events. However, SNMPv1 has no built-in authentication mechanism, meaning anyone accessing the network can read and modify network data. Another main flaw of SNMPv1 is that it does not support encryption, meaning that all data is sent in plain text and can be easily intercepted.

<h3>SNMPv2</h3>

SNMPv2 existed in different versions. The version still exists today is v2c, and the extension c means community-based SNMP. Regarding security, SNMPv2 is on par with SNMPv1 and has been extended with additional functions from the party-based SNMP no longer in use. However, a significant problem with the initial execution of the SNMP protocol is that the community string that provides security is only transmitted in plain text, meaning it has no built-in encryption.

<h3>SNMPv3</h3>

The security has been increased enormously for SNMPv3 by security features such as authentication using username and password and transmission encryption (via pre-shared key) of the data. However, the complexity also increases to the same extent, with significantly more configuration options than v2c.

<h3>Community Strings</h3>

Community strings can be seen as passwords that are used to determine whether the requested information can be viewed or not. It is important to note that many organizations are still using SNMPv2, as the transition to SNMPv3 can be very complex, but the services still need to remain active. This causes many administrators a great deal of concern and creates some problems they are keen to avoid. The lack of knowledge about how the information can be obtained and how we as attackers use it makes the administrators' approach seem inexplicable. At the same time, the lack of encryption of the data sent is also a problem. Because every time the community strings are sent over the network, they can be intercepted and read.

<h3>Default Configuration</h3>

The default configuration of the SNMP daemon defines the basic settings for the service, which include the IP addresses, ports, MIB, OIDs, authentication, and community strings.

<h3>SNMP Daemon Config</h3>

@htb[/htb]$ cat /etc/snmp/snmpd.conf | grep -v "#" | sed -r '/^\s*$/d'

The configuration of this service can also be changed in many ways. Therefore, we recommend setting up a VM to install and configure the SNMP server ourselves. All the settings that can be made for the SNMP daemon are defined and described in the manpage.

<h3>Dangerous Settings</h3>

Some dangerous settings that the administrator can make with SNMP are:

Settings	Description

rwuser noauth	Provides access to the full OID tree without authentication.


rwcommunity <community string> <IPv4 address>	Provides access to the full OID tree regardless of where the requests were sent from.

rwcommunity6 <community string> <IPv6 address>	Same access as with rwcommunity with the difference of using IPv6.

<h3>Footprinting the Service</h3>

For footprinting SNMP, we can use tools like snmpwalk, onesixtyone, and braa. Snmpwalk is used to query the OIDs with their information. Onesixtyone can be used to brute-force the names of the community strings since they can be named arbitrarily by the administrator. Since these community strings can be bound to any source, identifying the existing community strings can take quite some time.

<h3>SNMPwalk</h3>

@htb[/htb]$ snmpwalk -v2c -c public 10.129.14.128

In the case of a misconfiguration, we would get approximately the same results from snmpwalk as just shown above. Once we know the community string and the SNMP service that does not require authentication (versions 1, 2c), we can query internal system information like in the previous example.

Here we recognize some Python packages that have been installed on the system. If we do not know the community string, we can use onesixtyone and SecLists wordlists to identify these community strings.

<h3>OneSixtyOne</h3>

@htb[/htb]$ sudo apt install onesixtyone

@htb[/htb]$ onesixtyone -c /opt/useful/seclists/Discovery/SNMP/snmp.txt 10.129.14.128

Often, when certain community strings are bound to specific IP addresses, they are named with the hostname of the host, and sometimes even symbols are added to these names to make them more challenging to identify. However, if we imagine an extensive network with over 100 different servers managed using SNMP, the labels, in that case, will have some pattern to them. Therefore, we can use different rules to guess them. We can use the tool crunch to create custom wordlists. Creating custom wordlists is not an essential part of this module, but more details can be found in the module Cracking Passwords With Hashcat.

Once we know a community string, we can use it with braa to brute-force the individual OIDs and enumerate the information behind them.

<h3>Braa</h3>

@htb[/htb]$ sudo apt install braa

@htb[/htb]$ braa <community string>@<IP>:.1.3.6.*   # Syntax

@htb[/htb]$ braa public@10.129.14.128:.1.3.6.*

Once again, we would like to point out that the independent configuration of the SNMP service will bring us a great variety of different experiences that no tutorial can replace. Therefore, we highly recommend setting up a VM with SNMP, experimenting with it, and trying different configurations. SNMP can be a boon for an I.T. systems administrator as well as a curse for Security analysts and managers alike.

Enumerate the SNMP service and obtain the email address of the admin. Submit it as the answer.

devadmin@inlanefreight.htb

+ 1  What is the customized version of the SNMP server?
  
InFreight SNMP v0.91

+ 1  Enumerate the custom script that is running on the system and submit its output as the answer.
  
HTB{5nMp_fl4g_uidhfljnsldiuhbfsdij44738b2u763g}

