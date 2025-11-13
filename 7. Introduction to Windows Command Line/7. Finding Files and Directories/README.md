<h3>Finding Files and Directories</h3>

Now, we are comfortable creating, modifying, moving, and deleting files and directories. We should cover a beneficial concept that can make or break it during an engagement or in our day-to-day tasks as a System Administrator or Penetration Tester, known as enumeration. This section will cover how to search for particular files and directories utilizing CMD, why enumerating system files and directories are vital, and provide an essential list of what to look out for while enumerating the system.

<h3>Searching With CMD</h3>

<h3>Using Where</h3>

C:\Users\student\Desktop>where calc.exe

C:\Windows\System32\calc.exe

C:\Users\student\Desktop>where bio.txt

INFO: Could not find files for the given pattern(s).

Above, we can see two different tries using the where command. First, we searched for calc.exe, and it completed showing us the path for calc.exe. This command worked because the system32 folder is in our environment variable path, so the where command can look through those folders automatically.

The second attempt we see failed. This is because we are searching for a file that does not exist within that environment path. It is located within our user directory. So we need to specify the path to search in, and to ensure we dig through all directories within that path, we can use the /R switch.
