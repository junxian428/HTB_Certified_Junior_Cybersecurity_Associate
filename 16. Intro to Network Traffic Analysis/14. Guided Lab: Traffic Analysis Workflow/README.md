<h3>Guided Lab: Traffic Analysis Workflow</h3>

One of our fellow admins noticed a weird connection from Bob's host IP = 172.16.10.90 when analyzing the baseline captures we have been gathering. He asked us to check it out and see what we think is happening.

Attempt to utilize the concepts from the Analysis Process sections to complete an analysis of the guided-analysis.zip provided in the optional resources and live traffic from the academy network. Once done, a guided answer key is included with the PCAP in the zip to check your work.

<h3>Tasks:</h3>

Task #1

Connect to the live host for capture.

Connection Instructions: Access to the lab environment to complete the following tasks will require the use of XfreeRDP to provide GUI access to the virtual machine so we can utilize Wireshark from within the environment.

We will be connecting to the Academy lab like normal utilizing your own VM with a HTB Academy VPN key or the Pwnbox built into the module section. You can start the FreeRDP client on the Pwnbox by typing the following into your shell once the target spawns:

xfreerdp /v:<target IP> /u:htb-student /p:HTB_@cademy_stdnt!

<h3>Analysis</h3>

Follow this workflow template and examine the suspicious traffic. The goal is to determine what is happening with the host in question.

1. what is the issue?

a brief summary of the issue.

2. define our scope and the goal (what are we looking for? which time period?)

Scope: what are we looking for, where?

when the issue started:

supporting info: Files, data sources, anything helpful.

3. define our target(s) (net / host(s) / protocol)

Target hosts: Network or address of hosts.

4. capture network traffic / read from previously captured PCAP.

Perform actions as needed to analyze the traffic for signs of intrusion.

5. identification of required network traffic components (filtering)

once we have our traffic, filter out any traffic not necessary for this investigation to include; any traffic that matches our common baseline, and keep anything relevant to the scope of the investigation.

6. An understanding of captured network traffic

Once we have filtered out the noise, it's time to dig for our targets. Start broad and close the circle around our scope.

7. note taking / mind mapping of the found results.

Annotating everything we do, see, or find throughout the investigation is crucial. Ensure you are taking ample notes, including:

Timeframes we captured traffic during.

Suspicious hosts/ports within the network.

Conversations containing anything suspicious. ( to include timestamps, and packet numbers, files, etc.)

8. summary of the analysis (what did we find?)

Finally, summarize what has been found, explaining the relevant details so that superiors can decide to quarantine the affected hosts or perform a more critical incident response mission.

Our analysis will affect decisions made, so it is essential to be as clear and concise as possible.

Complete an attempt on your own first to examine and follow the workflow, then look below for a guided walkthrough of the lab.

This task was best completed using the PCAP file provided for the lesson. Following the steps in the workflow, we filled in the information and performed our analysis.

1. what is the issue?

Suspicious traffic coming from within the network.

2. define our scope and the goal (what are we looking for? which time period?)

target: traffic is originating from 10.129.43.4

when: within the last 48 hours. Capture traffic to determine if it is still happening.

supporting info: file: NTA-guided.pcap

3. define our target(s) (net / host(s) / protocol)

scope: 10.129.43.4 and anyone with a connection to it. Unknown protocol over port 4444.

4. capture network traffic

plug into a link with access to the 10.129.43.0/24 network to capture live traffic attempting to see if anything is happening.

We have been given a PCAP with historical data that contains some of the suspect traffic. We will examine this to analyze the issue.

5. identification of required network traffic components (filtering)
   
First, we will filter out anything that does not have a connection to 10.129.43.4, since this is our primary suspicious target for the moment.

<img width="860" height="649" alt="image" src="https://github.com/user-attachments/assets/decb1018-521b-4186-8567-e6d3ee81cc6e" />

After checking out the conversations plugin pictured above, we can see there are only three conversations captured in this pcap file, and they all pertain to our suspicious host. Next, we will look at the protocol hierarchy plugin to see what our traffic is.

<img width="856" height="479" alt="image" src="https://github.com/user-attachments/assets/519a06c0-3674-4b73-85ea-ad59c499d637" />

We can see here that this PCAP is mostly TCP traffic, with a bit of UDP traffic. Since there is less UDP than TCP traffic, let us look into that first.

Once we have filtered out the noise, it's time to dig for anything unusual. We are going to filter out everything but `UDP traffic first.

<img width="865" height="524" alt="image" src="https://github.com/user-attachments/assets/eb11c54c-2abf-4c8b-8488-34a4811bff7c" />


<img width="934" height="709" alt="image" src="https://github.com/user-attachments/assets/54bda5a6-d595-41cd-a2ee-1fe2a45a953a" />

<img width="922" height="687" alt="image" src="https://github.com/user-attachments/assets/6bcc713f-a0db-42f0-84d2-0ecac1598b66" />



Now that we followed the TCP stream, we should have alarm bells ringing for us. We can see this entire conversation between the two hosts in plain text, and it appears that someone was performing several different actions on the host.

Looking at the image above, it appears that someone is performing basic recon of the host. They are issuing commands like whoami, ipconfig, dir. It would appear they are trying to get a lay of the land and figure out what user they landed as on the host. highlighted in orange in the image above.

What is truly alarming is that we can now see someone made the account hacker and assigned it to the administrators group on this host. Either this is a joke by a poor administrator. Or someone has infiltrated the corporate infrastructure.
note taking / mind mapping of the found results.

Annotating everything we do, see, or find throughout the investigation is crucial. If needed, make a picture to depict the flow of actions.

Using this example workflow, we have already documented our actions and have included screenshots of everything we included for analysis. These will help influence the decision made for a response.
summary of the analysis (what did we find?)

Based on our analysis, we determined that a malicious actor has infiltrated at least one host on the network. Host 10.129.43.29 shows signs of someone executing commands to include user creation and assigning local administrator permissions via the net commands. It would look like the actor was using Bob's host to perform said actions. Since Bob was previously under investigation for the exfil of corporate secrets and disguising it as web traffic, I think it is safe to say the issue has spread further. The screenshots included with this document show the flow of traffic and commands utilized.
It is our opinion that a complete Incident Response IR procedure be enacted to ensure the threat is stopped from spreading further. We can dedicate resources to clearing the malicious presence and cleaning the affected hosts.

<img width="1858" height="1022" alt="image" src="https://github.com/user-attachments/assets/8284f0b6-f6f6-4d47-bd9e-e585fbf02166" />

<h3>Summary</h3>

After analyzing the actions taken, the IR team determined that The actor got lazy and decided to utilize a Netcat shell and directly interact with Bob's host while gathering more information. While doing so, he used RDP from Bob's host to another windows desktop in the environment to try and establish another foothold. Luckily, the IR team was able to capture some PCAP of the RDP traffic. Bob's host was quarantined, and incident response was initiated to determine what was taken and what other potential hosts were compromised. Great job spotting the intrusion.

 What was the name of the new user created on mrb3n's host?
 
hacker

+ 2  How many total packets were there in the Guided-analysis PCAP?
  
44

+ 1  What was the suspicious port that was being used?
  
4444
