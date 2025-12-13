<h3>Skills Assessment</h3>

Hunting For Stuxbot (Round 2)

Recently uncovered details shed light on the operational strategy of Stuxbot's newest iteration.

1. The newest iterations of Stuxbot are exploiting the C:\Users\Public directory as a conduit for deploying supplementary utilities.

2. The newest iterations of Stuxbot are utilizing registry run keys as a mechanism to ensure their sustained presence within the infected system.

3. The newest iterations of Stuxbot are utilizing PowerShell Remoting for lateral movement within the network and to gain access to domain controllers.

<h3>The Available Data</h3>

The cybersecurity strategy implemented is predicated on the utilization of the Elastic stack as a SIEM solution. Through the "Discover" functionality we can see logs from multiple sources. These sources include:

- Windows audit logs (categorized under the index pattern windows\*)

- System Monitor (Sysmon) logs (also falling under the index pattern windows\*, more about Sysmon here)

- PowerShell logs (indexed under windows\* as well, more about PowerShell logs here)

- Zeek logs, a network security monitoring tool (classified under the index pattern zeek\*)

<h3>The Tasks</h3>

Navigate to the bottom of this section and click on Click here to spawn the target system!

Now, navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Discover". Then, click on the calendar icon, specify "last 15 years", and click on "Apply".

Hunt 1: Create a KQL query to hunt for "Lateral Tool Transfer" to C:\Users\Public. Enter the content of the user.name field in the document that is related to a transferred tool that starts with "r" as your answer.

Hunt 2: Create a KQL query to hunt for "Boot or Logon Autostart Execution: Registry Run Keys / Startup Folder". Enter the content of the registry.value field in the document that is related to the first registry-based persistence action as your answer.

Hunt 3: Create a KQL query to hunt for "PowerShell Remoting for Lateral Movement". Enter the content of the winlog.user.name field in the document that is related to PowerShell remoting-based lateral movement towards DC1.

Enter your answer for Hunt 1.

Hunt 1: Create a KQL query to hunt for "Lateral Tool Transfer" to C:\\Users\\Public. Enter the content of the user.name field in the document that is related to a transferred tool that starts with "r" as your answer.

First, we need to understand what lateral tool transfer is. Essentially, it is not a tool but a technique adversaries use to transfer tools or files from one system to another within a compromised environment, internally within the network.

Adversaries may copy files between compromised systems to facilitate lateral movement using protocols such as the File Sharing Protocol (SMB/Windows Admin Shares) or authenticated connections via RDP.

Now we understand what lateral tool transfer means, let’s move on to the first hunt. we needs to create a KQL to detect this technique.

We need to analyze this from an event-based perspective. Based on the available data sources and indexes, we will use Sysmon.

Looking at the question from a different angle, if the attacker copies files from one path to another or between hosts — and the same applies to pasting — this behavior will generate an event called ‘File Creation’ with Event ID 11. Therefore, we will begin our query with this event ID.

Additionally, the question provides a useful hint: the attacker used the path C:\Users\Public during the transfer activities. This means we should carefully examine this path.

The final query:

event.code: 11 AND message:"C:\Users\Public\*"
We use the message field to search for this path based on our hint. This query will return all logs where the event ID is 11 and the message field contains C:\Users\Public\[Anything].

Press enter or click to view image in full size

event.code: 11 AND message:"C:\Users\Public\*"

svc-sql1
