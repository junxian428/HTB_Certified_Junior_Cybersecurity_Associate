<h3>Permission Management</h3>

In Linux, permissions are like keys that control access to files and directories. These permissions are assigned to both users and groups, much like keys being distributed to specific individuals and teams within an organization. Each user can belong to multiple groups, and being part of a group grants additional access rights, allowing users to perform specific actions on files and directories.

Every file and directory has an owner (a user) and is associated with a group. The permissions for these files are defined for both the owner and the group, determining what actions—like reading, writing, or executing—are allowed. When you create a new file or directory, it automatically becomes "yours" and is associated with the group you belong to, similar to how a project within a company might default to your team’s oversight.

In essence, Linux permissions act like a set of rules or keys that dictate who can access or modify certain resources, ensuring security and proper collaboration across the system.

When a user wants to access the contents of a Linux directory, it's similar to unlocking a door before stepping inside. To "traverse" or navigate into a directory, the user must first have the right key—this key is the execute permission on the directory. Without it, even if the contents of the directory are visible to the user, they won't be able to enter or move through it.

In other words, having execute permissions on a directory is like having permission to walk through a hallway to access the rooms inside. It doesn't allow you to see or modify what's inside, but it does grant you the ability to step inside and explore the directory's structure. Without this permission, the user cannot access the directory's contents and will instead be presented with a “Permission Denied" error message.

cry0l1t3@htb[/htb]$ ls -l

drw-rw-r-- 3 cry0l1t3 cry0l1t3 4096 Jan 12 12:30 scripts

cry0l1t3@htb[/htb]$ ls -al mydirectory/

ls: cannot access 'mydirectory/script.sh': Permission denied

ls: cannot access 'mydirectory/..': Permission denied

ls: cannot access 'mydirectory/subdirectory': Permission denied

ls: cannot access 'mydirectory/.': Permission denied

d????????? ? ? ? ? ? .

d????????? ? ? ? ? ? ..

-????????? ? ? ? ? ? script.sh

d????????? ? ? ? ? ? subdirectory

It is important to note that execute permissions are necessary to traverse a directory, no matter the user's level of access. Also, execute permissions on a directory do not allow a user to execute or modify any files or contents within the directory, only to traverse and access the content of the directory.

To execute files within the directory, a user needs execute permissions on the corresponding file. To modify the contents of a directory (create, delete, or rename files and subdirectories), the user needs write permissions on the directory.

The whole permission system on Linux systems is based on the octal number system, and basically, there are three different types of permissions a file or directory can be assigned:

(r) - Read

(w) - Write

(x) - Execute

The permissions can be set for the owner, group, and others like presented in the next example with their corresponding permissions.

cry0l1t3@htb[/htb]$ ls -l /etc/passwd

- rwx rw- r-- 1 root root 1641 May 4 23:42 /etc/passwd

- --- --- --- | | | | |\***\*\_\_\*\***|

  | | | | | | | | |\_ Date

  | | | | | | | |\***\*\_\_\*\*** File Size

  | | | | | | |**\*\***\_\_\_**\*\*** Group

  | | | | | |**\*\*\*\***\_\_\_\_**\*\*\*\*** User

  | | | | |\***\*\*\*\*\***\_\_\_\***\*\*\*\*\*** Number of hard links

  | | | |\_ Permission of others (read)

  | | |**\_** Permissions of the group (read, write)

  | |\***\*\_\*\*** Permissions of the owner (read, write, execute)

  |\***\*\_\_\_\_\*\*** File type (- = File, d = Directory, l = Link, ... )

<h3>Change Permissions</h3>

We can modify permissions using the chmod command, permission group references (u - owner, g - Group, o - others, a - All users), and either a [+] or a [-] to add or remove the designated permissions. In the following example, let us assume we have a file called shell and we want to change permissions for it so this script is owned by that user, becomes not executable, and set with read/write permissions for all users.
