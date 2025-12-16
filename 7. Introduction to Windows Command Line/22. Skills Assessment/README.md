<h3>Skills Assessment</h3>

<img width="1097" height="623" alt="image" src="https://github.com/user-attachments/assets/ae7fb79a-6411-49a6-a3bf-300d91d78132" />


During a penetration test with our team, we were instructed to collect some information for a non-critical Windows host. Our team has recently gained access to this host, which contains many users. For the team to focus on more complex tasks, we have been asked to take a closer look at this host. The main focus is on finding user names and passwords. This should enable us to examine the system in such a way that we can find out and document all user passwords.

Each question has a corresponding user with whom you will need to authenticate to complete the questions. In each challenge, you may be asked to perform specific actions, use specific executables, or find information on the host to get the flag for that question.

In most instances, the flag for the previous user must be used as the SSH password for the following user (i.e., the flag for user2 is the password for user3 to SSH in, and so on).

If you wish, play around and see if you can find multiple ways to achieve the same output as you got earlier from each question. Do not forget to document your one-liners, scripts, or general notes on how you went about finding specific information.

 The flag will print in the banner upon successful login on the host via SSH.
 
D0wn_the_rabbit_H0!3

 Access the host as user1 and read the contents of the file "flag.txt" located in the users Desktop.
 
Nice and Easy!

 If you search and find the name of this host, you will find the flag for user2.
 
ACADEMY-ICL11

How many hidden files exist on user3's Desktop?

101

User4 has a lot of files and folders in their Documents folder. The flag can be found within one of them.

Digging in The nest

  How many users exist on this host? (Excluding the DefaultAccount and WDAGUtility)
  
14

 For this level, you need to find the Registered Owner of the host. The Owner name is the flag.
 
htb-student

 For this level, you must successfully authenticate to the Domain Controller host at 172.16.5.155 via SSH after first authenticating to the target host. This host seems to have several PowerShell modules loaded, and this user's flag is hidden in one of them.

Modules_make_pwsh_run!

 This flag is the GivenName of a domain user with the Surname "Flag".
 
Rick

 Use the tasklist command to print running processes and then sort them in reverse order by name. The name of the process that begins with "vm" is the flag for this user.

vmtoolsd.exe

What user account on the Domain Controller has many Event ID (4625) logon failures generated in rapid succession, which is indicative of a password brute forcing attack? The flag is the name of the user account.

justalocaladmin




