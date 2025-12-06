<h3>Service Enumeration</h3>

For us, it is essential to determine the application and its version as accurately as possible. We can use this information to scan for known vulnerabilities and analyze the source code for that version if we find it. An exact version number allows us to search for a more precise exploit that fits the service and the operating system of our target.

<h3>Service Version Detection</h3>

It is recommended to perform a quick port scan first, which gives us a small overview of the available ports. This causes significantly less traffic, which is advantageous for us because otherwise we can be discovered and blocked by the security mechanisms. We can deal with these first and run a port scan in the background, which shows all open ports (-p-). We can use the version scan to scan the specific ports for services and their versions (-sV).

A full port scan takes quite a long time. To view the scan status, we can press the [Space Bar] during the scan, which will cause Nmap to show us the scan status.

@htb[/htb]$ sudo nmap 10.129.2.28 -p- -sV

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 19:44 CEST

[Space Bar]

Stats: 0:00:03 elapsed; 0 hosts completed (1 up), 1 undergoing SYN Stealth Scan

SYN Stealth Scan Timing: About 3.64% done; ETC: 19:45 (0:00:53 remaining)

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Scanning Option</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p-</td>
      <td>Scans all ports.</td>
    </tr>
    <tr>
      <td>-sV</td>
      <td>Performs service version detection on the specified ports.</td>
    </tr>
  </tbody>
</table>

Another option (--stats-every=5s) that we can use is defining how periods of time the status should be shown. Here we can specify the number of seconds (s) or minutes (m), after which we want to get the status.

@htb[/htb]$ sudo nmap 10.129.2.28 -p- -sV --stats-every=5s

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 19:46 CEST

Stats: 0:00:05 elapsed; 0 hosts completed (1 up), 1 undergoing SYN Stealth Scan

SYN Stealth Scan Timing: About 13.91% done; ETC: 19:49 (0:00:31 remaining)

Stats: 0:00:10 elapsed; 0 hosts completed (1 up), 1 undergoing SYN Stealth Scan

SYN Stealth Scan Timing: About 39.57% done; ETC: 19:48 (0:00:15 remaining)

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Scanning Option</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p-</td>
      <td>Scans all ports.</td>
    </tr>
    <tr>
      <td>-sV</td>
      <td>Performs service version detection on the specified ports.</td>
    </tr>
    <tr>
      <td>--stats-every=5s</td>
      <td>Shows progress updates every 5 seconds during the scan.</td>
    </tr>
  </tbody>
</table>

We can also increase the verbosity level (-v / -vv), which will show us the open ports directly when Nmap detects them.

@htb[/htb]$ sudo nmap 10.129.2.28 -p- -sV -v

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Scanning Option</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p-</td>
      <td>Scans all ports.</td>
    </tr>
    <tr>
      <td>-sV</td>
      <td>Performs service version detection on the specified ports.</td>
    </tr>
    <tr>
      <td>-v</td>
      <td>Increases the verbosity of the scan, displaying more detailed information.</td>
    </tr>
  </tbody>
</table>

<h3>Banner Grabbing</h3>

Once the scan is complete, we will see all TCP ports with the corresponding service and their versions that are active on the system.

@htb[/htb]$ sudo nmap 10.129.2.28 -p- -sV

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 20:00 CEST

Nmap scan report for 10.129.2.28

Host is up (0.013s latency).

Not shown: 65525 closed ports

PORT STATE SERVICE VERSION

22/tcp open ssh OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)

25/tcp open smtp Postfix smtpd

80/tcp open http Apache httpd 2.4.29 ((Ubuntu))

110/tcp open pop3 Dovecot pop3d

139/tcp filtered netbios-ssn

143/tcp open imap Dovecot imapd (Ubuntu)

445/tcp filtered microsoft-ds

993/tcp open ssl/imap Dovecot imapd (Ubuntu)

995/tcp open ssl/pop3 Dovecot pop3d

MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Service Info: Host: inlane; OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .

Nmap done: 1 IP address (1 host up) scanned in 91.73 seconds

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Scanning Option</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p-</td>
      <td>Scans all ports.</td>
    </tr>
    <tr>
      <td>-sV</td>
      <td>Performs service version detection on the specified ports.</td>
    </tr>
  </tbody>
</table>

Primarily, Nmap looks at the banners of the scanned ports and prints them out. If it cannot identify versions through the banners, Nmap attempts to identify them through a signature-based matching system, but this significantly increases the scan's duration. One disadvantage to Nmap's presented results is that the automatic scan can miss some information because sometimes Nmap does not know how to handle it. Let us look at an example of this.

@htb[/htb]$ sudo nmap 10.129.2.28 -p- -sV -Pn -n --disable-arp-ping --packet-trace

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-16 20:10 CEST
<SNIP>
NSOCK INFO [0.4200s] nsock_trace_handler_callback(): Callback: READ SUCCESS for EID 18 [10.129.2.28:25] (35 bytes): 220 inlane ESMTP Postfix (Ubuntu)..
Service scan match (Probe NULL matched with NULL line 3104): 10.129.2.28:25 is smtp. Version: |Postfix smtpd|||
NSOCK INFO [0.4200s] nsock_iod_delete(): nsock_iod_delete (IOD #1)
Nmap scan report for 10.129.2.28
Host is up (0.076s latency).

PORT STATE SERVICE VERSION

25/tcp open smtp Postfix smtpd

MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Service Info: Host: inlane

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .

Nmap done: 1 IP address (1 host up) scanned in 0.47 seconds

<table border="1">
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
      <td>-p-</td>
      <td>Scans all ports.</td>
    </tr>
    <tr>
      <td>-sV</td>
      <td>Performs service version detection on specified ports.</td>
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

If we look at the results from Nmap, we can see the port's status, service name, and hostname. Nevertheless, let us look at this line here:

NSOCK INFO [0.4200s] nsock_trace_handler_callback(): Callback: READ SUCCESS for EID 18 [10.129.2.28:25] (35 bytes): 220 inlane ESMTP Postfix (Ubuntu)..
Then we see that the SMTP server on our target gave us more information than Nmap showed us. Because here, we see that it is the Linux distribution Ubuntu. It happens because, after a successful three-way handshake, the server often sends a banner for identification. This serves to let the client know which service it is working with. At the network level, this happens with a PSH flag in the TCP header. However, it can happen that some services do not immediately provide such information. It is also possible to remove or manipulate the banners from the respective services. If we manually connect to the SMTP server using nc, grab the banner, and intercept the network traffic using tcpdump, we can see what Nmap did not show us.

<h3>Tcpdump</h3>

@htb[/htb]$ sudo tcpdump -i eth0 host 10.10.14.2 and 10.129.2.28

tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes

<h3>Nc</h3>

@htb[/htb]$ nc -nv 10.129.2.28 25

Connection to 10.129.2.28 port 25 [tcp/*] succeeded!
220 inlane ESMTP Postfix (Ubuntu)

<h3>Tcpdump - Intercepted Traffic</h3>

18:28:07.128564 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [S], seq 1798872233, win 65535, options [mss 1460,nop,wscale 6,nop,nop,TS val 331260178 ecr 0,sackOK,eol], length 0

18:28:07.255151 IP 10.129.2.28.smtp > 10.10.14.2.59618: Flags [S.], seq 1130574379, ack 1798872234, win 65160, options [mss 1460,sackOK,TS val 1800383922 ecr 331260178,nop,wscale 7], length 0

18:28:07.255281 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [.], ack 1, win 2058, options [nop,nop,TS val 331260304 ecr 1800383922], length 0

18:28:07.319306 IP 10.129.2.28.smtp > 10.10.14.2.59618: Flags [P.], seq 1:36, ack 1, win 510, options [nop,nop,TS val 1800383985 ecr 331260304], length 35: SMTP: 220 inlane ESMTP Postfix (Ubuntu)

18:28:07.319426 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [.], ack 36, win 2058, options [nop,nop,TS val 331260368 ecr 1800383985], length 0

The first three lines show us the three-way handshake.

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>#</th>
      <th>Flag</th>
      <th>Packet Details</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>[SYN]</td>
      <td>18:28:07.128564 IP 10.10.14.2.59618 &gt; 10.129.2.28.smtp: Flags [S], &lt;SNIP&gt;</td>
    </tr>
    <tr>
      <td>2</td>
      <td>[SYN-ACK]</td>
      <td>18:28:07.255151 IP 10.129.2.28.smtp &gt; 10.10.14.2.59618: Flags [S.], &lt;SNIP&gt;</td>
    </tr>
    <tr>
      <td>3</td>
      <td>[ACK]</td>
      <td>18:28:07.255281 IP 10.10.14.2.59618 &gt; 10.129.2.28.smtp: Flags [.], &lt;SNIP&gt;</td>
    </tr>
  </tbody>
</table>

After that, the target SMTP server sends us a TCP packet with the PSH and ACK flags, where PSH states that the target server is sending data to us and with ACK simultaneously informs us that all required data has been sent.

4. [PSH-ACK] 18:28:07.319306 IP 10.129.2.28.smtp > 10.10.14.2.59618: Flags [P.], <SNIP>

The last TCP packet that we sent confirms the receipt of the data with an ACK.

18:28:07.319426 IP 10.10.14.2.59618 > 10.129.2.28.smtp: Flags [.], <SNIP>
