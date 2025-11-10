<h3>Desktop Experience vs. Server Core</h3>

Windows Server Core was first released with Windows Server 2008 as a minimalistic Server environment only containing key Server functionality. As a result, Server Core has lower management requirements, a smaller attack surface, and uses less disk space and memory than its Desktop Experience (GUI) counterpart. In Server Core, all configuration and maintenance tasks are performed via the command-line, PowerShell, or remote management with MMC or Remote Server Administration Tools (RSAT).

While Server Core aims to have a smaller footprint by lacking a GUI, some graphical programs are still supported, such as Registry Editor, Notepad, System Information, Windows Installer, Task Manager, and PowerShell. It also supports some Sysinternals suite tools such as Active Directory Explorer, Process Explorer, Process Monitor, and TCPView.

As of Windows Server 2019, Server Core or Desktop Experience must be selected at installation, and neither can be rolled back (i.e., converting Server Core to Desktop Experience). Once installed, the initial setup for Server Core can be done via Sconfig, which is a text-based interface (actually a VBScript executed by WScript). Sconfig is used for performing a variety of common commands such as configuring networking, checking for/installing Windows updates, account management, configuring remote management, activating Windows, and more.

Certain server applications cannot run on Server Core, including Microsoft Server Virtual Machine Manager 2019 (SCVMM), System Center Data Protection Manager 2019, SharePoint Server 2019, Project Server 2019.

In summary, Server Core is lighter weight and less resource-intensive but has a steeper learning curve and can be more difficult to manage. It also has some limitations, such as performing management tasks using certain GUI programs.

In any environment, the determination between using Desktop Experience or Server Core for a server installation should be made by both the business need and intended use of the server and the skill level of the administrators responsible for maintaining it. The following table shows some of the applications available on Server Core vs. Desktop Experience. This is a list of common applications and not an exhaustive list.

<table border="1" cellspacing="0" cellpadding="5">
  <thead>
    <tr>
      <th>Application</th>
      <th>Server Core</th>
      <th>Desktop Experience</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Command prompt</td>
      <td>Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Windows PowerShell/ Microsoft .NET</td>
      <td>Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Regedit</td>
      <td>Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Diskmgmt.msc</td>
      <td>Not Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Server Manager</td>
      <td>Not Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Mmc.exe</td>
      <td>Not Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Eventvwr</td>
      <td>Not Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Services.msc</td>
      <td>Not Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Control Panel</td>
      <td>Not Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Windows Explorer</td>
      <td>Not Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Taskmgr</td>
      <td>Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Internet Explorer or Edge</td>
      <td>Not Available</td>
      <td>Available</td>
    </tr>
    <tr>
      <td>Remote Desktop Services</td>
      <td>Available</td>
      <td>Available</td>
    </tr>
  </tbody>
</table>

Reference:

https://learn.microsoft.com/en-us/windows-server/administration/server-core/what-is-server-core
