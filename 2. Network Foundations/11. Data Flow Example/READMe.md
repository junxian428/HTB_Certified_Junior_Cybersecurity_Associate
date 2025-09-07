<h3>Data Flow Example</h3>

Based on the knowledge we have gained from the previous sections, the following paragraphs will show precisely what happens when a user tries to access a website from their laptop. Below is a breakdown of these events in a client-server model.

<h3> 1. Accessing the Internet</h3>

Let's imagine a user using their laptop to connect to the internet through their home Wireless LAN (WLAN) network. As the laptop is connecting to this network, the following happens:

Steps

- The laptop first identifies the correct wireless network/SSID

- If the network uses WPA2/WPA3, the user must provide the correct password or credentials to authenticate.

- Finally, the connection is established, and the DHCP protocol takes over the IP configuration.

2. Checking Local Network Configuration (DHCP)

When a user opens a web browser (such as Chrome, Firefox, or Safari) and types in www.example.com to access a website, the browser prepares to send out a request for the webpage. Before a packet leaves the laptop, the operating system checks for a valid IP address for the local area network.

<table>
    <caption>DHCP Process Steps</caption>
    <thead>
      <tr>
        <th>Step</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>IP Address Assignment</td>
        <td>If the laptop does not already have an IP, it requests one from the home router's DHCP server. This IP address is only valid within the local network.</td>
      </tr>
      <tr>
        <td>DHCP Acknowledgement</td>
        <td>The DHCP server assigns a private IP address (for example, 192.168.1.10) to the laptop, along with other configuration details such as subnet mask, default gateway, and DNS server.</td>
      </tr>
    </tbody>
  </table>

3. DNS Resolution

   Next, the laptop needs to find the IP address of www.example.com. For this to happen, the following steps must be taken.

 <table>
    <caption>DNS Resolution & Data Encapsulation Steps</caption>
    <thead>
      <tr>
        <th>Step</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>DNS Query</td>
        <td>The laptop sends a DNS query to the DNS server, which is typically an external DNS server provided by the ISP or a third-party service like Google DNS.</td>
      </tr>
      <tr>
        <td>DNS Response</td>
        <td>The DNS server looks up the domain <code>www.example.com</code> and returns its IP address (e.g., 93.184.216.34).</td>
      </tr>
      <tr>
        <td>Data Encapsulation and Local Network Transmission</td>
        <td>Now that the laptop has the destination IP address, it begins preparing the data for transmission.  
        The following steps occur within the OSI/TCP-IP model.</td>
      </tr>
    </tbody>
  </table>

4. Data Encapsulation and Local Network Transmission

   Now that the laptop has the destination IP address, it begins preparing the data for transmission. The following steps occur within the OSI/TCP-IP model:

  <table>
    <caption>Data Encapsulation Steps (OSI/TCP-IP)</caption>
    <thead>
      <tr>
        <th>Layer</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Application Layer</td>
        <td>The browser creates an HTTP (or HTTPS) request for the webpage.</td>
      </tr>
      <tr>
        <td>Transport Layer</td>
        <td>The request is wrapped in a TCP segment (or UDP, but for web traffic it's typically TCP).  
            This segment includes source and destination ports (HTTP default port <code>80</code>, HTTPS default port <code>443</code>).</td>
      </tr>
      <tr>
        <td>Internet Layer</td>
        <td>The TCP segment is placed into an IP packet.  
            The source IP is the laptop's private IP (e.g., <code>192.168.1.10</code>), and the destination IP is the remote server’s IP (<code>93.184.216.34</code>).</td>
      </tr>
      <tr>
        <td>Link Layer</td>
        <td>The IP packet is placed into an Ethernet frame (if wired) or Wi-Fi frame.  
            The frame includes MAC addresses (source = laptop’s NIC, destination = router’s interface).  
            If the router’s MAC is unknown, the laptop sends an ARP request to learn it. Finally, the frame is sent to the router using the router’s MAC address as the destination.</td>
      </tr>
    </tbody>
  </table>

5. Network Address Translation (NAT)

   Once the router receives the frame, it processes the IP packet. At this point, the router replaces the private IP (192.168.1.10) with its public IP address (e.g., 203.0.113.45) in the packet header. This process is known as Network Address Translation (NAT). Next, the router forwards the packet to the ISP's network, and from there, it travels across the internet to the destination IP (93.184.216.34). During this process, the packet goes through many intermediate routers that look at the destination IP and determine the best path to reach that network.

6. Server Receives the Request and Responds

   Upon reaching the destination network, the server's firewall, if there is one, checks if the incoming traffic on port 80 (HTTP) or 443 (HTTPS) is allowed. If it passes firewall rules, it goes to the server hosting www.example.com. Next, the web server software (e.g., Apache, Nginx, IIS) receives and processes the request, prepares the webpage (HTML, CSS, images, etc.), and sends it back as a response.

The server's response process follows a similar path in reverse. Its IP (93.184.216.34) is now the source, and our home router's public IP (203.0.113.45) is the destination. When the packet reaches our home router (203.0.113.45), NAT ensures it is mapped back to the laptop's private IP (192.168.1.10).

7. Decapsulation and Display

   Finally, our laptop receives the response and strips away the Ethernet/Wi-Fi frame, the IP header, and the TCP header, until the application layer data is extracted. The laptop's browser reads the HTML/CSS/JavaScript, and ultimately displays the webpage.

Data Flow Diagram

Below is a flow chart showing the complete journey of a user accessing a website on the internet.
