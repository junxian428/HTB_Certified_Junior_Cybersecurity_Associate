<h3>IMAP / POP3</h3>

With the help of the Internet Message Access Protocol (IMAP), access to emails from a mail server is possible. Unlike the Post Office Protocol (POP3), IMAP allows online management of emails directly on the server and supports folder structures. Thus, it is a network protocol for the online management of emails on a remote server. The protocol is client-server-based and allows synchronization of a local email client with the mailbox on the server, providing a kind of network file system for emails, allowing problem-free synchronization across several independent clients. POP3, on the other hand, does not have the same functionality as IMAP, and it only provides listing, retrieving, and deleting emails as functions at the email server. Therefore, protocols such as IMAP must be used for additional functionalities such as hierarchical mailboxes directly at the mail server, access to multiple mailboxes during a session, and preselection of emails.

Clients access these structures online and can create local copies. Even across several clients, this results in a uniform database. Emails remain on the server until they are deleted. IMAP is text-based and has extended functions, such as browsing emails directly on the server. It is also possible for several users to access the email server simultaneously. Without an active connection to the server, managing emails is impossible. However, some clients offer an offline mode with a local copy of the mailbox. The client synchronizes all offline local changes when a connection is reestablished.

The client establishes the connection to the server via port 143. For communication, it uses text-based commands in ASCII format. Several commands can be sent in succession without waiting for confirmation from the server. Later confirmations from the server can be assigned to the individual commands using the identifiers sent along with the commands. Immediately after the connection is established, the user is authenticated by user name and password to the server. Access to the desired mailbox is only possible after successful authentication.

SMTP is usually used to send emails. By copying sent emails into an IMAP folder, all clients have access to all sent mails, regardless of the computer from which they were sent. Another advantage of the Internet Message Access Protocol is creating personal folders and folder structures in the mailbox. This feature makes the mailbox clearer and easier to manage. However, the storage space requirement on the email server increases.

Without further measures, IMAP works unencrypted and transmits commands, emails, or usernames and passwords in plain text. Many email servers require establishing an encrypted IMAP session to ensure greater security in email traffic and prevent unauthorized access to mailboxes. SSL/TLS is usually used for this purpose. Depending on the method and implementation used, the encrypted connection uses the standard port 143 or an alternative port such as 993.

<h3>Default Configuration</h3>

Both IMAP and POP3 have a large number of configuration options, making it difficult to deep dive into each component in more detail. If you wish to examine these protocol configurations deeper, we recommend creating a VM locally and install the two packages dovecot-imapd, and dovecot-pop3d using apt and play around with the configurations and experiment.

In the documentation of Dovecot, we can find the individual core settings and service configuration options that can be utilized for our experiments. However, let us look at the list of commands and see how we can directly interact and communicate with IMAP and POP3 using the command line.

<h3>IMAP Commands</h3>

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>#</th>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>LOGIN username password</td>
      <td>User login</td>
    </tr>
    <tr>
      <td>1</td>
      <td>LIST "" *</td>
      <td>Lists all directories</td>
    </tr>
    <tr>
      <td>1</td>
      <td>CREATE "INBOX"</td>
      <td>Creates a mailbox with a specified name</td>
    </tr>
    <tr>
      <td>1</td>
      <td>DELETE "INBOX"</td>
      <td>Deletes a mailbox</td>
    </tr>
    <tr>
      <td>1</td>
      <td>RENAME "ToRead" "Important"</td>
      <td>Renames a mailbox</td>
    </tr>
    <tr>
      <td>1</td>
      <td>LSUB "" *</td>
      <td>Returns subscribed or active mailboxes</td>
    </tr>
    <tr>
      <td>1</td>
      <td>SELECT INBOX</td>
      <td>Selects a mailbox for access</td>
    </tr>
    <tr>
      <td>1</td>
      <td>UNSELECT INBOX</td>
      <td>Exits the selected mailbox</td>
    </tr>
    <tr>
      <td>1</td>
      <td>FETCH &lt;ID&gt; ALL</td>
      <td>Retrieves all data for a message</td>
    </tr>
    <tr>
      <td>1</td>
      <td>CLOSE</td>
      <td>Deletes messages marked with the Deleted flag</td>
    </tr>
    <tr>
      <td>1</td>
      <td>LOGOUT</td>
      <td>Closes the IMAP connection</td>
    </tr>
  </tbody>
</table>

<h3>POP3 Commands</h3>

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>USER username</td>
      <td>Identifies the user</td>
    </tr>
    <tr>
      <td>PASS password</td>
      <td>Authenticates the user using a password</td>
    </tr>
    <tr>
      <td>STAT</td>
      <td>Requests the number of stored emails from the server</td>
    </tr>
    <tr>
      <td>LIST</td>
      <td>Requests the number and size of all stored emails</td>
    </tr>
    <tr>
      <td>RETR id</td>
      <td>Requests the server to retrieve an email by ID</td>
    </tr>
    <tr>
      <td>DELE id</td>
      <td>Requests the server to delete an email by ID</td>
    </tr>
    <tr>
      <td>CAPA</td>
      <td>Requests the server to list its capabilities</td>
    </tr>
    <tr>
      <td>RSET</td>
      <td>Requests the server to reset the session state</td>
    </tr>
    <tr>
      <td>QUIT</td>
      <td>Closes the connection with the POP3 server</td>
    </tr>
  </tbody>
</table>

<h3>Dangerous Settings</h3>

Nevertheless, configuration options that were improperly configured could allow us to obtain more information, such as debugging the executed commands on the service or logging in as anonymous, similar to the FTP service. Most companies use third-party email providers such as Google, Microsoft, and many others. However, some companies still use their own mail servers for many different reasons. One of these reasons is to maintain the privacy that they want to keep in their own hands. Many configuration mistakes can be made by administrators, which in the worst cases will allow us to read all the emails sent and received, which may even contain confidential or sensitive information. Some of these configuration options include:

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Setting</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>auth_debug</td>
      <td>Enables all authentication debug logging</td>
    </tr>
    <tr>
      <td>auth_debug_passwords</td>
      <td>Increases authentication log verbosity and logs submitted passwords and authentication schemes</td>
    </tr>
    <tr>
      <td>auth_verbose</td>
      <td>Logs unsuccessful authentication attempts and their failure reasons</td>
    </tr>
    <tr>
      <td>auth_verbose_passwords</td>
      <td>Logs passwords used for authentication; passwords may be truncated</td>
    </tr>
    <tr>
      <td>auth_anonymous_username</td>
      <td>Specifies the username used when logging in via the ANONYMOUS SASL mechanism</td>
    </tr>
  </tbody>
</table>

<h3>Footprinting the Service</h3>

By default, ports 110 and 995 are used for POP3, and ports 143 and 993 are used for IMAP. The higher ports (993 and 995) use TLS/SSL to encrypt the communication between the client and server. Using Nmap, we can scan the server for these ports. The scan will return the corresponding information (as seen below) if the server uses an embedded certificate.

<h3>Nmap</h3>

@htb[/htb]$ sudo nmap 10.129.14.128 -sV -p110,143,993,995 -sC

For example, from the output, we can see that the common name is mail1.inlanefreight.htb, and the email server belongs to the organization Inlanefreight, which is located in California. The displayed capabilities show us the commands available on the server and for the service on the corresponding port.

If we successfully figure out the access credentials for one of the employees, an attacker could log in to the mail server and read or even send the individual messages.

<h3>cURL</h3>

@htb[/htb]$ curl -k 'imaps://10.129.14.128' --user user:p4ssw0rd

If we also use the verbose (-v) option, we will see how the connection is made. From this, we can see the version of TLS used for encryption, further details of the SSL certificate, and even the banner, which will often contain the version of the mail server.

@htb[/htb]$ curl -k 'imaps://10.129.14.128' --user cry0l1t3:1234 -v

To interact with the IMAP or POP3 server over SSL, we can use openssl, as well as ncat. The commands for this would look like this:

<h3>OpenSSL - TLS Encrypted Interaction POP3</h3>

@htb[/htb]$ openssl s_client -connect 10.129.14.128:pop3s

<h3>OpenSSL - TLS Encrypted Interaction IMAP</h3>

@htb[/htb]$ openssl s_client -connect 10.129.14.128:imaps

Once we have successfully initiated a connection and logged in to the target mail server, we can use the above commands to work with and navigate the server. We want to point out that the configuration of our own mail server, the research for it, and the experiments we can do together with other community members will give us the know-how to understand the communication taking place and what configuration options are responsible for this.

In the SMTP section, we have found the user robin. Another member of our team was able to find out that the user also uses his username as a password (robin:robin). We can use these credentials and try them to interact with the IMAP/POP3 services.
