<h3>Working with the Windows Event Log</h3>

From a SOC Analyst or IT Administrator's perspective, monitoring, collecting, and categorizing events occurring on all machines across the network is an invaluable source of information for defenders proactively analyzing and protecting their network from suspicious activity. On the other hand, attackers can see this as an opportunity to gain insight into the target environment, disrupt the flow of information, and as a way to hide their tracks. As we will see in later modules, sometimes we can find juicy information such as credentials hiding in event logs as a target system that we compromise during a penetration test. Other times, enumerating event logs can help us understand the level of logging in the environment (are just the defaults in place, or has the target organization configured more granular logging?). In this section, we will discuss the following:

- What is the Windows Event Log?

- What information does it log, and where does it store this information?

- Interacting with the Event Log via the wevtutil command line utility

- Interacting with the Event Log using PowerShell cmdlets

<h3>What is the Windows Event Log?</h3>

A clear understanding of event logging is crucial to success in infosec. To kickstart our journey into gaining a thorough understanding of the Windows Event Log, there are a few key concepts that we need to define before diving in. These concepts will become the base upon which everything else will be built. The first one that needs to be explained is an event definition. Simply put, an event is any action or occurrence that can be identified and classified by a system's hardware or software. Events can be generated or triggered through a variety of different ways including some of the following:

User-Generated Events

Movement of a mouse, typing on a keyboard, other user-controlled peripherals, etc.

Application Generated Events

Application updates, crashes, memory usage/consumption, etc.

System Generated Events

System uptime, system updates, driver loading/unloading, user login, etc.

With so many events occurring at different intervals of time from various sources, how does a Windows system keep track of and categorize all of them? This is where our second key concept, known as event logging comes into play.

Event Logging as defined by Microsoft:

"...provides a standard, centralized way for applications (and the operating system) to record important software and hardware events."

This definition sums up the question quite nicely. However, let us attempt to break it down a bit. As we discussed beforehand, there are a lot of events that are being triggered or generated concurrently on a system. Each event will have its own source that provides the information and details behind the event in its own format. So how does it handle all of this information?

Windows attempts to resolve this issue by providing a standardized approach to recording, storing, and managing events and event information through a service known as the Windows Event Log. As its name suggests, the Event Log manages events and event logs, however, in addition to this functionality it also opens up a special API that allows applications to maintain and manage their own separate logs. In the Windows Fundamentals module, we discussed services in logs in greater detail in the Windows Services and Processes section, however, it is essential to understand that the Event Log is a required Windows service starting upon system initialization that runs in the context of another executable and not it's own.

Before we dig into querying the Event Log from cmd.exe and PowerShell we need to understand the possible types of events available to us, the elements of a log, and various other elements.

<h3>Event Log Categories and Types</h3>

The main four log categories include application, security, setup, and system. Another type of category also exists called forwarded events.

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Log Category</th>
      <th>Log Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>System Log</td>
      <td>The system log contains events related to the Windows system and its components. A system-level event could be a service failing at startup.</td>
    </tr>
    <tr>
      <td>Security Log</td>
      <td>Includes security-related events such as failed and successful logins, and file creation/deletion. Useful for detecting attacks.</td>
    </tr>
    <tr>
      <td>Application Log</td>
      <td>Stores events related to software/applications installed on the system (e.g., errors when an app like Slack fails to start).</td>
    </tr>
    <tr>
      <td>Setup Log</td>
      <td>Contains events generated during Windows installation. On domain controllers, includes Active Directory setup-related events.</td>
    </tr>
    <tr>
      <td>Forwarded Events</td>
      <td>Logs forwarded from other hosts within the same network.</td>
    </tr>
  </tbody>
</table>

<h3>Event Types</h3>

There are five types of events that can be logged on Windows systems:

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Type of Event</th>
      <th>Event Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Error</td>
      <td>Indicates a major problem, such as a service failing to load during startup.</td>
    </tr>
    <tr>
      <td>Warning</td>
      <td>A less significant issue that may indicate a future problem, such as low disk space. Applications can typically recover without losing functionality or data.</td>
    </tr>
    <tr>
      <td>Information</td>
      <td>Logged when an application, driver, or service performs successfully—for example, a network driver loading properly.</td>
    </tr>
    <tr>
      <td>Success Audit</td>
      <td>Recorded when an audited security access attempt is successful, such as a successful logon.</td>
    </tr>
    <tr>
      <td>Failure Audit</td>
      <td>Recorded when an audited security access attempt fails, such as an incorrect password during login. Many failures may indicate an attack like password spraying.</td>
    </tr>
  </tbody>
</table>

<h3>Event Severity Levels</h3>

Each log can have one of five severity levels associated with it, denoted by a number:

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>Severity Level</th>
      <th>Level #</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Verbose</td>
      <td>5</td>
      <td>Progress or success messages.</td>
    </tr>
    <tr>
      <td>Information</td>
      <td>4</td>
      <td>An event that occurred on the system but did not cause any issues.</td>
    </tr>
    <tr>
      <td>Warning</td>
      <td>3</td>
      <td>A potential problem that a sysadmin should investigate.</td>
    </tr>
    <tr>
      <td>Error</td>
      <td>2</td>
      <td>An issue related to the system or service that does not require immediate attention.</td>
    </tr>
    <tr>
      <td>Critical</td>
      <td>1</td>
      <td>A serious issue requiring urgent attention; may cause application or system instability if not resolved.</td>
    </tr>
  </tbody>
</table>

<h3>Elements of a Windows Event Log</h3>

The Windows Event Log provides information about hardware and software events on a Windows system. All event logs are stored in a standard format and include the following elements:

- Log name: As discussed above, the name of the event log where the events will be written. By default, events are logged for system, security, and applications.

- Event date/time: Date and time when the event occurred

- Task Category: The type of recorded event log

- Event ID: A unique identifier for sysadmins to identify a specific logged event

- Source: Where the log originated from, typically the name of a program or software application

- Level: Severity level of the event. This can be information, error, verbose, warning, critical

- User: Username of who logged onto the host when the event occurred

- Computer: Name of the computer where the event is logged

There are many Event IDs that an organization can monitor to detect various issues. In an Active Directory environment, this list includes key events that are recommended to be monitored for to look for signs of a compromise. This searchable database of Event IDs is worth perusing to understand the depth of logging possible on a Windows system.

<h3>Windows Event Log Technical Details</h3>

The Windows Event Log is handled by the EventLog services. On a Windows system, the service's display name is Windows Event Log, and it runs inside the service host process svchost.exe. It is set to start automatically at system boot by default. It is difficult to stop the EventLog service as it has multiple dependency services. If it is stopped, it will likely cause significant system instability. By default, Windows Event Logs are stored in C:\Windows\System32\winevt\logs with the file extension .evtx.

PS C:\htb> ls C:\Windows\System32\winevt\logs

We can interact with the Windows Event log using the Windows Event Viewer GUI application via the command line utility wevtutil, or using the Get-WinEvent PowerShell cmdlet. Both wevtutil and Get-WinEvent can be used to query Event Logs on both local and remote Windows systems via cmd.exe or PowerShell.

<h3>Interacting with the Windows Event Log - wevtutil</h3>

The wevtutil command line utility can be used to retrieve information about event logs. It can also be used to export, archive, and clear logs, among other commands.

<h3>Wevtutil without Parameters</h3>

C:\htb> wevtutil /?

Windows Events Command Line Utility.

We can use the el parameter to enumerate the names of all logs present on a Windows system.

<h3>Enumerating Log Sources</h3>

C:\htb> wevtutil el

With the gl parameter, we can display configuration information for a specific log, notably whether the log is enabled or not, the maximum size, permissions, and where the log is stored on the system.

<h3>Gathering Log Information</h3>

C:\htb> wevtutil gl "Windows PowerShell"

The gli parameter will give us specific status information about the log or log file, such as the creation time, last access and write times, file size, number of log records, and more.

C:\htb> wevtutil gli "Windows PowerShell"

There are many ways we can query for events. For example, let's say we want to display the last 5 most recent events from the Security log in text format. Local admin access is needed for this command.

<h3>Querying Events</h3>

C:\htb> wevtutil qe Security /c:5 /rd:true /f:text

We can also export events from a specific log for offline processing. Local admin is also needed to perform this export.

<h3>Exporting Events</h3>

C:\htb> wevtutil epl System C:\system_export.evtx

<h3>Interacting with the Windows Event Log - PowerShell</h3>

Similarly, we can interact with Windows Event Logs using the Get-WinEvent PowerShell cmdlet. Like with the wevtutil examples, some commands require local admin-level access.

To start, we can list all logs on the computer, giving us the number of records in each log.

<h3>PowerShell - Listing All Logs</h3>

PS C:\htb> Get-WinEvent -ListLog \*

We can also list information about a specific log. Here we can see the size of the Security log.

<h3>Security Log Details</h3>

PS C:\htb> Get-WinEvent -ListLog Security

We can query for the last X number of events, looking specifically for the last five events using the -MaxEvents parameter. Here we will list the last five events recorded in the Security log. By default, the newest logs are listed first. If we want to get older logs first, we can reverse the order to list the oldest ones first using the -Oldest parameter.

<h3>Querying Last Five Events</h3>

PS C:\htb> Get-WinEvent -LogName 'Security' -MaxEvents 5 | Select-Object -ExpandProperty Message

We can dig deeper and look at specific event IDs in specific logs. Let's say we only want to look at logon failures in the Security log, checking for Event ID 4625: An account failed to log on. From here, we could use the -ExpandProperty parameter to dig deeper into specific events, list logs from oldest to newest, etc.

<h3>Filtering for Logon Failures</h3>

PS C:\htb> Get-WinEvent -FilterHashTable @{LogName='Security';ID='4625 '}

ProviderName: Microsoft-Windows-Security-Auditing

We can also look at only events with a specific information level. Let's check all System logs for only critical events with information level 1. Here we see just one log entry where the system did not reboot cleanly.

PS C:\htb> Get-WinEvent -FilterHashTable @{LogName='System';Level='1'} | select-object -ExpandProperty Message

The system has rebooted without cleanly shutting down first. This error could be caused if the system stopped responding, crashed, or lost power unexpectedly.

Practice more with wevtutil and Get-WinEvent to become more comfortable with searching logs. Microsoft provides some examples for Get-WinEvent, while this site shows examples for wevtutil, and this site has some additional examples for using Get-WinEvent.

<h3>Moving On</h3>

This section introduced the Windows Event Log, a vast topic that we will dig much deeper into in later modules. Try out the various examples in this section and get comfortable using both tools to query for specific information. In later modules, we will see how we can sometimes find sensitive data, such as passwords, in Event Logs. Logging on Windows is very powerful when configured properly. Each system generates a massive amount of logs, and, as we saw with all the possible Event IDs, we can get quite granular with what exactly we choose to log. All of this data on its own would be very difficult to constantly query and is most effective when forwarded to a SIEM tool that can be used to set up alerts on specific Event IDs which may be indicative of an attack, such as Kerberoasting, Password Spraying, or other less common attacks. As penetration testers, we should be familiar with Windows Event Log, how we can use it to gain information about the environment, and sometimes even extract sensitive data. For blue teamers, in-depth knowledge of Windows Event Log and how to leverage it for effective alerting and monitoring is critical.

In the next section, we will cover working with networking operations from the command line on a Windows system.

Explore the targets provided and practice your Event Log PowerShell Kung-Fu. Type COMPLETE as the answer when finished.

COMPLETE
