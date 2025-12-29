Firewall and IDS/IPS Evasion - Medium Lab

After we conducted the first test and submitted our results to our client, the administrators made some changes and improvements to the IDS/IPS and firewall. We could hear that the administrators were not satisfied with their previous configurations during the meeting, and they could see that the network traffic could be filtered more strictly.

Note: To successfully solve the exercise, we must use the UDP protocol on the VPN.

After the configurations are transferred to the system, our client wants to know if it is possible to find out our target's DNS server version. Submit the DNS server version of the target as the answer.

HTB{GoTtgUnyze9Psw4vGjcuMpHRp}


┌──(kali㉿kali)-[~/Desktop]

└─$ nmap -p 53 -sU -sV X.X.X.X

Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-29 08:51 EST

Stats: 0:00:33 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan

Service scan Timing: About 100.00% done; ETC: 08:51 (0:00:00 remaining)

Nmap scan report for 10.129.2.48

Host is up (0.19s latency).

PORT   STATE SERVICE VERSION

53/udp open  domain  (unknown banner: HTB{GoTtgUnyze9Psw4vGjcuMpHRp})

1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
