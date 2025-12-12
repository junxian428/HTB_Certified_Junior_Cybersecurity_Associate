<h3>Performance</h3>

Scanning performance plays a significant role when we need to scan an extensive network or are dealing with low network bandwidth. We can use various options to tell Nmap how fast (-T <0-5>), with which frequency (--min-parallelism <number>), which timeouts (--max-rtt-timeout <time>) the test packets should have, how many packets should be sent simultaneously (--min-rate <number>), and with the number of retries (--max-retries <number>) for the scanned ports the targets should be scanned.

<h3>Timeout</h3>

When Nmap sends a packet, it takes some time (Round-Trip-Time - RTT) to receive a response from the scanned port. Generally, Nmap starts with a high timeout (--min-RTT-timeout) of 100ms. Let us look at an example by scanning the whole network with 256 hosts, including the top 100 ports.

<h3>Default Scan</h3>

@htb[/htb]$ sudo nmap 10.129.2.0/24 -F

<SNIP>

Nmap done: 256 IP addresses (10 hosts up) scanned in 39.44 seconds

<h3>Optimized RTT</h3>

@htb[/htb]$ sudo nmap 10.129.2.0/24 -F --initial-rtt-timeout 50ms --max-rtt-timeout 100ms

<SNIP>

Nmap done: 256 IP addresses (8 hosts up) scanned in 12.29 seconds

<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.0/24</td>
      <td>Scans the specified target network.</td>
    </tr>
    <tr>
      <td>-F</td>
      <td>Scans top 100 ports.</td>
    </tr>
    <tr>
      <td>--initial-rtt-timeout 50ms</td>
      <td>Sets the specified time value as initial RTT timeout.</td>
    </tr>
    <tr>
      <td>--max-rtt-timeout 100ms</td>
      <td>Sets the specified time value as maximum RTT timeout.</td>
    </tr>
  </tbody>
</table>

When comparing the two scans, we can see that we found two hosts less with the optimized scan, but the scan took only a quarter of the time. From this, we can conclude that setting the initial RTT timeout (--initial-rtt-timeout) to too short a time period may cause us to overlook hosts.

<h3>Max Retries</h3>

Another way to increase scan speed is by specifying the retry rate of sent packets (--max-retries). The default value is 10, but we can reduce it to 0. This means if Nmap does not receive a response for a port, it won't send any more packets to that port and will skip it.

<h3>Default Scan</h3>

@htb[/htb]$ sudo nmap 10.129.2.0/24 -F | grep "/tcp" | wc -l

23

<h3>Reduced Retries</h3>

@htb[/htb]$ sudo nmap 10.129.2.0/24 -F --max-retries 0 | grep "/tcp" | wc -l

21

<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.0/24</td>
      <td>Scans the specified target network.</td>
    </tr>
    <tr>
      <td>-F</td>
      <td>Scans top 100 ports.</td>
    </tr>
    <tr>
      <td>--max-retries 0</td>
      <td>Sets the number of retries that will be performed during the scan.</td>
    </tr>
  </tbody>
</table>

Again, we recognize that accelerating can also have a negative effect on our results, which means we can overlook important information.

<h3>Rates</h3>

During a white-box penetration test, we may get whitelisted for the security systems to check the systems in the network for vulnerabilities and not only test the protection measures. If we know the network bandwidth, we can work with the rate of packets sent, which significantly speeds up our scans with Nmap. When setting the minimum rate (--min-rate <number>) for sending packets, we tell Nmap to simultaneously send the specified number of packets. It will attempt to maintain the rate accordingly.

<h3>Default Scan</h3>

@htb[/htb]$ sudo nmap 10.129.2.0/24 -F -oN tnet.default

<SNIP>

Nmap done: 256 IP addresses (10 hosts up) scanned in 29.83 seconds

<h3>Optimized Scan</h3>

@htb[/htb]$ sudo nmap 10.129.2.0/24 -F -oN tnet.minrate300 --min-rate 300

<SNIP>

Nmap done: 256 IP addresses (10 hosts up) scanned in 8.67 seconds

<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.0/24</td>
      <td>Scans the specified target network.</td>
    </tr>
    <tr>
      <td>-F</td>
      <td>Scans top 100 ports.</td>
    </tr>
    <tr>
      <td>-oN tnet.minrate300</td>
      <td>Saves the results in normal format, starting the specified file name.</td>
    </tr>
    <tr>
      <td>--min-rate 300</td>
      <td>Sets the minimum number of packets to be sent per second.</td>
    </tr>
  </tbody>
</table>

<h3>Default Scan - Found Open Port</h3>

@htb[/htb]$ cat tnet.default | grep "/tcp" | wc -l

23

<h3>Optimized Scan - Found Open Ports</h3>

@htb[/htb]$ cat tnet.minrate300 | grep "/tcp" | wc -l

23

<h3>Timing</h3>

Because such settings cannot always be optimized manually, as in a black-box penetration test, Nmap offers six different timing templates (-T <0-5>) for us to use. These values (0-5) determine the aggressiveness of our scans. This can also have negative effects if the scan is too aggressive, and security systems may block us due to the produced network traffic. The default timing template used when we have defined nothing else is the normal (-T 3).

-T 0 / -T paranoid

-T 1 / -T sneaky

-T 2 / -T polite

-T 3 / -T normal

-T 4 / -T aggressive

-T 5 / -T insane

These templates contain options that we can also set manually, and have seen some of them already. The developers determined the values set for these templates according to their best results, making it easier for us to adapt our scans to the corresponding network environment. The exact used options with their values we can find here: https://nmap.org/book/performance-timing-templates.html

<h3>Default Scan</h3>

@htb[/htb]$ sudo nmap 10.129.2.0/24 -F -oN tnet.default

<SNIP>

Nmap done: 256 IP addresses (10 hosts up) scanned in 32.44 seconds

<h3>Insane Scan</h3>

@htb[/htb]$ sudo nmap 10.129.2.0/24 -F -oN tnet.T5 -T 5

<SNIP>

Nmap done: 256 IP addresses (10 hosts up) scanned in 18.07 seconds

<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.0/24</td>
      <td>Scans the specified target network.</td>
    </tr>
    <tr>
      <td>-F</td>
      <td>Scans top 100 ports.</td>
    </tr>
    <tr>
      <td>-oN tnet.T5</td>
      <td>Saves the results in normal format, starting the specified file name.</td>
    </tr>
    <tr>
      <td>-T 5</td>
      <td>Specifies the insane timing template.</td>
    </tr>
  </tbody>
</table>

<h3>Default Scan - Found Open Ports</h3>

@htb[/htb]$ cat tnet.default | grep "/tcp" | wc -l

23

<h3>Insane Scan - Found Open Ports</h3>

@htb[/htb]$ cat tnet.T5 | grep "/tcp" | wc -l

23

More information about scan performance we can find at https://nmap.org/book/man-performance.html
