<h3>Databases</h3>

Databases in msfconsole are used to keep track of your results. It is no mystery that during even more complex machine assessments, much less entire networks, things can get a little fuzzy and complicated due to the sheer amount of search results, entry points, detected issues, discovered credentials, etc.

This is where Databases come into play. Msfconsole has built-in support for the PostgreSQL database system. With it, we have direct, quick, and easy access to scan results with the added ability to import and export results in conjunction with third-party tools. Database entries can also be used to configure Exploit module parameters with the already existing findings directly.

<h4>Setting up the Database</h4>

First, we must ensure that the PostgreSQL server is up and running on our host machine. To do so, input the following command:

<h3>PostgreSQL Status</h3>

@htb[/htb]$ sudo service postgresql status

<h3>Start PostgreSQL</h3>

@htb[/htb]$ sudo systemctl start postgresql

After starting PostgreSQL, we need to create and initialize the MSF database with msfdb init.

<h3>MSF - Initiate a Database</h3>

@htb[/htb]$ sudo msfdb init

Sometimes an error can occur if Metasploit is not up to date. This difference that causes the error can happen for several reasons. First, often it helps to update Metasploit again (apt update) to solve this problem. Then we can try to reinitialize the MSF database.

@htb[/htb]$ sudo msfdb init

If the initialization is skipped and Metasploit tells us that the database is already configured, we can recheck the status of the database.

@htb[/htb]$ sudo msfdb status

If this error does not appear, which often happens after a fresh installation of Metasploit, then we will see the following when initializing the database:

@htb[/htb]$ sudo msfdb init

After the database has been initialized, we can start msfconsole and connect to the created database simultaneously.

<h3>MSF - Connect to the Initiated Database</h3>

7@htb[/htb]$ sudo msfdb run

[i] Database already started

If, however, we already have the database configured and are not able to change the password to the MSF username, proceed with these commands:

<h3>MSF - Reinitiate the Database</h3>


<img width="919" height="137" alt="image" src="https://github.com/user-attachments/assets/9fbe0f36-9960-4ed4-9ae1-be885603d695" />

db_status

Now, we are good to go. The msfconsole also offers integrated help for the database. This gives us a good overview of interacting with and using the database.

<h3>MSF - Database Options</h3>

msf6 > help database

msf6 > db_status

<h3>Using the Database</h3>

With the help of the database, we can manage many different categories and hosts that we have analyzed. Alternatively, the information about them that we have interacted with using Metasploit. These databases can be exported and imported. This is especially useful when we have extensive lists of hosts, loot, notes, and stored vulnerabilities for these hosts. After confirming that the database is successfully connected, we can organize our Workspaces.

<h3>Workspaces</h3>

We can think of Workspaces the same way we would think of folders in a project. We can segregate the different scan results, hosts, and extracted information by IP, subnet, network, or domain.

To view the current Workspace list, use the workspace command. Adding a -a or -d switch after the command, followed by the workspace's name, will either add or delete that workspace to the database.

  msf6 > workspace

* default

Notice that the default Workspace is named default and is currently in use according to the * symbol. Type the workspace [name] command to switch the presently used workspace. Looking back at our example, let us create a workspace for this assessment and select it.

msf6 > workspace -a Target_1

[*] Added workspace: Target_1

[*] Workspace: Target_1


msf6 > workspace Target_1 

[*] Workspace: Target_1


msf6 > workspace

  default
  
* Target_1

To see what else we can do with Workspaces, we can use the workspace -h command for the help menu related to Workspaces.

msf6 > workspace -h

<h3>Importing Scan Results</h3>

Next, let us assume we want to import a Nmap scan of a host into our Database's Workspace to understand the target better. We can use the db_import command for this. After the import is complete, we can check the presence of the host's information in our database by using the hosts and services commands. Note that the .xml file type is preferred for db_import.

<h3>Stored Nmap Scan</h3>

@htb[/htb]$ cat Target.nmap

<h3>Importing Scan Results</h3>

msf6 > db_import Target.xml

msf6 > hosts

<h3>Using Nmap Inside MSFconsole</h3>

Alternatively, we can use Nmap straight from msfconsole! To scan directly from the console without having to background or exit the process, use the db_nmap command.

<h3>MSF - Nmap</h3>

msf6 > db_nmap -sV -sS 10.10.10.8

<h3>Data Backup</h3>

After finishing the session, make sure to back up our data if anything happens with the PostgreSQL service. To do so, use the db_export command.

<h3>MSF - DB Export</h3>

msf6 > db_export -h

This data can be imported back to msfconsole later when needed. Other commands related to data retention are the extended use of hosts, services, and the creds and loot commands.

<h3>Hosts</h3>

The hosts command displays a database table automatically populated with the host addresses, hostnames, and other information we find about these during our scans and interactions. For example, suppose msfconsole is linked with scanner plugins that can perform service and OS detection. In that case, this information should automatically appear in the table once the scans are completed through msfconsole. Again, tools like Nessus, NexPose, or Nmap will help us in these cases.

Hosts can also be manually added as separate entries in this table. After adding our custom hosts, we can also organize the format and structure of the table, add comments, change existing information, and more.

<h3>MSF - Stored Hosts</h3>

msf6 > hosts -h

<h3>Services</h3>

The services command functions the same way as the previous one. It contains a table with descriptions and information on services discovered during scans or interactions. In the same way as the command above, the entries here are highly customizable.

<h3>MSF - Stored Services of Hosts</h3>

msf6 > services -h

<h3>Credentials</h3>

The creds command allows you to visualize the credentials gathered during your interactions with the target host. We can also add credentials manually, match existing credentials with port specifications, add descriptions, etc.

<h3>MSF - Stored Credentials</h3>

msf6 > creds -h

<h3>Loot</h3>

The loot command works in conjunction with the command above to offer you an at-a-glance list of owned services and users. The loot, in this case, refers to hash dumps from different system types, namely hashes, passwd, shadow, and more.

<h3>MSF - Stored Loot</h3>

msf6 > loot -h
