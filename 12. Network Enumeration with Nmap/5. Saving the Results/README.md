<h3>Saving the Results</h3>

<h3>Different Formats</h3>

While we run various scans, we should always save the results. We can use these later to examine the differences between the different scanning methods we have used. Nmap can save the results in 3 different formats.

Normal output (-oN) with the .nmap file extension

Grepable output (-oG) with the .gnmap file extension

XML output (-oX) with the .xml file extension

We can also specify the option (-oA) to save the results in all formats. The command could look like this:

@htb[/htb]$ sudo nmap 10.129.2.28 -p- -oA target

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-16 12:14 CEST

Nmap scan report for 10.129.2.28

Host is up (0.0091s latency).

Not shown: 65525 closed ports

PORT STATE SERVICE

22/tcp open ssh

25/tcp open smtp

80/tcp open http

MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 10.22 seconds

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Scanning Option</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>10.129.2.28</td>
      <td>Scans the specified target.</td>
    </tr>
    <tr>
      <td>-p-</td>
      <td>Scans all ports.</td>
    </tr>
    <tr>
      <td>-oA target</td>
      <td>Saves the results in all formats, using <code>target</code> as the file name prefix.</td>
    </tr>
  </tbody>
</table>

If no full path is given, the results will be stored in the directory we are currently in. Next, we look at the different formats Nmap has created for us.

@htb[/htb]$ ls

target.gnmap target.xml target.nmap

<h3>Normal Output</h3>

@htb[/htb]$ cat target.nmap

# Nmap 7.80 scan initiated Tue Jun 16 12:14:53 2020 as: nmap -p- -oA target 10.129.2.28

Nmap scan report for 10.129.2.28

Host is up (0.053s latency).

Not shown: 4 closed ports

PORT STATE SERVICE

22/tcp open ssh

25/tcp open smtp

80/tcp open http

MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

# Nmap done at Tue Jun 16 12:15:03 2020 -- 1 IP address (1 host up) scanned in 10.22 seconds

<h3>Grepable Output</h3>

@htb[/htb]$ cat target.gnmap

# Nmap 7.80 scan initiated Tue Jun 16 12:14:53 2020 as: nmap -p- -oA target 10.129.2.28

Host: 10.129.2.28 () Status: Up

Host: 10.129.2.28 () Ports: 22/open/tcp//ssh///, 25/open/tcp//smtp///, 80/open/tcp//http/// Ignored State: closed (4)

# Nmap done at Tue Jun 16 12:14:53 2020 -- 1 IP address (1 host up) scanned in 10.22 seconds

<h3>XML Output</h3>

@htb[/htb]$ cat target.xml

<h3>Style sheets</h3>

With the XML output, we can easily create HTML reports that are easy to read, even for non-technical people. This is later very useful for documentation, as it presents our results in a detailed and clear way. To convert the stored results from XML format to HTML, we can use the tool xsltproc.

@htb[/htb]$ xsltproc target.xml -o target.html

If we now open the HTML file in our browser, we see a clear and structured presentation of our results.

<h3>Nmap Report</h3>

More information about the output formats can be found at: https://nmap.org/book/output.html

Perform a full TCP port scan on your target and create an HTML report. Submit the number of the highest port as the answer.

31337
