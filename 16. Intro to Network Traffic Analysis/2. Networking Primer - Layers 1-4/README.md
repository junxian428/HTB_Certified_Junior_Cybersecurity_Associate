<img width="997" height="653" alt="image" src="https://github.com/user-attachments/assets/c0031a08-49e1-4fa3-b9e3-e6b2679f3cc3" /><h3>Networking Primer - Layers 1-4</h3>

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


