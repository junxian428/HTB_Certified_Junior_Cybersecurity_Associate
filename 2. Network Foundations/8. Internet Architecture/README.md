<h3>Internet Architecture</h3>

Internet Architecture describes how data is organized, transmitted, and managed across networks. Different architectural models serve different needs—some offer a straightforward client-server setup (like a website), while others rely on a more distributed approach (like file-sharing platforms). Understanding these models helps us see why networks are designed and operated the way they are. Different architectures solve different problems. Often, we see a combination of architectures creating hybrid models. Each model comes with its own set of trade-offs in terms of scalability, performance, security, and manageability. In the following paragraphs, we will describe the different architectures in more detail.

<h3>Peer-to-Peer (P2P) Architecture</h3>

In a Peer-to-Peer (P2P) network, each node, whether it's a computer or any other device, acts as both a client and a server. This setup allows nodes to communicate directly with each other, sharing resources such as files, processing power, or bandwidth, without the need for a central server. P2P networks can be fully decentralized, with no central server involved, or partially centralized, where a central server may coordinate some tasks but does not host data.

Imagine a group of friends who want to share vacation photos with each other. Instead of uploading all the photos to a single website or server, each of them sets up a folder on their own computer that can be accessed by the others. They use a file-sharing program that connects their computers directly.

First, they install a Peer-to-Peer (P2P) file-sharing application on their computer. Then, they select the folder containing the vacation photos to share with the other friends. Everyone performs the same setup on their computers. Once everyone is connected through the P2P application, they can all browse and download photos directly from each other’s shared folders, allowing for a direct exchange of files without the need for a central server.

A popular example of Peer-to-Peer (P2P) architecture is torrenting, as seen with applications like BitTorrent. In this system, anyone who has the file, referred to as a seeder, can upload it, allowing others to download it from multiple sources simultaneously.

In the following table, we can see the advantages and disadvantages of a Peer-to-Peer architecture.

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Advantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Scalability</td>
    <td>Adding more nodes can increase total resources (storage, CPU, etc.).</td>
  </tr>
  <tr>
    <td>Resilience</td>
    <td>If one node goes offline, others can continue functioning.</td>
  </tr>
  <tr>
    <td>Cost distribution</td>
    <td>Resource burden, like bandwidth and storage, is distributed among peers, making it more cost-efficient.</td>
  </tr>
  <tr>
    <th>Disadvantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Management complexity</td>
    <td>Harder to control and manage updates/security policies across all nodes.</td>
  </tr>
  <tr>
    <td>Potential reliability issues</td>
    <td>If too many peers leave, resources could be unavailable.</td>
  </tr>
  <tr>
    <td>Security challenges</td>
    <td>Each node is exposed to potential vulnerabilities.</td>
  </tr>
</table>

<h3>Client-Server Architecture</h3>

The Client-Server model is one of the most widely used architectures on the Internet. In this setup, clients, which are user devices, send requests, such as a web browser asking for a webpage, and servers respond to these requests, like a web server hosting the webpage. This model typically involves centralized servers where data and applications reside, with multiple clients connecting to these servers to access services and resources.

Let's assume we want to check the weather forecast on a website. We start by opening the web browser on our phone or computer, and proceed to type in the website's name, e.g., weatherexample.com. When we press enter, the browser sends a request over the Internet to the server that hosts weatherexample.com. This server, a powerful computer set up specifically to store the website’s data and handle requests, receives the query and processes it by locating the requested page. It then sends back the data (regarding the weather, we requested) to our browser, which receives this information and displays the webpage, allowing us to see the latest weather updates.

A key component of this architecture is the tier model, which organizes server roles and responsibilities into layers. This enhances scalability and manageability, as well as security and performance.

<h3>Single-Tier Architecture</h3>

In a single-tier architecture, the client, server, and database all reside on the same machine. This setup is straightforward but is rarely used for large-scale applications due to significant limitations in scalability and security.

<h3>Two-Tier Architecture</h3>

The two-tier architecture splits the application environment into a client and a server. The client handles the presentation layer, and the server manages the data layer. This model is typically seen in desktop applications where the user interface is on the user's machine, and the database is on a server. Communication usually occurs directly between the client and the server, which can be a database server with query-processing capabilities.

Note: In a typical web application, the client (browser) does not directly interact with the database server. Instead, the browser requests web pages from a **web server**, which in turn sends its response (HTML, CSS, JavaScript) back to the browser for rendering. The web server _may_ interact with an application server or database in order to formulate it's response, but in general, the scenario of a person visiting a website does not constitute a Two-Tier Architecture.

<h3>Three-Tier Architecture</h3>

A three-tier architecture introduces an additional layer between the client and the database server, known as the application server. In this model, the client manages the presentation layer, the application server handles all the business logic and processing, and the third tier is a database server. This separation provides added flexibility and scalability because each layer can be developed and maintained independently.

<h3>N-Tier Architecture</h3>

In more complex systems, an N-tier architecture is used, where N refers to any number of separate tiers used beyond three. This setup involves multiple levels of application servers, each responsible for different aspects of business logic, processing, or data management. N-tier architectures are highly scalable and allow for distributed deployment, making them ideal for web applications and services that demand robust, flexible solutions.

While tiered client-server architectures offer many improvements, they also introduce complexity in deployment and maintenance. Each tier needs to be correctly configured and secured, and communication between tiers must be efficient and secure to avoid performance bottlenecks and security vulnerabilities. In the following table, we can see the advantages and disadvantages of a Client-Server architecture in general.

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Advantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Centralized control</td>
    <td>Easier to manage and update.</td>
  </tr>
  <tr>
    <td>Security</td>
    <td>Central security policies can be applied.</td>
  </tr>
  <tr>
    <td>Performance</td>
    <td>Dedicated servers can be optimized for their tasks.</td>
  </tr>
</table>

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Disadvantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Single point of failure</td>
    <td>If the central server goes down, clients lose access.</td>
  </tr>
  <tr>
    <td>High Cost and Maintenance</td>
    <td>Setting up and sustaining a client-server architecture is expensive, requiring constant operation and expert management, making it costly to maintain.</td>
  </tr>
  <tr>
    <td>Network Congestion</td>
    <td>High traffic on the network can lead to congestion, slowing down or even disrupting connections when too many clients access the server simultaneously.</td>
  </tr>
</table>

<h3>Hybrid Architecture</h3>

A Hybrid model blends elements of both Client-Server and Peer-to-Peer (P2P) architectures. In this setup, central servers are used to facilitate coordination and authentication tasks, while the actual data transfer occurs directly between peers. This combination leverages the strengths of both architectures to enhance efficiency and performance. The following example gives a high-level explanation of how a hybrid architecture works.

When we open a video conferencing app and log in, the credentials (username and password) are verified by central servers, which also manage the session by coordinating who is in the meeting and controlling access. Once we're logged in and the meeting begins, the actual video and audio data is transferred directly between our device and those of other participants, bypassing the central server to reduce lag and enhance video quality. This setup combines both models: it uses the central server for initial connection and control tasks, while the bulk of data transfer occurs in a peer-to-peer style, reducing the server load and leveraging direct, fast connections between peers. The following table refers to some of the advantages and disadvantages of a Hybrid Architecture.

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Advantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Efficiency</td>
    <td>Relieves workload from servers by letting peers share data.</td>
  </tr>
  <tr>
    <td>Control</td>
    <td>Central server can still manage user authentication, directory services, or indexing.</td>
  </tr>
</table>

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Disadvantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Complex Implementation</td>
    <td>Requires more sophisticated design to handle both centralized and distributed components.</td>
  </tr>
  <tr>
    <td>Potential Single Point of Failure</td>
    <td>If the central coordinating server fails, peer discovery might stop.</td>
  </tr>
</table>

<h3>Cloud Architecture</h3>

Cloud Architecture refers to computing infrastructure that is hosted and managed by third-party providers, such as AWS, Azure, and Google Cloud. This architecture operates on a virtualized scale following a client-server model. It provides on-demand access to resources such as servers, storage, and applications, all accessible over the Internet. In this model, users interact with these services without controlling the underlying hardware.

Services like Google Drive or Dropbox are some examples of Cloud Architecture operating under the SaaS (Software as a Service) model, where we access applications over the internet without managing the underlying hardware. Below are five essential characteristics that define a Cloud Architecture.

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Characteristic</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>1. On-demand self-service</td>
    <td>Automatically set up and manage the services without human help.</td>
  </tr>
  <tr>
    <td>2. Broad network access</td>
    <td>Access services from any internet-connected device.</td>
  </tr>
  <tr>
    <td>3. Resource pooling</td>
    <td>Share and allocate service resources dynamically among multiple users.</td>
  </tr>
  <tr>
    <td>4. Rapid elasticity</td>
    <td>Quickly scale services up or down based on demand.</td>
  </tr>
  <tr>
    <td>5. Measured service</td>
    <td>Only pay for the resources you use, tracked with precision.</td>
  </tr>
</table>

The below table shows some of the advantages and disadvantages of the Cloud Architecture.

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Advantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Scalability</td>
    <td>Easily add or remove computing resources as needed.</td>
  </tr>
  <tr>
    <td>Reduced cost &amp; maintenance</td>
    <td>Hardware managed by the cloud provider.</td>
  </tr>
  <tr>
    <td>Flexibility</td>
    <td>Access services from anywhere with Internet connectivity.</td>
  </tr>
</table>

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Disadvantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Vendor lock-in</td>
    <td>Migrating from one cloud provider to another can be complex.</td>
  </tr>
  <tr>
    <td>Security/Compliance</td>
    <td>Relying on a third party for data hosting can introduce concerns about data privacy.</td>
  </tr>
  <tr>
    <td>Connectivity</td>
    <td>Requires stable Internet access.</td>
  </tr>
</table>

<h3>Software-Defined Architecture (SDN)</h3>

Software-Defined Networking (SDN) is a modern networking approach that separates the control plane, which makes decisions about where traffic is sent, from the data plane, which actually forwards the traffic. Traditionally, network devices like routers and switches housed both of these planes. However, in SDN, the control plane is centralized within a software-based controller. This configuration allows network devices to simply execute instructions they receive from the controller. SDN provides a programmable network management environment, enabling administrators to dynamically adjust network policies and routing as required. This separation makes the network more flexible and improves how it's managed.

Large enterprises or cloud providers use SDN to dynamically allocate bandwidth and manage traffic flows according to real-time demands. Below is a table with the advantages and disadvantages of the Software-Defined architecture.

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Advantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Centralized control</td>
    <td>Simplifies network management.</td>
  </tr>
  <tr>
    <td>Programmability &amp; Automation</td>
    <td>Network configurations can be changed quickly through software instead of manually configuring each device.</td>
  </tr>
  <tr>
    <td>Scalability &amp; Efficiency</td>
    <td>Can optimize traffic flows dynamically, leading to better resource utilization.</td>
  </tr>
</table>

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Disadvantage</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Controller Vulnerability</td>
    <td>If the central controller goes down, the network might be adversely affected.</td>
  </tr>
  <tr>
    <td>Complex Implementation</td>
    <td>Requires new skill sets and specialized software/hardware.</td>
  </tr>
</table>

<h3>Key Comparisons</h3>

Below is a comparison table that outlines key characteristics of different network architectures

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>Architecture</th>
    <th>Centralized</th>
    <th>Scalability</th>
    <th>Ease of Management</th>
    <th>Typical Use Cases</th>
  </tr>
  <tr>
    <td>P2P</td>
    <td>Decentralized (or partial)</td>
    <td>High (as peers grow)</td>
    <td>Complex (no central control)</td>
    <td>File-sharing, blockchain</td>
  </tr>
  <tr>
    <td>Client-Server</td>
    <td>Centralized</td>
    <td>Moderate</td>
    <td>Easier (server-based)</td>
    <td>Websites, email services</td>
  </tr>
  <tr>
    <td>Hybrid</td>
    <td>Partially central</td>
    <td>Higher than C-S</td>
    <td>More complex management</td>
    <td>Messaging apps, video conferencing</td>
  </tr>
  <tr>
    <td>Cloud</td>
    <td>Centralized in provider’s infra</td>
    <td>High</td>
    <td>Easier (outsourced)</td>
    <td>Cloud storage, SaaS, PaaS</td>
  </tr>
  <tr>
    <td>SDN</td>
    <td>Centralized control plane</td>
    <td>High (policy-driven)</td>
    <td>Moderate (needs specialized tools)</td>
    <td>Datacenters, large enterprises</td>
  </tr>
</table>

Conclusion

Each architecture has its unique benefits and challenges, and in practice, we often see these models blended to balance performance, scalability, and cost. Understanding these distinctions is important for anyone planning to set up or improve network systems.
