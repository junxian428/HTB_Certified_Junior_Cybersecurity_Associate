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
