<h3>Host and Port Scanning</h3>

It is essential to understand how the tool we use works and how it performs and processes the different functions. We will only understand the results if we know what they mean and how they are obtained. Therefore we will take a closer look at and analyze some of the scanning methods. After we have found out that our target is alive, we want to get a more accurate picture of the system. The information we need includes:

Open ports and its services

Service versions

Information that the services provided

Operating system

There are a total of 6 different states for a scanned port we can obtain:

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>State</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>open</td>
      <td>This indicates that the connection to the scanned port has been established. These connections can be TCP connections, UDP datagrams as well as SCTP associations.</td>
    </tr>
    <tr>
      <td>closed</td>
      <td>When the port is shown as closed, the TCP protocol indicates that the packet we received back contains an RST flag. This scanning method can also be used to determine if our target is alive or not.</td>
    </tr>
    <tr>
      <td>filtered</td>
      <td>Nmap cannot correctly identify whether the scanned port is open or closed because either no response is returned from the target for the port or we get an error code from the target.</td>
    </tr>
    <tr>
      <td>unfiltered</td>
      <td>This state of a port only occurs during the TCP-ACK scan and means that the port is accessible, but it cannot be determined whether it is open or closed.</td>
    </tr>
    <tr>
      <td>open|filtered</td>
      <td>If we do not get a response for a specific port, Nmap will set it to that state. This indicates that a firewall or packet filter may protect the port.</td>
    </tr>
    <tr>
      <td>closed|filtered</td>
      <td>This state only occurs in the IP ID idle scans and indicates that it was impossible to determine if the scanned port is closed or filtered by a firewall.</td>
    </tr>
  </tbody>
</table>
