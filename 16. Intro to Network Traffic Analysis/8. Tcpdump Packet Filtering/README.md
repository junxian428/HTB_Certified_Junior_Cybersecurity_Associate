<h3>Tcpdump Packet Filtering</h3>

Tcpdump provides a robust and efficient way to parse the data included in our captures via packet filters. This section will examine those filters and get a glimpse at how it modifies the output from our capture.

<h3>Filtering and Advanced Syntax Options</h3>

Utilizing more advanced filtering options like those listed below will enable us to trim down what traffic is printed to output or sent to file. By reducing the amount of info we capture and write to disk, we can help reduce the space needed to write the file and help the buffer process data quicker. Filters can be handy when paired with standard tcpdump syntax options. We can capture as widely as we wish, or be super specific only to capture packets from a particular host, or even with a particular bit in the TCP header set to on. It is highly recommended to explore the more advanced filters and find different combinations.

These filters and advanced operators are by no means an exhaustive list. They were chosen because they are the most frequently used and will get us up and running quickly. When implemented, these filters will inspect any packets captured and look for the given values in the protocol header to match.

<h3>Helpful TCPDump Filters</h3>

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Filter</th>
      <th>Result</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>host</td>
      <td>Filters visible traffic to show anything involving the designated host (bi-directional).</td>
    </tr>
    <tr>
      <td>src / dest</td>
      <td>Modifiers used to designate a source or destination host or port.</td>
    </tr>
    <tr>
      <td>net</td>
      <td>Shows traffic sourcing from or destined to the specified network using CIDR (/ notation).</td>
    </tr>
    <tr>
      <td>proto</td>
      <td>Filters for a specific protocol type (e.g., ether, TCP, UDP, ICMP).</td>
    </tr>
    <tr>
      <td>port</td>
      <td>Bi-directional filter showing traffic where the port is source or destination.</td>
    </tr>
    <tr>
      <td>portrange</td>
      <td>Allows specification of a range of ports (e.g., 0-1024).</td>
    </tr>
    <tr>
      <td>less / greater (&lt; &gt;)</td>
      <td>Filters packets based on size or protocol option length.</td>
    </tr>
    <tr>
      <td>and / &&</td>
      <td>Concatenates multiple filters together (e.g., src host AND port).</td>
    </tr>
    <tr>
      <td>or</td>
      <td>Matches traffic meeting either of the specified conditions.</td>
    </tr>
    <tr>
      <td>not</td>
      <td>Excludes traffic matching a condition (e.g., not UDP).</td>
    </tr>
  </tbody>
</table>

With these filters, we can filter the network traffic on most properties to facilitate the analysis. Let us look at some examples of these filters and how they look when we use them. When using the host filter, whatever IP we input will be checked for in the source or destination IP field. This can be seen in the output below.

<h3>Host Filter</h3>

@htb[/htb]$ ### Syntax: host [IP]

@htb[/htb]$ sudo tcpdump -i eth0 host 172.16.146.2

tcpdump: verbose output suppressed, use -v[v]... for full protocol decode

listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes

This filter is often used when we want to examine only a specific host or server. With this, we can identify with whom this host or server communicates and in which way. Based on our network configurations, we will understand if this connection is legitimate. If the communication seems strange, we can use other filters and options to view the content in more detail. Besides the individual hosts, we can also define the source host as well as the target host. We can also define entire networks and their ports.

<h3>Source/Destination Filter</h3>

@htb[/htb]$ ### Syntax: src/dst [host|net|port] [IP|Network Range|Port]

@htb[/htb]$ sudo tcpdump -i eth0 src host 172.16.146.2
  
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode

Source and destination allow us to work with the directions of communication. For example, in the last output, we have specified that our source host is 172.16.146.2, and only packets sent from this host will be intercepted. This can be done for ports, and network ranges as well. An example of this utilizing src port # would look something like this:

<h3>Utilizing Source With Port as a Filter</h3>

@htb[/htb]$ sudo tcpdump -i eth0 tcp src port 80

Notice now that we only see one side of the conversation? This is because we are filtering on the source port of 80 (HTTP). Used in this manner, net will grab anything matching the / notation for a network. In the example, we are looking for anything destined for the 172.16.146.0/24 network.

<h3>Using Destination in Combination with the Net Filter</h3>

@htb[/htb]$ sudo tcpdump -i eth0 dest net 172.16.146.0/24

This filter can utilize the common protocol name or protocol number for any IP, IPv6, or Ethernet protocol. Common examples would be tcp[6], udp[17], or icmp[1]. In the outputs below, we will utilize both the common name (top) and the protocol number (bottom). We can see it produced the same output. For the most part, these are interchangeable, but utilizing proto will become more useful when you are starting to dissect a specific part of the IP or other protocol headers. It will be more apparent later in this section when we talk about looking for TCP flags. We can take a look at this resource for a helpful list covering protocol numbers.

<h3>Protocol Filter - Common Name</h3>

@htb[/htb]$ ### Syntax: [tcp/udp/icmp]

@htb[/htb]$ sudo tcpdump -i eth0 udp

<h3>Protocol Filter - Number</h3>

@htb[/htb]$ ### Syntax: proto [protocol number]

@htb[/htb]$ sudo tcpdump -i eth0 proto 17

06:17:09.864896 IP dialin-145-254-160-237.pools.arcor-ip.net.3009 > 145.253.2.203.domain: 35+ A? pagead2.googlesyndication.com. (47)

06:17:10.225414 IP 145.253.2.203.domain > dialin-145-254-160-237.pools.arcor-ip.net.3009: 35 4/0/0 CNAME pagead2.google.com., CNAME pagead.google.akadns.net., A 216.239.59.104, A 216.239.59.99 (146)

Using the port filter, we should keep in mind what we are looking for and how that protocol functions. Some standard protocols like HTTP or HTTPS only use ports 80 and 443 with the transport protocol of TCP. With that in mind, picture ports as a simple way to establish connections and protocols like TCP and UDP to determine if they use an established method. Ports by themselves can be used for anything, so filtering on port 80 will show all traffic over that port number. However, if we are looking to capture all HTTP traffic, utilizing tcp port 80 will ensure we only see HTTP traffic.

With protocols that use both TCP and UDP for different functions, such as DNS, we can filter looking at one or the other TCP/UDP port 53 or filter for port 53. By doing this, we will see any traffic-utilizing that port, regardless of the transport protocol.

<h3>Port Filter</h3>

@htb[/htb]$ ### Syntax: port [port number]

@htb[/htb]$ sudo tcpdump -i eth0 tcp port 443

Apart from the individual ports, we can also define specific ranges of these ports, which are then listened to by TCPdump. Listening on a range of ports can be especially useful when we see network traffic from ports that do not match the services running on our servers. For example, if we have a web server with TCP ports 80 and 443 running in a particular segment of our network and suddenly have outgoing network traffic from TCP port 10000 or others, it is very suspicious.

The portrange filter, as seen below, allows us to see everything from within the port range. In the example, we see some DNS traffic along with some HTTP web requests.

<h3>Port Range Filter</h3>

@htb[/htb]$ ### Syntax: portrange [portrange 0-65535]

@htb[/htb]$ sudo tcpdump -i eth0 portrange 0-1024

Next, we are looking for any packet less than 64 bytes. From the following output, we can see that for this capture, those packets mainly consisted of SYN, FIN, or KeepAlive packets. Less than and greater than can be a helpful modifier set. For example, let us say we are looking to capture traffic that includes a file transfer or set of files. We know these files will be larger than regular traffic. To demonstrate, we can utilize greater 500 (alternatively '>500'), which will only show us packets with a size larger than 500 bytes. This will strip out all the extra packets from the view we know we are not concerned with already.

<h3>Less/Greater Filter</h3>

@htb[/htb]$ ### Syntax: less/greater [size in bytes]

@htb[/htb]$ sudo tcpdump -i eth0 less 64

Above was an excellent example of using less. We can utilize the modifier greater 500 to only show me packets with 500 or more bytes. It came back with a unique response in the ASCII. Can we tell what happened here?

AND as a modifier will show us anything that meets both requirements set. For example, host 10.12.1.122 and tcp port 80 will look for anything from the source host and contain port 80 TCP or UDP traffic. Both criteria have to be met for the filter to capture the packet. We can see this in action below. Here we utilize host 192.168.0.1 and port 23 as a filter. So we will see only traffic that is from this particular host that is only port 23 traffic.


<h3>Utilizing Greater</h3>

@htb[/htb]$ sudo tcpdump -i eth0 greater 500

<h3>AND Filter</h3>

@htb[/htb]$ ### Syntax: and [requirement]

@htb[/htb]$ sudo tcpdump -i eth0 host 192.168.0.1 and port 23

The other modifiers, OR and NOT provide us with a way to specify multiple conditions or negate something. Let us play with that a bit now. What do we notice about this output?

<h3>Basic Capture With No Filter</h3>

@htb[/htb]$ sudo tcpdump -i eth0

We have a mix of different sources and destinations along with multiple protocol types. If we were to use the OR (alternatively ||) modifier, we could ask for traffic from a specific host or just ICMP traffic as an example. Let us rerun it and add in an OR.

<h3>OR Filter</h3>

@htb[/htb]$ ### Syntax: or/|| [requirement]

@htb[/htb]$ sudo tcpdump -r sus.pcap icmp or host 172.16.146.1

Our traffic looks a bit different now. That is because a lot of the packets matched the ICMP variable while some matched the host variable. So in this output, we can see some ARP traffic and ICMP traffic. The filter worked since 172.16.146.2 matched the other variable and appeared as a host in either the source or destination field. Now, what happens if we utilize the NOT (alternatively !) modifier.

<h3>NOT Filter</h3>

@htb[/htb]$ ### Syntax: not/! [requirement]

@htb[/htb]$ sudo tcpdump -r sus.pcap not icmp

It looks much different now. We only see some ARP traffic, and then we see some HTTPS traffic we did not get to before. This is because we negated any ICMP traffic from being displayed using not icmp.

<h3>Pre-Capture Filters VS. Post-Capture Processing</h3>

When utilizing filters, we can apply them directly to the capture or apply them when reading a capture file. By applying them to the capture, it will drop any traffic not matching the filter. This will reduce the amount of data in the captures and potentially clear out traffic we may need later, so use them only when looking for something specific, such as troubleshooting a network connectivity issue. When applying the filter to capture, we have read from a file, and the filter will parse the file and remove anything from our terminal output not matching the specified filter. Using a filter in this way can help us investigate while saving potential valuable data in the captures. It will not permanently change the capture file, and to change or clear the filter from our output will require we rerunning our command with a change in the syntax.

<h3>Interpreting Tips and Tricks</h3>

Using the -S switch will display absolute sequence numbers, which can be extremely long. Typically, tcpdump displays relative sequence numbers, which are easier to track and read. However, if we look for these values in another tool or log, we will only find the packet based on absolute sequence numbers. For example, 13245768092588 to 100.

The -v, -X, and -e switches can help you increase the amount of data captured, while the -c, -n, -s, -S, and -q switches can help reduce and modify the amount of data written and seen.

Many handy options that can be used but are not always directly valuable for everyone are the -A and -l switches. A will show only the ASCII text after the packet line, instead of both ASCII and Hex. L will tell tcpdump to output packets in a different mode. L will line buffer instead of pooling and pushing in chunks. It allows us to send the output directly to another tool such as grep using a pipe |.

<h3>Tips and Tricks</h3>

@htb[/htb]$sudo tcpdump -Ar telnet.pcap

21:12:43.528695 IP 192.168.0.1.telnet > 192.168.0.2.1550: Flags [P.], seq 157:217, ack 216, win 17376, options [nop,nop,TS val 2467382 ecr 10234022], length 60
E..p;...@..p..............c.......C........

Notice how it has the ASCII values shown below each output line because of our use of -A. This can be helpful when quickly looking for something human-readable in the output.

<h3>Piping a Capture to Grep</h3>

@htb[/htb]$ sudo tcpdump -Ar http.cap -l | grep 'mailto:*'

reading from file http.cap, link-type EN10MB (Ethernet), snapshot length 65535


Using -l in this way allowed us to examine the capture quickly and grep for keywords or formatting we suspected could be there. In this case, we used the -l to pass the output to grep and looking for any instance of the phrase mailto:*. This shows us every line with our search in it, and we can see the results above. Using modifiers and redirecting output can be a quick way to scrape websites for email addresses, naming standards, and much more.

We can dig as deep as we wish into the packets we captured. It requires a bit of knowledge of how the protocols are structured, however. For example, if we wanted to see only packets with the TCP SYN flag set, we could use the following command:

<h3>Looking for TCP Protocol Flags</h3>

@htb[/htb]$ tcpdump -i eth0 'tcp[13] &2 != 0'

This is counting to the 13th byte in the structure and looking at the 2nd bit. If it is set to 1 or ON, the SYN flag is set.

<h3>Hunting For a SYN Flag</h3>

@htb[/htb]$ sudo tcpdump -i eth0 'tcp[13] &2 != 0'

Our results include only packets with the TCP SYN flag set from what we see above.

TCPDump can be a powerful tool if we understand our networking and how hosts interact with one another. Take the time to understand typical protocol header structures to spot the anomaly when the time comes. Here are a few links to further our studies on standard Protocols and their structures. Except for the Wikipedia link, each link should take us directly to the RFC that sets the standard in place for each.

<h3>Protocol RFC Links</h3>

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Link</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>IP Protocol</td>
      <td>RFC 791 describes IP and its functionality.</td>
    </tr>
    <tr>
      <td>ICMP Protocol</td>
      <td>RFC 792 describes ICMP and its functionality.</td>
    </tr>
    <tr>
      <td>TCP Protocol</td>
      <td>RFC 793 describes the TCP protocol and how it functions.</td>
    </tr>
    <tr>
      <td>UDP Protocol</td>
      <td>RFC 768 describes UDP and how it operates.</td>
    </tr>
    <tr>
      <td>RFC Quick Links</td>
      <td>This Wikipedia article contains a large list of protocols tied to the RFCs that explain their implementation.</td>
    </tr>
  </tbody>
</table>

What filter will allow me to see traffic coming from or destined to the host with an ip of 10.10.20.1?

host 10.10.20.1

+ 0  What filter will allow me to capture based on either of two options?

or

+ 0  True or False: TCPDump will resolve IPs to hostnames by default.

True

