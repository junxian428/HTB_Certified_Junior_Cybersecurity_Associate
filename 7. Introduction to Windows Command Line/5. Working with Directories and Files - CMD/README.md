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

The image above shows how the three can be used in conjunction. chdir can also change our current working directory.

<h3>Create A New Directory</h3>

Creating a directory to add to our structure is a simple endeavor. We can utilize the md and mkdir commands.

<h3>Using MD</h3>

md new-directory

Above, md is in use. In the next shell, we will see mkdir used similarly. Both accomplish the same goal, so use either as you wish.

<h3>Using mkdir to Create Directories.</h3>

mkdir yet-another-dir

<h3>Delete Directories</h3>

Deleting directories can be accomplished using the rd or rmdir commands. The commands rd and rmdir are explicitly meant for removing directory trees and do not deal with specific files or attributes.

Let us look at rd and rmdir now.

<h3>RD & RMDIR</h3>

dir

<h3>RD /S</h3>

rd /S Git-Pulls

In the session above, we listed the directory to see its contents, then issued the rd Git-Pulls command. From the first session window, we can see that it did not execute the command since the directory was not empty. Rd has a switch /S that we can utilize to erase the directory and its contents. Since we want to make Git-Pulls disappear, we will issue it in the second cmd session seen above. The commands we have issued with rd are the same as rmdir.

Removing directories is pretty simple. If you get stuck trying to remove a directory and are getting a warning saying the directory is not empty, do not forget about the /S switch.

<h3>Modifying</h3>

Modifying a directory is more complicated than changing a file. The directory holds data within it for other files or directories. We have several options in any case. Move, Robocopy, and xcopy can copy and make changes to directories and their structures.

To use move, we have to issue the syntax in this order. When moving directories, it will take the directory and any files within and move it from the source to the destination path specified.

<h3>Move a Directory</h3>

C:\Users\htb\Desktop> tree example /F

We ran the tree command to see what resided in the example directory before copying it. After that, executing move example C:\Users\htb\Documents\example placed the example directory and all its files into the user's Documents folder. We can validate this by running a dir on Documents to see if the directory exists.

<h3>Validate the Move</h3>

C:\Users\htb\Desktop> dir C:\Users\htb\Documents

Moreover, there we have it. The directory example exists now within the Documents directory. The following two options have more capability in the ways they can interact with files and directories. We will take a minute to look at xcopy since it still exists in current Windows operating systems, but it is essential to know that it has been deprecated for robocopy. Where xcopy shines is that it can remove the Read-only bit from files when moving them. The syntax for xcopy is xcopy source destination options. As it was with move, we can use wildcards for source files, not destination files.
