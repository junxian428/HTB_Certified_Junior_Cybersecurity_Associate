<h3>Domain Information</h3>

Domain information is a core component of any penetration test, and it is not just about the subdomains but about the entire presence on the Internet. Therefore, we gather information and try to understand the company's functionality and which technologies and structures are necessary for services to be offered successfully and efficiently.

This type of information is gathered passively without direct and active scans. In other words, we remain hidden and navigate as "customers" or "visitors" to avoid direct connections to the company that could expose us. The OSINT relevant sections are only a tiny part of how in-depth OSINT goes and describe only a few of the many ways to obtain information in this way. More approaches and strategies for this can be found in the module OSINT: Corporate Recon.

However, when passively gathering information, we can use third-party services to understand the company better. However, the first thing we should do is scrutinize the company's main website. Then, we should read through the texts, keeping in mind what technologies and structures are needed for these services.

For example, many IT companies offer app development, IoT, hosting, data science, and IT security services, depending on their industry. If we encounter a service that we have had little to do with before, it makes sense and is necessary to get to grips with it and find out what activities it consists of and what opportunities are available. Those services also give us a good overview of how the company can be structured.

For example, this part is the combination between the first principle and the second principle of enumeration. We pay attention to what we see and we do not see. We see the services but not their functionality. However, services are bound to certain technical aspects necessary to provide a service. Therefore, we take the developer's view and look at the whole thing from their point of view. This point of view allows us to gain many technical insights into the functionality.

<h3>Online Presence
</h3>

Once we have a basic understanding of the company and its services, we can get a first impression of its presence on the Internet. Let us assume that a medium-sized company has hired us to test their entire infrastructure from a black-box perspective. This means we have only received a scope of targets and must obtain all further information ourselves.

Note: Please remember that the examples below will differ from the practical exercises and will not give the same results. However, the examples are based on real penetration tests and illustrate how and what information can be obtained.

The first point of presence on the Internet may be the SSL certificate from the company's main website that we can examine. Often, such a certificate includes more than just a subdomain, and this means that the certificate is used for several domains, and these are most likely still active.

Another source to find more subdomains is crt.sh. This source is Certificate Transparency logs. Certificate Transparency is a process that is intended to enable the verification of issued digital certificates for encrypted Internet connections. The standard (RFC 6962) provides for the logging of all digital certificates issued by a certificate authority in audit-proof logs. This is intended to enable the detection of false or maliciously issued certificates for a domain. SSL certificate providers like Let's Encrypt share this with the web interface crt.sh, which stores the new entries in the database to be accessed later.

We can also output the results in JSON format.

<h3>Certificate Transparency</h3>

Domain Information

@htb[/htb]$ curl -s https://crt.sh/\?q\=inlanefreight.com\&output\=json | jq .

If needed, we can also have them filtered by the unique subdomains.

@htb[/htb]$ curl -s https://crt.sh/\?q\=inlanefreight.com\&output\=json | jq . | grep name | cut -d":" -f2 | grep -v "CN=" | cut -d'"' -f2 | awk '{gsub(/\\n/,"\n");}1;' | sort -u

Next, we can identify the hosts directly accessible from the Internet and not hosted by third-party providers. This is because we are not allowed to test the hosts without the permission of third-party providers.

@htb[/htb]$ for i in $(cat subdomainlist);do host $i | grep "has address" | grep inlanefreight.com | cut -d" " -f1,4;done

blog.inlanefreight.com 10.129.24.93

inlanefreight.com 10.129.27.33

matomo.inlanefreight.com 10.129.127.22

www.inlanefreight.com 10.129.127.33

s3-website-us-west-2.amazonaws.com 10.129.95.250

Once we see which hosts can be investigated further, we can generate a list of IP addresses with a minor adjustment to the cut command and run them through Shodan.

Shodan can be used to find devices and systems permanently connected to the Internet like Internet of Things (IoT). It searches the Internet for open TCP/IP ports and filters the systems according to specific terms and criteria. For example, open HTTP or HTTPS ports and other server ports for FTP, SSH, SNMP, Telnet, RTSP, or SIP are searched. As a result, we can find devices and systems, such as surveillance cameras, servers, smart home systems, industrial controllers, traffic lights and traffic controllers, and various network components.

<h3>Shodan - IP List</h3>

@htb[/htb]$ for i in $(cat subdomainlist);do host $i | grep "has address" | grep inlanefreight.com | cut -d" " -f4 >> ip-addresses.txt;done

@htb[/htb]$ for i in $(cat ip-addresses.txt);do shodan host $i;done

We remember the IP 10.129.127.22 (matomo.inlanefreight.com) for later active investigations we want to perform. Now, we can display all the available DNS records where we might find more hosts.

<h3>DNS Records</h3>

@htb[/htb]$ dig any inlanefreight.com

Let us look at what we have learned here and come back to our principles. We see an IP record, some mail servers, some DNS servers, TXT records, and an SOA record.

A records: We recognize the IP addresses that point to a specific (sub)domain through the A record. Here we only see one that we already know.

MX records: The mail server records show us which mail server is responsible for managing the emails for the company. Since this is handled by google in our case, we should note this and skip it for now.

NS records: These kinds of records show which name servers are used to resolve the FQDN to IP addresses. Most hosting providers use their own name servers, making it easier to identify the hosting provider.

TXT records: this type of record often contains verification keys for different third-party providers and other security aspects of DNS, such as SPF, DMARC, and DKIM, which are responsible for verifying and confirming the origin of the emails sent. Here we can already see some valuable information if we look closer at the results.

What we could see so far were entries on the DNS server, which at first glance did not look very interesting (except for the additional IP addresses). However, we could not see the third-party providers behind the entries shown at first glance. The core information we can see now is:

Atlassian Google Gmail LogMeIn

Mailgun Outlook INWX ID/Username

10.129.24.8 10.129.27.2 10.72.82.106

For example, Atlassian states that the company uses this solution for software development and collaboration. If we are not familiar with this platform, we can try it for free to get acquainted with it.

Google Gmail indicates that Google is used for email management. Therefore, it can also suggest that we could access open GDrive folders or files with a link.

LogMeIn is a central place that regulates and manages remote access on many different levels. However, the centralization of such operations is a double-edged sword. If access as an administrator to this platform is obtained (e.g., through password reuse), one also has complete access to all systems and information.

Mailgun offers several email APIs, SMTP relays, and webhooks with which emails can be managed. This tells us to keep our eyes open for API interfaces that we can then test for various vulnerabilities such as IDOR, SSRF, POST, PUT requests, and many other attacks.

Outlook is another indicator for document management. Companies often use Office 365 with OneDrive and cloud resources such as Azure blob and file storage. Azure file storage can be very interesting because it works with the SMB protocol.

The last thing we see is INWX. This company seems to be a hosting provider where domains can be purchased and registered. The TXT record with the "MS" value is often used to confirm the domain. In most cases, it is similar to the username or ID used to log in to the management platform.
