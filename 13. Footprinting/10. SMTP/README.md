<h3>SMTP</h3>

The Simple Mail Transfer Protocol (SMTP) is a protocol for sending emails in an IP network. It can be used between an email client and an outgoing mail server or between two SMTP servers. SMTP is often combined with the IMAP or POP3 protocols, which can fetch emails and send emails. In principle, it is a client-server-based protocol, although SMTP can be used between a client and a server and between two SMTP servers. In this case, a server effectively acts as a client.

By default, SMTP servers accept connection requests on port 25. However, newer SMTP servers also use other ports such as TCP port 587. This port is used to receive mail from authenticated users/servers, usually using the STARTTLS command to switch the existing plaintext connection to an encrypted connection. The authentication data is protected and no longer visible in plaintext over the network. At the beginning of the connection, authentication occurs when the client confirms its identity with a user name and password. The emails can then be transmitted. For this purpose, the client sends the server sender and recipient addresses, the email's content, and other information and parameters. After the email has been transmitted, the connection is terminated again. The email server then starts sending the email to another SMTP server.

SMTP works unencrypted without further measures and transmits all commands, data, or authentication information in plain text. To prevent unauthorized reading of data, the SMTP is used in conjunction with SSL/TLS encryption. Under certain circumstances, a server uses a port other than the standard TCP port 25 for the encrypted connection, for example, TCP port 465.

An essential function of an SMTP server is preventing spam using authentication mechanisms that allow only authorized users to send e-mails. For this purpose, most modern SMTP servers support the protocol extension ESMTP with SMTP-Auth. After sending his e-mail, the SMTP client, also known as Mail User Agent (MUA), converts it into a header and a body and uploads both to the SMTP server. This has a so-called Mail Transfer Agent (MTA), the software basis for sending and receiving e-mails. The MTA checks the e-mail for size and spam and then stores it. To relieve the MTA, it is occasionally preceded by a Mail Submission Agent (MSA), which checks the validity, i.e., the origin of the e-mail. This MSA is also called Relay server. These are very important later on, as the so-called Open Relay Attack can be carried out on many SMTP servers due to incorrect configuration. We will discuss this attack and how to identify the weak point for it a little later. The MTA then searches the DNS for the IP address of the recipient mail server.

On arrival at the destination SMTP server, the data packets are reassembled to form a complete e-mail. From there, the Mail delivery agent (MDA) transfers it to the recipient's mailbox.

<img width="1010" height="110" alt="image" src="https://github.com/user-attachments/assets/21f49ace-69c3-4ccc-a377-b85c80f988f4" />


But SMTP has two disadvantages inherent to the network protocol.


1. The first is that sending an email using SMTP does not return a usable delivery confirmation. Although the specifications of the protocol provide for this type of notification, its formatting is not specified by default, so that usually only an English-language error message, including the header of the undelivered message, is returned.

2. Users are not authenticated when a connection is established, and the sender of an email is therefore unreliable. As a result, open SMTP relays are often misused to send spam en masse. The originators use arbitrary fake sender addresses for this purpose to not be traced (mail spoofing). Today, many different security techniques are used to prevent the misuse of SMTP servers. For example, suspicious emails are rejected or moved to quarantine (spam folder). For example, responsible for this are the identification protocol DomainKeys (DKIM), the Sender Policy Framework (SPF).

For this purpose, an extension for SMTP has been developed called Extended SMTP (ESMTP). When people talk about SMTP in general, they usually mean ESMTP. ESMTP uses TLS, which is done after the EHLO command by sending STARTTLS. This initializes the SSL-protected SMTP connection, and from this moment on, the entire connection is encrypted, and therefore more or less secure. Now AUTH PLAIN extension for authentication can also be used safely.

<h3>Default Configuration</h3>

Each SMTP server can be configured in many ways, as can all other services. However, there are differences because the SMTP server is only responsible for sending and forwarding emails.

<h3>Default Configuration</h3>

@htb[/htb]$ cat /etc/postfix/main.cf | grep -v "#" | sed -r "/^\s*$/d"

The sending and communication are also done by special commands that cause the SMTP server to do what the user requires.

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>AUTH PLAIN</td>
      <td>AUTH is a service extension used to authenticate the client.</td>
    </tr>
    <tr>
      <td>HELO</td>
      <td>The client logs in with its computer name and thus starts the session.</td>
    </tr>
    <tr>
      <td>MAIL FROM</td>
      <td>The client names the email sender.</td>
    </tr>
    <tr>
      <td>RCPT TO</td>
      <td>The client names the email recipient.</td>
    </tr>
    <tr>
      <td>DATA</td>
      <td>The client initiates the transmission of the email.</td>
    </tr>
    <tr>
      <td>RSET</td>
      <td>The client aborts the initiated transmission but keeps the connection between client and server.</td>
    </tr>
    <tr>
      <td>VRFY</td>
      <td>The client checks if a mailbox is available for message transfer.</td>
    </tr>
    <tr>
      <td>EXPN</td>
      <td>The client also checks if a mailbox is available for messaging with this command.</td>
    </tr>
    <tr>
      <td>NOOP</td>
      <td>The client requests a response from the server to prevent disconnection due to time-out.</td>
    </tr>
    <tr>
      <td>QUIT</td>
      <td>The client terminates the session.</td>
    </tr>
  </tbody>
</table>

To interact with the SMTP server, we can use the telnet tool to initialize a TCP connection with the SMTP server. The actual initialization of the session is done with the command mentioned above, HELO or EHLO.

<h3>Telnet - HELO/EHLO</h3>

@htb[/htb]$ telnet 10.129.14.128 25

The command VRFY can be used to enumerate existing users on the system. However, this does not always work. Depending on how the SMTP server is configured, the SMTP server may issue code 252 and confirm the existence of a user that does not exist on the system. A list of all SMTP response codes can be found here.

<h3>Telnet - VRFY</h3>

@htb[/htb]$ telnet 10.129.14.128 25

Therefore, one should never entirely rely on the results of automatic tools. After all, they execute pre-configured commands, but none of the functions explicitly state how the administrator configures the tested server.

Sometimes we may have to work through a web proxy. We can also make this web proxy connect to the SMTP server. The command that we would send would then look something like this: CONNECT 10.129.14.128:25 HTTP/1.0

All the commands we enter in the command line to send an email we know from every email client program like Thunderbird, Gmail, Outlook, and many others. We specify the subject, to whom the email should go, CC, BCC, and the information we want to share with others. Of course, the same works from the command line.

<h3>Send an Email</h3>

@htb[/htb]$ telnet 10.129.14.128 25

The mail header is the carrier of a large amount of interesting information in an email. Among other things, it provides information about the sender and recipient, the time of sending and arrival, the stations the email passed on its way, the content and format of the message, and the sender and recipient.

Some of this information is mandatory, such as sender information and when the email was created. Other information is optional. However, the email header does not contain any information necessary for technical delivery. It is transmitted as part of the transmission protocol. Both sender and recipient can access the header of an email, although it is not visible at first glance. The structure of an email header is defined by RFC5322.

<h3>Dangerous Settings</h3>

To prevent the sent emails from being filtered by spam filters and not reaching the recipient, the sender can use a relay server that the recipient trusts. It is an SMTP server that is known and verified by all others. As a rule, the sender must authenticate himself to the relay server before using it.

Often, administrators have no overview of which IP ranges they have to allow. This results in a misconfiguration of the SMTP server that we will still often find in external and internal penetration tests. Therefore, they allow all IP addresses not to cause errors in the email traffic and thus not to disturb or unintentionally interrupt the communication with potential and current customers.

<h3>Open Relay Configuration</h3>

mynetworks = 0.0.0.0/0

With this setting, this SMTP server can send fake emails and thus initialize communication between multiple parties. Another attack possibility would be to spoof the email and read it.

<h3>Footprinting the Service</h3>

The default Nmap scripts include smtp-commands, which uses the EHLO command to list all possible commands that can be executed on the target SMTP server.

<h3>Nmap</h3>

@htb[/htb]$ sudo nmap 10.129.14.128 -sC -sV -p25

However, we can also use the smtp-open-relay NSE script to identify the target SMTP server as an open relay using 16 different tests. If we also print out the output of the scan in detail, we will also be able to see which tests the script is running.

<h3>Nmap - Open Relay</h3>

@htb[/htb]$ sudo nmap 10.129.14.128 -p25 --script smtp-open-relay -v

