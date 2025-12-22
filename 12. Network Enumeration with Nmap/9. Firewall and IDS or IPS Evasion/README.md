<h3>Firewall and IDS/IPS Evasion</h3>

Nmap gives us many different ways to bypass firewalls rules and IDS/IPS. These methods include the fragmentation of packets, the use of decoys, and others that we will discuss in this section.

<h3>Firewalls</h3>

A firewall is a security measure against unauthorized connection attempts from external networks. Every firewall security system is based on a software component that monitors network traffic between the firewall and incoming data connections and decides how to handle the connection based on the rules that have been set. It checks whether individual network packets are being passed, ignored, or blocked. This mechanism is designed to prevent unwanted connections that could be potentially dangerous.

<h3>IDS/IPS</h3>

Like the firewall, the intrusion detection system (IDS) and intrusion prevention system (IPS) are also software-based components. IDS scans the network for potential attacks, analyzes them, and reports any detected attacks. IPS complements IDS by taking specific defensive measures if a potential attack should have been detected. The analysis of such attacks is based on pattern matching and signatures. If specific patterns are detected, such as a service detection scan, IPS may prevent the pending connection attempts.

<h3>Determine Firewalls and Their Rules</h3>

We already know that when a port is shown as filtered, it can have several reasons. In most cases, firewalls have certain rules set to handle specific connections. The packets can either be dropped, or rejected. The dropped packets are ignored, and no response is returned from the host.

This is different for rejected packets, which elicit an explicit response. TCP packets are returned with an RST flag, while ICMP can contain different types of error codes.

Such errors include:

- Net Unreachable

- Net Prohibited

- Host Unreachable

- Host Prohibited

- Port Unreachable

- Proto Unreachable

Nmap's TCP ACK scan (-sA) method is much harder to filter for firewalls and IDS/IPS systems than regular SYN (-sS) or Connect scans (sT) because they only send a TCP packet with only the ACK flag. When a port is closed or open, the host must respond with an RST flag. Unlike outgoing connections, all connection attempts (with the SYN flag) from external networks are usually blocked by firewalls. However, the packets with the ACK flag are often passed by the firewall because the firewall cannot determine whether the connection was first established from the external network or the internal network.

If we look at these scans, we will see how the results differ.

<h3>SYN-Scan</h3>

@htb[/htb]$ sudo nmap 10.129.2.28 -p 21,22,25 -sS -Pn -n --disable-arp-ping --packet-trace

<h3>ACK-Scan</h3>

@htb[/htb]$ sudo nmap 10.129.2.28 -p 21,22,25 -sA -Pn -n --disable-arp-ping --packet-trace

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p 21,22,25</td>
      <td>Scans only the specified ports.</td>
    </tr>
    <tr>
      <td>-sS</td>
      <td>Performs SYN scan on specified ports.</td>
    </tr>
    <tr>
      <td>-sA</td>
      <td>Performs ACK scan on specified ports.</td>
    </tr>
    <tr>
      <td>-Pn</td>
      <td>Disables ICMP Echo requests.</td>
    </tr>
    <tr>
      <td>-n</td>
      <td>Disables DNS resolution.</td>
    </tr>
    <tr>
      <td>--disable-arp-ping</td>
      <td>Disables ARP ping.</td>
    </tr>
    <tr>
      <td>--packet-trace</td>
      <td>Shows all packets sent and received.</td>
    </tr>
  </tbody>
</table>

Please pay attention to the RCVD packets and its set flag we receive from our target. With the SYN scan (-sS) our target tries to establish the TCP connection by sending a packet back with the SYN-ACK (SA) flags set and with the ACK scan (-sA) we get the RST flag because TCP port 22 is open. For the TCP port 25, we do not receive any packets back, which indicates that the packets will be dropped.

<h3>Detect IDS/IPS</h3>

Unlike firewalls and their rules, the detection of IDS/IPS systems is much more difficult because these are passive traffic monitoring systems. IDS systems examine all connections between hosts. If the IDS finds packets containing the defined contents or specifications, the administrator is notified and takes appropriate action in the worst case.

IPS systems take measures configured by the administrator independently to prevent potential attacks automatically. It is essential to know that IDS and IPS are different applications and that IPS serves as a complement to IDS.

Several virtual private servers (VPS) with different IP addresses are recommended to determine whether such systems are on the target network during a penetration test. If the administrator detects such a potential attack on the target network, the first step is to block the IP address from which the potential attack comes. As a result, we will no longer be able to access the network using that IP address, and our Internet Service Provider (ISP) will be contacted and blocked from all access to the Internet.

- IDS systems alone are usually there to help administrators detect potential attacks on their network. They can then decide how to handle such connections. We can trigger certain security measures from an administrator, for example, by aggressively scanning a single port and its service. Based on whether specific security measures are taken, we can detect if the network has some monitoring applications or not.

- One method to determine whether such IPS system is present in the target network is to scan from a single host (VPS). If at any time this host is blocked and has no access to the target network, we know that the administrator has taken some security measures. Accordingly, we can continue our penetration test with another VPS.

Consequently, we know that we need to be quieter with our scans and, in the best case, disguise all interactions with the target network and its services.

<h3>Decoys</h3>

There are cases in which administrators block specific subnets from different regions in principle. This prevents any access to the target network. Another example is when IPS should block us. For this reason, the Decoy scanning method (-D) is the right choice. With this method, Nmap generates various random IP addresses inserted into the IP header to disguise the origin of the packet sent. With this method, we can generate random (RND) a specific number (for example: 5) of IP addresses separated by a colon (:). Our real IP address is then randomly placed between the generated IP addresses. In the next example, our real IP address is therefore placed in the second position. Another critical point is that the decoys must be alive. Otherwise, the service on the target may be unreachable due to SYN-flooding security mechanisms.

@htb[/htb]$ sudo nmap 10.129.2.28 -p 80 -sS -Pn -n --disable-arp-ping --packet-trace -D RND:5

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p 80</td>
      <td>Scans only the specified port.</td>
    </tr>
    <tr>
      <td>-sS</td>
      <td>Performs SYN scan on specified ports.</td>
    </tr>
    <tr>
      <td>-Pn</td>
      <td>Disables ICMP Echo requests.</td>
    </tr>
    <tr>
      <td>-n</td>
      <td>Disables DNS resolution.</td>
    </tr>
    <tr>
      <td>--disable-arp-ping</td>
      <td>Disables ARP ping.</td>
    </tr>
    <tr>
      <td>--packet-trace</td>
      <td>Shows all packets sent and received.</td>
    </tr>
    <tr>
      <td>-D RND:5</td>
      <td>Generates five random IP addresses to act as decoy source IPs.</td>
    </tr>
  </tbody>
</table>

The spoofed packets are often filtered out by ISPs and routers, even though they come from the same network range. Therefore, we can also specify our VPS servers' IP addresses and use them in combination with "IP ID" manipulation in the IP headers to scan the target.

Another scenario would be that only individual subnets would not have access to the server's specific services. So we can also manually specify the source IP address (-S) to test if we get better results with this one. Decoys can be used for SYN, ACK, ICMP scans, and OS detection scans. So let us look at such an example and determine which operating system it is most likely to be.

<h3>Testing Firewall Rule</h3>

@htb[/htb]$ sudo nmap 10.129.2.28 -n -Pn -p445 -O

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-22 01:23 CEST

Nmap scan report for 10.129.2.28

Host is up (0.032s latency).


PORT    STATE    SERVICE

445/tcp filtered microsoft-ds

MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Too many fingerprints match this host to give specific OS details

Network Distance: 1 hop

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .

Nmap done: 1 IP address (1 host up) scanned in 3.14 seconds

<h3>Scan by Using Different Source IP</h3>

@htb[/htb]$ sudo nmap 10.129.2.28 -n -Pn -p 445 -O -S 10.129.2.200 -e tun0

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-n</td>
      <td>Disables DNS resolution.</td>
    </tr>
    <tr>
      <td>-Pn</td>
      <td>Disables ICMP Echo requests.</td>
    </tr>
    <tr>
      <td>-p 445</td>
      <td>Scans only the specified port.</td>
    </tr>
    <tr>
      <td>-O</td>
      <td>Performs operating system detection scan.</td>
    </tr>
    <tr>
      <td>-S</td>
      <td>Scans the target using a different source IP address.</td>
    </tr>
    <tr>
      <td>10.129.2.200</td>
      <td>Specifies the source IP address.</td>
    </tr>
    <tr>
      <td>-e tun0</td>
      <td>Sends all requests through the specified network interface.</td>
    </tr>
  </tbody>
</table>

<h3>DNS Proxying</h3>

By default, Nmap performs a reverse DNS resolution unless otherwise specified to find more important information about our target. These DNS queries are also passed in most cases because the given web server is supposed to be found and visited. The DNS queries are made over the UDP port 53. The TCP port 53 was previously only used for the so-called "Zone transfers" between the DNS servers or data transfer larger than 512 bytes. More and more, this is changing due to IPv6 and DNSSEC expansions. These changes cause many DNS requests to be made via TCP port 53.

However, Nmap still gives us a way to specify DNS servers ourselves (--dns-server <ns>,<ns>). This method could be fundamental to us if we are in a demilitarized zone (DMZ). The company's DNS servers are usually more trusted than those from the Internet. So, for example, we could use them to interact with the hosts of the internal network. As another example, we can use TCP port 53 as a source port (--source-port) for our scans. If the administrator uses the firewall to control this port and does not filter IDS/IPS properly, our TCP packets will be trusted and passed through.

<h3>SYN-Scan of a Filtered Port</h3>

 sudo nmap 10.129.2.28 -p50000 -sS -Pn -n --disable-arp-ping --packet-trace

 <h3>SYN-Scan From DNS Port</h3>

 @htb[/htb]$ sudo nmap 10.129.2.28 -p50000 -sS -Pn -n --disable-arp-ping --packet-trace --source-port 53

 <table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p 50000</td>
      <td>Scans only the specified port.</td>
    </tr>
    <tr>
      <td>-sS</td>
      <td>Performs SYN scan on specified ports.</td>
    </tr>
    <tr>
      <td>-Pn</td>
      <td>Disables ICMP Echo requests.</td>
    </tr>
    <tr>
      <td>-n</td>
      <td>Disables DNS resolution.</td>
    </tr>
    <tr>
      <td>--disable-arp-ping</td>
      <td>Disables ARP ping.</td>
    </tr>
    <tr>
      <td>--packet-trace</td>
      <td>Shows all packets sent and received.</td>
    </tr>
    <tr>
      <td>--source-port 53</td>
      <td>Performs the scan using the specified source port.</td>
    </tr>
  </tbody>
</table>

Now that we have found out that the firewall accepts TCP port 53, it is very likely that IDS/IPS filters might also be configured much weaker than others. We can test this by trying to connect to this port by using Netcat.

<h3>Connect To The Filtered Port</h3>

@htb[/htb]$ ncat -nv --source-port 53 10.129.2.28 50000

<h3>Firewall and IDS/IPS Evasion Labs</h3>

In the next three sections, we get different scenarios to practice where we have to scan our target. Firewall rules and IDS/IPS protect the systems, so we need to use the techniques shown to bypass the firewall rules and do this as quiet as possible. Otherwise, we will be blocked by IPS.

