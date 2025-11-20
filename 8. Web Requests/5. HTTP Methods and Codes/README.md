<h3>HTTP Methods and Codes</h3>

HTTP supports multiple methods for accessing a resource. In the HTTP protocol, several request methods allow the browser to send information, forms, or files to the server. These methods are used, among other things, to tell the server how to process the request we send and how to reply.

We saw different HTTP methods used in the HTTP requests we tested in the previous sections. With cURL, if we use -v to preview the full request, the first line contains the HTTP method (e.g. GET / HTTP/1.1), while with browser devtools, the HTTP method is shown in the Method column. Furthermore, the response headers also contain the HTTP status code, which indicates the result of processing our HTTP request.

<h3>Request Methods</h3>

The following are some of the commonly used methods:

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Method</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>GET</td>
      <td>Requests a specific resource. Additional data can be passed to the server via query strings in the URL (e.g. <code>?param=value</code>).</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>Sends data to the server. It can handle multiple types of input, such as text, PDFs, and other forms of binary data. This data is appended in the request body present after the headers. The POST method is commonly used when sending information (e.g. forms/logins) or uploading data to a website, such as images or documents.</td>
    </tr>
    <tr>
      <td>HEAD</td>
      <td>Requests the headers that would be returned if a GET request was made to the server. It doesn't return the request body and is usually made to check the response length before downloading resources.</td>
    </tr>
    <tr>
      <td>PUT</td>
      <td>Creates new resources on the server. Allowing this method without proper controls can lead to uploading malicious resources.</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>Deletes an existing resource on the webserver. If not properly secured, can lead to Denial of Service (DoS) by deleting critical files on the web server.</td>
    </tr>
    <tr>
      <td>OPTIONS</td>
      <td>Returns information about the server, such as the methods accepted by it.</td>
    </tr>
    <tr>
      <td>PATCH</td>
      <td>Applies partial modifications to the resource at the specified location.</td>
    </tr>
  </tbody>
</table>

The list only highlights a few of the most commonly used HTTP methods. The availability of a particular method depends on the server as well as the application configuration. For a full list of HTTP methods, you can visit this link.

Note: Most modern web applications mainly rely on the GET and POST methods. However, any web application that utilizes REST APIs also rely on PUT and DELETE, which are used to update and delete data on the API endpoint, respectively. Refer to the Introduction to Web Applications module for more details.

<h3>Status Codes</h3>

HTTP status codes are used to tell the client the status of their request. An HTTP server can return five classes of status codes:

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Class</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1xx</td>
      <td>Provides information and does not affect the processing of the request.</td>
    </tr>
    <tr>
      <td>2xx</td>
      <td>Returned when a request succeeds.</td>
    </tr>
    <tr>
      <td>3xx</td>
      <td>Returned when the server redirects the client.</td>
    </tr>
    <tr>
      <td>4xx</td>
      <td>Signifies improper requests from the client. For example, requesting a resource that doesn't exist or requesting a bad format.</td>
    </tr>
    <tr>
      <td>5xx</td>
      <td>Returned when there is some problem with the HTTP server itself.</td>
    </tr>
  </tbody>
</table>

The following are some of the commonly seen examples from each of the above HTTP status code classes:

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Code</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>200 OK</td>
      <td>Returned on a successful request, and the response body usually contains the requested resource.</td>
    </tr>
    <tr>
      <td>302 Found</td>
      <td>Redirects the client to another URL. For example, redirecting the user to their dashboard after a successful login.</td>
    </tr>
    <tr>
      <td>400 Bad Request</td>
      <td>Returned on encountering malformed requests such as requests with missing line terminators.</td>
    </tr>
    <tr>
      <td>403 Forbidden</td>
      <td>Signifies that the client doesn't have appropriate access to the resource. It can also be returned when the server detects malicious input from the user.</td>
    </tr>
    <tr>
      <td>404 Not Found</td>
      <td>Returned when the client requests a resource that doesn't exist on the server.</td>
    </tr>
    <tr>
      <td>500 Internal Server Error</td>
      <td>Returned when the server cannot process the request.</td>
    </tr>
  </tbody>
</table>

For a full list of standard HTTP status codes, you can visit this link. Apart from the standard HTTP codes, various servers and providers such as Cloudflare or AWS implement their own codes.
