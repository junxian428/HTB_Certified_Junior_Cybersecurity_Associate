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

<h3>Recursive Where</h3>

C:\Users\student\Desktop>where /R C:\Users\student\ bio.txt

C:\Users\student\Downloads\bio.txt

Above, we searched recursively, looking for bio.txt. The file was found in the C:\Users\student\Downloads\ folder. The /R switch forced the where command to search through every folder in the student user directory hive. On top of looking for files, we can also search wildcards for specific strings, file types, and more. Below is an example of searching for the csv file type within the student directory.

<h3>Using Wildcards</h3>

C:\Users\student\Desktop>where /R C:\Users\student\ \*.csv

C:\Users\student\AppData\Local\live-hosts.csv

We used where to give us an idea of how to search for files and applications on the host. Now, let us talk about Find. Find is used to search for text strings or their absence within a file or files. You can also use find against the console's output or another command. Where find is limited, however, is its capability to utilize wildcard patterns in its matching. The example below will show us a simple search with Find against the not-password.txt file.

<h3>Basic Find</h3>

C:\Users\student\Desktop> find "password" "C:\Users\student\not-passwords.txt"
We can modify the way find searches using several switches. The /V modifier can change our search from a matching clause to a Not clause. So, for example, if we use /V with the search string password against a file, it will show us any line that does not have the specified string. We can also use the /N switch to display line numbers for us and the /I display to ignore case sensitivity. In the example below, we use all of the modifiers to show us any lines that do not match the string IP Address while asking it to display line numbers and ignore the case of the string.

<h3>Find Modifiers</h3>

C:\Users\student\Desktop> find /N /I /V "IP Address" example.txt

For quick searches, find is easy to use, but it could be more robust in how it can search. However, if we need something more specific, findstr is what we need. The findstr command is similar to find in that it searches through files but for patterns instead. It will look for anything matching a pattern, regex value, wildcards, and more. Think of it as find2.0. For those familiar with Linux, findstr is closer to grep.
