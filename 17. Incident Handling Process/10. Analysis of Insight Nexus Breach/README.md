<h3>Analysis of Insight Nexus Breach</h3>

<h3>Incident Scenario</h3>

The victim in this incident is Insight Nexus, a mid-sized market research and data analytics firm headquartered in Singapore. They provide competitive intelligence and consumer insights for global clients, including Fortune 500 companies in IT and finance. Their infrastructure includes many applications, servers, and hosts, but we'll focus on the important ones, such as an internet-facing application stack for clients, a ManageEngine server for IT administration, and a PHP-based customer reporting portal. Because of the nature of their work, they became an attractive target for adversaries interested in client data theft.

Let's take a look at the incident to understand some challenges that incident handlers face. This incident shows an example of the patterns repeatedly observed in real-world incidents. The victim in this scenario is Insight Nexus, a global market research firm that handles sensitive competitive data for high-profile clients in the IT sector. The firm becomes a target of two distinct threat groups operating simultaneously within its environment. The first threat actor gained entry when system administrators forgot to change the default admin/admin password on an internet-facing application, i.e., ManageEngine ADManager Plus, after a product update. By leveraging this, the attackers logged in successfully, performed reconnaissance, mapped users and machines, and eventually created new privileged Active Directory accounts. Using one of the newly created accounts, the adversaries pivoted further into the environment, identifying an external RDP service exposed by misconfiguration. Exploiting that entry point, they escalated their control and eventually used Group Policy Objects (GPOs) to deploy spyware using an MSI package across multiple endpoints.

<img width="1224" height="566" alt="image" src="https://github.com/user-attachments/assets/cde6a830-d06b-4003-8342-da2bc4442294" />

For days, these activities went unnoticed. The incident was first discovered one day when an analyst from the SOC team investigated an alert on TheHive (Security Incident Response Platform) related to the creation of a suspicious file named checkme.txt in the root of a web server. Upon investigation, they discovered that it was deliberately placed there as a signature — "SilentJackal was here". This unusual artifact triggered a deeper investigation. What made the situation more complex was that the SOC team then realized two different threat actor groups were active in the same environment. While the first group was still exploring and deploying persistence mechanisms, a second actor had already compromised a vulnerable PHP application earlier, exfiltrated sensitive market research data, and significantly reduced their activity after achieving their objective, leaving only occasional connections to an external IP.

<h3>Threat Actors</h3>

Crimson Fox (Primary threat actor): A group with known links to the IT industry supply chain targeting, suspected to be state-backed. They specialize in credential theft and long-term persistence for data exfiltration. It is a capable and persistent group known for several previous successful attacks related to supply-chain and corporate intelligence.

Silent Jackal (Secondary actor): A loosely organized criminal group focused on opportunistic website defacements and proof-of-concept intrusions, not necessarily financially motivated but disruptive. The members of this group are low-skill web intruders.

<h3>Environment & Important Assets</h3>

<h3>Public Internet</h3>

External Web Application (manage.insightnexus.com): The web application ManageEngine ADManager Plus provides the capability for Active Directory management to the organization's system administrators. HTTPS (port 443) was accessible from the Internet (management portal).

Client Reports Portal (portal.insightnexus.com): A PHP-based client reporting portal (file upload enabled for reports).

<h3>Internal environment structure</h3>

Domain Controller: DC01.insight.local

File Server: FS01.insight.local (file share: \fs01\projects)

Database Server: DB01.insight.local contains sensitive databases.

Workstations: This includes the developer fleet (ranging from DEV-001 to DEV-120), including some workstations with permissions to allow incoming RDP connections. A Windows machine with external RDP exposure was discovered during reconnaissance: DEV-021 (misconfigured).

<h3>Security</h3>

Perimeter firewall with default logging (no integration with Threat Intelligence).

Basic IDS with a high false-positive rate.

Wazuh agents on most Windows hosts (partial coverage).

Centralized SIEM (Wazuh) ingesting Windows Sysmon, Windows Security, web server logs, and firewall logs (limited retention).

TheHive is used for case management, with Cortex available for enrichment.

<h3>Incident Analysis</h3>

A system administrator noticed unusual outbound connections from the ManageEngine server to an IP address in Eastern Europe while working on the server for scheduled maintenance. He called the SOC team and collaborated with them to investigate the alerts to find anything suspicious. One of the SOC analysts started investigating the alerts and found an alert mentioning a suspicious checkme.txt file on the same server.

Detection Gap: There were too many alerts about new files being created on the servers, and this alert was not escalated due to alert fatigue. They need to reduce some false positives and add more filters.

The SOC team started investigating this incident and found many reconnaissance attempts on the external web applications.

<img width="1216" height="586" alt="image" src="https://github.com/user-attachments/assets/b8d5616d-b808-407c-a2ec-7e29e1582300" />

Upon further investigation, the responders found that on 2025-10-01 03:12:02, the threat actor Crimson Fox obtained initial access via ManageEngine. Initially, they performed targeted login attempts against manage.insightnexus.com. They found that the default credentials (i.e., admin/admin) worked, which means either the system administrators forgot to change the default credentials after an update or they left the web application accessible to everyone on the public internet. The result was unfortunate for the organization, and the threat actors performed an interactive web login via HTTPS. The logon audit report shows this successful login activity.

Organizational oversight: Despite vendor advisories, the default credentials were never changed. Multi-factor authentication was not enforced, and there was no WAF inspection on the endpoint. The logon events of the web application were not sent to a centralized SIEM.

<img width="1228" height="599" alt="image" src="https://github.com/user-attachments/assets/89d6c417-bac0-4755-82c4-40b34a047647" />

There was a Java web vulnerability related to the ManageEngine ADManager Plus product where unauthenticated remote code execution was possible. The actor utilized this and established an outbound C2 over HTTPS to 103.112.60.117 (an attacker-controlled cloud host), impersonating update traffic. The following Sysmon Event ID 3 (Network Connection detected) was logged:

Event 3, Sysmon

Network Connection detected:

UtcTime: 2025-10-01 03:18:32.557

Image: C:\ManageEngine\jre\bin\java.exe

DestinationIp: 103.112.60.117

DestinationPort: 443

On 2025-10-02 04:02:11, attackers enumerated domain users and computers via queries from the ManageEngine console. Using the ManageEngine foothold, they also created a new Domain Administrator account. During Active Directory enumeration, they found that a Windows 10 machine (DEV-021) had a publicly exposed RDP port. This desktop machine is used occasionally by developers to perform development and release tasks by taking RDP directly on its public IP while working from home. The attacker took RDP directly into this machine using the newly created Domain Administrator account.

<img width="1226" height="565" alt="image" src="https://github.com/user-attachments/assets/3595f9b9-2c53-46bb-9c5e-dc55ef305d90" />

For this activity, the following event log was created in the Windows Event Logs with Event ID 4624.

An account was successfully logged on.

Subject:

    Security ID: SYSTEM

    Account Name: DEV-021$

    Account Domain: INSIGHT

    Time: 2025-10-04T02:03:12Z

Logon Information:

    Logon Type: 10

Network Information:

    Workstation Name: DEV-021

    Source Network Address: 103.112.60.117

New Logon:

    SubjectUserName: insight\svc_deployer

    SourceNetworkAddress: 103.112.60.117

After a successful logon, the attackers conducted some domain reconnaissance. They found some interesting file shares on the file server, which they attempted to access multiple times. On the file server, they located client project folders that contained draft reports, survey data, and market forecasts.

<img width="1227" height="572" alt="image" src="https://github.com/user-attachments/assets/24213055-9c90-49c9-8a7d-b88bf769798b" />

On the file server, multiple event logs were created, such as 5140(S, F): A network share object was accessed. However, there were no rules created for generating alerts specifically for these public IP RDP events.

These kinds of event logs can be detected using the following Sigma rule, for example:

After exploring and observing for a week, they started compressing and exfiltrating selected data. The attackers packaged stolen client materials into a file named diagnostics_data.zip, a filename chosen to resemble routine telemetry. The archive was then uploaded to the attacker-controlled host over HTTPS. Because the filename resembled legitimate diagnostics data and the upload used standard HTTPS, it did not immediately raise alarms. This tactic increases the attackers chance of exfiltrating data before defenders escalate.

<img width="1220" height="594" alt="image" src="https://github.com/user-attachments/assets/f9c9025e-a733-48fd-b5fc-e6ed6c1c60a5" />

Then, on 2025-10-04 02:10:45, from DEV-021, they executed some PowerShell scripts that used domain administrator credentials to create a Group Policy Object (GPO) that pushes an MSI package (java-update.msi) across the domain. This MSI package created a scheduled task to run a process that performs spying and data exfiltration on the machines.

These events were also captured in the event logs, such as the creation of a new .msi file as Sysmon Event ID 11.

Sysmon Event 11: TargetFilename: C:\Windows\Temp\java-update.msi

Also, Sysmon Event ID 1 captures the command line for the execution of the .msi file in the background.

Sysmon Event 1: Image: C:\Windows\System32\msiexec.exe CommandLine: "msiexec /i C:\Windows\Temp\java-update.msi /quiet"

This malware, with spying and data exfiltration capabilities, is deployed on all domain machines using GPO.

<img width="1217" height="569" alt="image" src="https://github.com/user-attachments/assets/bcf1a6ba-4f21-4c27-80ee-dd2840053f2d" />

Around the same time, another threat actor, Silent Jackal, also performed some activities on a separate PHP-based reporting portal. This server had an unpatched file upload vulnerability, which was exploited by the threat actor to gain access to this server. Silent Jackal uploaded a file into the root directory of the web server. Their activities appeared limited to leaving the checkme.txt marker file. This created noise in the environment and provided defenders with the first clue of compromise.

<img width="1226" height="576" alt="image" src="https://github.com/user-attachments/assets/6de01e63-d6e6-4876-a1c1-3362161687c0" />

However, the threat actor did not proceed beyond their initial access. This was likely a low-skill intrusion meant to signal presence rather than cause immediate damage.

Organizational oversight: No web application firewall monitoring and no regular vulnerability assessments of internet-facing portals.

Crimson Fox reduced high-activity operations, with only occasional low-rate beacons to 103.112.60.117 to check for new instructions. Silent Jackal similarly reduced activity.

<h3>Immediate Incident Response Actions</h3>

The first tangible discovery was checkme.txt by a SOC analyst. That file alone would normally be low priority, but the SOC analyst performing correlation saw that the same time window had ManageEngine events with unusual outbound traffic and multiple login events from an unfamiliar foreign IP.

The correlation of the following was done as follows:

1. ManageEngine successful admin logins from foreign IPs.

2. Sysmon process creation of msiexec installing an MSI across many hosts.

3. LDAP enumeration logs and GPO changes.

4. File server file compression and upload logs.

5. Outbound HTTPS to an unusual IP address.

After the correlation, the SOC analyst immediately escalated the incident to the incident response team and opened a case in TheHive. The following actions and findings completed the investigation and response:

1. Case creation and triage

- The SOC created a TheHive case titled “Insight Nexus — ManageEngine Compromise,” linked all related alerts (ManageEngine admin logins, Sysmon msiexec events, LDAP enumeration, file server uploads, and the portal checkme.txt event), and assigned roles: Triage Analyst, Forensics Lead, Containment Lead, and Communications Lead.

- Priority was set to Critical due to confirmed data exfiltration.

2. Containment — network controls

- Blocked outbound traffic to 103.112.60.117 at the perimeter firewall and on host-based firewalls. Added temporary egress block rules for the attacker IPs.

- Added an IDS signature to alert on connections to 103.112.60.117 and similar endpoints.

3. Containment — credential & account actions

- Disabled the ManageEngine admin account and rotated all high-privilege credentials exposed in logs (service accounts, deployer accounts, and any account showing suspicious activity).

- Restricted the ManageEngine web console to be accessed only internally.

- Implemented forced password changes and immediate revocation of active sessions where possible.

4. Host isolation

- Isolated manage.insightnexus.com, DEV-021, and any machines that showed evidence of MSI installation from the production network for forensic collection (network access blocked, but preserved in a manner to allow analysis).

- Suspended scheduled tasks and disabled GPO-initiated deployments until confirmation of remediation.

5. Collect forensic artifacts

On isolated hosts, collected volatile memory, process lists, registry hives, and disk images. Exported ManageEngine audit logs and the web server access logs with full timestamps.

Preserved copies of the MSI file (java-update.msi), the compressed exfiltrated package (diagnostics_data.zip), and any web shell files found in management app directories.

<h3>Mapping to MITRE ATT&CK</h3>

Reconnaissance: Scanning public assets; MITRE T1595 (Active Scanning).

Weaponization / Initial Access: ManageEngine default credentials (T1078.004 - Valid Accounts), PHP upload exploitation (T1190 - Exploit Public-Facing Application).

Delivery / Exploitation: Web shell uploads, console command execution; (T1505 - Server Software Component).

Installation / Persistence: Scheduled tasks, services, GPO-deployed MSI (T1547, T1543, T1069).

Command & Control: HTTPS to attacker-controlled IP (T1071.001 - Web Protocols).

Action on Objective / Exfiltration: Compress and upload project data (T1560/T1041).

<h3>Lessons Learned</h3>

The following lessons were learned:

1. Default credentials on Internet-facing applications remain one of the simplest but most damaging oversights.

2. Multiple concurrent threat actors can be present in a single environment, with different motivations — one opportunistic, one highly targeted. This complicates response because defenders may underestimate the severity if they only see the “loud” intruder.

3. Failure to correlate alerts across teams delays containment, giving advanced actors more time to achieve objectives.

4. Post-incident monitoring must include scanning for persistence mechanisms, since deleting an attacker’s marker file does not neutralize the root cause.

Questions

Answer the question(s) below to complete this Section and earn cubes!

- Download the Wazuh exported logs file (i.e., wazuh_export.zip), and identify all events that indicate potential credential compromise. Check the event ID 4688 and verify the full path of the parent process name that executed a credential dumping tool. Answer format is C:\\Pr........

C:\\Program Files\\Mozilla Firefox\\firefox.exe

- 0 Identify events that show persistence mechanisms. Type the value of imagePath for a persistence mechanism that took place on the host DB01.
  C:\\Windows\\PSEXESVC.exe

- 1 Identify exfiltration activity — file(s) uploaded or outbound traffic. What is the external IP address to which the file diagnostics_data.zip was uploaded?
  93.184.216.34

- 0 Which user tried to connect to the file share \\fs01\projects?

svc_admin

Reference:

https://github.com/SigmaHQ/sigma/blob/master/rules/windows/builtin/security/account_management/win_security_successful_external_remote_rdp_login.yml
