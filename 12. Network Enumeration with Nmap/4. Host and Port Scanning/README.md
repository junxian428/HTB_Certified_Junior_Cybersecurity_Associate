<h3>Host and Port Scanning</h3>

It is essential to understand how the tool we use works and how it performs and processes the different functions. We will only understand the results if we know what they mean and how they are obtained. Therefore we will take a closer look at and analyze some of the scanning methods. After we have found out that our target is alive, we want to get a more accurate picture of the system. The information we need includes:

Open ports and its services

Service versions

Information that the services provided

Operating system

There are a total of 6 different states for a scanned port we can obtain:

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>State</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>open</td>
      <td>This indicates that the connection to the scanned port has been established. These connections can be TCP connections, UDP datagrams as well as SCTP associations.</td>
    </tr>
    <tr>
      <td>closed</td>
      <td>When the port is shown as closed, the TCP protocol indicates that the packet we received back contains an RST flag. This scanning method can also be used to determine if our target is alive or not.</td>
    </tr>
    <tr>
      <td>filtered</td>
      <td>Nmap cannot correctly identify whether the scanned port is open or closed because either no response is returned from the target for the port or we get an error code from the target.</td>
    </tr>
    <tr>
      <td>unfiltered</td>
      <td>This state of a port only occurs during the TCP-ACK scan and means that the port is accessible, but it cannot be determined whether it is open or closed.</td>
    </tr>
    <tr>
      <td>open|filtered</td>
      <td>If we do not get a response for a specific port, Nmap will set it to that state. This indicates that a firewall or packet filter may protect the port.</td>
    </tr>
    <tr>
      <td>closed|filtered</td>
      <td>This state only occurs in the IP ID idle scans and indicates that it was impossible to determine if the scanned port is closed or filtered by a firewall.</td>
    </tr>
  </tbody>
</table>

Discovering Open TCP Ports

By default, Nmap scans the top 1000 TCP ports with the SYN scan (-sS). This SYN scan is set only to default when we run it as root because of the socket permissions required to create raw TCP packets. Otherwise, the TCP scan (-sT) is performed by default. This means that if we do not define ports and scanning methods, these parameters are set automatically. We can define the ports one by one (-p 22,25,80,139,445), by range (-p 22-445), by top ports (--top-ports=10) from the Nmap database that have been signed as most frequent, by scanning all ports (-p-) but also by defining a fast port scan, which contains top 100 ports (-F).

Scanning Top 10 TCP Ports

Host and Port Scanning

@htb[/htb]$ sudo nmap 10.129.2.28 --top-ports=10

Scanning Options Description

10.129.2.28 Scans the specified target.

--top-ports=10 Scans the specified top ports that have been defined as most frequent.

We see that we only scanned the top 10 TCP ports of our target, and Nmap displays their state accordingly. If we trace the packets Nmap sends, we will see the RST flag on TCP port 21 that our target sends back to us. To have a clear view of the SYN scan, we disable the ICMP echo requests (-Pn), DNS resolution (-n), and ARP ping scan (--disable-arp-ping).

Nmap - Trace the Packets

Host and Port Scanning

@htb[/htb]$ sudo nmap 10.129.2.28 -p 21 --packet-trace -Pn -n --disable-arp-ping

<table border="1" cellpadding="6" cellspacing="0">
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
      <td>-p 21</td>
      <td>Scans only the specified port.</td>
    </tr>
    <tr>
      <td>--packet-trace</td>
      <td>Shows all packets sent and received.</td>
    </tr>
    <tr>
      <td>-n</td>
      <td>Disables DNS resolution.</td>
    </tr>
    <tr>
      <td>--disable-arp-ping</td>
      <td>Disables ARP ping.</td>
    </tr>
  </tbody>
</table>
