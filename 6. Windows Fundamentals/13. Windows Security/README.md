<h3>Windows Security</h3>

Security is a critical topic in Windows operating systems. Windows systems have many moving parts that present a vast attack surface. Due to the many built-in applications, features, and layers of settings, Windows systems can be easily misconfigured, thus opening them up to attack even if they are fully patched.

It has many built-in features that can be abused and has suffered from a wide variety of critical vulnerabilities, resulting in widely used and very effective remote and local exploits.

Microsoft has improved upon Windows security over the years. As our world's interconnectedness continues to expand and attackers become more sophisticated, Microsoft has continued to add new features that can be used by systems administrators to harden systems and actively block and detect attempts at intrusion and misuse.

Windows follows certain security principles to control access and authentication within the system. These principles apply to various entities, such as users, networked computers, threads, and processes, which can be authorized for specific actions. The security model is designed to minimize the risk of unauthorized access, making it more challenging for attackers or malicious software to exploit the system.

<h3>Security Identifier (SID)</h3>

Each of the security principals on the system has a unique security identifier (SID). The system automatically generates SIDs. This means that even if, for example, we have two identical users on the system, Windows can distinguish the two and their rights based on their SIDs. SIDs are string values with different lengths, which are stored in the security database. These SIDs are added to the user's access token to identify all actions that the user is authorized to take.

A SID consists of the Identifier Authority and the Relative ID (RID). In an Active Directory (AD) domain environment, the SID also includes the domain SID.

PS C:\htb> whoami /user

## USER INFORMATION

User Name SID

=================== =============================================

ws01\bob S-1-5-21-674899381-4069889467-2080702030-1002

The SID is broken down into this pattern.

(SID)-(revision level)-(identifier-authority)-(subauthority1)-(subauthority2)-(etc)

Let's break down the SID piece by piece.

<table border="1" cellspacing="0" cellpadding="5">
  <thead>
    <tr>
      <th>Number</th>
      <th>Meaning</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>S</td>
      <td>SID</td>
      <td>Identifies the string as a SID.</td>
    </tr>
    <tr>
      <td>1</td>
      <td>Revision Level</td>
      <td>To date, this has never changed and has always been 1.</td>
    </tr>
    <tr>
      <td>5</td>
      <td>Identifier-authority</td>
      <td>A 48-bit string that identifies the authority (the computer or network) that created the SID.</td>
    </tr>
    <tr>
      <td>21</td>
      <td>Subauthority1</td>
      <td>This is a variable number that identifies the user's relation or group described by the SID to the authority that created it. It tells us in what order this authority created the user's account.</td>
    </tr>
    <tr>
      <td>674899381-4069889467-2080702030</td>
      <td>Subauthority2</td>
      <td>Tells us which computer (or domain) created the number.</td>
    </tr>
    <tr>
      <td>1002</td>
      <td>Subauthority3</td>
      <td>The RID that distinguishes one account from another. Tells us whether this user is a normal user, a guest, an administrator, or part of some other group.</td>
    </tr>
  </tbody>
</table>

<h3>Security Accounts Manager (SAM) and Access Control Entries (ACE)</h3>

SAM grants rights to a network to execute specific processes.

The access rights themselves are managed by Access Control Entries (ACE) in Access Control Lists (ACL). The ACLs contain ACEs that define which users, groups, or processes have access to a file or to execute a process, for example.

The permissions to access a securable object are given by the security descriptor, classified into two types of ACLs: the Discretionary Access Control List (DACL) or System Access Control List (SACL). Every thread and process started or initiated by a user goes through an authorization process. An integral part of this process is access tokens, validated by the Local Security Authority (LSA). In addition to the SID, these access tokens contain other security-relevant information. Understanding these functionalities is an essential part of learning how to use and work around these security mechanisms during the privilege escalation phase.

<h3>User Account Control (UAC)</h3>

User Account Control (UAC) is a security feature in Windows to prevent malware from running or manipulating processes that could damage the computer or its contents. There is the Admin Approval Mode in UAC, which is designed to prevent unwanted software from being installed without the administrator's knowledge or to prevent system-wide changes from being made. Surely you have already seen the consent prompt if you have installed a specific software, and your system has asked for confirmation if you want to have it installed. Since the installation requires administrator rights, a window pops up, asking you if you want to confirm the installation. With a standard user who has no rights for the installation, execution will be denied, or you will be asked for the administrator password. This consent prompt interrupts the execution of scripts or binaries that malware or attackers try to execute until the user enters the password or confirms execution. To understand how UAC works, we need to know how it is structured and how it works, and what triggers the consent prompt. The following diagram, adapted from the source here, illustrates how UAC works.
