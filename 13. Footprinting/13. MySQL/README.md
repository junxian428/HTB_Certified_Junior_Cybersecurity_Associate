<h3>MySQL</h3>

MySQL is an open-source SQL relational database management system developed and supported by Oracle. A database is simply a structured collection of data organized for easy use and retrieval. The database system can quickly process large amounts of data with high performance. Within the database, data storage is done in a manner to take up as little space as possible. The database is controlled using the SQL database language. MySQL works according to the client-server principle and consists of a MySQL server and one or more MySQL clients. The MySQL server is the actual database management system. It takes care of data storage and distribution. The data is stored in tables with different columns, rows, and data types. These databases are often stored in a single file with the file extension .sql, for example, like wordpress.sql.

<h3>MySQL Clients</h3>

The MySQL clients can retrieve and edit the data using structured queries to the database engine. Inserting, deleting, modifying, and retrieving data, is done using the SQL database language. Therefore, MySQL is suitable for managing many different databases to which clients can send multiple queries simultaneously. Depending on the use of the database, access is possible via an internal network or the public Internet.

One of the best examples of database usage is the CMS WordPress. WordPress stores all created posts, usernames, and passwords in their own database, which is only accessible from the localhost. However, as explained in more detail in the module Introduction to Web Applications, there are database structures that are distributed across multiple servers also.

<h3>MySQL Databases</h3>

MySQL is ideally suited for applications such as dynamic websites, where efficient syntax and high response speed are essential. It is often combined with a Linux OS, PHP, and an Apache web server and is also known in this combination as LAMP (Linux, Apache, MySQL, PHP), or when using Nginx, as LEMP. In a web hosting with MySQL database, this serves as a central instance in which content required by PHP scripts is stored. Among these are:

Headers	Texts	Meta tags	Forms

Customers	Usernames	Administrators	Moderators

Email addresses	User information	Permissions	Passwords

External/Internal links	Links to Files	Specific contents	Values

Sensitive data such as passwords can be stored in their plain-text form by MySQL; however, they are generally encrypted beforehand by the PHP scripts using secure methods such as One-Way-Encryption.

<h3>MySQL Commands</h3>

A MySQL database translates the commands internally into executable code and performs the requested actions. The web application informs the user if an error occurs during processing, which various SQL injections can provoke. Often, these error descriptions contain important information and confirm, among other things, that the web application interacts with the database in a different way than the developers intended.

The web application sends the generated information back to the client if the data is processed correctly. This information can be the data extracts from a table or records needed for further processing with logins, search functions, etc. SQL commands can display, modify, add or delete rows in tables. In addition, SQL can also change the structure of tables, create or delete relationships and indexes, and manage users.

MariaDB, which is often connected with MySQL, is a fork of the original MySQL code. This is because the chief developer of MySQL left the company MySQL AB after it was acquired by Oracle and developed another open-source SQL database management system based on the source code of MySQL and called it MariaDB.

<h3>Default Configuration</h3>

The management of SQL databases and their configurations is a vast topic. It is so large that entire professions, such as database administrator, deal with almost nothing but databases. These structures become very large quickly, and their planning can become complicated. Among other things, DB management is a core competency for software developers but also information security analysts. To cover this area completely would go beyond the scope of this module. Therefore, we recommend setting up a MySQL/MariaDB instance to experiment with the various configurations to understand the available functionality and configuration options better. Let us have a look at the default configuration of MySQL.

<h3>Default Configuration</h3>

@htb[/htb]$ sudo apt install mysql-server -y

@htb[/htb]$ cat /etc/mysql/mysql.conf.d/mysqld.cnf | grep -v "#" | sed -r '/^\s*$/d'

<h3>Dangerous Settings</h3>

Many things can be misconfigured with MySQL. We can look in more detail at the MySQL reference to determine which options can be made in the server configuration. The main options that are security-relevant are:

Settings	Description

user	Sets which user the MySQL service will run as.

password	Sets the password for the MySQL user.

admin_address	The IP address on which to listen for TCP/IP connections on the administrative network interface.

debug	This variable indicates the current debugging settings

sql_warnings	This variable controls whether single-row INSERT statements produce an information string if warnings occur.

secure_file_priv	This variable is used to limit the effect of data import and export operations.

The settings user, password, and admin_address are security-relevant because the entries are made in plain text. Often, the rights for the configuration file of the MySQL server are not assigned correctly. If we get another way to read files or even a shell, we can see the file and the username and password for the MySQL server. Suppose there are no other security measures to prevent unauthorized access. In that case, the entire database and all the existing customers' information, email addresses, passwords, and personal data can be viewed and even edited.

The debug and sql_warnings settings provide verbose information output in case of errors, which are essential for the administrator but should not be seen by others. This information often contains sensitive content, which could be detected by trial and error to identify further attack possibilities. These error messages are often displayed directly on web applications. Accordingly, the SQL injections could be manipulated even to have the MySQL server execute system commands. This is discussed and shown in the module SQL Injection Fundamentals and SQLMap Essentials.

<h3>Footprinting the Service</h3>

There are many reasons why a MySQL server could be accessed from an external network. Nevertheless, it is far from being one of the best practices, and we can always find databases that we can reach. Often, these settings were only meant to be temporary but were forgotten by the administrators. This server setup could also be used as a workaround due to a technical problem. Usually, the MySQL server runs on TCP port 3306, and we can scan this port with Nmap to get more detailed information.

<h3>Scanning MySQL Server</h3>

@htb[/htb]$ sudo nmap 10.129.14.128 -sV -sC -p3306 --script mysql*

As with all our scans, we must be careful with the results and manually confirm the information obtained because some of the information might turn out to be a false-positive. This scan above is an excellent example of this, as we know for a fact that the target MySQL server does not use an empty password for the user root, but a fixed password. We can test this with the following command:

<h3>Interaction with the MySQL Server</h3>

@htb[/htb]$ mysql -u root -h 10.129.14.132

For example, if we use a password that we have guessed or found through our research, we will be able to log in to the MySQL server and execute some commands.

@htb[/htb]$ mysql -u root -pP4SSw0rd -h 10.129.14.128

If we look at the existing databases, we will see several already exist. The most important databases for the MySQL server are the system schema (sys) and information schema (information_schema). The system schema contains tables, information, and metadata necessary for management. More about this database can be found in the reference manual of MySQL.

mysql> use sys;

mysql> show tables;  

The information schema is also a database that contains metadata. However, this metadata is mainly retrieved from the system schema database. The reason for the existence of these two is the ANSI/ISO standard that has been established. System schema is a Microsoft system catalog for SQL servers and contains much more information than the information schema.

Some of the commands we should remember and write down for working with MySQL databases are described below in the table.

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>mysql -u &lt;user&gt; -p&lt;password&gt; -h &lt;IP address&gt;</code></td>
      <td>Connect to the MySQL server. There should not be a space between the <code>-p</code> flag and the password.</td>
    </tr>
    <tr>
      <td><code>show databases;</code></td>
      <td>Show all databases.</td>
    </tr>
    <tr>
      <td><code>use &lt;database&gt;;</code></td>
      <td>Select one of the existing databases.</td>
    </tr>
    <tr>
      <td><code>show tables;</code></td>
      <td>Show all available tables in the selected database.</td>
    </tr>
    <tr>
      <td><code>show columns from &lt;table&gt;;</code></td>
      <td>Show all columns in the selected table.</td>
    </tr>
    <tr>
      <td><code>select * from &lt;table&gt;;</code></td>
      <td>Show everything in the desired table.</td>
    </tr>
    <tr>
      <td><code>select * from &lt;table&gt; where &lt;column&gt; = "&lt;string&gt;";</code></td>
      <td>Search for a specific string in the selected column.</td>
    </tr>
  </tbody>
</table>

We must know how to interact with different databases. Therefore, we recommend installing and configuring a MySQL server on one of our VMs for experimentation. There is also a widely covered security issues section in the reference manual that covers best practices for securing MySQL servers. We should use this when setting up our MySQL server to understand better why something might not work.


Enumerate the MySQL server and determine the version in use. (Format: MySQL X.X.XX)

MySQL 8.0.27

+ 1  During our penetration test, we found weak credentials "robin:robin". We should try these against the MySQL server. What is the email address of the customer "Otto Lang"?
  
ultrices@google.htb
