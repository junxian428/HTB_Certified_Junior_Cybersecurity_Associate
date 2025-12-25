<h3>Skills Assessment</h3>

In the skills assessment, you are in the role of a junior incident responder and need to perform some tasks.

Let's navigate to the bottom of this section and click on "Click here to spawn the target system!". Then, let's open TheHive webpage on "Target IP:9000" on port 9000 using the provided credentials to view the alerts.

<h3>Triage the alerts</h3>

TheHive is loaded with alerts related to the Insights Nexus breach. You are requested to triage them, starting with:

- Task 1: Create a new case in TheHive. Find all the alerts that are specific to the Insights Nexus breach scenario, and link the alerts in the case. This exercise introduces you to work in TheHive alerts and cases.

- Task 2: Perform triage, enrichment, and correlation in TheHive. In the notes of an alert, you can add useful information for enrichment.

- Task 3: One of the alerts related to Insights Nexus in TheHive contains some information in the notes. The netstat command output shows some connectivity to external IP addresses. You can validate this finding.

<img width="995" height="470" alt="image" src="https://github.com/user-attachments/assets/feb58a42-c36f-45f8-b718-1ebdb7d03246" />

This output was captured after the host machine rejoined the domain following recovery. However, it is still connecting to an IP address. The analyst added this in the comments of the alert.

There are some further questions asked at bottom of this section.

<h3>Mapping to the Cyber Kill Chain</h3>

A user opens an attachment, which executes a downloader that writes an .exe file to %AppData%, creates a Run registry key, and later loads VaultCli.dll via a suspicious tool, exfiltrating credentials to an external IP. Your task is to map each step of the attack to the kill chain phase.

Task 1: Map the file download, registry, and exfiltration activity to MITRE ATT&CK.

Task 2: Check the alert related to Mimikatz in TheHive and identify the MITRE Technique ID.

Investigate the collected logs

Task 1: Additionally, you are provided with some event log files (i.e., logs-wazuh.zip). One of the tasks is to decode some PowerShell commands and extract IOCs from them.

Task 2: Identify the user who executed the suspicious PowerShell command.
