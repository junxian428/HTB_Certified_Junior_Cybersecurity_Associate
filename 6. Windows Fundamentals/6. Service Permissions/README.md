<h3>Service Permissions</h3>

Recall that services allow for the management of long-running processes and are a critical part of Windows operating systems. Sysadmins often overlook them as potential threat vectors that can be used to load malicious DLLs, execute applications without access to an admin account, escalate privileges and even maintain persistence. These threat vectors in Windows services often come into existence through service permissions misconfigurations put in place by 3rd party software and easy to make mistakes by admins during install processes.

The first step in realizing the importance of service permissions is simply understanding that they exist and being mindful of them. On server operating systems, critical network services like DHCP and Active Directory Domain Services commonly get installed using the account assigned to the admin performing the install. Part of the install process includes assigning a specific service to run using the credentials and privileges of a designated user, which by default is set within the currently logged-on user context.

For example, if we are logged on as Bob on a server during DHCP install, then that service will be configured to run as Bob unless specified otherwise. What bad things could come of this? Well, what if Bob leaves the organization or gets fired? The typical business practice would be to disable Bob’s account as part of his exit process. In this case, what would happen to DHCP and other services running using Bob’s account? Those services would fail to start. DHCP or Dynamic Host Configuration Protocol is responsible for leasing IP addresses to computers on the network. If this service stops on a Windows DHCP server, clients requesting an IP address will not receive one. This means a service misconfiguration could lead to downtime and loss of productivity. It is highly recommended to create an individual user account to run critical network services. These are referred to as service accounts.

We should also be mindful of service permissions and the permissions of the directories they execute from because it is possible to replace the path to an executable with a malicious DLL or executable file. Let's examine the permissions of services running on Windows 10 to get an even better understanding of this.

<h3>Examining Services using services.msc</h3>

As discussed in the processes and services section, we can use services.msc to view and manage just about every detail regarding all services. Let's take a closer look at the service associated with Windows Update (wuauserv).

<img width="809" height="496" alt="image" src="https://github.com/user-attachments/assets/88775b98-44dd-4a40-876a-bc697d3c5657" />

Make a note of the different properties available for viewing and configuration. Knowing the service name is especially useful when using command-line tools to examine and manage services. Path to the executable is the full path to the program and command to execute when the service starts. If the NTFS permissions of the destination directory are configured with weak permissions, an attacker could replace the original executable with one created for malicious purposes. We discuss NTFS permissions more in the NTFS vs. Share permissions section of this module.

<img width="809" height="612" alt="image" src="https://github.com/user-attachments/assets/67136f48-8ea7-4637-b650-4386e155afea" />

Most services run with LocalSystem privileges by default which is the highest level of access allowed on an individual Windows OS. Not all applications need Local System account-level permissions, so it is beneficial to perform research on a case-by-case basis when considering installing new applications in a Windows environment. It is a good practice to identify applications that can run with the least privileges possible to align with the principle of least privilege.

Here is one breakdown of the principle of least privilege

Notable built-in service accounts in Windows:

LocalService

NetworkService

LocalSystem

Note: We can also create new accounts and use them for the sole purpose of running a service.

<img width="811" height="536" alt="image" src="https://github.com/user-attachments/assets/79c7b6c2-e3c4-4724-bbc2-4bf85243c98d" />

The recovery tab allows steps to be configured should a service fail. Notice how this service can be set to run a program after the first failure. This is yet another vector that an attacker could use to run malicious programs by utilizing a legitimate service.

<h3>Examining services using sc</h3>

Sc can also be used to configure and manage services. Let's experiment with a few commands.

C:\Users\htb-student>sc qc wuauserv

[SC] QueryServiceConfig SUCCESS

SERVICE_NAME: wuauserv

TYPE : 20 WIN32_SHARE_PROCESS

START_TYPE : 3 DEMAND_START

ERROR_CONTROL : 1 NORMAL

BINARY_PATH_NAME : C:\WINDOWS\system32\svchost.exe -k netsvcs -p

LOAD_ORDER_GROUP :

TAG : 0

DISPLAY_NAME : Windows Update

DEPENDENCIES : rpcss

SERVICE_START_NAME : LocalSystem

The sc qc command is used to query the service. This is where knowing the names of services can come in handy. If we wanted to query a service on a device over the network, we could specify the hostname or IP address immediately after sc.

C:\Users\htb-student>sc //hostname or ip of box query ServiceName

We can also use sc to start and stop services.

C:\Users\htb-student> sc stop wuauserv

[SC] OpenService FAILED 5:

Access is denied.
