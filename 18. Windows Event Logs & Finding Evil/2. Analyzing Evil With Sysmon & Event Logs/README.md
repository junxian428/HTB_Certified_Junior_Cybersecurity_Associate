<h3>Analyzing Evil With Sysmon & Event Logs</h3>

In our pursuit of robust cybersecurity, it is crucial to understand how to identify and analyze malicious events effectively. Building upon our previous exploration of benign events, we will now delve into the realm of malicious activities and discover techniques for detection.

<h3>Sysmon Basics</h3>

When investigating malicious events, several event IDs serve as common indicators of compromise. For instance, Event ID 4624 provides insights into new logon events, enabling us to monitor and detect suspicious user access and logon patterns. Similarly, Event ID 4688 furnishes information about newly created processes, aiding the identification of unusual or malicious process launches. To enhance our event log coverage, we can extend the capabilities by incorporating Sysmon, which offers additional event logging capabilities.

System Monitor (Sysmon) is a Windows system service and device driver that remains resident across system reboots to monitor and log system activity to the Windows event log. Sysmon provides detailed information about process creation, network connections, changes to file creation time, and more.

Sysmon's primary components include:

- A Windows service for monitoring system activity.

- A device driver that assists in capturing the system activity data.

- An event log to display captured activity data.

Sysmon's unique capability lies in its ability to log information that typically doesn't appear in the Security Event logs, and this makes it a powerful tool for deep system monitoring and cybersecurity forensic analysis.

Sysmon categorizes different types of system activity using event IDs, where each ID corresponds to a specific type of event. For example, Event ID 1 corresponds to "Process Creation" events, and Event ID 3 refers to "Network Connection" events. The full list of Sysmon event IDs can be found here.

For more granular control over what events get logged, Sysmon uses an XML-based configuration file. The configuration file allows you to include or exclude certain types of events based on different attributes like process names, IP addresses, etc. We can refer to popular examples of useful Sysmon configuration files:

- For a comprehensive configuration, we can visit: https://github.com/SwiftOnSecurity/sysmon-config. <-- We will use this one in this section!

- Another option is: https://github.com/olafhartong/sysmon-modular, which provides a modular approach.

To get started, you can install Sysmon by downloading it from the official Microsoft documentation (https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon). Once downloaded, open an administrator command prompt and execute the following command to install Sysmon.

C:\Tools\Sysmon> sysmon.exe -i -accepteula -h md5,sha256,imphash -l -n

<img width="706" height="257" alt="image" src="https://github.com/user-attachments/assets/e452d6f8-f743-4458-ae81-b6d9840b790f" />

To utilize a custom Sysmon configuration, execute the following after installing Sysmon.

C:\Tools\Sysmon> sysmon.exe -c filename.xml

Note: It should be noted that Sysmon for Linux also exists.

<h3>Detection Example 1: Detecting DLL Hijacking</h3>

In our specific use case, we aim to detect a DLL hijack. The Sysmon event log IDs relevant to DLL hijacks can be found in the Sysmon documentation (https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon). To detect a DLL hijack, we need to focus on Event Type 7, which corresponds to module load events. To achieve this, we need to modify the sysmonconfig-export.xml Sysmon configuration file we downloaded from https://github.com/SwiftOnSecurity/sysmon-config.

By examining the modified configuration, we can observe that the "include" comment signifies events that should be included.

<img width="712" height="77" alt="image" src="https://github.com/user-attachments/assets/f975ddb9-446d-453e-91f9-e998785f238c" />


In the case of detecting DLL hijacks, we change the "include" to "exclude" to ensure that nothing is excluded, allowing us to capture the necessary data.

<img width="714" height="77" alt="image" src="https://github.com/user-attachments/assets/31088445-7060-4db6-b69c-94b884c9a5b9" />

To utilize the updated Sysmon configuration, execute the following.

C:\Tools\Sysmon> sysmon.exe -c sysmonconfig-export.xml

<img width="714" height="217" alt="image" src="https://github.com/user-attachments/assets/b02c2a97-837d-45d0-b247-796f2290adcc" />

With the modified Sysmon configuration, we can start observing image load events. To view these events, navigate to the Event Viewer and access "Applications and Services" -> "Microsoft" -> "Windows" -> "Sysmon." A quick check will reveal the presence of the targeted event ID.

<img width="719" height="331" alt="image" src="https://github.com/user-attachments/assets/eef313b4-9754-4655-b7ef-5dee87cf7b68" />

Let's now see how a Sysmon event ID 7 looks like.

<img width="704" height="196" alt="image" src="https://github.com/user-attachments/assets/7c9a4ffd-8b1e-4585-9fc1-89c7c6ca949b" />

The event log contains the DLL's signing status (in this case, it is Microsoft-signed), the process or image responsible for loading the DLL, and the specific DLL that was loaded. In our example, we observe that "MMC.exe" loaded "psapi.dll", which is also Microsoft-signed. Both files are located in the System32 directory.

Now, let's proceed with building a detection mechanism. To gain more insights into DLL hijacks, conducting research is paramount. We stumble upon an informative blog post that provides an exhaustive list of various DLL hijack techniques. For the purpose of our detection, we will focus on a specific hijack involving the vulnerable executable calc.exe and a list of DLLs that can be hijacked.

<img width="709" height="395" alt="image" src="https://github.com/user-attachments/assets/d1d90418-f40e-4009-9b99-1c2f00420669" />

Let's attempt the hijack using "calc.exe" and "WININET.dll" as an example. To simplify the process, we can utilize Stephen Fewer's "hello world" reflective DLL. It should be noted that DLL hijacking does not require reflective DLLs.

By following the required steps, which involve renaming reflective_dll.x64.dll to WININET.dll, moving calc.exe from C:\Windows\System32 along with WININET.dll to a writable directory (such as the Desktop folder), and executing calc.exe, we achieve success. Instead of the Calculator application, a MessageBox is displayed.

<img width="706" height="418" alt="image" src="https://github.com/user-attachments/assets/a5b1f4cf-d0a0-458a-8a4b-b20892fd9f36" />

Next, we analyze the impact of the hijack. First, we filter the event logs to focus on Event ID 7, which represents module load events, by clicking "Filter Current Log...".

<img width="670" height="714" alt="image" src="https://github.com/user-attachments/assets/f203d11a-5fdd-4ef9-97b6-e9e76a3bcfce" />
