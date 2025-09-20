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
      <th><u>Class</u></th>
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

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Class</th>
      <th>Network Address</th>
      <th>First Address</th>
      <th>Last Address</th>
      <th><u>Subnet Mask</u></th>
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

<h3>Network and Gateway Addresses</h3>

The two additional IPs added in the IPs column are reserved for the so-called network address and the broadcast address. Another important role plays the default gateway, which is the name for the IPv4 address of the router that couples networks and systems with different protocols and manages addresses and transmission methods. It is common for the default gateway to be assigned the first or last assignable IPv4 address in a subnet. This is not a technical requirement, but has become a de-facto standard in network environments of all sizes.

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Class</th>
      <th>Network Address</th>
      <th><u>First Address</u></th>
      <th>Last Address</th>
      <th>Subnet Mask</th>
      <th>CIDR</th>
      <th>Subnets</th>
      <th><u>IPs</u></th>
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

<h3>Broadcast Address</h3>

The broadcast IP address's task is to connect all devices in a network with each other. Broadcast in a network is a message that is transmitted to all participants of a network and does not require any response. In this way, a host sends a data packet to all other participants of the network simultaneously and, in doing so, communicates its IP address, which the receivers can use to contact it. This is the last IPv4 address that is used for the broadcast.

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Class</th>
      <th>Network Address</th>
      <th>First Address</th>
      <th><u> Last Address</u></th>
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

<h3>Binary system</h3>

he binary system is a number system that uses only two different states that are represented into two numbers (0 and 1) opposite to the decimal-system (0 to 9).

An IPv4 address is divided into 4 octets, as we have already seen. Each octet consists of 8 bits. Each position of a bit in an octet has a specific decimal value.

Let's take the following IPv4 address as an example:

IPv4 Address: 192.168.10.39

Here is an example of how the first octet looks like:

1st Octet - Value: 192

IP Addresses

Values: 128 64 32 16 8 4 2 1

Binary: 1 1 0 0 0 0 0 0

If we calculate the sum of all these values for each octet where the bit is set to 1, we get the sum:

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Octet</th>
      <th>Values</th>
      <th>Sum</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1st</td>
      <td>128 + 64 + 0 + 0 + 0 + 0 + 0 + 0</td>
      <td>= 192</td>
    </tr>
    <tr>
      <td>2nd</td>
      <td>128 + 0 + 32 + 0 + 8 + 0 + 0 + 0</td>
      <td>= 168</td>
    </tr>
    <tr>
      <td>3rd</td>
      <td>0 + 0 + 0 + 0 + 8 + 0 + 2 + 0</td>
      <td>= 10</td>
    </tr>
    <tr>
      <td>4th</td>
      <td>0 + 0 + 32 + 0 + 0 + 4 + 2 + 1</td>
      <td>= 39</td>
    </tr>
  </tbody>
</table>

The entire representation from binary to decimal would look like this:

<h3>IPv4 - Binary Notation</h3>

Octet: 1st 2nd 3rd 4th

Binary: 1100 0000 . 1010 1000 . 0000 1010 . 0010 0111

Decimal: 192 . 168 . 10 . 39

<h3>IPv4 - Decimal to Binary</h3>

Values: 128 64 32 16 8 4 2 1

Binary: 1 1 1 1 1 1 1 1

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Octet</th>
      <th>Values</th>
      <th>Sum</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1st</td>
      <td>128 + 64 + 32 + 16 + 8 + 4 + 2 + 1</td>
      <td>= 255</td>
    </tr>
    <tr>
      <td>2nd</td>
      <td>128 + 64 + 32 + 16 + 8 + 4 + 2 + 1</td>
      <td>= 255</td>
    </tr>
    <tr>
      <td>3rd</td>
      <td>128 + 64 + 32 + 16 + 8 + 4 + 2 + 1</td>
      <td>= 255</td>
    </tr>
    <tr>
      <td>4th</td>
      <td>0 + 0 + 0 + 0 + 0 + 0 + 0 + 0</td>
      <td>= 0</td>
    </tr>
  </tbody>
</table>

<h3>Subnet Mask</h3>

Octet: 1st 2nd 3rd 4th

Binary: 1111 1111 . 1111 1111 . 1111 1111 . 0000 0000

Decimal: 255 . 255 . 255 . 0

IPv4 Address: 192.168.10.39

Subnet mask: 255.255.255.0

<h3>CIDR</h3>

Classless Inter-Domain Routing (CIDR) is a method of representation and replaces the fixed assignment between IPv4 address and network classes (A, B, C, D, E). The division is based on the subnet mask or the so-called CIDR suffix, which allows the bitwise division of the IPv4 address space and thus into subnets of any size. The CIDR suffix indicates how many bits from the beginning of the IPv4 address belong to the network. It is a notation that represents the subnet mask by specifying the number of 1-bits in the subnet mask.

Let us stick to the following IPv4 address and subnet mask as an example:

IPv4 Address: 192.168.10.39

Subnet mask: 255.255.255.0

Now the whole representation of the IPv4 address and the subnet mask would look like this:

CIDR: 192.168.10.39/24

The CIDR suffix is, therefore, the sum of all ones in the subnet mask.

Octet: 1st 2nd 3rd 4th

Binary: 1111 1111 . 1111 1111 . 1111 1111 . 0000 0000 (/24)

Decimal: 255 . 255 . 255 . 0
