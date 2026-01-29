<h3>MSSQL</h3>

Microsoft SQL (MSSQL) is Microsoft's SQL-based relational database management system. Unlike MySQL, which we discussed in the last section, MSSQL is closed source and was initially written to run on Windows operating systems. It is popular among database administrators and developers when building applications that run on Microsoft's .NET framework due to its strong native support for .NET. There are versions of MSSQL that will run on Linux and MacOS, but we will more likely come across MSSQL instances on targets running Windows.

<h3>MSSQL Clients</h3>

SQL Server Management Studio (SSMS) comes as a feature that can be installed with the MSSQL install package or can be downloaded & installed separately. It is commonly installed on the server for initial configuration and long-term management of databases by admins. Keep in mind that since SSMS is a client-side application, it can be installed and used on any system an admin or developer is planning to manage the database from. It doesn't only exist on the server hosting the database. This means we could come across a vulnerable system with SSMS with saved credentials that allow us to connect to the database. The image below shows SSMS in action.

<img width="816" height="593" alt="image" src="https://github.com/user-attachments/assets/ce1b5a8f-6eba-4fe0-9e5f-c620b7b7b787" />

Many other clients can be used to access a database running on MSSQL. Including but not limited to:

mssql-cli	SQL Server PowerShell	HeidiSQL	SQLPro	Impacket's mssqlclient.py

Of the MSSQL clients listed above, pentesters may find Impacket's mssqlclient.py to be the most useful due to SecureAuthCorp's Impacket project being present on many pentesting distributions at install. To find if and where the client is located on our host, we can use the following command:

@htb[/htb]$ locate mssqlclient

/usr/bin/impacket-mssqlclient

/usr/share/doc/python3-impacket/examples/mssqlclient.py

<h3>MSSQL Databases</h3>

MSSQL has default system databases that can help us understand the structure of all the databases that may be hosted on a target server. Here are the default databases and a brief description of each:

<table border="1" cellpadding="8" cellspacing="0">
  <thead>
    <tr>
      <th>System Database</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>master</td>
      <td>Tracks all system information for an SQL Server instance</td>
    </tr>
    <tr>
      <td>model</td>
      <td>
        Template database that acts as a structure for every new database created.
        Any setting changed in the model database will be reflected in any new
        database created after the change.
      </td>
    </tr>
    <tr>
      <td>msdb</td>
      <td>The SQL Server Agent uses this database to schedule jobs and alerts</td>
    </tr>
    <tr>
      <td>tempdb</td>
      <td>Stores temporary objects</td>
    </tr>
    <tr>
      <td>resource</td>
      <td>Read-only database containing system objects included with SQL Server</td>
    </tr>
  </tbody>
</table>

<h3>Default Configuration</h3>

When an admin initially installs and configures MSSQL to be network accessible, the SQL service will likely run as NT SERVICE\MSSQLSERVER. Connecting from the client-side is possible through Windows Authentication, and by default, encryption is not enforced when attempting to connect.

<img width="815" height="486" alt="image" src="https://github.com/user-attachments/assets/e7c8b4f1-0561-48f6-83fc-01409f788979" />

Authentication being set to Windows Authentication means that the underlying Windows OS will process the login request and use either the local SAM database or the domain controller (hosting Active Directory) before allowing connectivity to the database management system. Using Active Directory can be ideal for auditing activity and controlling access in a Windows environment, but if an account is compromised, it could lead to privilege escalation and lateral movement across a Windows domain environment. Like with any OS, service, server role, or application, it can be beneficial to set it up in a VM from installation to configuration to understand all the default configurations and potential mistakes that the administrator could make.

<h3>Dangerous Settings</h3>

It can be beneficial to place ourselves in the perspective of an IT administrator when we are on an engagement. This mindset can help us remember to look for various settings that may have been misconfigured or configured in a dangerous manner by an admin. A workday in IT can be rather busy, with lots of different projects happening simultaneously and the pressure to perform with speed & accuracy being a reality in many organizations, mistakes can be easily made. It only takes one tiny misconfiguration that could compromise a critical server or service on the network. This applies to just about every network service and server role that can be configured, including MSSQL.

This is not an extensive list because there are countless ways MSSQL databases can be configured by admins based on the needs of their respective organizations. We may benefit from looking into the following:

MSSQL clients not using encryption to connect to the MSSQL server

The use of self-signed certificates when encryption is being used. It is possible to spoof self-signed certificates

The use of named pipes

Weak & default sa credentials. Admins may forget to disable this account

<h3>Footprinting the Service</h3>

There are many ways we can approach footprinting the MSSQL service, the more specific we can get with our scans, the more useful information we will be able to gather. NMAP has default mssql scripts that can be used to target the default tcp port 1433 that MSSQL listens on.

The scripted NMAP scan below provides us with helpful information. We can see the hostname, database instance name, software version of MSSQL and named pipes are enabled. We will benefit from adding these discoveries to our notes.

<h3>NMAP MSSQL Script Scan</h3>

@htb[/htb]$ sudo nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args mssql.instance-port=1433,mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER -sV -p 1433 10.129.201.248

Starting Nmap 7.91 ( https://nmap.org ) at 2021-11-08 09:40 EST

We can also use Metasploit to run an auxiliary scanner called mssql_ping that will scan the MSSQL service and provide helpful information in our footprinting process.

<h3>MSSQL Ping in Metasploit</h3>

msf6 auxiliary(scanner/mssql/mssql_ping) > set rhosts 10.129.201.248

rhosts => 10.129.201.248


msf6 auxiliary(scanner/mssql/mssql_ping) > run

<h3>Connecting with Mssqlclient.py</h3>

If we can guess or gain access to credentials, this allows us to remotely connect to the MSSQL server and start interacting with databases using T-SQL (Transact-SQL). Authenticating with MSSQL will enable us to interact directly with databases through the SQL Database Engine. From Pwnbox or a personal attack host, we can use Impacket's mssqlclient.py to connect as seen in the output below. Once connected to the server, it may be good to get a lay of the land and list the databases present on the system.

@htb[/htb]$ python3 mssqlclient.py Administrator@10.129.201.248 -windows-auth

Impacket v0.9.22 - Copyright 2020 SecureAuth Corporation

 Enumerate the target using the concepts taught in this section. List the hostname of MSSQL server.
 
ILF-SQL-01

+ 0  Connect to the MSSQL instance running on the target using the account (backdoor:Password1), then list the non-default database present on the server.
  
Employees
