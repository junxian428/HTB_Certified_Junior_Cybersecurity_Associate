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
      <th>Decimal IPv4 / CIDR</th>
      <th>Subnet mask (binary)</th>
      <th>Subnet mask (dotted)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="left">Binary octets</td>
      <td>1100 0000</td>
      <td>1010 1000</td>
      <td>0000 1100</td>
      <td>1010 0000</td>
      <td class="muted">—</td>
      <td>1111 1111 &nbsp;1111 1111 &nbsp;1111 1111 &nbsp;1100 0000</td>
      <td>255.255.255.192</td>
    </tr>

    <tr>
      <td class="left">Decimal octets</td>
      <td>192</td>
      <td>168</td>
      <td>12</td>
      <td>160</td>
      <td class="muted">192.168.12.160</td>
      <td class="muted">(same as left)</td>
      <td class="muted">/26</td>
    </tr>

    <tr>
      <td class="left">Decimal IPv4 &amp; CIDR</td>
      <td colspan="4" class="muted">192 . 168 . 12 . 160</td>
      <td>192.168.12.160/26</td>
      <td colspan="2" class="muted">Mask = 255.255.255.192 (binary shown above)</td>
    </tr>

    <tr>
      <td class="left">Bits (octet boundaries)</td>
      <td>/8</td>
      <td>/16</td>
      <td>/24</td>
      <td>/32</td>
      <td colspan="3" class="muted">Common CIDR boundaries for full-octet increments</td>
    </tr>

  </tbody>
</table>
