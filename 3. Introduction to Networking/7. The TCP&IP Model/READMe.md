<h3>The TCP/IP Model</h3>

The TCP/IP model is also a layered reference model, often referred to as the Internet Protocol Suite. The term TCP/IP stands for the two protocols Transmission Control Protocol (TCP) and Internet Protocol (IP). IP is located within the network layer (Layer 3) and TCP is located within the transport layer (Layer 4) of the OSI layer model.

 <table>
    <caption>TCP/IP Model Layers</caption>
    <tr>
      <th>Layer</th>
      <th>Function</th>
    </tr>
    <tr>
      <td>4. Application</td>
      <td>Allows applications to access lower-layer services and defines protocols applications use to exchange data.</td>
    </tr>
    <tr>
      <td>3. Transport</td>
      <td>Provides TCP session and UDP datagram services for the Application Layer.</td>
    </tr>
    <tr>
      <td>2. Internet</td>
      <td>Handles host addressing, packaging, and routing functions.</td>
    </tr>
    <tr>
      <td>1. Link</td>
      <td>Places TCP/IP packets on the network medium and receives packets from the medium, independent of access method, frame format, or medium.</td>
    </tr>
  </table>

With TCP/IP, every application can transfer and exchange data over any network, and it does not matter where the receiver is located. IP ensures that the data packet reaches its destination, and TCP controls the data transfer and ensures the connection between data stream and application. The main difference between TCP/IP and OSI is the number of layers, some of which have been combined.

<img width="901" height="549" alt="image" src="https://github.com/user-attachments/assets/eca378ef-2306-4e37-aa94-ecb6e3061fa5" />


The most important tasks of TCP/IP are:

 <table>
    <thead>
      <tr>
        <th>Task</th>
        <th>Protocol</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Logical Addressing</td>
        <td>IP</td>
        <td>Due to many hosts in different networks, there is a need to structure the network topology and logical addressing. Within TCP/IP, IP takes over the logical addressing of networks and nodes. Data packets only reach the network where they are supposed to be. The methods to do so are network classes, subnetting, and CIDR.</td>
      </tr>
      <tr>
        <td>Routing</td>
        <td>IP</td>
        <td>For each data packet, the next node is determined in each node on the way from the sender to the receiver. This way, a data packet is routed to its receiver, even if its location is unknown to the sender.</td>
      </tr>
      <tr>
        <td>Error &amp; Control Flow</td>
        <td>TCP</td>
        <td>The sender and receiver are frequently in touch with each other via a virtual connection. Therefore control messages are sent continuously to check if the connection is still established.</td>
      </tr>
      <tr>
        <td>Application Support</td>
        <td>TCP</td>
        <td>TCP and UDP ports form a software abstraction to distinguish specific applications and their communication links.</td>
      </tr>
      <tr>
        <td>Name Resolution</td>
        <td>DNS</td>
        <td>DNS provides name resolution through Fully Qualified Domain Names (FQDN) in IP addresses, enabling us to reach the desired host with the specified name on the internet.</td>
      </tr>
    </tbody>
  </table>
