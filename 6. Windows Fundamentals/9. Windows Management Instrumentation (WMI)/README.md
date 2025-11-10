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
