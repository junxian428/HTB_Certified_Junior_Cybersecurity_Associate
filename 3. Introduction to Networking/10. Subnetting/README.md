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

<h3>Network Address</h3>

So if we now set all bits to 0 in the host part of the IPv4 address, we get the respective subnet's network address.

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

<h3>Broadcast Address</h3>

If we set all bits in the host part of the IPv4 address to 1, we get the broadcast address.

<table>
  <tr>
    <th>Details of</th>
    <th>1st Octet</th>
    <th>2nd Octet</th>
    <th>3rd Octet</th>
    <th>4th Octet</th>
    <th>Decimal</th>
  </tr>
  <tr>
    <td>IPv4</td>
    <td>1100&nbsp;0000</td>
    <td>1010&nbsp;1000</td>
    <td>0000&nbsp;1100</td>
    <td>10&nbsp;10&nbsp;0000</td>
    <td>192.168.12.160/26</td>
  </tr>
  <tr>
    <td>Subnet mask</td>
    <td><span class="green">1111&nbsp;1111</span></td>
    <td><span class="green">1111&nbsp;1111</span></td>
    <td><span class="green">1111&nbsp;1111</span></td>
    <td><span class="green">11</span>00&nbsp;0000</td>
    <td>255.255.255.192</td>
  </tr>
  <tr>
    <td>Bits</td>
    <td>/8</td>
    <td>/16</td>
    <td>/24</td>
    <td>/32</td>
    <td></td>
  </tr>
</table>

Since we now know that the IPv4 addresses 192.168.12.128 and 192.168.12.191 are assigned, all other IPv4 addresses are accordingly between 192.168.12.129-190. Now we know that this subnet offers us a total of 64 - 2 (network address & broadcast address) or 62 IPv4 addresses that we can assign to our hosts.

Hosts IPv4

Network Address 192.168.12.128

First Host 192.168.12.129

Other Hosts ...

Last Host 192.168.12.190

Broadcast Address 192.168.12.191

<h3>Subnetting Into Smaller Networks</h3>

Let us now assume that we, as administrators, have been given the task of dividing the subnet assigned to us into 4 additional subnets. Thus, it is essential to know that we can only divide the subnets based on the binary system.

<table>
  <tr>
    <th>Exponent</th>
    <th>Value</th>
  </tr>
  <tr><td>2<sup>0</sup></td><td>1</td></tr>
  <tr><td>2<sup>1</sup></td><td>2</td></tr>
  <tr><td>2<sup>2</sup></td><td>4</td></tr>
  <tr><td>2<sup>3</sup></td><td>8</td></tr>
  <tr><td>2<sup>4</sup></td><td>16</td></tr>
  <tr><td>2<sup>5</sup></td><td>32</td></tr>
  <tr><td>2<sup>6</sup></td><td>64</td></tr>
  <tr><td>2<sup>7</sup></td><td>128</td></tr>
  <tr><td>2<sup>8</sup></td><td>256</td></tr>
</table>

Therefore we can divide the 64 hosts we know by 4. The 4 is equal to the exponent 2^2 in the binary system, so we find out the number of bits for the subnet mask by which we have to extend it. So we know the following parameters:

Subnet: 192.168.12.128/26

Required Subnets: 4

---

Now we increase/expand our subnet mask by 2 bits from /26 to /28, and it looks like this:

Details of 1st Octet 2nd Octet 3rd Octet 4th Octet Decimal

Subnet mask 1111 1111 1111 1111 1111 1111 1111| 0000 255.255.255.240

Bits /8 /16 /24 /32

Next, we can divide the 64 IPv4 addresses that are available to us into 4 parts:

Hosts Math Subnets Host range for each subnet

64 / 4 = 16

So we know how big each subnet will be. From now on, we start from the network address given to us (192.168.12.128) and add the 16 hosts 4 times:

<table>
  <tr>
    <th>Subnet No.</th>
    <th>Network Address</th>
    <th>First Host</th>
    <th>Last Host</th>
    <th>Broadcast Address</th>
    <th>CIDR</th>
  </tr>
  <tr>
    <td>1</td>
    <td>192.168.12.128</td>
    <td>192.168.12.129</td>
    <td>192.168.12.142</td>
    <td>192.168.12.143</td>
    <td>192.168.12.128/28</td>
  </tr>
  <tr>
    <td>2</td>
    <td>192.168.12.144</td>
    <td>192.168.12.145</td>
    <td>192.168.12.158</td>
    <td>192.168.12.159</td>
    <td>192.168.12.144/28</td>
  </tr>
  <tr>
    <td>3</td>
    <td>192.168.12.160</td>
    <td>192.168.12.161</td>
    <td>192.168.12.174</td>
    <td>192.168.12.175</td>
    <td>192.168.12.160/28</td>
  </tr>
  <tr>
    <td>4</td>
    <td>192.168.12.176</td>
    <td>192.168.12.177</td>
    <td>192.168.12.190</td>
    <td>192.168.12.191</td>
    <td>192.168.12.176/28</td>
  </tr>
</table>

<h3>Mental Subnetting</h3>

It may seem like there is a lot of math involved in subnetting, but each octet repeats itself, and everything is a power of two, so there doesn't have to be a lot of memorization. The first thing to do is identify what octet changes.

1st Octet 2nd Octet 3rd Octet 4th Octet

/8 /16 /24 /32

It is possible to identify what octet of the IP Address may change by remembering those four numbers. Given the Network Address: 192.168.1.1/25, it is immediately apparent that 192.168.2.4 would not be in the same network because the /25 subnet means only the fourth octet may change.

The next part identifies how big each subnet can be but by dividing eight by the network and looking at the remainder. This is also called Modulo Operation (%) and is heavily utilized in cryptology. Given our previous example of /25, (25 % 8) would be 1. This is because eight goes into 25 three times (8 \* 3 = 24). There is a 1 leftover, which is the network bit reserved for the network mask. There is a total of eight bits in each octet of an IP Address. If one is used for the network mask, the equation becomes 2^(8-1) or 2^7, 128. The table below contains all the numbers.

<table>
  <tr>
    <th>Remainder</th>
    <th>Number</th>
    <th>Exponential Form</th>
    <th>Division Form</th>
  </tr>
  <tr>
    <td class="mono">0</td>
    <td class="mono">256</td>
    <td class="mono">2<sup>8</sup></td>
    <td class="mono">256</td>
  </tr>
  <tr>
    <td class="mono">1</td>
    <td class="mono">128</td>
    <td class="mono">2<sup>7</sup></td>
    <td class="mono">256/2</td>
  </tr>
  <tr>
    <td class="mono">2</td>
    <td class="mono">64</td>
    <td class="mono">2<sup>6</sup></td>
    <td class="mono">256/2/2</td>
  </tr>
  <tr>
    <td class="mono">3</td>
    <td class="mono">32</td>
    <td class="mono">2<sup>5</sup></td>
    <td class="mono">256/2/2/2</td>
  </tr>
  <tr>
    <td class="mono">4</td>
    <td class="mono">16</td>
    <td class="mono">2<sup>4</sup></td>
    <td class="mono">256/2/2/2/2</td>
  </tr>
  <tr>
    <td class="mono">5</td>
    <td class="mono">8</td>
    <td class="mono">2<sup>3</sup></td>
    <td class="mono">256/2/2/2/2/2</td>
  </tr>
  <tr>
    <td class="mono">6</td>
    <td class="mono">4</td>
    <td class="mono">2<sup>2</sup></td>
    <td class="mono">256/2/2/2/2/2/2</td>
  </tr>
  <tr>
    <td class="mono">7</td>
    <td class="mono">2</td>
    <td class="mono">2<sup>1</sup></td>
    <td class="mono">256/2/2/2/2/2/2/2</td>
  </tr>
</table>

By remembering the powers of two up to eight, it can become an instant calculation. However, if forgotten, it may be quicker to remember to divide 256 in half the number of times of the remainder.

The tricky part of this is getting the actual IP Address range because 0 is a number and not null in networking. So in our /25 with 128 IP Addresses, the first range is 192.168.1.0-127. The first address is the network, and the last is the broadcast address, which means the usable IP Space would become 192.168.1.1-126. If our IP Address fell above 128, then the usable ip space would be 192.168.1.129-254 (128 is the network and 255 is the broadcast).

Questions

Answer the question(s) below to complete this Section and earn cubes!

- 2 Submit the decimal representation of the subnet mask from the following CIDR: 10.200.20.0/27

  255.255.255.224

- 2 Submit the broadcast address of the following CIDR: 10.200.20.0/27

  10.200.20.31

- 3 Split the network 10.200.20.0/27 into 4 subnets and submit the network address of the 3rd subnet as the answer.

  10.200.20.16

- 3 Split the network 10.200.20.0/27 into 4 subnets and submit the broadcast address of the 2nd subnet as the answer.

  10.200.20.15
