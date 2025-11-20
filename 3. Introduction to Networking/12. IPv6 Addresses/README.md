<h3>IPv6 Addresses</h3>

IPv6 is the successor of IPv4. In contrast to IPv4, the IPv6 address is 128 bit long. The prefix identifies the host and network parts. The Internet Assigned Numbers Authority (IANA) is responsible for assigning IPv4 and IPv6 addresses and their associated network portions. In the long term, IPv6 is expected to completely replace IPv4, which is still predominantly used on the Internet. In principle, however, IPv4 and IPv6 can be made available simultaneously (Dual Stack).

IPv6 consistently follows the end-to-end principle and provides publicly accessible IP addresses for any end devices without the need for NAT. Consequently, an interface can have multiple IPv6 addresses, and there are special IPv6 addresses to which multiple interfaces are assigned.

IPv6 is a protocol with many new features, which also has many other advantages over IPv4:

- Larger address space

- Address self-configuration (SLAAC)

- Multiple IPv6 addresses per interface

- Faster routing

- End-to-end encryption (IPsec)

- Data packages up to 4 GByte

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Features</th>
      <th>IPv4</th>
      <th>IPv6</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Bit length</td>
      <td>32-bit</td>
      <td>128-bit</td>
    </tr>
    <tr>
      <td>OSI layer</td>
      <td>Network Layer</td>
      <td>Network Layer</td>
    </tr>
    <tr>
      <td>Adressing range</td>
      <td>~ 4.3 billion</td>
      <td>~ 340 undecillion</td>
    </tr>
    <tr>
      <td>Representation</td>
      <td>Binary</td>
      <td>Hexadecimal</td>
    </tr>
    <tr>
      <td>Prefix notation</td>
      <td>10.10.10.0/24</td>
      <td>fe80::dd80:b1a9:6687:2d3b/64</td>
    </tr>
    <tr>
      <td>Dynamic addressing</td>
      <td>DHCP</td>
      <td>SLAAC / DHCPv6</td>
    </tr>
    <tr>
      <td>IPsec</td>
      <td>Optional</td>
      <td>Mandatory</td>
    </tr>
  </tbody>
</table>

There are three different types of IPv6 addresses:

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
      <td>Addresses for multiple interfaces, where all receive the same packet.</td>
    </tr>
  </tbody>
</table>

Note: Contrary to IPv4, IPv6 eliminates the broadcast address. Instead, IPv6 uses multicast addresses to support discovery and communication with multiple nodes.

<h3>Hexadecimal System</h3>

The hexadecimal system (hex) is used to make the binary representation more readable and understandable. We can only show 10 (0-9) states with the decimal system and 2 (0 / 1) with the binary system by using a single character. In contrast to the binary and decimal system, we can use the hexadecimal system to show 16 (0-F) states with a single character.

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Decimal</th>
      <th>Hex</th>
      <th>Binary</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>1</td><td>0001</td></tr>
    <tr><td>2</td><td>2</td><td>0010</td></tr>
    <tr><td>3</td><td>3</td><td>0011</td></tr>
    <tr><td>4</td><td>4</td><td>0100</td></tr>
    <tr><td>5</td><td>5</td><td>0101</td></tr>
    <tr><td>6</td><td>6</td><td>0110</td></tr>
    <tr><td>7</td><td>7</td><td>0111</td></tr>
    <tr><td>8</td><td>8</td><td>1000</td></tr>
    <tr><td>9</td><td>9</td><td>1001</td></tr>
    <tr><td>10</td><td>A</td><td>1010</td></tr>
    <tr><td>11</td><td>B</td><td>1011</td></tr>
    <tr><td>12</td><td>C</td><td>1100</td></tr>
    <tr><td>13</td><td>D</td><td>1101</td></tr>
    <tr><td>14</td><td>E</td><td>1110</td></tr>
    <tr><td>15</td><td>F</td><td>1111</td></tr>
  </tbody>
</table>

Let's look at an example with an IPv4, at how the IPv4 address (192.168.12.160) would look in hexadecimal representation.

In total, the IPv6 address consists of 16 bytes. Because of its length, an IPv6 address is represented in a hexadecimal notation. Therefore the 128 bits are divided into 8 blocks multiplied by 16 bits (or 4 hex numbers). All four hex numbers are grouped and separated by a colon (:) instead of a simple dot (.) as in IPv4. To simplify the notation, we leave out leading at least 4 zeros in the blocks, and we can replace them with two colons (::).

An IPv6 address can look like this:

- Full IPv6: fe80:0000:0000:0000:dd80:b1a9:6687:2d3b/64

- Short IPv6: fe80::dd80:b1a9:6687:2d3b/64

An IPv6 address consists of two parts:

- Network Prefix (network part)

- Interface Identifier also called Suffix (host part)

The Network Prefix identifies the network, subnet, or address range. The Interface Identifier is formed from the 48-bit MAC address (which we will discuss later) of the interface and is converted to a 64-bit address in the process. The default prefix length is /64. However, other typical prefixes are /32, /48, and /56. If we want to use our networks, we get a shorter prefix (e.g. /56) than /64 from our provider.

In RFC 5952, the aforementioned IPv6 address notation was defined:

- All alphabetical characters are always written in lower case.

- All leading zeros of a block are always omitted.

- One or more consecutive blocks of 4 zeros (hex) are shortened by two colons (::).

- The shortening to two colons (::) may only be performed once starting from the left.
