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
