<h3>Analysis with Wireshark</h3>

Wireshark is a free and open-source network traffic analyzer much like tcpdump but with a graphical interface. Wireshark is multi-platform and capable of capturing live data off many different interface types (to include WiFi, USB, and Bluetooth) and saving the traffic to several different formats. Wireshark allows the user to dive much deeper into the inspection of network packets than other tools. What makes Wireshark truly powerful is the analysis capability it provides, giving a detailed insight into the traffic.

Depending on the host we are using, we may not always have a GUI to utilize traditional Wireshark. Lucky for us, several variants allow us to use it from the command line.

<h3>Features and Capabilities:</h3>

- Deep packet inspection for hundreds of different protocols

- Graphical and TTY interfaces

- Capable of running on most Operating systems

- Ethernet, IEEE 802.11, PPP/HDLC, ATM, Bluetooth, USB, Token Ring, Frame Relay, FDDI, among others

- Decryption capabilities for IPsec, ISAKMP, Kerberos, SNMPv3, SSL/TLS, WEP, and WPA/WPA2

- Many many more...

<h3>Requirements for Use</h3>

Wireshark requires the following for use:

<h3>Windows:</h3>

- The Universal C Runtime. This is included with Windows 10 and Windows Server 2019 and is installed automatically on earlier versions if Microsoft Windows Update is enabled. Otherwise, KB2999226 or KB3118401 must be installed.

- Any modern 64-bit AMD64/x86-64 or 32-bit x86 processor.

- 500 MB available RAM. Larger capture files require more RAM.

- 500 MB available disk space. Capture files require additional disk space.

- Any modern display. 1280 × 1024 or higher resolution is recommended. Wireshark will make use of HiDPI or Retina resolutions if available. Power users will find multiple monitors useful.

- A supported network card for capturing:

- Ethernet. Any card supported by Windows should work.

- 802.11. See the Wireshark wiki page. Capturing raw 802.11 information may be difficult without special equipment.
  
- To install, download the executable from wireshark.org, validate the hash, and install.

Linux:

- Wireshark runs on most UNIX and UNIX-like platforms, including Linux and most BSD variants. The system requirements should be comparable to the specifications listed above for Windows.

- Binary packages are available for most Unix and Linux distributions.

- To validate if the package exists on a host, use the following command:

<h3>Locating Wireshark</h3>

@htb[/htb]$ which wireshark

If the package does not exist, (It can often be found in /usr/sbin/wireshark) you can install it with:

<h3>Installing Wireshark On Linux</h3>

@htb[/htb]$ sudo apt install wireshark 

<h3>TShark VS. Wireshark (Terminal vs. GUI)</h3>

Both options have their merits. TShark is a purpose-built terminal tool based on Wireshark. TShark shares many of the same features that are included in Wireshark and even shares syntax and options. TShark is perfect for use on machines with little or no desktop environment and can easily pass the capture information it receives to another tool via the command line. Wireshark is the feature-rich GUI option for traffic capture and analysis. If you wish to have the full-featured experience and work from a machine with a desktop environment, the Wireshark GUI is the way to go.

<h3>Basic TShark Switches</h3>

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Switch</th>
      <th>Command Result</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>D</td>
      <td>Will display any interfaces available to capture from and then exit out.</td>
    </tr>
    <tr>
      <td>L</td>
      <td>Will list the link-layer mediums you can capture from and then exit out (e.g., Ethernet).</td>
    </tr>
    <tr>
      <td>i</td>
      <td>Choose an interface to capture from (e.g., <code>-i eth0</code>).</td>
    </tr>
    <tr>
      <td>f</td>
      <td>Packet filter in libpcap syntax. Used during capture.</td>
    </tr>
    <tr>
      <td>c</td>
      <td>Grab a specific number of packets, then quit the program (defines a stop condition).</td>
    </tr>
    <tr>
      <td>a</td>
      <td>Defines an autostop condition (duration, file size, or number of packets).</td>
    </tr>
    <tr>
      <td>r</td>
      <td>Read packets from a file (<code>pcap-file</code>).</td>
    </tr>
    <tr>
      <td>W</td>
      <td>Write packets into a file using the <code>pcapng</code> format.</td>
    </tr>
    <tr>
      <td>P</td>
      <td>Print the packet summary while writing into a file (<code>-W</code>).</td>
    </tr>
    <tr>
      <td>x</td>
      <td>Add Hex and ASCII output into the capture.</td>
    </tr>
    <tr>
      <td>h</td>
      <td>Display the help menu.</td>
    </tr>
  </tbody>
</table>


To see the full list of switches you can utilize:

<h3>TShark Help</h3>

@htb[/htb]$ tshark -h

<h3>TShark Basic Usage</h3>

TShark can use filters for protocols, common items like hosts and ports, and even the ability to dig deeper into the packets and dissect individual fields from the packet.

<h3>Locating TShark</h3>

htb[/htb]$ which tshark

htb[/htb]$ tshark -D

htb[/htb]$ tshark -i 1 -w /tmp/test.pcap

Capturing on 'Wi-Fi: en0'

484

With the basic string in the command line above, we utilize TShark to capture on en0, specified with the -i flag and the -w option to save the capture to a specified output file. Utilizing TShark is very similar to TCPDump in the filters and switches we can use. Both tools utilize BPF syntax. To read the capture, tshark can be passed the -r switch just like in TCPDump, or we can pass the -P switch to have tshark print the packet summaries while writing out to a file. Below is an example of reading from the PCAP file we previously captured.

<h3>Selecting an Interface & Writing to a File</h3>

@htb[/htb]$ sudo tshark -i eth0 -w /tmp/test.pcap

<h3>Applying Filters</h3>

@htb[/htb]$ sudo tshark -i eth0 -f "host 172.16.146.2"

-f allows us to apply filters to the capture. In the example, we utilized host, but you can use almost any filter Wireshark recognizes. We have touched on TShark a bit now. Let's take a look at a nifty tool called Termshark.

<h3>Termshark</h3>

Termshark is a Text-based User Interface (TUI) application that provides the user with a Wireshark-like interface right in your terminal window.

<h3>Termshark</h3>

<img width="882" height="551" alt="image" src="https://github.com/user-attachments/assets/71404a49-c486-45e1-9dfd-2a9fe4b58042" />


Termshark can be found at Termshark. It can be built from the source by cloning the repo, or pull down one of the current stable releases from https://github.com/gcla/termshark/releases , extract the file, and hit the ground running.

For help navigating this TUI, see the image below.

<h3>Termshark Help</h3>

<img width="877" height="553" alt="image" src="https://github.com/user-attachments/assets/b148ba8a-c9e6-4acd-b5bc-28596082a5f9" />

To start Termshark, issue the same strings, much like TShark or tcpdump. We can specify an interface to capture on, filters, and other settings from the terminal. The Termshark window will not open until it senses traffic in its capture filter. So give it a second if nothing happens.

<h3>Wireshark GUI Walkthrough</h3>

Now that we have spent time learning the art of packet capture from the command line let's spend some time in Wireshark. We will take a few minutes to examine what we are looking at in the output below. Let's dissect this view of the Wireshark GUI.

<h3>Wireshark GUI</h3>

<img width="890" height="595" alt="image" src="https://github.com/user-attachments/assets/6a633f92-c162-4e04-bec3-7d91f5119b34" />

<h3>Three Main Panes: See Figure above</h3>

1. Packet List: Orange

In this window, we see a summary line of each packet that includes the fields listed below by default. We can add or remove columns to change what information is presented.

- Number- Order the packet arrived in Wireshark

- Time- Unix time format

- Source- Source IP

- Destination- Destination IP

- Protocol- The protocol used (TCP, UDP, DNS, ETC.)

- Information- Information about the packet. This field can vary based on the type of protocol used within. It will show, for example, what type of query It is for a DNS packet.

2. Packet Details: Blue

- The Packet Details window allows us to drill down into the packet to inspect the protocols with greater detail. It will break it down into chunks that we would expect following the typical OSI Model reference. The packet is dissected into different encapsulation layers for inspection.

- Keep in mind, Wireshark will show this encapsulation in reverse order with lower layer encapsulation at the top of the window and higher levels at the bottom.

3. Packet Bytes: Green

- The Packet Bytes window allows us to look at the packet contents in ASCII or hex output. As we select a field from the windows above, it will be highlighted in the Packet Bytes window and show us where that bit or byte falls within the overall packet.

- This is a great way to validate that what we see in the Details pane is accurate and the interpretation Wireshark made matches the packet output.

- Each line in the output contains the data offset, sixteen hexadecimal bytes, and sixteen ASCII bytes. Non-printable bytes are replaced with a period in the ASCII format.

<h3>Other Notable Features</h3>

When looking at the Wireshark interface, we will notice a few different option areas and radial buttons. These areas are control points in which we can modify the interface and our view of the packets in the current capture. See Figure below

<h3>Wireshark Menu</h3>

<img width="890" height="597" alt="image" src="https://github.com/user-attachments/assets/8d076b8b-2ffa-4a46-b6e1-019d18b139ae" />

<h3>Performing our first capture in Wireshark</h3>

Starting a capture with Wireshark is a simple endeavor. The gif below will show the steps.

<img width="991" height="797" alt="image" src="https://github.com/user-attachments/assets/d91d4ce0-b35e-42f5-a873-2d6dbdd52af0" />

<img width="978" height="794" alt="image" src="https://github.com/user-attachments/assets/44a79732-b9f9-4552-8d06-fd493077d8f2" />

Keep in mind, any time we change the capture options, Wireshark will restart the trace. Much like TCPDump, Wireshark has capture and display filter options that can be used.

<h3>The Basics</h3>

The Toolbar

<img width="1009" height="644" alt="image" src="https://github.com/user-attachments/assets/561d21e9-3e20-42d6-a05c-9f04496ee82c" />

<h3>Pre-capture and Post-capture Processing and Filtering</h3>

While capturing traffic with Wireshark, we have several options regarding how and when we filter out traffic. This is accomplished utilizing Capture and Display filters. The Former initiated before the capture starts and the latter during or after capture is complete. While Wireshark has a bunch of useful baked-in functionality, it is worth mentioning that it has a bit of trouble handling large captures. The more packets captured, the longer it will take Wireshark to run the display or analysis filter against it. It can take from just a couple of seconds to a few minutes if it completes at all. If we are working with a large pcap file, it may be best to break it up into smaller chunks first.

<h3>Capture Filters</h3>

Capture Filters- are entered before the capture is started. These use BPF syntax like host 214.15.2.30 much in the same fashion as TCPDump. We have fewer filter options this way, and a capture filter will drop all other traffic not explicitly meeting the criteria set. This is a great way to trim down the data you write to disk when troubleshooting a connection, such as capturing the conversations between two hosts.

Here is a table of common and helpful capture filters with a description of each:

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Capture Filters</th>
      <th>Result</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>host x.x.x.x</code></td>
      <td>Capture only traffic pertaining to a certain host</td>
    </tr>
    <tr>
      <td><code>net x.x.x.x/24</code></td>
      <td>Capture traffic to or from a specific network (using slash notation to specify the mask)</td>
    </tr>
    <tr>
      <td><code>src net x.x.x.x/24</code><br><code>dst net x.x.x.x/24</code></td>
      <td>Capture traffic sourcing from or destined to the specified network</td>
    </tr>
    <tr>
      <td><code>port #</code></td>
      <td>Capture traffic only on the specified port</td>
    </tr>
    <tr>
      <td><code>not port #</code></td>
      <td>Capture all traffic except the specified port</td>
    </tr>
    <tr>
      <td><code>port # and #</code></td>
      <td>Capture traffic on both specified ports</td>
    </tr>
    <tr>
      <td><code>portrange x-x</code></td>
      <td>Capture traffic from all ports within the specified range</td>
    </tr>
    <tr>
      <td><code>ip</code> / <code>ether</code> / <code>tcp</code></td>
      <td>Capture traffic from the specified protocol headers only</td>
    </tr>
    <tr>
      <td><code>broadcast</code> / <code>multicast</code> / <code>unicast</code></td>
      <td>Capture specific traffic types: one-to-all, one-to-many, or one-to-one</td>
    </tr>
  </tbody>
</table>

<h3>Applying a Capture Filter</h3>

Before we apply a capture filter, let us take a look at the built-in filters. To do so: Click on the capture radial at the top of the Wireshark window → then select capture filters from the drop-down.

<h3>Filter List</h3>

<img width="991" height="593" alt="image" src="https://github.com/user-attachments/assets/3d3c3600-c4db-41ca-bd4c-f2962f7636c7" />


From here, we can modify the existing filters or add our own.

To apply the filter to a capture, we will: Click on the capture radial at the top of the Wireshark window → then select Options from the drop-down → in the new window select the drop-down for Capture filter for selected interfaces or type in the filter we wish to use. below the red arrow in the picture below

<h3>Applying A Capture Filter</h3>

<img width="994" height="510" alt="image" src="https://github.com/user-attachments/assets/5e427538-0aac-44f1-82fa-c9fd0c1bfb46" />

<h3>Display Filters</h3>

Display Filters- are used while the capture is running and after the capture has stopped. Display filters are proprietary to Wireshark, which offers many different options for almost any protocol.

Here is a table of common and helpful display filters with a description of each:

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Display Filters</th>
      <th>Result</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>ip.addr == x.x.x.x</code></td>
      <td>Display only traffic pertaining to a certain host (logical OR match)</td>
    </tr>
    <tr>
      <td><code>ip.addr == x.x.x.x/24</code></td>
      <td>Display traffic pertaining to a specific network (logical OR match)</td>
    </tr>
    <tr>
      <td><code>ip.src == x.x.x.x</code><br><code>ip.dst == x.x.x.x</code></td>
      <td>Display traffic sourced from or destined to a specific host</td>
    </tr>
    <tr>
      <td><code>dns</code> / <code>tcp</code> / <code>ftp</code> / <code>arp</code> / <code>ip</code></td>
      <td>Filter traffic by a specific protocol (many more protocols supported)</td>
    </tr>
    <tr>
      <td><code>tcp.port == x</code></td>
      <td>Filter traffic by a specific TCP port</td>
    </tr>
    <tr>
      <td><code>tcp.port != x</code><br><code>udp.port != x</code></td>
      <td>Display all traffic except the specified port</td>
    </tr>
    <tr>
      <td><code>and</code> / <code>or</code> / <code>not</code></td>
      <td>
        Logical operators:<br>
        <strong>AND</strong> combines conditions,<br>
        <strong>OR</strong> matches either condition,<br>
        <strong>NOT</strong> excludes a condition
      </td>
    </tr>
  </tbody>
</table>

 Keep in mind, while utilizing Display filters traffic is processed to show only what is requested but the rest of the capture file will not be overwritten. Applying Display filters and analysis options will cause Wireshark to reprocess the pcap data in order to apply.

<h3>Applying a Display Filter</h3>

Applying a display filter is even easier than a capture filter. From the main Wireshark capture window, all we need to do is: select the bookmark in the Toolbar → , then select an option from the drop-down. Alternatively, place the cursor in the text radial → and type in the filter we wish to use. If the field turns green, the filter is correct. Just like in the image below.

<h3>Applying Display Filters</h3>

<img width="1001" height="356" alt="image" src="https://github.com/user-attachments/assets/873950f2-5abc-4938-a928-0dad34418e9d" />

When using capture and display filters, keep in mind that what we specify is taken in a literal sense. For example, filtering for port 80 traffic is not the same as filtering for HTTP. Think of ports and protocols more like guidelines instead of rigid rules. Ports can be bound and used for different purposes other than what they were originally intended. For example, filtering for HTTP will look for key markers that the protocol uses, such as GET/POST requests, and show results from them. Filtering for port 80 will show anything sent or received over that port regardless of the transport protocol.

In the next section, we will work with some of the more advanced features of Wireshark.
