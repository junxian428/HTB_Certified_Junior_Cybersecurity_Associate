<h3>IP Addresses</h3>

Each host in the network located can be identified by the so-called Media Access Control address (MAC). This would allow data exchange within this one network. If the remote host is located in another network, knowledge of the MAC address is not enough to establish a connection. Addressing on the Internet is done via the IPv4 and/or IPv6 address, which is made up of the network address and the host address.

It does not matter whether it is a smaller network, such as a home computer network, or the entire Internet. The IP address ensures the delivery of data to the correct receiver. We can imagine the representation of MAC and IPv4 / IPv6 addresses as follows:

1. IPv4 / IPv6 - describes the unique postal address and district of the receiver's building.

2. MAC - describes the exact floor and apartment of the receiver.

It is possible for a single IP address to address multiple receivers (broadcasting) or for a device to respond to multiple IP addresses. However, it must be ensured that each IP address is assigned only once within the network.

<h3>IPv4 Structure</h3>

The most common method of assigning IP addresses is IPv4, which consists of a 32-bit binary number combined into 4 bytes consisting of 8-bit groups (octets) ranging from 0-255. These are converted into more easily readable decimal numbers, separated by dots and represented as dotted-decimal notation.

Thus an IPv4 address can look like this:

Notation Presentation

Binary 0111 1111.0000 0000.0000 0000.0000 0001

Decimal 127.0.0.1

Each network interface (network cards, network printers, or routers) is assigned a unique IP address.

The IPv4 format allows 4,294,967,296 unique addresses. The IP address is divided into a host part and a network part. The router assigns the host part of the IP address at home or by an administrator. The respective network administrator assigns the network part. On the Internet, this is IANA, which allocates and manages the unique IPs.

In the past, further classification took place here. The IP network blocks were divided into classes A - E. The different classes differed in the host and network shares' respective lengths.

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Class</th>
      <th>Network Address</th>
      <th>First Address</th>
      <th>Last Address</th>
      <th>Subnet Mask</th>
      <th>CIDR</th>
      <th>Subnets</th>
      <th>IPs</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>A</td>
      <td>1.0.0.0</td>
      <td>1.0.0.1</td>
      <td>127.255.255.255</td>
      <td>255.0.0.0</td>
      <td>/8</td>
      <td>127</td>
      <td>16,777,214 + 2</td>
    </tr>
    <tr>
      <td>B</td>
      <td>128.0.0.0</td>
      <td>128.0.0.1</td>
      <td>191.255.255.255</td>
      <td>255.255.0.0</td>
      <td>/16</td>
      <td>16,384</td>
      <td>65,534 + 2</td>
    </tr>
    <tr>
      <td>C</td>
      <td>192.0.0.0</td>
      <td>192.0.0.1</td>
      <td>223.255.255.255</td>
      <td>255.255.255.0</td>
      <td>/24</td>
      <td>2,097,152</td>
      <td>254 + 2</td>
    </tr>
    <tr>
      <td>D</td>
      <td>224.0.0.0</td>
      <td>224.0.0.1</td>
      <td>239.255.255.255</td>
      <td>Multicast</td>
      <td>Multicast</td>
      <td>Multicast</td>
      <td>Multicast</td>
    </tr>
    <tr>
      <td>E</td>
      <td>240.0.0.0</td>
      <td>240.0.0.1</td>
      <td>255.255.255.255</td>
      <td>Reserved</td>
      <td>Reserved</td>
      <td>Reserved</td>
      <td>Reserved</td>
    </tr>
  </tbody>
</table>

<h3>Subnet Mask</h3>

A further separation of these classes into small networks is done with the help of subnetting. This separation is done using the netmasks, which is as long as an IPv4 address. As with classes, it describes which bit positions within the IP address act as network part or host part.
