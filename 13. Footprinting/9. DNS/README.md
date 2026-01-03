<h3>DNS</h3>

Domain Name System (DNS) is an integral part of the Internet. For example, through domain names, such as academy.hackthebox.com or www.hackthebox.com, we can reach the web servers that the hosting provider has assigned one or more specific IP addresses. DNS is a system for resolving computer names into IP addresses, and it does not have a central database. Simplified, we can imagine it like a library with many different phone books. The information is distributed over many thousands of name servers. Globally distributed DNS servers translate domain names into IP addresses and thus control which server a user can reach via a particular domain. There are several types of DNS servers that are used worldwide:

- DNS root server

- Authoritative name server

- Non-authoritative name server

- Caching server

- Forwarding server

- Resolver

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Server Type</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>DNS Root Server</strong></td>
      <td>
        The root servers of the DNS are responsible for the top-level domains (TLD).
        As the last instance, they are only requested if the name server does not respond.
        Thus, a root server is a central interface between users and content on the Internet,
        as it links domain and IP address. The Internet Corporation for Assigned Names and Numbers (ICANN)
        coordinates the work of the root name servers. There are 13 such root servers around the globe.
      </td>
    </tr>
    <tr>
      <td><strong>Authoritative Nameserver</strong></td>
      <td>
        Authoritative name servers hold authority for a particular zone.
        They only answer queries from their area of responsibility, and their information is binding.
        If an authoritative name server cannot answer a client's query, the root name server takes over.
        Based on the country, company, etc., authoritative nameservers provide answers to recursive DNS
        nameservers, assisting in finding the specific web server(s).
      </td>
    </tr>
    <tr>
      <td><strong>Non-authoritative Nameserver</strong></td>
      <td>
        Non-authoritative name servers are not responsible for a particular DNS zone.
        Instead, they collect information on specific DNS zones themselves, which is done
        using recursive or iterative DNS querying.
      </td>
    </tr>
    <tr>
      <td><strong>Caching DNS Server</strong></td>
      <td>
        Caching DNS servers cache information from other name servers for a specified period.
        The authoritative name server determines the duration of this storage.
      </td>
    </tr>
    <tr>
      <td><strong>Forwarding Server</strong></td>
      <td>
        Forwarding servers perform only one function: they forward DNS queries to another DNS server.
      </td>
    </tr>
    <tr>
      <td><strong>Resolver</strong></td>
      <td>
        Resolvers are not authoritative DNS servers but perform name resolution locally
        in the computer or router.
      </td>
    </tr>
  </tbody>
</table>


DNS is mainly unencrypted. Devices on the local WLAN and Internet providers can therefore hack in and spy on DNS queries. Since this poses a privacy risk, there are now some solutions for DNS encryption. By default, IT security professionals apply DNS over TLS (DoT) or DNS over HTTPS (DoH) here. In addition, the network protocol DNSCrypt also encrypts the traffic between the computer and the name server.

However, the DNS does not only link computer names and IP addresses. It also stores and outputs additional information about the services associated with a domain. A DNS query can therefore also be used, for example, to determine which computer serves as the e-mail server for the domain in question or what the domain's name servers are called.

<img width="588" height="422" alt="image" src="https://github.com/user-attachments/assets/a870c9ca-2d2a-4232-8d1b-5d909ef3213d" />

Different DNS records are used for the DNS queries, which all have various tasks. Moreover, separate entries exist for different functions since we can set up mail servers and other servers for a domain.

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>DNS Record</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>A</strong></td>
      <td>Returns an IPv4 address of the requested domain as a result.</td>
    </tr>
    <tr>
      <td><strong>AAAA</strong></td>
      <td>Returns an IPv6 address of the requested domain.</td>
    </tr>
    <tr>
      <td><strong>MX</strong></td>
      <td>Returns the responsible mail servers as a result.</td>
    </tr>
    <tr>
      <td><strong>NS</strong></td>
      <td>Returns the DNS servers (nameservers) of the domain.</td>
    </tr>
    <tr>
      <td><strong>TXT</strong></td>
      <td>
        This record can contain various information. It can be used to validate the Google Search Console,
        SSL certificates, or for SPF and DMARC entries to validate mail traffic and protect it from spam.
      </td>
    </tr>
    <tr>
      <td><strong>CNAME</strong></td>
      <td>
        Serves as an alias for another domain name. For example, www.hackthebox.eu can point to the same IP as hackthebox.eu by creating an A record for hackthebox.eu and a CNAME for www.hackthebox.eu.
      </td>
    </tr>
    <tr>
      <td><strong>PTR</strong></td>
      <td>Works the other way around (reverse lookup). Converts IP addresses into valid domain names.</td>
    </tr>
    <tr>
      <td><strong>SOA</strong></td>
      <td>Provides information about the corresponding DNS zone and the email address of the administrative contact.</td>
    </tr>
  </tbody>
</table>

The SOA record is located in a domain's zone file and specifies who is responsible for the operation of the domain and how DNS information for the domain is managed.

@htb[/htb]$ dig soa www.inlanefreight.com

The dot (.) is replaced by an at sign (@) in the email address. In this example, the email address of the administrator is awsdns-hostmaster@amazon.com.

<h3>Default Configuration</h3>

There are many different configuration types for DNS. Therefore, we will only discuss the most important ones to illustrate better the functional principle from an administrative point of view. All DNS servers work with three different types of configuration files:

1. local DNS configuration files

2. zone files

3. reverse name resolution files

The DNS server Bind9 is very often used on Linux-based distributions. Its local configuration file (named.conf) is roughly divided into two sections, firstly the options section for general settings and secondly the zone entries for the individual domains. The local configuration files are usually:

- named.conf.local

- named.conf.options

- named.conf.log

It contains the associated RFC where we can customize the server to our needs and our domain structure with the individual zones for different domains. The configuration file named.conf is divided into several options that control the behavior of the name server. A distinction is made between global options and zone options.

Global options are general and affect all zones. A zone option only affects the zone to which it is assigned. Options not listed in named.conf have default values. If an option is both global and zone-specific, then the zone option takes precedence.

<h3>Local DNS Configuration</h3>

@bind9:~# cat /etc/bind/named.conf.local

In this file, we can define the different zones. These zones are divided into individual files, which in most cases are mainly intended for one domain only. Exceptions are ISP and public DNS servers. In addition, many different options extend or reduce the functionality. We can look these up on the documentation of Bind9.

A zone file is a text file that describes a DNS zone with the BIND file format. In other words it is a point of delegation in the DNS tree. The BIND file format is the industry-preferred zone file format and is now well established in DNS server software. A zone file describes a zone completely. There must be precisely one SOA record and at least one NS record. The SOA resource record is usually located at the beginning of a zone file. The main goal of these global rules is to improve the readability of zone files. A syntax error usually results in the entire zone file being considered unusable. The name server behaves similarly as if this zone did not exist. It responds to DNS queries with a SERVFAIL error message.

In short, here, all forward records are entered according to the BIND format. This allows the DNS server to identify which domain, hostname, and role the IP addresses belong to. In simple terms, this is the phone book where the DNS server looks up the addresses for the domains it is searching for.
