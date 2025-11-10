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
