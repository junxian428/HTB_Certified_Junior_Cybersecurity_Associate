<h3>Introduction</h3>

The built-in command shell CMD.exe and PowerShell are two implementations included in all Windows hosts. These tools provide direct access to the operating system, automate routine tasks, and provide the user with granular control of any aspect of the computer and installed applications. This module will give us the knowledge, skills, and abilities to effectively administer Windows hosts via the command line.

From a penetration testing perspective, we will learn how to utilize built-in Windows tools and commands and third-party scripts and applications to help with reconnaissance, exploitation, and exfiltration of data from within a Windows environment as we move into more advanced modules within HTB Academy.

<h3>Command Prompt Vs. PowerShell</h3>

There are some key differences between Windows Command Prompt and PowerShell, which we will see throughout this module. One key difference is that you can run Command Prompt commands from a PowerShell console, but to run PowerShell commands from a Command Prompt, you would have to preface the command with powershell (i.e., powershell get-alias). The following table outlines some other key differences.

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>PowerShell</th>
      <th>Command Prompt</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Introduced in 2006</td>
      <td>Introduced in 1981</td>
    </tr>
    <tr>
      <td>Can run both batch commands and PowerShell cmdlets</td>
      <td>Can only run batch commands</td>
    </tr>
    <tr>
      <td>Supports the use of command aliases</td>
      <td>Does not support command aliases</td>
    </tr>
    <tr>
      <td>Cmdlet output can be passed to other cmdlets</td>
      <td>Command output cannot be passed to other commands</td>
    </tr>
    <tr>
      <td>All output is in the form of an object</td>
      <td>Output of commands is text</td>
    </tr>
    <tr>
      <td>Able to execute a sequence of cmdlets in a script</td>
      <td>A command must finish before the next command can run</td>
    </tr>
    <tr>
      <td>Has an Integrated Scripting Environment (ISE)</td>
      <td>Does not have an ISE</td>
    </tr>
    <tr>
      <td>Can access programming libraries because it is built on the .NET framework</td>
      <td>Cannot access these libraries</td>
    </tr>
    <tr>
      <td>Can be run on Linux systems</td>
      <td>Can only be run on Windows systems</td>
    </tr>
  </tbody>
</table>

As we can see, the Command Prompt is a much more static way of interacting with the operating system, while PowerShell is a powerful scripting language that can be used for a wide variety of tasks and to create simple and very complex scripts.

<h3>Scenario</h3>

We will use a scenario through this module to help keep the topics in scope and provide insight into how these tools and commands can aid our mission.

Consider this scenario:

We are a system administrator looking to broaden our horizons and dip our toes into pentesting. Before we approach our manager and Internal Red Team Lead to see about apprenticing, we must first practice and gain a fundamental understanding of Windows primary command line interfaces: PowerShell and Command Prompt. Soon they will have no choice but to accept us as a certified Command Line Ninja and grant us a seat at the table.

<h3>Connection Instructions</h3>

For this module, you will have access to several Windows hosts from which you can perform any actions needed to complete the lab exercises. Since we are working in a pure CLI-based module, this challenge will use SSH only to connect with the targets.

To connect to the target hosts as the user via SSH, utilize the following format:

ssh htb-student@<IP-Address>

Once connected, you will be asked to accept the host's certificate and provide the user's password to log in completely. After you authenticate, you are free to dive in.
