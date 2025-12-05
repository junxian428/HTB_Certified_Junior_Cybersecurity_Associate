<h3>Host Discovery</h3>

When we need to conduct an internal penetration test for the entire network of a company, for example, then we should, first of all, get an overview of which systems are online that we can work with. To actively discover such systems on the network, we can use various Nmap host discovery options. There are many options Nmap provides to determine whether our target is alive or not. The most effective host discovery method is to use ICMP echo requests, which we will look into.

It is always recommended to store every single scan. This can later be used for comparison, documentation, and reporting. After all, different tools may produce different results. Therefore it can be beneficial to distinguish which tool produces which results.

<h3>Scan Network Range</h3>

sudo nmap 10.129.2.0/24 -sn -oA tnet | grep for | cut -d" " -f5

10.129.2.4

10.129.2.10

10.129.2.11

10.129.2.18

10.129.2.19

10.129.2.20

10.129.2.28

<table border="1" cellspacing="0" cellpadding="5">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.0/24</td>
      <td>Target network range.</td>
    </tr>
    <tr>
      <td>-sn</td>
      <td>Disables port scanning.</td>
    </tr>
    <tr>
      <td>-oA tnet</td>
      <td>Stores the results in all formats starting with the name 'tnet'.</td>
    </tr>
  </tbody>
</table>

This scanning method works only if the firewalls of the hosts allow it. Otherwise, we can use other scanning techniques to find out if the hosts are active or not. We will take a closer look at these techniques in "Firewall and IDS Evasion".

<h3>Scan IP List</h3>

During an internal penetration test, it is not uncommon for us to be provided with an IP list with the hosts we need to test. Nmap also gives us the option of working with lists and reading the hosts from this list instead of manually defining or typing them in.

Such a list could look something like this:

@htb[/htb]$ cat hosts.lst

10.129.2.4

10.129.2.10

10.129.2.11

10.129.2.18

10.129.2.19

10.129.2.20

10.129.2.28

If we use the same scanning technique on the predefined list, the command will look like this:

@htb[/htb]$ sudo nmap -sn -oA tnet -iL hosts.lst | grep for | cut -d" " -f5

10.129.2.18

10.129.2.19

10.129.2.20

<table border="1" cellspacing="0" cellpadding="5">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>-sn</td>
      <td>Disables port scanning.</td>
    </tr>
    <tr>
      <td>-oA tnet</td>
      <td>Stores the results in all formats starting with the name 'tnet'.</td>
    </tr>
    <tr>
      <td>-iL</td>
      <td>Performs defined scans against targets in provided 'hosts.lst' list.</td>
    </tr>
  </tbody>
</table>

In this example, we see that only 3 of 7 hosts are active. Remember, this may mean that the other hosts ignore the default ICMP echo requests because of their firewall configurations. Since Nmap does not receive a response, it marks those hosts as inactive.

<h3>Scan Multiple IPs</h3>

It can also happen that we only need to scan a small part of a network. An alternative to the method we used last time is to specify multiple IP addresses.

@htb[/htb]$ sudo nmap -sn -oA tnet 10.129.2.18 10.129.2.19 10.129.2.20| grep for | cut -d" " -f5

10.129.2.18

10.129.2.19

10.129.2.20

If these IP addresses are next to each other, we can also define the range in the respective octet.

7@htb[/htb]$ sudo nmap -sn -oA tnet 10.129.2.18-20| grep for | cut -d" " -f5

10.129.2.18

10.129.2.19

10.129.2.20

<h3>Scan Single IP</h3>

Before we scan a single host for open ports and its services, we first have to determine if it is alive or not. For this, we can use the same method as before.

@htb[/htb]$ sudo nmap 10.129.2.18 -sn -oA host

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-14 23:59 CEST

Nmap scan report for 10.129.2.18

Host is up (0.087s latency).

MAC Address: DE:AD:00:00:BE:EF

Nmap done: 1 IP address (1 host up) scanned in 0.11 seconds

<table border="1" cellspacing="0" cellpadding="5">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.18</td>
      <td>Performs defined scans against the target.</td>
    </tr>
    <tr>
      <td>-sn</td>
      <td>Disables port scanning.</td>
    </tr>
    <tr>
      <td>-oA host</td>
      <td>Stores the results in all formats starting with the name 'host'.</td>
    </tr>
  </tbody>
</table>

If we disable port scan (-sn), Nmap automatically ping scan with ICMP Echo Requests (-PE). Once such a request is sent, we usually expect an ICMP reply if the pinging host is alive. The more interesting fact is that our previous scans did not do that because before Nmap could send an ICMP echo request, it would send an ARP ping resulting in an ARP reply. We can confirm this with the "--packet-trace" option. To ensure that ICMP echo requests are sent, we also define the option (-PE) for this.

@htb[/htb]$ sudo nmap 10.129.2.18 -sn -oA host -PE --packet-trace

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 00:08 CEST

SENT (0.0074s) ARP who-has 10.129.2.18 tell 10.10.14.2

RCVD (0.0309s) ARP reply 10.129.2.18 is-at DE:AD:00:00:BE:EF

Nmap scan report for 10.129.2.18

Host is up (0.023s latency).

MAC Address: DE:AD:00:00:BE:EF

Nmap done: 1 IP address (1 host up) scanned in 0.05 seconds

<table border="1" cellspacing="0" cellpadding="5">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.18</td>
      <td>Performs defined scans against the target.</td>
    </tr>
    <tr>
      <td>-sn</td>
      <td>Disables port scanning.</td>
    </tr>
    <tr>
      <td>-oA host</td>
      <td>Stores the results in all formats starting with the name 'host'.</td>
    </tr>
    <tr>
      <td>-PE</td>
      <td>Performs the ping scan by using 'ICMP Echo requests' against the target.</td>
    </tr>
    <tr>
      <td>--packet-trace</td>
      <td>Shows all packets sent and received.</td>
    </tr>
  </tbody>
</table>

Another way to determine why Nmap has our target marked as "alive" is with the "--reason" option.

@htb[/htb]$ sudo nmap 10.129.2.18 -sn -oA host -PE --reason

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 00:10 CEST

SENT (0.0074s) ARP who-has 10.129.2.18 tell 10.10.14.2

RCVD (0.0309s) ARP reply 10.129.2.18 is-at DE:AD:00:00:BE:EF

Nmap scan report for 10.129.2.18

Host is up, received arp-response (0.028s latency).

MAC Address: DE:AD:00:00:BE:EF

Nmap done: 1 IP address (1 host up) scanned in 0.03 seconds

<table border="1" cellspacing="0" cellpadding="5">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.18</td>
      <td>Performs defined scans against the target.</td>
    </tr>
    <tr>
      <td>-sn</td>
      <td>Disables port scanning.</td>
    </tr>
    <tr>
      <td>-oA host</td>
      <td>Stores the results in all formats starting with the name 'host'.</td>
    </tr>
    <tr>
      <td>-PE</td>
      <td>Performs the ping scan by using 'ICMP Echo requests' against the target.</td>
    </tr>
    <tr>
      <td>--reason</td>
      <td>Displays the reason for specific result.</td>
    </tr>
  </tbody>
</table>

We see here that Nmap does indeed detect whether the host is alive or not through the ARP request and ARP reply alone. To disable ARP requests and scan our target with the desired ICMP echo requests, we can disable ARP pings by setting the "--disable-arp-ping" option. Then we can scan our target again and look at the packets sent and received.

htb[/htb]$ sudo nmap 10.129.2.18 -sn -oA host -PE --packet-trace --disable-arp-ping

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 00:12 CEST

SENT (0.0107s) ICMP [10.10.14.2 > 10.129.2.18 Echo request (type=8/code=0)

id=13607 seq=0] IP [ttl=255 id=23541 iplen=28 ]

RCVD (0.0152s) ICMP [10.129.2.18 > 10.10.14.2 Echo reply (type=0/code=0)
id=13607 seq=0] IP [ttl=128 id=40622 iplen=28 ]

Nmap scan report for 10.129.2.18

Host is up (0.086s latency).

MAC Address: DE:AD:00:00:BE:EF

Nmap done: 1 IP address (1 host up) scanned in 0.11 seconds

We have already mentioned in the "Learning Process," and at the beginning of this module, it is essential to pay attention to details. An ICMP echo request can help us determine if our target is alive and identify its system. More strategies about host discovery can be found at:

https://nmap.org/book/host-discovery-strategies.html

Questions

Answer the question(s) below to complete this Section and earn cubes!

- 1 Based on the last result, find out which operating system it belongs to. Submit the name of the operating system as result.

  Windows

Performing a quick Google search for Default TTL values for different OS will bring up many sites, with the first showing that 128 belongs to the Windows OS:
