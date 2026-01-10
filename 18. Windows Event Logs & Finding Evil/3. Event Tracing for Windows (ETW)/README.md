<h3>Event Tracing for Windows (ETW)</h3>

In the realm of effective threat detection and incident response, we often find ourselves relying on the limited log data at our disposal. However, this approach falls short of fully harnessing the immense wealth of information that can be derived from the powerful resource known as Event Tracing for Windows (ETW). Unfortunately, this oversight can be attributed to a lack of awareness and appreciation for the comprehensive and intricate insights that ETW can offer.

<h3>What is ETW?</h3>

According to Microsoft, Event Tracing For Windows (ETW) is a general-purpose, high-speed tracing facility provided by the operating system. Using a buffering and logging mechanism implemented in the kernel, ETW provides a tracing mechanism for events raised by both user-mode applications and kernel-mode device drivers.

ETW, functioning as a high-performance event tracing mechanism deeply embedded within the Windows operating system, presents an unparalleled opportunity to bolster our defense capabilities. Its architecture facilitates the dynamic generation, collection, and analysis of various events occurring within the system, resulting in the creation of intricate, real-time logs that encompass a wide spectrum of activities.

By effectively leveraging ETW, we can tap into an expansive array of telemetry sources that surpass the limitations imposed by traditional log data. ETW captures a diverse set of events, spanning system calls, process creation and termination, network activity, file and registry modifications, and numerous other dimensions. These events collectively weave a detailed tapestry of system activity, furnishing invaluable context for the identification of anomalous behavior, discovery of potential security incidents, and facilitation of forensic investigations.

ETW's versatility and extensibility are further accentuated by its seamless integration with Event Providers. These specialized components generate specific types of events and can be seamlessly incorporated into applications, operating system components, or third-party software. Consequently, this integration ensures a broad coverage of potential event sources. Furthermore, ETW's extensibility enables the creation of custom providers tailored to address specific organizational requirements, thereby fostering a targeted and focused approach to logging and monitoring.

Notably, ETW's lightweight nature and minimal performance impact render it an optimal telemetry solution for real-time monitoring and continuous security assessment. By selectively enabling and configuring relevant event providers, we can finely adjust the scope of data collection to align with our specific security objectives, striking a harmonious balance between the richness of information and system performance considerations.

Moreover, the existence of robust tooling and utilities, including Microsoft's Message Analyzer and PowerShell's Get-WinEvent cmdlet, greatly simplifies the retrieval, parsing, and analysis of ETW logs. These tools offer advanced filtering capabilities, event correlation mechanisms, and real-time monitoring features, empowering members of the blue team to extract actionable insights from the vast pool of information captured by ETW.

<h3>ETW Architecture & Components</h3>

The underlying architecture and the key components of Event Tracing for Windows (ETW) are illustrated in the following diagram from Microsoft.

<img width="825" height="683" alt="image" src="https://github.com/user-attachments/assets/891c1f7a-8620-48d5-bee9-c3bacc951c00" />

Controllers: The Controllers component, as its name implies, assumes control over all aspects related to ETW operations. It encompasses functionalities such as initiating and terminating trace sessions, as well as enabling or disabling providers within a particular trace. Trace sessions can establish subscriptions to one or multiple providers, thereby granting the providers the ability to commence logging operations. An example of a widely used controller is the built-in utility "logman.exe," which facilitates the management of ETW activities.

At the core of ETW's architecture is the publish-subscribe model. This model involves two primary components:

- Providers: Providers play a pivotal role in generating events and writing them to the designated ETW sessions. Applications have the ability to register ETW providers, enabling them to generate and transmit numerous events. There are four distinct types of providers utilized within ETW.

- MOF Providers: These providers are based on Managed Object Format (MOF) and are capable of generating events according to predefined MOF schemas. They offer a flexible approach to event generation and are widely used in various scenarios.

- WPP Providers: Standing for "Windows Software Trace Preprocessor," WPP providers leverage specialized macros and annotations within the application's source code to generate events. This type of provider is often utilized for low-level kernel-mode tracing and debugging purposes.

- Manifest-based Providers: Manifest-based providers represent a more contemporary form of providers within ETW. They rely on XML manifest files that define the structure and characteristics of events. This approach offers enhanced flexibility and ease of management, allowing for dynamic event generation and customization.

- TraceLogging Providers: TraceLogging providers offer a simplified and efficient approach to event generation. They leverage the TraceLogging API, introduced in recent Windows versions, which streamlines the process of event generation with minimal code overhead.

- Consumers: Consumers subscribe to specific events of interest and receive those events for further processing or analysis. By default, the events are typically directed to an .ETL (Event Trace Log) file for handling. However, an alternative consumer scenario involves leveraging the capabilities of the Windows API to process and consume the events.

- Channels: To facilitate efficient event collection and consumption, ETW relies on event channels. Event channels act as logical containers for organizing and filtering events based on their characteristics and importance. ETW supports multiple channels, each with its own defined purpose and audience. Event consumers can selectively subscribe to specific channels to receive relevant events for their respective use cases.

- ETL files: ETW provides specialized support for writing events to disk through the use of event trace log files, commonly referred to as "ETL files." These files serve as durable storage for events, enabling offline analysis, long-term archiving, and forensic investigations. ETW allows for seamless rotation and management of ETL files to ensure efficient storage utilization.

Notes:

- ETW supports event providers in both kernel mode and user mode.

- Some event providers generate a significant volume of events, which can potentially overwhelm the system resources if they are constantly active. As a result, to prevent unnecessary resource consumption, these providers are typically disabled by default and are only enabled when a tracing session specifically requests their activation.

- In addition to its inherent capabilities, ETW can be extended through custom event providers.

- Only ETW provider events that have a Channel property applied to them can be consumed by the event log

<h3>Interacting With ETW</h3>

Logman is a pre-installed utility for managing Event Tracing for Windows (ETW) and Event Tracing Sessions. This tool is invaluable for creating, initiating, halting, and investigating tracing sessions. This is particularly useful when determining which sessions are set for data collection or when initiating your own data collection.

Employing the -ets parameter will allow for a direct investigation of the event tracing sessions, providing insights into system-wide tracing sessions. As an example, the Sysmon Event Tracing Sessions can be found towards the end of the displayed information.

C:\Tools> logman.exe query -ets

When we examine an Event Tracing Session directly, we uncover specific session details including the Name, Max Log Size, Log Location, and the subscribed providers. This information is invaluable for incident responders. Discovering a session that records providers relevant to your interests may provide crucial logs for an investigation.

Please note that the “-ets” parameter is vital to the command. Without it, Logman will not identify the Event Tracing Session.

For each provider subscribed to the session, we can acquire critical data:

- Name / Provider GUID: This is the exclusive identifier for the provider.

- Level: This describes the event level, indicating if it's filtering for warning, informational, critical, or all events.

- Keywords Any: Keywords create a filter based on the kind of event generated by the provider.

C:\Tools> logman.exe query "EventLog-System" -ets

By using the logman query providers command, we can generate a list of all available providers on the system, including their respective GUIDs.

C:\Tools> logman.exe query providers

Windows 10 includes more than 1,000 built-in providers. Moreover, Third-Party Software often incorporates its own ETW providers, especially those operating in Kernel mode.

Due to the high number of providers, it's usually advantageous to filter them using findstr. For instance, you will see multiple results for "Winlogon" in the given example.

C:\Tools> logman.exe query providers | findstr "Winlogon"

By specifying a provider with Logman, we gain a deeper understanding of the provider's function. This will inform us about the Keywords we can filter on, the available event levels, and which processes are currently utilizing the provider.

C:\Tools> logman.exe query providers Microsoft-Windows-Winlogon

The Microsoft-Windows-Winlogon/Diagnostic and Microsoft-Windows-Winlogon/Operational keywords reference the event logs generated from this provider.

GUI-based alternatives also exist. These are:

1. Using the graphical interface of the Performance Monitor tool, we can visualize various running trace sessions. A detailed overview of a specific trace can be accessed simply by double-clicking on it. This reveals all pertinent data related to the trace, from the engaged providers and their activated features to the nature of the trace itself. Additionally, these sessions can be modified to suit our needs by incorporating or eliminating providers. Lastly, we can devise new sessions by opting for the "User Defined" category.

<img width="820" height="448" alt="image" src="https://github.com/user-attachments/assets/5228fa17-679c-4328-b3ac-a0e080e8ae87" />

<img width="801" height="525" alt="image" src="https://github.com/user-attachments/assets/3fbc6c49-90b5-4258-bd6f-4f646dd95a76" />

<img width="800" height="561" alt="image" src="https://github.com/user-attachments/assets/34bd4768-c2be-44e0-9dc9-7400bd5969ce" />

2. ETW Provider metadata can also be viewed through the EtwExplorer project.

<img width="798" height="465" alt="image" src="https://github.com/user-attachments/assets/21d4c7a3-0a47-4b64-8180-1178a2055899" />

<h3>Useful Providers</h3>

- Microsoft-Windows-Kernel-Process: This ETW provider is instrumental in monitoring process-related activity within the Windows kernel. It can aid in detecting unusual process behaviors such as process injection, process hollowing, and other tactics commonly used by malware and advanced persistent threats (APTs).

- Microsoft-Windows-Kernel-File: As the name suggests, this provider focuses on file-related operations. It can be employed for detection scenarios involving unauthorized file access, changes to critical system files, or suspicious file operations indicative of exfiltration or ransomware activity.

- Microsoft-Windows-Kernel-Network: This ETW provider offers visibility into network-related activity at the kernel level. It's especially useful in detecting network-based attacks such as data exfiltration, unauthorized network connections, and potential signs of command and control (C2) communication.

- Microsoft-Windows-SMBClient/SMBServer: These providers monitor Server Message Block (SMB) client and server activity, providing insights into file sharing and network communication. They can be used to detect unusual SMB traffic patterns, potentially indicating lateral movement or data exfiltration.

- Microsoft-Windows-DotNETRuntime: This provider focuses on .NET runtime events, making it ideal for identifying anomalies in .NET application execution, potential exploitation of .NET vulnerabilities, or malicious .NET assembly loading.

- OpenSSH: Monitoring the OpenSSH ETW provider can provide important insights into Secure Shell (SSH) connection attempts, successful and failed authentications, and potential brute force attacks.

- Microsoft-Windows-VPN-Client: This provider enables tracking of Virtual Private Network (VPN) client events. It can be useful for identifying unauthorized or suspicious VPN connections.

- Microsoft-Windows-PowerShell: This ETW provider tracks PowerShell execution and command activity, making it invaluable for detecting suspicious PowerShell usage, script block logging, and potential misuse or exploitation.

- Microsoft-Windows-Kernel-Registry: This provider monitors registry operations, making it useful for detection scenarios related to changes in registry keys, often associated with persistence mechanisms, malware installation, or system configuration changes.

- Microsoft-Windows-CodeIntegrity: This provider monitors code and driver integrity checks, which can be key in identifying attempts to load unsigned or malicious drivers or code.

- Microsoft-Antimalware-Service: This ETW provider can be employed to detect potential issues with the antimalware service, including disabled services, configuration changes, or potential evasion techniques employed by malware.

- WinRM: Monitoring the Windows Remote Management (WinRM) provider can reveal unauthorized or suspicious remote management activity, often indicative of lateral movement or remote command execution.

- Microsoft-Windows-TerminalServices-LocalSessionManager: This provider tracks local Terminal Services sessions, making it useful for detecting unauthorized or suspicious remote desktop activity.

- Microsoft-Windows-Security-Mitigations: This provider keeps tabs on the effectiveness and operations of security mitigations in place. It's essential for identifying potential bypass attempts of these security controls.

- Microsoft-Windows-DNS-Client: This ETW provider gives visibility into DNS client activity, which is crucial for detecting DNS-based attacks, including DNS tunneling or unusual DNS requests that may indicate C2 communication.

- Microsoft-Antimalware-Protection: This provider monitors the operations of antimalware protection mechanisms. It can be used to detect any issues with these mechanisms, such as disabled protection features, configuration changes, or signs of evasion techniques employed by malicious actors.

<h3>Restricted Providers</h3>

In the realm of Windows operating system security, certain ETW providers are considered "restricted." These providers offer valuable telemetry but are only accessible to processes that carry the requisite permissions. This exclusivity is designed to ensure that sensitive system data remains shielded from potential threats.

One of these high-value, restricted providers is Microsoft-Windows-Threat-Intelligence. This provider offers crucial insights into potential security threats and is often leveraged in Digital Forensics and Incident Response (DFIR) operations. However, to access this provider, processes must be privileged with a specific right, known as Protected Process Light (PPL).

According to Elastic:To be able to run as a PPL, an anti-malware vendor must apply to Microsoft, prove their identity, sign binding legal documents, implement an Early Launch Anti-Malware (ELAM) driver, run it through a test suite, and submit it to Microsoft for a special Authenticode signature. It is not a trivial process. Once this process is complete, the vendor can use this ELAM driver to have Windows protect their anti-malware service by running it as a PPL. With that said, workarounds to access the Microsoft-Windows-Threat-Intelligence provider exist.

In the context of Microsoft-Windows-Threat-Intelligence, the benefits of this privileged access are manifold. This provider can record highly granular data about potential threats, enabling security professionals to detect and analyze sophisticated attacks that may have eluded other defenses. Its telemetry can serve as vital evidence in forensic investigations, revealing details about the origin of a threat, the systems and data it interacted with, and the alterations it made. Moreover, by monitoring this provider in real-time, security teams can potentially identify ongoing threats and intervene to mitigate damage.

In the next section, we will utilize ETW to investigate attacks that may evade detection if we rely solely on Sysmon for monitoring and analysis, due to its inherent limitations in capturing certain events.

<h3>References</h3>

https://nasbench.medium.com/a-primer-on-event-tracing-for-windows-etw-997725c082bf

https://bmcder.com/blog/a-begginers-all-inclusive-guide-to-etw
