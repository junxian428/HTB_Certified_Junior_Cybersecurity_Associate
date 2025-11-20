<h3>User Management</h3>

Effective user management is a fundamental aspect of Linux system administration. Administrators frequently need to create new user accounts or assign existing users to specific groups to enforce appropriate access controls. Additionally, executing commands as a different user is often necessary for tasks that require different privileges. For example, certain groups may have exclusive permissions to view or modify specific files or directories, which is essential for maintaining system security and integrity. This capability allows us to gather more detailed information locally on the machine, which can be critically important for troubleshooting or auditing purposes.

For example, imagine a new employee named Alex joins your company and is provided with a Linux-based workstation to perform their tasks. As a system administrator, you need to create a user account for Alex and add them to the appropriate groups that grant access to necessary resources, such as project files or development tools. Additionally, there may be situations where Alex needs to execute commands with elevated privileges or as a different user to complete certain tasks.

<h3>Execution as a user</h3>

@htb[/htb]$ cat /etc/shadow

cat: /etc/shadow: Permission denied

The /etc/shadow file is a critical system file that stores encrypted password information for all user accounts. For security reasons, it is readable and writable only by the root user to prevent unauthorized access to sensitive authentication data.

To perform tasks that require elevated privileges, users can utilize the sudo command. The sudo command, short for "superuser do," allows permitted users to execute commands with the security privileges of another user, typically the superuser or root. This enables users to perform administrative tasks without logging in as the root user, which is a best practice for maintaining system security. We will explore sudo permissions in greater detail in the Linux Security section.

<h3>Execution as root</h3>

@htb[/htb]$ sudo cat /etc/shadow

root:<SNIP>:18395:0:99999:7:::

daemon:\_:17737:0:99999:7:::

bin:\_:17737:0:99999:7:::

<SNIP>

Here is a list that will help us to better understand and deal with user management.

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>sudo</td>
      <td>Execute command as a different user.</td>
    </tr>
    <tr>
      <td>su</td>
      <td>The su utility requests appropriate user credentials via PAM and switches to that user ID (the default user is the superuser). A shell is then executed.</td>
    </tr>
    <tr>
      <td>useradd</td>
      <td>Creates a new user or updates default new user information.</td>
    </tr>
    <tr>
      <td>userdel</td>
      <td>Deletes a user account and related files.</td>
    </tr>
    <tr>
      <td>usermod</td>
      <td>Modifies a user account.</td>
    </tr>
    <tr>
      <td>addgroup</td>
      <td>Adds a group to the system.</td>
    </tr>
    <tr>
      <td>delgroup</td>
      <td>Removes a group from the system.</td>
    </tr>
    <tr>
      <td>passwd</td>
      <td>Changes user password.</td>
    </tr>
  </tbody>
</table>

Understanding how user accounts, permissions, and authentication mechanisms operate enables us to identify vulnerabilities, exploit misconfigurations, and assess the security posture of a system effectively. The most effective way to gain proficiency in user management is to practice using the individual commands along with their various options in a controlled environment.

Feel free to experiment with the various commands and explore their functionalities. It's important to let your creativity guide you in deciding what you want to achieve. By combining these user management tools with the knowledge you've gained from the previous sections, you'll realize how much you've already learned. Apply your understanding of the Linux system: create new user accounts, set up files and directories for these users, select files, read and filter specific elements, and redirect them to the files and directories of the new users you've created. Feel free to explore extensively. On your target system, there's nothing that can't be fixed, and even if something goes wrong, you have the ability to reset the target and start anew until you feel confident.

Questions

Answer the question(s) below to complete this Section and earn cubes!

- 0 Which option needs to be set to create a home directory for a new user using "useradd" command?

  -m

- 0 Which option needs to be set to lock a user account using the "usermod" command? (long version of the option)

  --lock

- 0 Which option needs to be set to execute a command as a different user using the "su" command? (long version of the option)

  --command
