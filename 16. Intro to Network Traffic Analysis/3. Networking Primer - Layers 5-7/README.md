<h3>Networking Primer - Layers 5-7</h3>

We have seen how lower-level networking functions, now let us look at some of the upper layer protocols that handle our applications. It takes many different applications and services to maintain a network connection and ensure that data can be transferred between hosts. This section will outline just a vital few.

HTTP

Hypertext Transfer Protocol (HTTP) is a stateless Application Layer protocol that has been in use since 1990. HTTP enables the transfer of data in clear text between a client and server over TCP. The client would send an HTTP request to the server, asking for a resource. A session is established, and the server responds with the requested media (HTML, images, hyperlinks, video). HTTP utilizes ports 80 or 8000 over TCP during normal operations. In exceptional circumstances, it can be modified to use alternate ports, or even at times, UDP.

HTTP Methods

To perform operations such as fetching webpages, requesting items for download, or posting your most recent tweet all require the use of specific methods. These methods define the actions taken when requesting a URI. Methods:

<table border="1" cellpadding="6" cellspacing="0">
<thead>
<tr>
<th>Method</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>HEAD</td>
<td>Required. A safe method that requests a response similar to GET, except the message body is not included. Useful for checking server status.</td>
</tr>
<tr>
<td>GET</td>
<td>Required. The most common method. Requests information or content from the server.</td>
</tr>
<tr>
<td>POST</td>
<td>Optional. Submits data to the server (e.g., forms, comments). Action depends on the server and should be validated by response codes.</td>
</tr>
<tr>
<td>PUT</td>
<td>Optional. Creates or updates a resource at the specified URI. If no object exists, it creates one; if it exists, it updates it.</td>
</tr>
<tr>
<td>DELETE</td>
<td>Optional. Removes the resource at the given URI.</td>
</tr>
<tr>
<td>TRACE</td>
<td>Optional. Used for diagnostics. The server echoes back the received request.</td>
</tr>
<tr>
<td>OPTIONS</td>
<td>Optional. Retrieves supported HTTP methods for a resource without requesting the data.</td>
</tr>
<tr>
<td>CONNECT</td>
<td>Optional. Used with proxies or firewalls. Allows tunneling over HTTP (e.g., SSL tunnels).</td>
</tr>
</tbody>
</table>

Notice that we have required or optional listed beside each method. As a requirement by the standard, GET and HEAD must always work and exist with standard HTTP implementations. This is true only for them. The methods trace, options, delete, put and post are optional functionalities one can allow. An example of this is a read-only webpage like a blog post. The client PC can request a resource from the page but not modify, add, or delete the resource or resources.

For more information on HTTP as a protocol or how it operates, see RFC:2616.

<h3>HTTPS</h3>

HTTP Secure (HTTPS) is a modification of the HTTP protocol designed to utilize Transport Layer Security (TLS) or Secure Sockets Layer (SSL) with older applications for data security. TLS is utilized as an encryption mechanism to secure the communications between a client and a server. TLS can wrap regular HTTP traffic within TLS, which means that we can encrypt our entire conversation, not just the data sent or requested. Before the TLS mechanism was in place, we were vulnerable to Man-in-the-middle attacks and other types of reconnaissance or hijacking, meaning anyone in the same LAN as the client or server could view the web traffic if they were listening on the wire. We can now have security implemented in the browser enabling everyone to encrypt their web habits, search requests, sessions or data transfers, bank transactions, and much more.

Even though it is HTTP at its base, HTTPS utilizes ports 443 and 8443 instead of the standard port 80. This is a simple way for the client to signal the server that it wishes to establish a secure connection. Let's look at an output of HTTPS traffic and discern how a TLS handshake functions for a minute.

<h3>TLS Handshake Via HTTPS</h3>

<img width="992" height="370" alt="image" src="https://github.com/user-attachments/assets/11a9a8a6-dcd9-49b9-aaeb-6910b61b0af4" />

In the first few packets, we can see that the client establishes a session to the server using port 443 boxed in blue. This signals the server that it wishes to use HTTPS as the application communication protocol.

Once a session is initiated via TCP, a TLS ClientHello is sent next to begin the TLS handshake. During the handshake, several parameters are agreed upon, including session identifier, peer x509 certificate, compression algorithm to be used, the cipher spec encryption algorithm, if the session is resumable, and a 48-byte master secret shared between the client and server to validate the session.

Once the session is established, all data and methods will be sent through the TLS connection and appear as TLS Application Data as seen in the red box. TLS is still using TCP as its transport protocol, so we will still see acknowledgment packets from the stream coming over port 443.

To summarize the handshake:

1. Client and server exchange hello messages to agree on connection parameters.

2. Client and server exchange necessary cryptographic parameters to establish a premaster secret.

3. Client and server will exchange x.509 certificates and cryptographic information allowing for authentication within the session.

4. Generate a master secret from the premaster secret and exchanged random values.

5. Client and server issue negotiated security parameters to the record layer portion of the TLS protocol.

6. Client and server verify that their peer has calculated the same security parameters and that the handshake occurred without tampering by an attacker.

Encryption in itself is a complex and lengthy topic that deserves its own module. This section is a simple summary of how HTTP and TLS provide security within the HTTPS application protocol. For more information on how HTTPS functions and how TLS performs security operations, see RFC:2246.

<h3>FTP</h3>

File Transfer Protocol (FTP) is an Application Layer protocol that enables quick data transfer between computing devices. FTP can be utilized from the command-line, web browser, or through a graphical FTP client such as FileZilla. FTP itself is established as an insecure protocol, and most users have moved to utilize tools such as SFTP to transfer files through secure channels. As a note moving into the future, most modern web browsers have phased out support for FTP as of 2020.

When we think about communication between hosts, we typically think about a client and server talking over a single socket. Through this socket, both the client and server send commands and data over the same link. In this aspect, FTP is unique since it utilizes multiple ports at a time. FTP uses ports 20 and 21 over TCP. Port 20 is used for data transfer, while port 21 is utilized for issuing commands controlling the FTP session. In regards to authentication, FTP supports user authentication as well as allowing anonymous access if configured.

FTP is capable of running in two different modes, active or passive. Active is the default operational method utilized by FTP, meaning that the server listens for a control command PORT from the client, stating what port to use for data transfer. Passive mode enables us to access FTP servers located behind firewalls or a NAT-enabled link that makes direct TCP connections impossible. In this instance, the client would send the PASV command and wait for a response from the server informing the client what IP and port to utilize for the data transfer channel connection.

<h3>FTP Command & Response Examples</h3>

<img width="995" height="396" alt="image" src="https://github.com/user-attachments/assets/4ffb8355-a6cf-4c74-b89b-a805de57b1ce" />

The image above shows several examples of requests issued over the FTP command channel green arrows, and the responses sent back from the FTP server blue arrows. This is all pretty standard stuff. For a list of each command and what it is doing, check out the table below.

When looking at FTP traffic, some common commands we can see passed over port 21 include:

<h3>FTP Commands</h3>

<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>USER</td>
      <td>Specifies the user to log in as.</td>
    </tr>
    <tr>
      <td>PASS</td>
      <td>Sends the password for the user attempting to log in.</td>
    </tr>
    <tr>
      <td>PORT</td>
      <td>When in active mode, this will change the data port used.</td>
    </tr>
    <tr>
      <td>PASV</td>
      <td>Switches the connection to the server from active mode to passive.</td>
    </tr>
    <tr>
      <td>LIST</td>
      <td>Displays a list of the files in the current directory.</td>
    </tr>
    <tr>
      <td>CWD</td>
      <td>Will change the current working directory to one specified.</td>
    </tr>
    <tr>
      <td>PWD</td>
      <td>Prints out the directory you are currently working in.</td>
    </tr>
    <tr>
      <td>SIZE</td>
      <td>Will return the size of a file specified.</td>
    </tr>
    <tr>
      <td>RETR</td>
      <td>Retrieves the file from the FTP server.</td>
    </tr>
    <tr>
      <td>QUIT</td>
      <td>Ends the session.</td>
    </tr>
  </tbody>
</table>

This is not an exhaustive list of the possible FTP control commands that could be seen. These can vary based on the FTP application or shell in use. For more information on FTP, see RFC:959.

<h3>SMB</h3>

Server Message Block (SMB) is a protocol most widely seen in Windows enterprise environments that enables sharing resources between hosts over common networking architectures. SMB is a connection-oriented protocol that requires user authentication from the host to the resource to ensure the user has correct permissions to use that resource or perform actions. In the past, SMB utilized NetBIOS as its transport mechanism over UDP ports 137 and 138. Since modern changes, SMB now supports direct TCP transport over port 445, NetBIOS over TCP port 139, and even the QUIC protocol.

As a user, SMB provides us easy and convenient access to resources like printers, shared drives, authentication servers, and more. For this reason, SMB is very attractive to potential attackers as well.

Like any other application that uses TCP as its transport mechanism, it will perform standard functions like the three-way handshake and acknowledging received packets. Let us take a second to look at some SMB traffic to familiarize ourselves.

<h3>SMB On The Wire</h3>

<img width="992" height="502" alt="image" src="https://github.com/user-attachments/assets/dff51dca-c506-4f01-854a-c42ef3c28a60" />

Looking at the image above, we can see that it performs the TCP handshake each time it establishes a session orange boxes. When looking at the source and destination ports blue box, port 445 is being utilized, signaling SMB traffic over TCP. If we look at the green boxes, the info field tells us a bit about what is happening in the SMB communication. In this example, there are many errors, which is an example of something to dig deeper into. One or two auth failures from a user is relatively common, but a large cluster of them repeating can signal a potential unauthorized individual trying to access a user's account or use their credentials to move. This is a common tactic of attackers, grab an authenticated user, steal their credentials, utilize them to move laterally, or access resources they typically would be denied access to.

This is just one example of SMB use. Another common thing we will see is file-share access between servers and hosts. For the most part, this is regular communication. However, if we see a host access file shares on other hosts, this is not common. Please pay attention to who is requesting connections, where to, and what they are doing.

What is the default operational mode method used by FTP?
Active

- 0 FTP utilizes what two ports for command and data transfer? (separate the two numbers with a space)

  20 21

- 0 Does SMB utilize TCP or UDP as its transport layer protocol?

  TCP

- 0 SMB has moved to using what TCP port?

  445

- 0 Hypertext Transfer Protocol uses what well known TCP port number?

  80

- 0 What HTTP method is used to request information and content from the webserver?

  GET

- 0 What web based protocol uses TLS as a security measure?

  HTTPS

- 0 True or False: when utilizing HTTPS, all data sent across the session will appear as TLS Application data?

  True
