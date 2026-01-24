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
