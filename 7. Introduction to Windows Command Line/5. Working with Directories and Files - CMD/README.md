<h3>Working with Directories and Files - CMD</h3>

Now that we can safely navigate via the command line, it is time to master the art of files and directories. This can be a robust topic; we have several ways to accomplish the same tasks with Windows. We will cover a few but keep in mind that there are many other ways to work with files and directories. Let us dive in.

<h3>Directories</h3>

What is a directory? In this case, it is an overarching folder structure within the Windows filesystem. Our files are nested within this folder structure, and we can move around utilizing common commands we practiced in the last section, such as cd and dir.

Revisiting our hallway concept from the last section for a second when thinking about directories, we can break it down like this:

The Drive itself is a disk, but it is also the root directory. So think about the C: drive as our hotel.

That hotel has many different floors filled with hallways. This level would include directories like Windows, Users, Program Files, and any other directories created by the operating system or the users.

These floors have multiple halls. Think of each hall as a folder nested with our previous directories. So for the case of Users, we would then have a folder for each user logged into the host. At this point, we are several levels deep into the filesystem. (C:\Users\htb) as an example of a directory.

This continues with other hallways (directories) as the use of the host expands and more software is installed.

Eventually, we find the room we were looking for and peek in. Think of the door as a file within the directory hive.

<h3>Viewing & Listing Directories</h3>

As we said in the previous section, we can issue the 'cd' command when trying to see what directory we currently reside in. To get a listing of what files are within a directory, we can use the dir command, and tree provides a complete listing of all files and folders within the specified path. So it is nice to see we already have a head start.
