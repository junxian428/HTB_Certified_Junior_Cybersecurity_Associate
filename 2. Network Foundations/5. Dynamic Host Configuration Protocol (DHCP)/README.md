<h3> Dynamic Host Configuration Protocol (DHCP)</h3>

Introduction to DHCP

In a computer network, every device needs a unique IP (Internet Protocol) address to communicate with other devices. Manually assigning IP addresses to each device can be time-consuming and cause errors, especially in large networks. To resolve this issue, networks can rely on the Dynamic Host Configuration Protocol (DHCP). DHCP is a network management protocol used to automate the process of configuring devices on IP networks. It allows devices to automatically receive an IP address and other network configuration parameters, such as subnet mask, default gateway, and DNS servers, without manual intervention.

DHCP simplifies network management by automatically assigning IP addresses, significantly reducing the administrative workload. This automation ensures that each device connected to the network receives a unique IP address, preventing conflicts and duplication of addresses. Furthermore, DHCP recycles IP addresses that are no longer in use when devices disconnect from the network, optimizing the available address pool.

How DHCP Works

The DHCP process involves a series of interactions between the client (the device requesting an IP address) and the DHCP server (the service running on a network device that assigns IP addresses). This process is often referred to as DORA, an acronym for Discover, Offer, Request, and Acknowledge. Below we see a breakdown of DORA. Before we explore the DORA steps in detail, let's first clarify the roles of the DHCP server and the DHCP client:

<table border="1" cellspacing="0" cellpadding="8">
  <thead>
    <tr>
      <th>Role</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>DHCP Server</td>
      <td>A network device (like a router or dedicated server) that manages IP address allocation. It maintains a pool of available IP addresses and configuration parameters.</td>
    </tr>
    <tr>
      <td>DHCP Client</td>
      <td>Any device that connects to the network and requests network configuration parameters from the DHCP server.</td>
    </tr>
  </tbody>
</table>

Below, we break down each step of the DORA process:

<table border="1" cellspacing="0" cellpadding="8">
  <thead>
    <tr>
      <th>Step</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1. Discover</td>
      <td>When a device connects to the network, it broadcasts a DHCP Discover message to find available DHCP servers.</td>
    </tr>
    <tr>
      <td>2. Offer</td>
      <td>DHCP servers on the network receive the discover message and respond with a DHCP Offer message, proposing an IP address lease to the client.</td>
    </tr>
    <tr>
      <td>3. Request</td>
      <td>The client receives the offer and replies with a DHCP Request message, indicating that it accepts the offered IP address.</td>
    </tr>
    <tr>
      <td>4. Acknowledge</td>
      <td>The DHCP server sends a DHCP Acknowledge message, confirming that the client has been assigned the IP address. The client can now use the IP address to communicate on the network.</td>
    </tr>
  </tbody>
</table>

A Linux host, connected to a wireless network, initializes the DORA process. GIF showcasing the process of connecting to a wireless network.

<img width="1021" height="649" alt="image" src="https://github.com/user-attachments/assets/4d9097d9-9617-40ba-a5dc-d491f7121ef8" />

<img width="835" height="645" alt="image" src="https://github.com/user-attachments/assets/0355ceef-81d5-4eaa-b917-0e75ef5012bb" />

The IP address assignment via DHCP is not permanent but is instead issued with a specific lease time. For instance, a DHCP server might assign an IP address to a smartphone with a lease time of 24 hours. After this period, the smartphone must request a renewal of the lease to continue using the IP address. Regarding the renewal process, before the lease expires, the client must proactively attempt to renew its IP address lease. This involves sending a renewal request to the DHCP server. As the lease nears its expiration, the client communicates with the DHCP server, asking if it can continue using the assigned IP address, to which the server can respond affirmatively, extending the lease.

Example Scenario

Let's walk through a simple example, based on the steps previously discussed, of how DHCP assigns an IP address to a device: Alice brings her new laptop to the office and connects it to the network. Since the laptop doesn't have an IP address yet, it sends out a DHCP Discover message to find a DHCP server. The office's DHCP server receives this message and responds with an offer, proposing the IP address 192.168.1.10. Alice's laptop receives this offer and sends back a DHCP Request message to accept the IP address. Finally, the DHCP server acknowledges this request and confirms the assignment. The laptop is now configured with the IP address 192.168.1.10, allowing it to communicate on the network.

The IP address 192.168.1.10 assigned to Alice's laptop is not permanent but is instead provided for a specific duration, known as the lease time. As this lease nears expiration, Alice's laptop must renew it to continue using the IP address. To do this, it sends another DHCP Request to the DHCP server asking to extend the lease. If the server can renew the lease, it will respond with a DHCP Acknowledge message, confirming the continued use of the IP address.

<img width="1013" height="655" alt="image" src="https://github.com/user-attachments/assets/3d09d12a-3d7e-43fa-89c7-2991500e0c2f" />

Questions
Answer the question(s) below to complete this Section and earn cubes!

- 0 What protocol automates IP address configuration for devices on a network?

  DHCP

- 0 What acronym describes the sequence of messages exchanged during the DHCP process?

  DORA

- 0 What type of message does a client send to accept an IP address from a DHCP server?

  request
