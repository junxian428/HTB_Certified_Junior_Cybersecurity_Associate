<h3>Nmap Scripting Engine</h3>

Nmap Scripting Engine (NSE) is another handy feature of Nmap. It provides us with the possibility to create scripts in Lua for interaction with certain services. There are a total of 14 categories into which these scripts can be divided:

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Category</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>auth</td>
      <td>Determination of authentication credentials.</td>
    </tr>
    <tr>
      <td>broadcast</td>
      <td>Scripts used for host discovery by broadcasting; discovered hosts can be automatically added to remaining scans.</td>
    </tr>
    <tr>
      <td>brute</td>
      <td>Executes scripts that try to log in to the respective service by brute-forcing credentials.</td>
    </tr>
    <tr>
      <td>default</td>
      <td>Default scripts executed using the <code>-sC</code> option.</td>
    </tr>
    <tr>
      <td>discovery</td>
      <td>Evaluation of accessible services.</td>
    </tr>
    <tr>
      <td>dos</td>
      <td>Checks services for denial‑of‑service vulnerabilities; used less often because it may harm services.</td>
    </tr>
    <tr>
      <td>exploit</td>
      <td>Scripts that try to exploit known vulnerabilities for the scanned port.</td>
    </tr>
    <tr>
      <td>external</td>
      <td>Scripts that use external services for further processing.</td>
    </tr>
    <tr>
      <td>fuzzer</td>
      <td>Scripts that send different packet fields to identify vulnerabilities and unexpected packet handling (can take time).</td>
    </tr>
    <tr>
      <td>intrusive</td>
      <td>Intrusive scripts that could negatively affect the target system.</td>
    </tr>
    <tr>
      <td>malware</td>
      <td>Checks whether the target system is infected by malware.</td>
    </tr>
    <tr>
      <td>safe</td>
      <td>Defensive scripts that do not perform intrusive or destructive access.</td>
    </tr>
    <tr>
      <td>version</td>
      <td>Service detection extension scripts.</td>
    </tr>
    <tr>
      <td>vuln</td>
      <td>Identification of specific vulnerabilities.</td>
    </tr>
  </tbody>
</table>

We have several ways to define the desired scripts in Nmap.

<h3>Default Scripts</h3>

@htb[/htb]$ sudo nmap <target> -sC

<h3>Specific Scripts Category</h3>

@htb[/htb]$ sudo nmap <target> --script <category>

<h3>Defined Scripts</h3>

@htb[/htb]$ sudo nmap <target> --script <script-name>,<script-name>,...

For example, let us keep working with the target SMTP port and see the results we get with two defined scripts.

<h3>Nmap - Specifying Scripts</h3>

@htb[/htb]$ sudo nmap 10.129.2.28 -p 25 --script banner,smtp-commands

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-16 23:21 CEST

Nmap scan report for 10.129.2.28

Host is up (0.050s latency).

PORT STATE SERVICE

25/tcp open smtp

|\_banner: 220 inlane ESMTP Postfix (Ubuntu)

|\_smtp-commands: inlane, PIPELINING, SIZE 10240000, VRFY, ETRN, STARTTLS, ENHANCEDSTATUSCODES, 8BITMIME, DSN, SMTPUTF8,

MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p 25</td>
      <td>Scans only the specified port.</td>
    </tr>
    <tr>
      <td>--script banner,smtp-commands</td>
      <td>Uses the specified NSE scripts.</td>
    </tr>
  </tbody>
</table>

We see that we can recognize the Ubuntu distribution of Linux by using the' banner' script. The smtp-commands script shows us which commands we can use by interacting with the target SMTP server. In this example, such information may help us to find out existing users on the target. Nmap also gives us the ability to scan our target with the aggressive option (-A). This scans the target with multiple options as service detection (-sV), OS detection (-O), traceroute (--traceroute), and with the default NSE scripts (-sC).

<h3>Nmap - Aggressive Scan</h3>

@htb[/htb]$ sudo nmap 10.129.2.28 -p 80 -A

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-17 01:38 CEST

Nmap scan report for 10.129.2.28

Host is up (0.012s latency).

PORT STATE SERVICE VERSION

80/tcp open http Apache httpd 2.4.29 ((Ubuntu))

|\_http-generator: WordPress 5.3.4

|\_http-server-header: Apache/2.4.29 (Ubuntu)

|\_http-title: blog.inlanefreight.com

MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port

Aggressive OS guesses: Linux 2.6.32 (96%), Linux 3.2 - 4.9 (96%), Linux 2.6.32 - 3.10 (96%), Linux 3.4 - 3.10 (95%), Linux 3.1 (95%), Linux 3.2 (95%),

AXIS 210A or 211 Network Camera (Linux 2.6.17) (94%), Synology DiskStation Manager 5.2-5644 (94%), Netgear RAIDiator 4.2.28 (94%),

Linux 2.6.32 - 2.6.35 (94%)

No exact OS matches for host (test conditions non-ideal).

Network Distance: 1 hop

TRACEROUTE

HOP RTT ADDRESS

1 11.91 ms 10.129.2.28

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .

Nmap done: 1 IP address (1 host up) scanned in 11.36 seconds

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p 80</td>
      <td>Scans only the specified port.</td>
    </tr>
    <tr>
      <td>-A</td>
      <td>Performs service detection, OS detection, traceroute, and uses default scripts to scan the target.</td>
    </tr>
  </tbody>
</table>

With the help of the used scan option (-A), we found out what kind of web server (Apache 2.4.29) is running on the system, which web application (WordPress 5.3.4) is used, and the title (blog.inlanefreight.com) of the web page. Also, Nmap shows that it is likely to be Linux (96%) operating system.

<h3>Vulnerability Assessment</h3>

Now let us move on to HTTP port 80 and see what information and vulnerabilities we can find using the vuln category from NSE.

<h3>Nmap - Vuln Category</h3>

@htb[/htb]$ sudo nmap 10.129.2.28 -p 80 -sV --script vuln

Nmap scan report for 10.129.2.28

Host is up (0.036s latency).

PORT STATE SERVICE VERSION

80/tcp open http Apache httpd 2.4.29 ((Ubuntu))

| http-enum:

| /wp-login.php: Possible admin folder

| /readme.html: Wordpress version: 2

| /: WordPress version: 5.3.4

| /wp-includes/images/rss.png: Wordpress version 2.2 found.

| /wp-includes/js/jquery/suggest.js: Wordpress version 2.5 found.

| /wp-includes/images/blank.gif: Wordpress version 2.6 found.

| /wp-includes/js/comment-reply.js: Wordpress version 2.7 found.

| /wp-login.php: Wordpress login page.

| /wp-admin/upgrade.php: Wordpress login page.

|\_ /readme.html: Interesting, a readme.

|\_http-server-header: Apache/2.4.29 (Ubuntu)

|\_http-stored-xss: Couldn't find any stored XSS vulnerabilities.

| http-wordpress-users:

| Username found: admin

|\_Search stopped at ID #25. Increase the upper limit if necessary with 'http-wordpress-users.limit'

| vulners:

| cpe:/a:apache:http_server:2.4.29:

| CVE-2019-0211 7.2 https://vulners.com/cve/CVE-2019-0211

| CVE-2018-1312 6.8 https://vulners.com/cve/CVE-2018-1312

| CVE-2017-15715 6.8 https://vulners.com/cve/CVE-2017-15715

<SNIP>

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Scanning Options</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p 80</td>
      <td>Scans only the specified port.</td>
    </tr>
    <tr>
      <td>-sV</td>
      <td>Performs service version detection on specified ports.</td>
    </tr>
    <tr>
      <td>--script vuln</td>
      <td>Uses all related scripts from the specified category.</td>
    </tr>
  </tbody>
</table>

The scripts used for the last scan interact with the webserver and its web application to find out more information about their versions and check various databases to see if there are known vulnerabilities. More information about NSE scripts and the corresponding categories we can find at: https://nmap.org/nsedoc/index.html

Use NSE and its scripts to find the flag that one of the services contain and submit it as the answer.

HTB{873nniuc71bu6usbs1i96as6dsv26}
