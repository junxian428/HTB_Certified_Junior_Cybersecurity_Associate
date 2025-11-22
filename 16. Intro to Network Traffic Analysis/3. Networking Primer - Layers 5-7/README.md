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
