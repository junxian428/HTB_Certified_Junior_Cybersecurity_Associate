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

Subsequently, we search for instances of "calc.exe", by clicking "Find...", to identify the DLL load associated with our hijack.

<img width="706" height="280" alt="image" src="https://github.com/user-attachments/assets/88286e46-ac83-428f-8ce4-782762353946" />

The output from Sysmon provides valuable insights. Now, we can observe several indicators of compromise (IOCs) to create effective detection rules. Before moving forward though, let's compare this to an authenticate load of "wininet.dll" by "calc.exe".

<img width="707" height="331" alt="image" src="https://github.com/user-attachments/assets/735ad88e-bf85-4c64-b6a0-9f1d2e2fac5f" />

Let's explore these IOCs:

1. "calc.exe", originally located in System32, should not be found in a writable directory. Therefore, a copy of "calc.exe" in a writable directory serves as an IOC, as it should always reside in System32 or potentially Syswow64.

2. "WININET.dll", originally located in System32, should not be loaded outside of System32 by calc.exe. If instances of "WININET.dll" loading occur outside of System32 with "calc.exe" as the parent process, it indicates a DLL hijack within calc.exe. While caution is necessary when alerting on all instances of "WININET.dll" loading outside of System32 (as some applications may package specific DLL versions for stability), in the case of "calc.exe", we can confidently assert a hijack due to the DLL's unchanging name, which attackers cannot modify to evade detection.

3. The original "WININET.dll" is Microsoft-signed, while our injected DLL remains unsigned.

These three powerful IOCs provide an effective means of detecting a DLL hijack involving calc.exe. It's important to note that while Sysmon and event logs offer valuable telemetry for hunting and creating alert rules, they are not the sole sources of information.

<h3>Detection Example 2: Detecting Unmanaged PowerShell/C-Sharp Injection</h3>

Before delving into detection techniques, let's gain a brief understanding of C# and its runtime environment. C# is considered a "managed" language, meaning it requires a backend runtime to execute its code. The Common Language Runtime (CLR) serves as this runtime environment. Managed code does not directly run as assembly; instead, it is compiled into a bytecode format that the runtime processes and executes. Consequently, a managed process relies on the CLR to execute C# code.

As defenders, we can leverage this knowledge to detect unusual C# injections or executions within our environment. To accomplish this, we can utilize a useful utility called Process Hacker.

<img width="711" height="650" alt="image" src="https://github.com/user-attachments/assets/be6eee6d-9b1a-4afa-ab9d-bc8ba05272aa" />

By using Process Hacker, we can observe a range of processes within our environment. Sorting the processes by name, we can identify interesting color-coded distinctions. Notably, "powershell.exe", a managed process, is highlighted in green compared to other processes. Hovering over powershell.exe reveals the label "Process is managed (.NET)," confirming its managed status.

<img width="721" height="274" alt="image" src="https://github.com/user-attachments/assets/e71ec749-c65e-41e7-b82e-2ae7e1904c2e" />

Examining the module loads for powershell.exe, by right-clicking on powershell.exe, clicking "Properties", and navigating to "Modules", we can find relevant information.

<img width="721" height="50" alt="image" src="https://github.com/user-attachments/assets/1a778956-5b8a-4067-a4e2-7616a693f884" />

The presence of "Microsoft .NET Runtime...", clr.dll, and clrjit.dll should attract our attention. These 2 DLLs are used when C# code is ran as part of the runtime to execute the bytecode. If we observe these DLLs loaded in processes that typically do not require them, it suggests a potential execute-assembly or unmanaged PowerShell injection attack.

To showcase unmanaged PowerShell injection, we can inject an unmanaged PowerShell-like DLL into a random process, such as spoolsv.exe. We can do that by utilizing the PSInject project in the following manner.

 powershell -ep bypass
 Import-Module .\Invoke-PSInject.ps1
 Invoke-PSInject -ProcId [Process ID of spoolsv.exe] -PoshCode "V3JpdGUtSG9zdCAiSGVsbG8sIEd1cnU5OSEi"

 <img width="725" height="313" alt="image" src="https://github.com/user-attachments/assets/c737f175-5fbf-4ffa-8df0-020514f36333" />

After the injection, we observe that "spoolsv.exe" transitions from an unmanaged to a managed state.

<img width="718" height="396" alt="image" src="https://github.com/user-attachments/assets/3f7438aa-a644-4869-9967-6c108ffb37a4" />

Additionally, by referring to both the related "Modules" tab of Process Hacker and Sysmon Event ID 7, we can examine the DLL load information to validate the presence of the aforementioned DLLs.

<img width="729" height="452" alt="image" src="https://github.com/user-attachments/assets/e461588b-c9e0-4be7-b01b-ab095aa5760a" />

<img width="724" height="348" alt="image" src="https://github.com/user-attachments/assets/ae268050-a518-480f-ae75-0bd1ef46889d" />

<h3>Detection Example 3: Detecting Credential Dumping</h3>

Another critical aspect of cybersecurity is detecting credential dumping activities. One widely used tool for credential dumping is Mimikatz, offering various methods for extracting Windows credentials. One specific command, "sekurlsa::logonpasswords", enables the dumping of password hashes or plaintext passwords by accessing the Local Security Authority Subsystem Service (LSASS). LSASS is responsible for managing user credentials and is a primary target for credential-dumping tools like Mimikatz.

The attack can be executed as follows.

<img width="667" height="706" alt="image" src="https://github.com/user-attachments/assets/2241159c-e4f1-4ef6-88e9-a71bd0962314" />

As we can see, the output of the "sekurlsa::logonpasswords" command provides powerful insights into compromised credentials.

To detect this activity, we can rely on a different Sysmon event. Instead of focusing on DLL loads, we shift our attention to process access events. By checking Sysmon event ID 10, which represents "ProcessAccess" events, we can identify any suspicious attempts to access LSASS.

<img width="730" height="484" alt="image" src="https://github.com/user-attachments/assets/1f7305eb-2f2f-4fef-9677-98b6061bbb6e" />

For instance, if we observe a random file ("AgentEXE" in this case) from a random folder ("Downloads" in this case) attempting to access LSASS, it indicates unusual behavior. Additionally, the SourceUser being different from the TargetUser (e.g., "waldo" as the SourceUser and "SYSTEM" as the TargetUser) further emphasizes the abnormality. It's also worth noting that as part of the mimikatz-based credential dumping process, the user must request SeDebugPrivileges. As the name suggests, it's primarily used for debugging. This can be another Indicator of Compromise (IOC).

Please note that some legitimate processes may access LSASS, such as authentication-related processes or security tools like AV or EDR.

<h3>Practical Exercises</h3>

Navigate to the bottom of this section and click on Click here to spawn the target system!

Then, RDP to [Target IP] using the provided credentials and answer the questions below. Do not forget to configure Sysmon accordingly, before you replicate the attacks.

@htb[/htb]$ xfreerdp /u:Administrator /p:'HTB_@cad3my_lab_W1n10_r00t!@0' /v:[Target IP] /dynamic-resolution
