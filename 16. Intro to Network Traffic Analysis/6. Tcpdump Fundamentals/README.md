<h3>Tcpdump Fundamentals</h3>

Tcpdump is a command-line packet sniffer that can directly capture and interpret data frames from a file or network interface. It was built for use on any Unix-like operating system and had a Windows twin called WinDump. It is a potent and straightforward tool used on most Unix-based systems. It does not require a GUI and can be used through any terminal or remote connection, such as SSH. Nevertheless, this tool can seem overwhelming at first due to the many different functions and filters it offers us. However, once we learn the essential functions, we will find it much easier to use this tool efficiently. To capture network traffic from "off the wire," it uses the libraries pcap and libpcap, paired with an interface in promiscuous mode to listen for data. This allows the program to see and capture packets sourcing from or destined for any device in the local area network, not just the packets destined for us.

TCPDump is available for most Unix systems and Unix derivatives, such as AIX, BSD, Linux, Solaris, and is supplied by many manufacturers already in the system. Due to the direct access to the hardware, we need the root or the administrator's privileges to run this tool. For us that means we will have to utilize sudo to execute TCPDump as seen in the examples below. TCPDump often comes preinstalled on the majority of Linux operating systems.

It should be noted that Windows had a port of TCPDump called Windump. Support for windump has ceased. As an alternative running a Linux distribution such as Parrot or Ubuntu in Windows Subsystem for Linux can be an easy way to have a Linux virtual host right on our computer, allowing for the use of TCPDump and many other Linux built tools.

<h3>Locate Tcpdump</h3>

To validate if the package exists on our host, use the following command:

@htb[/htb]$ which tcpdump

Often it can be found in /usr/sbin/tcpdump. However, if the package does not exist, we can install it with:

<h3>Install Tcpdump</h3>

@htb[/htb]$ sudo apt install tcpdump

We can run the tcpdump package with the --version switch to check our install and current package version to validate our install.

<h3>Tcpdump Version Validation</h3>

@htb[/htb]$ sudo tcpdump --version

tcpdump version 4.9.3

libpcap version 1.9.1 (with TPACKET_V3)

OpenSSL 1.1.1f 31 Mar 2020

<h3>Traffic Captures with Tcpdump</h3>

Because of the many different functions and filters, we should first familiarize ourselves with the tool's essential features. Let us discuss some basic TCPDump options, demo some commands, and show how to save traffic to PCAP files and read from these.

<h3>Basic Capture Options</h3>

Below is a table of basic Tcpdump switches we can use to modify how our captures run. These switches can be chained together to craft how the tool output is shown to us in STDOUT and what is saved to the capture file. This is not an exhaustive list, and there are many more we can use, but these are the most common and valuable.

<table border="1" cellpadding="6" cellspacing="0">
    <thead>
        <tr>
            <th>Switch Command</th>
            <th>Result</th>
        </tr>
    </thead>
    <tbody>
        <tr><td>D</td><td>Will display any interfaces available to capture from.</td></tr>
        <tr><td>i</td><td>Selects an interface to capture from. ex. -i eth0</td></tr>
        <tr><td>n</td><td>Do not convert addresses (i.e., host addresses, port numbers, etc.) to names.</td></tr>
        <tr><td>e</td><td>Will grab the ethernet header along with upper-layer data.</td></tr>
        <tr><td>X</td><td>Show contents of packets in hex and ASCII.</td></tr>
        <tr><td>XX</td><td>Same as X, but will also specify ethernet headers (like using Xe).</td></tr>
        <tr><td>v, vv, vvv</td><td>Increase the verbosity of output shown and saved.</td></tr>
        <tr><td>c</td><td>Grab a specific number of packets, then quit the program.</td></tr>
        <tr><td>s</td><td>Defines how much of a packet to grab.</td></tr>
        <tr><td>S</td><td>Change relative sequence numbers to absolute sequence numbers.</td></tr>
        <tr><td>q</td><td>Print less protocol information.</td></tr>
        <tr><td>r file.pcap</td><td>Read from a file.</td></tr>
        <tr><td>w file.pcap</td><td>Write into a file.</td></tr>
    </tbody>
</table>

<h3>Man Page Utilization</h3>

To see the complete list of switches, we can utilize the man pages:

<h3>Tcpdump Man Page</h3>

@htb[/htb]$ man tcpdump

Here are some examples of basic Tcpdump switch usage along with descriptions of what is happening:

<h3>Listing Available Interfaces</h3>

@htb[/htb]$ sudo tcpdump -D

1.eth0 [Up, Running, Connected]

2.any (Pseudo-device that captures on all interfaces) [Up, Running]

3.lo [Up, Running, Loopback]

4.bluetooth0 (Bluetooth adapter number 0) [Wireless, Association status unknown]

5.bluetooth-monitor (Bluetooth Linux Monitor) [Wireless]

6.nflog (Linux netfilter log (NFLOG) interface) [none]

7.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]

8.dbus-system (D-Bus system bus) [none]

9.dbus-session (D-Bus session bus) [none]

The above command calls tcpdump using sudo privileges and lists the usable network interfaces. We can choose one of these network interfaces and tell tcpdump which interfaces it should listen to.

<h3>Choosing an Interface to Capture From</h3>

@htb[/htb]$ sudo tcpdump -i eth0

tcpdump: verbose output suppressed, use -v[v]... for full protocol decode

listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes

In this terminal, we are calling tcpdump and selecting the interface eth0 to capture traffic. Once we issue the command, tcpdump will begin to sniff traffic and see the first few packets across the interface. By issuing the -nn switches as seen below, we tell TCPDump to refrain from resolving IP addresses and port numbers to their hostnames and common port names. In this representation, the last octet is the port from/to which the connection goes.

<h3>Disable Name Resolution</h3>

@htb[/htb]$ sudo tcpdump -i eth0 -nn

tcpdump: verbose output suppressed, use -v[v]... for full protocol decode

listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes

When utilizing the -e switch, we are tasking tcpdump to include the ethernet headers in the capture's output along with its regular content. We can see this worked by examining the output. Usually, the first and second fields consist of the Timestamp and then the IP header's beginning. Now it consists of Timestamp and the source MAC Address of the host.

<h3>Display the Ethernet Header</h3>

@htb[/htb]$ sudo tcpdump -i eth0 -e

tcpdump: verbose output suppressed, use -v[v]... for full protocol decode

listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes

@htb[/htb]$ sudo tcpdump -i eth0 -e

tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes

<h3>Include ASCII and Hex Output</h3>

@htb[/htb]$ sudo tcpdump -i eth0 -X

Pay attention to the level of detail in the output above. We will notice that we have information on the IP header options like time to live, offset, and other flags and more details into the upper layer protocols. Below, we are combining the switches to craft the output to our liking.

<h3>Tcpdump Switch Combinations</h3>

@htb[/htb]$ sudo tcpdump -i eth0 -nnvXX

tcpdump: listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes

11:13:59.149599 IP (tos 0x0, ttl 64, id 24075, offset 0, flags [DF], proto TCP (6), length 89)

When utilizing the switches, chaining them together as in the example above is best practice.

<h3>Tcpdump Output</h3>

When looking at the output from TCPDump, it can be a bit overwhelming. Running through these basic switches has already shown us several different views. We are going to take a minute to dissect that output and explain what we are seeing. The image and table below will define each field. Keep in mind that the more verbose we are with our filters, the more detail from each header is shown.

<h3>Tcpdump Shell Breakdown</h3>
