<h3>Networking Primer - Layers 1-4</h3>

This section serves as a quick refresher on networking and how some standard protocols we can see while performing traffic captures work. These concepts are at the core of capturing and dissecting traffic. Without a fundamental understanding of typical network flow and what ports and protocols are used, we cannot accurately analyze any traffic we capture. If this is the first time you encounter some of these terms or concepts, we suggest completing the Introduction to Networking Module first.

<h3>OSI / TCP-IP Models</h3>

<img width="990" height="620" alt="image" src="https://github.com/user-attachments/assets/6d1e5baa-bb74-4f2c-a60e-4b3ae80fbd9d" />

The image above gives a great view of the Open Systems Interconnect (OSI) model and the Transmission Control Protocol - Internet Protocol (TCP-IP) model side by side. The models are a graphical representation of how communication is handled between networked computers. Let's take a second to compare the two:

<h3>Model Traits Comparison</h3>

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Trait</th>
      <th>OSI</th>
      <th>TCP-IP</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Layers</td>
      <td>Seven</td>
      <td>Four</td>
    </tr>
    <tr>
      <td>Flexibility</td>
      <td>Strict</td>
      <td>Loose</td>
    </tr>
    <tr>
      <td>Dependency</td>
      <td>Protocol independent &amp; generic</td>
      <td>Based on common communication protocols</td>
    </tr>
  </tbody>
</table>

When examining these two models, we can notice that the OSI model is segmented more than the TCP-IP model. This is because it is broken down into small functional chunks. Layers one through four of the OSI model are focused on controlling the transportation of data between hosts. This control includes everything from the physical medium used for transmission to the protocol utilized to manage the conversation or lack thereof when transporting data. Layers five through seven handle the interpretation, management, and presentation of the encapsulated data presented to the end-user. Think of the OSI model as the theory behind how everything works, whereas the TCP-IP model is more closely aligned with the actual functionality of networking. The TCP-IP model is a bit more blended, and the rules are flexible. The TCP-IP model comprises four layers where layers five, six, and seven of the OSI model align with layer four of the TCP-IP model. Layer three deals with transportation, layer two is the internet layer which aligns with the network layer in OSI, and layer one is the link-layer which covers layers two and one of the OSI model.

Throughout this module, we will examine many different Protocol Data Units (PDU), so a functional understanding of how it appears in theory and on the wire is required. A PDU is a data packet made up of control information and data encapsulated from each layer of the OSI model. The breakout below will show how the layers in the two models match up to a PDU.

<h3>PDU Example</h3>

<img width="979" height="591" alt="image" src="https://github.com/user-attachments/assets/49e1264c-b48d-4196-9dc4-e09f6094cd15" />

When inspecting a PDU, we need to keep the idea of encapsulation in mind. As our data moves down the protocol stack, each layer will wrap the previous layers' data in a new bubble we call encapsulation. This bubble adds the necessary information of that layer into the header of the PDU. This information can vary by level, but it includes what is held by the previous layer, operational flags, any options required to negotiate communications, the source and destination IP addresses, ports, transport, and application layer protocols.

<h3>PDU Packet Breakdown</h3>

<img width="1002" height="542" alt="image" src="https://github.com/user-attachments/assets/0b4b93b4-25cf-4836-969a-594dc3071862" />

The image above shows us the makeup of a PDU side by side with a packet breakout from Wireshark's Packet Details pane. Please take note that when we see the breakout in Wireshark, it is in reverse order. Wireshark shows us the PDU in reverse because it is in the order that it was unencapsulated.

<h3>Addressing Mechanisms</h3>

Now that we have gone over the basic concepts driving networking behavior let us take some time to discuss the addressing mechanisms that enable the delivery of our packets to the correct hosts. We will begin with Media Access Control addresses first.

<h3>MAC-Addressing</h3>

Each logical or physical interface attached to a host has a Media Access Control (MAC) address. This address is a 48-bit six octet address represented in hexadecimal format. If we look at the image below, we can see an example of one by the red arrow.

<h3>Mac-Address</h3>

<img width="1003" height="221" alt="image" src="https://github.com/user-attachments/assets/071b77b1-3cd4-4446-95e5-776e5e4e5697" />


MAC-addressing is utilized in Layer two ( the data-link or link-layer depending on which model you look at ) communications between hosts. This works through host-to-host communication within a broadcast domain. If layer two traffic needs to cross a layer three interface, that PDU is sent to the layer three egress interface, and it is routed to the correct network. At layer two, this looks as though the PDU is addressed to the router interface, and the router will take the layer three address into account when determining where to send it next. Once it makes a choice, it strips the encapsulation at layer two and replaces it with new information that indicates the next physical address in the route.

<h3>IP Addressing</h3>

The Internet Protocol (IP) was developed to deliver data from one host to another across network boundaries. IP is responsible for routing packets, the encapsulation of data, and fragmentation and reassembly of datagrams when they reach the destination host. By nature, IP is a connectionless protocol that provides no assurances that data will reach its intended recipient. For the reliability and validation of data delivery, IP relies on upper-layer protocols such as TCP. Currently, there exist two main versions of IP. IPv4, which is the current dominant standard, and IPv6, which is intended to be the successor of IPv4.

<h3>IPv4</h3>

The most common addressing mechanism most are familiar with is the Internet Protocol address version 4 (IPv4). IPv4 addressing is the core method of routing packets across networks to hosts located outside our immediate vicinity. The image below shows us an example of an IPv4 address by the green arrow.

<h3>IP Address</h3>

<img width="962" height="221" alt="image" src="https://github.com/user-attachments/assets/39c3cd7c-72a6-477d-827d-ae17a450e147" />

An IPv4 address is made up of a 32-bit four octet number represented in decimal format. In our example, we can see the address 192.168.86.243. Each octet of an IP address can be represented by a number ranging from 0 to 255. When examining a PDU, we will find IP addresses in layer three (Network) of the OSI model and layer two (internet) of the TCP-IP model. We will not deep dive into IPv4 here, but for the sake of this module, understand what these addresses are, what they do for us, and at which layer they are used.

<h3>IPv6</h3>

<img width="951" height="212" alt="image" src="https://github.com/user-attachments/assets/a67ac728-9f53-476f-9a18-c0ee7bb831d6" />

Along with a much larger address space, IPv6 provides: Better support for Multicasting (sending traffic from one to many) Global addressing per device Security within the protocol in the form of IPSec Simplified Packet headers allow for easier processing and move from connection to connection without being re-assigned an address.

IPv6 uses four main types of addresses within its schema:

<h3>IPv6 Addressing Types</h3>

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Type</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Unicast</td>
      <td>Addresses for a single interface.</td>
    </tr>
    <tr>
      <td>Anycast</td>
      <td>Addresses for multiple interfaces, where only one of them receives the packet.</td>
    </tr>
    <tr>
      <td>Multicast</td>
      <td>Addresses for multiple interfaces, where all of them receive the same packet.</td>
    </tr>
    <tr>
      <td>Broadcast</td>
      <td>Does not exist and is realized with multicast addresses.</td>
    </tr>
  </tbody>
</table>

When thinking about each address type, it is helpful to remember that Unicast traffic is host to host, while Multicast is one to many, and Anycast is one to many in a group where only one will answer the packet. (think load balancing).

Even with its current state providing many advantages over IPv4, the adoption of IPv6 has been slow to catch on.

<h3>Adoption of IPv6</h3>

<img width="997" height="653" alt="image" src="https://github.com/user-attachments/assets/c0031a08-49e1-4fa3-b9e3-e6b2679f3cc3" />

At the time of writing, according to statistics published by Google, the adoption rate is only around 40 percent globally.

<h3>TCP / UDP, Transport Mechanisms</h3>

The Transport Layer has several mechanisms to help ensure the seamless delivery of data from source to destination. Think about the Transport layer as a control hub. Application data from the higher layers have to traverse down the stack to the Transport layer. This layer directs how the traffic will be encapsulated and thrown to the lower layer protocols ( IP and MAC ). Once the data reaches its intended recipient, the Transport layer, working with the Network / Internet layer protocols, is responsible for reassembling the encapsulated data back in the correct order. The two mechanisms used to accomplish this task are the Transmission Control (TCP) and the User Datagram Protocol (UDP).

<h3>TCP vs. UDP</h3>

Let us take a second to examine these two protocols side by side.

<h3>TCP VS. UDP</h3>

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Characteristic</th>
      <th>TCP</th>
      <th>UDP</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Transmission</td>
      <td>Connection-oriented</td>
      <td>Connectionless. Fire and forget.</td>
    </tr>
    <tr>
      <td>Connection Establishment</td>
      <td>TCP uses a three-way handshake to ensure that a connection is established.</td>
      <td>UDP does not ensure the destination is listening.</td>
    </tr>
    <tr>
      <td>Data Delivery</td>
      <td>Stream-based conversations</td>
      <td>Packet by packet, the source does not care if the destination is active.</td>
    </tr>
    <tr>
      <td>Receipt of data</td>
      <td>Sequence and Acknowledgement numbers are utilized to account for data.</td>
      <td>UDP does not care.</td>
    </tr>
    <tr>
      <td>Speed</td>
      <td>TCP has more overhead and is slower because of its built-in functions.</td>
      <td>UDP is fast but unreliable.</td>
    </tr>
  </tbody>
</table>

By looking at the table above, we can see that TCP and UDP provide two very different data transmission methods. TCP is considered a more reliable protocol since it allows for error checking and data acknowledgment as a normal function. In contrast, UDP is a quick, fire, and forget protocol best utilized when we care about speed over quality and validation.

To put this into perspective, TCP is utilized when moving data that requires completeness over speed. For example, when we use Secure Shell (SSH) to connect from one host to another, a connection is opened that stays active while you issue commands and perform actions. This is a function of TCP, ensuring our conversation with the distant host is not interrupted. If it does get interrupted for some reason, TCP will not reassemble a partial fragment of a packet and send it to the application. We can avoid errors this way. What would happen if we issued a command like sudo passwd user to change the user's password on a remote host, and during the change, part of the message drops. If this were over UDP, we would have no way of knowing what happened to the rest of that message and potentially mess up the user's password or worse. TCP helps prevent this by acknowledging each packet received to ensure the destination host has acquired each packet before assembling the command and sending it to the application for action.

On the other hand, when we require quick responses or utilize applications that require speed over completeness, UDP is our answer. Take streaming a video, for example. The user will not notice a pixel or two dropped from a streaming video. We care more about watching the video without it constantly stopping to buffer the next piece. Another example of this would be DNS. When a host requests a record entry for inlanefreight.com, the host is looking for a quick response to continue the process it was performing. The worst thing that happens if a DNS request is dropped is that it is reissued. No harm, no foul. The user will not receive corrupted data because of this drop.

UDP traffic appears like regular traffic; it is a single packet, with no response or acknowledgment that it was sent or received, so there is not much to show here. However, we can take a look at TCP and how it establishes connections.

<h3>TCP Three-way Handshake</h3>

One of the ways TCP ensures the delivery of data from server to client is the utilization of sessions. These sessions are established through what is called a three-way handshake. To make this happen, TCP utilizes an option in the TCP header called flags. We will not deep dive into TCP flags now; know that the common flags we will see in a three-way handshake are Synchronization (SYN) and acknowledgment (ACK). When a host requests to have a conversation with a server over TCP;

1. The client sends a packet with the SYN flag set to on along with other negotiable options in the TCP header.

  1. This is a synchronization packet. It will only be set in the first packet from host and server and enables establishing a session by allowing both ends to agree on a sequence number to start communicating with.

  2. This is crucial for the tracking of packets. Along with the sequence number sync, many other options are negotiated in this phase to include window size, maximum segment size, and selective acknowledgments.

2. The server will respond with a TCP packet that includes a SYN flag set for the sequence number negotiation and an ACK flag set to acknowledge the previous SYN packet sent by the host.

  1. The server will also include any changes to the TCP options it requires set in the options fields of the TCP header.

3. The client will respond with a TCP packet with an ACK flag set agreeing to the negotiation.

1. This packet is the end of the three-way handshake and established the connection between client and server.

Let us take a quick look at this in action to be familiar with it when it appears in our packet output later on in the module.

<h3>TCP Three-way Handshake</h3>

<img width="1001" height="377" alt="image" src="https://github.com/user-attachments/assets/ef1184c1-6cdd-450b-8379-ddc77bde8bad" />

When examining this output, we can see the start of our handshake on line one. Looking at the information highlighted in the red box, we can see our initial Syn flag is set. If we look at the port numbers underlined in green, we can see two numbers, 57678 and 80. The first number is the random high port number in use by the client, and the second is the well-known port for HTTP used by the server to listen for incoming web request connections. In line 2, we can see the server's response to the client with an SYN / ACK packet sent to the same ports. On line 3, we can see the client acknowledge the server's synchronization packet to establish the connection.

Packet 4 shows us that the HTTP request was sent, and a session is established to stream the data for the image requested. We can see as the stream continues that TCP sends acknowledgments for each chunk of data sent. This is an example of typical TCP communication.

We have seen how a session is established with TCP; now, let us examine how a session is concluded.

<h3>TCP Session Teardown</h3>

<img width="1003" height="459" alt="image" src="https://github.com/user-attachments/assets/e203fdfc-a823-427a-8d6f-b0762e7c7ace" />

In the image above, a set of packets similar to our three-way handshake visible at the end of the output. This is how TCP gracefully shuts connections. Another flag we will see with TCP is the FIN flag. It is used for signaling that the data transfer is finished and the sender is requesting termination of the connection. The client acknowledges the receipt of the data and then sends a FIN and ACK to begin session termination. The server responds with an acknowledgment of the FIN and sends back its own FIN. Finally, the client acknowledges the session is complete and closes the connection. Before session termination, we should see a packet pattern of:

1. FIN, ACK

2. FIN, ACK,

3. ACK

If we look at the image above detailing a session, we will see that this is the case. An output similar to this is considered an adequately terminated connection.

