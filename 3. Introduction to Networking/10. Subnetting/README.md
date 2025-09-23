<h3>Subnetting</h3>

The division of an address range of IPv4 addresses into several smaller address ranges is called subnetting.

A subnet is a logical segment of a network that uses IP addresses with the same network address. We can think of a subnet as a labeled entrance on a large building corridor. For example, this could be a glass door that separates various departments of a company building. With the help of subnetting, we can create a specific subnet by ourselves or find out the following outline of the respective network:

- Network address

- Broadcast address

- First host

- Last host

- Number of hosts

Let us take the following IPv4 address and subnet mask as an example:

- IPv4 Address: 192.168.12.160

- Subnet Mask: 255.255.255.192

- CIDR: 192.168.12.160/26

We already know that an IP address is divided into the network part and the host part.

<h3>Network Part</h3>

<table>
  <thead>
    <tr>
      <th>Details of</th>
      <th>1st Octet</th>
      <th>2nd Octet</th>
      <th>3rd Octet</th>
      <th>4th Octet</th>
      <th>Decimal</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>IPv4</td>
      <td class="bin">1100&nbsp;0000</td>
      <td class="bin">1010&nbsp;1000</td>
      <td class="bin">0000&nbsp;1100</td>
      <td class="bin">1010&nbsp;0000</td>
      <td class="dec">192.168.12.160/26</td>
    </tr>
    <tr>
      <td>Subnet mask</td>
      <td class="bin">1111&nbsp;1111</td>
      <td class="bin">1111&nbsp;1111</td>
      <td class="bin">1111&nbsp;1111</td>
      <td class="bin">1100&nbsp;0000</td>
      <td class="dec">255.255.255.192</td>
    </tr>
    <tr>
      <td>Bits</td>
      <td>/8</td>
      <td>/16</td>
      <td>/24</td>
      <td>/32</td>
      <td></td>
    </tr>
  </tbody>
</table>

In subnetting, we use the subnet mask as a template for the IPv4 address. From the 1-bits in the subnet mask, we know which bits in the IPv4 address cannot be changed. These are fixed and therefore determine the "main network" in which the subnet is located.

<h3>Host Part</h3>

<table>
  <thead>
    <tr>
      <th rowspan="2">Details of</th>
      <th rowspan="2">1st Octet</th>
      <th rowspan="2">2nd Octet</th>
      <th rowspan="2">3rd Octet</th>
      <th colspan="2">4th Octet</th>
      <th rowspan="2">Decimal</th>
    </tr>
    <tr>
      <th>Binary</th>
      <th>Decimal</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>IPv4</td>
      <td class="bin">1100&nbsp;0000</td>
      <td class="bin">1010&nbsp;1000</td>
      <td class="bin">0000&nbsp;1100</td>
      <td class="bin">1010&nbsp;0000</td>
      <td class="dec">160</td>
      <td class="dec">192.168.12.160/26</td>
    </tr>
    <tr>
      <td>Subnet mask</td>
      <td class="bin">1111&nbsp;1111</td>
      <td class="bin">1111&nbsp;1111</td>
      <td class="bin">1111&nbsp;1111</td>
      <td class="bin">1100&nbsp;0000</td>
      <td class="dec">192</td>
      <td class="dec">255.255.255.192</td>
    </tr>
    <tr>
      <td>Bits</td>
      <td>/8</td>
      <td>/16</td>
      <td>/24</td>
      <td colspan="2">/32</td>
      <td></td>
    </tr>
  </tbody>
</table>

The bits in the host part can be changed to the first and last address. The first address is the network address, and the last address is the broadcast address for the respective subnet.

The network address is vital for the delivery of a data packet. If the network address is the same for the source and destination address, the data packet is delivered within the same subnet. If the network addresses are different, the data packet must be routed to another subnet via the default gateway.

The subnet mask determines where this separation occurs.

<h3>Separation Of Network & Host Parts</h3>

<table>
  <thead>
    <tr>
      <th>Details of</th>
      <th>1st Octet</th>
      <th>2nd Octet</th>
      <th>3rd Octet</th>
      <th>4th Octet</th>
      <th>Decimal</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>IPv4</td>
      <td class="bin">1100&nbsp;0000</td>
      <td class="bin">1010&nbsp;1000</td>
      <td class="bin">0000&nbsp;1100</td>
      <td class="bin">10<span class="split">10&nbsp;0000</span></td>
      <td class="dec">192.168.12.160/26</td>
    </tr>
    <tr>
      <td>Subnet mask</td>
      <td class="bin">1111&nbsp;1111</td>
      <td class="bin">1111&nbsp;1111</td>
      <td class="bin">1111&nbsp;1111</td>
      <td class="bin">11<span class="split">00&nbsp;0000</span></td>
      <td class="dec">255.255.255.192</td>
    </tr>
    <tr>
      <td>Bits</td>
      <td>/8</td>
      <td>/16</td>
      <td>/24</td>
      <td>/32</td>
      <td></td>
    </tr>
  </tbody>
</table>
