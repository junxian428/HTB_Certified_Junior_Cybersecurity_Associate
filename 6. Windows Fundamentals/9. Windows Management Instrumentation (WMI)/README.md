<h3>Windows Management Instrumentation (WMI)</h3>

WMI is a subsystem of PowerShell that provides system administrators with powerful tools for system monitoring. The goal of WMI is to consolidate device and application management across corporate networks. WMI is a core part of the Windows operating system and has come pre-installed since Windows 2000. It is made up of the following components:

<table border="1" cellspacing="0" cellpadding="5">
  <thead>
    <tr>
      <th>Component Name</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>WMI service</td>
      <td>The Windows Management Instrumentation process, which runs automatically at boot and acts as an intermediary between WMI providers, the WMI repository, and managing applications.</td>
    </tr>
    <tr>
      <td>Managed objects</td>
      <td>Any logical or physical components that can be managed by WMI.</td>
    </tr>
    <tr>
      <td>WMI providers</td>
      <td>Objects that monitor events/data related to a specific object.</td>
    </tr>
    <tr>
      <td>Classes</td>
      <td>These are used by the WMI providers to pass data to the WMI service.</td>
    </tr>
    <tr>
      <td>Methods</td>
      <td>These are attached to classes and allow actions to be performed. For example, methods can be used to start/stop processes on remote machines.</td>
    </tr>
    <tr>
      <td>WMI repository</td>
      <td>A database that stores all static data related to WMI.</td>
    </tr>
    <tr>
      <td>CIM Object Manager</td>
      <td>The system that requests data from WMI providers and returns it to the application requesting it.</td>
    </tr>
    <tr>
      <td>WMI API</td>
      <td>Enables applications to access the WMI infrastructure.</td>
    </tr>
    <tr>
      <td>WMI Consumer</td>
      <td>Sends queries to objects via the CIM Object Manager.</td>
    </tr>
  </tbody>
</table>

Some of the uses for WMI are:

Status information for local/remote systems

Configuring security settings on remote machines/applications

Setting and changing user and group permissions

Setting/modifying system properties

Code execution

Scheduling processes

Setting up logging

These tasks can all be performed using a combination of PowerShell and the WMI Command-Line Interface (WMIC). WMI can be run via the Windows command prompt by typing WMIC to open an interactive shell or by running a command directly such as wmic computersystem get name to get the hostname. We can view a listing of WMIC commands and aliases by typing WMIC /?.

<img width="812" height="522" alt="image" src="https://github.com/user-attachments/assets/bd23fca4-27ef-4e88-9a09-be557120335d" />

The following command example lists information about the operating system.

C:\htb> wmic os list brief

BuildNumber Organization RegisteredUser SerialNumber SystemDirectory Version

19041 Owner 00123-00123-00123-AAOEM C:\Windows\system32 10.0.19041

WMIC uses aliases and associated verbs, adverbs, and switches. The above command example uses LIST to show data and the adverb BRIEF to provide just the core set of properties. An in-depth listing of verbs, switches, and adverbs is available here. WMI can be used with PowerShell by using the Get-WmiObject module. This module is used to get instances of WMI classes or information about available classes. This module can be used against local or remote machines.

Here we can get information about the operating system.

PS C:\htb> Get-WmiObject -Class Win32_OperatingSystem | select SystemDirectory,BuildNumber,SerialNumber,Version | ft

SystemDirectory BuildNumber SerialNumber Version

---

C:\Windows\system32 19041 00123-00123-00123-AAOEM 10.0.19041

We can also use the Invoke-WmiMethod module, which is used to call the methods of WMI objects. A simple example is renaming a file. We can see that the command completed properly because the ReturnValue is set to 0.

PS C:\htb> Invoke-WmiMethod -Path "CIM_DataFile.Name='C:\users\public\spns.csv'" -Name Rename -ArgumentList "C:\Users\Public\kerberoasted_users.csv"

\_\_GENUS : 2

**CLASS : **PARAMETERS

\_\_SUPERCLASS :

**DYNASTY : **PARAMETERS

\_\_RELPATH :

\_\_PROPERTY_COUNT : 1

\_\_DERIVATION : {}

\_\_SERVER :

\_\_NAMESPACE :

\_\_PATH :

ReturnValue : 0

PSComputerName :

This section provides a brief overview of WMI, WMIC, and combining WMIC and PowerShell. WMI has a wide variety of uses for both blue team and red team operators. Later sections of this course will show some ways that WMI can be leveraged offensively for both enumeration and lateral movement.

Use WMI to find the serial number of the system.

00329-10280-00000-AA938
