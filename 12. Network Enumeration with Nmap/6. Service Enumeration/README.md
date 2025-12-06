<h3>Service Enumeration</h3>

For us, it is essential to determine the application and its version as accurately as possible. We can use this information to scan for known vulnerabilities and analyze the source code for that version if we find it. An exact version number allows us to search for a more precise exploit that fits the service and the operating system of our target.

<h3>Service Version Detection</h3>

It is recommended to perform a quick port scan first, which gives us a small overview of the available ports. This causes significantly less traffic, which is advantageous for us because otherwise we can be discovered and blocked by the security mechanisms. We can deal with these first and run a port scan in the background, which shows all open ports (-p-). We can use the version scan to scan the specific ports for services and their versions (-sV).

A full port scan takes quite a long time. To view the scan status, we can press the [Space Bar] during the scan, which will cause Nmap to show us the scan status.

@htb[/htb]$ sudo nmap 10.129.2.28 -p- -sV

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 19:44 CEST

[Space Bar]

Stats: 0:00:03 elapsed; 0 hosts completed (1 up), 1 undergoing SYN Stealth Scan

SYN Stealth Scan Timing: About 3.64% done; ETC: 19:45 (0:00:53 remaining)

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
      <td>-sV</td>
      <td>Performs service version detection on the specified ports.</td>
    </tr>
  </tbody>
</table>

Another option (--stats-every=5s) that we can use is defining how periods of time the status should be shown. Here we can specify the number of seconds (s) or minutes (m), after which we want to get the status.

@htb[/htb]$ sudo nmap 10.129.2.28 -p- -sV --stats-every=5s

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 19:46 CEST

Stats: 0:00:05 elapsed; 0 hosts completed (1 up), 1 undergoing SYN Stealth Scan

SYN Stealth Scan Timing: About 13.91% done; ETC: 19:49 (0:00:31 remaining)

Stats: 0:00:10 elapsed; 0 hosts completed (1 up), 1 undergoing SYN Stealth Scan

SYN Stealth Scan Timing: About 39.57% done; ETC: 19:48 (0:00:15 remaining)

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
      <td>-sV</td>
      <td>Performs service version detection on the specified ports.</td>
    </tr>
    <tr>
      <td>--stats-every=5s</td>
      <td>Shows progress updates every 5 seconds during the scan.</td>
    </tr>
  </tbody>
</table>
