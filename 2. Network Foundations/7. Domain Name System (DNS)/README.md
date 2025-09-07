<h3>Domain Name System (DNS)</h3>

The Domain Name System (DNS) is like the phonebook of the internet. It helps us find the right number (an IP address) for a given name (a domain such as www.google.com). Without DNS, we would need to memorize long, often complex IP addresses for every website we visit. DNS makes our lives easier by allowing us to use human-friendly names to access online resources.

<h3>Domain Names vs. IP Addresses</h3>

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Address</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Domain Name</td>
    <td>A readable address like <b>www.example.com</b> that people can easily remember.</td>
  </tr>
  <tr>
    <td>IP Address</td>
    <td>A numerical label (e.g., <b>93.184.216.34</b>) used to identify devices on a network.</td>
  </tr>
</table>

DNS bridges the gap between these two, so we can just type www.google.com without needing to remember the underlying IP address.

<h3>DNS Hierarchy</h3>

DNS is organized like a tree, starting from the root and branching out into different layers.

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Layer</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Root Servers</td>
    <td>The top of the DNS hierarchy.</td>
  </tr>
  <tr>
    <td>Top-Level Domains (TLDs)</td>
    <td>Such as <b>.com</b>, <b>.org</b>, <b>.net</b>, or country codes like <b>.uk</b>, <b>.de</b>.</td>
  </tr>
  <tr>
    <td>Second-Level Domains</td>
    <td>For example, <b>example</b> in <b>example.com</b>.</td>
  </tr>
  <tr>
    <td>Subdomains or Hostname</td>
    <td>For instance, <b>www</b> in <b>www.example.com</b>, or <b>accounts</b> in <b>accounts.google.com</b>.</td>
  </tr>
</table>

<h3>DNS Resolution Process (Domain Translation)</h3>

When we enter a domain name in our browser, the computer needs to find the corresponding IP address. This process is known as DNS resolution or domain translation. The steps below show how this process works.

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Step</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Step 1</td>
    <td>We type <b>www.example.com</b> into our browser.</td>
  </tr>
  <tr>
    <td>Step 2</td>
    <td>Our computer checks its local DNS cache (a small storage area) to see if it already knows the IP address.</td>
  </tr>
  <tr>
    <td>Step 3</td>
    <td>If not found locally, it queries a recursive DNS server. This is often provided by our Internet Service Provider or a third-party DNS service like <b>Google DNS</b>.</td>
  </tr>
  <tr>
    <td>Step 4</td>
    <td>The recursive DNS server contacts a root server, which points it to the appropriate TLD name server (such as the <b>.com</b> domains, for instance).</td>
  </tr>
  <tr>
    <td>Step 5</td>
    <td>The TLD name server directs the query to the authoritative name server for <b>example.com</b>.</td>
  </tr>
  <tr>
    <td>Step 6</td>
    <td>The authoritative name server responds with the IP address for <b>www.example.com</b>.</td>
  </tr>
  <tr>
    <td>Step 7</td>
    <td>The recursive server returns this IP address to your computer, which can then connect to the website’s server directly.</td>
  </tr>
</table>

This all happens in just fractions of a second. Below we can see a simple example of the Domain Translation process. Suppose you want to visit the website at www.example.com. Without the Domain Name System (DNS), we would need to know and type the IP address, such as 93.184.216.34, every time you want to access that site. With DNS in place, we can simply type www.example.com into our browser. Behind the scenes, DNS automatically finds and translates this domain name into the correct IP address for us, ensuring a seamless connection to the website. The diagram below illustrates the diagram of the DNS Query Process.
