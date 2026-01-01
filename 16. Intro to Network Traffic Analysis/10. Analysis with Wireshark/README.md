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

