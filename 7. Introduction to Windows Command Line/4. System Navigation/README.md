<h3>System Navigation</h3>

So far, most of what we have covered is introductory information to help us get a basic understanding and feel of the Command Prompt. Continuing with that flow, our next goal should be utilizing our Command Prompt to successfully navigate and move around on the system. In this section, we attempt to conquer our surroundings by:

Listing A Directory

Finding Our Place on the System

Moving Around using CD

Exploring the File System

Additionally, at the end of the section, we will briefly look into certain directories on a Windows host that might seem juicy from the adversary's perspective. Keeping all of that in mind, let us dive right in and explore the system together.

<h3>Listing A Directory</h3>

One of the easiest things we can do when initially poking around on a Windows host is to get a listing of the directory we are currently working in. We do that with the dir command.

dir

As seen through the example above, dir is an easy-to-use and surprisingly versatile command. Simply calling upon the command without any arguments will give us a listing of our current directory and its contents. As shown in the Getting Help section, we can also use the /? argument to provide us with a complete listing of the dir's functionality and any additional arguments that we can provide to utilize it is advanced searching capabilities. In a later section, we will further discuss the meaning behind the above output and how we can use dir to aid us in our search for important files and directories. For now, understanding the basic usage of dir will provide us with more than enough utility to efficiently move around the system.

<h3>Finding Our Place</h3>

Before doing anything on a host, it is helpful to know where we are in the filesystem. We can determine that by utilizing the cd or chdir commands.

C:\htb> cd

C:\htb

As shown by the example above, issuing the command without arguments gives us our current working directory. Our current working directory is our initial starting point. It describes our current directory as the one we are currently working in. Any command(s) run here without specifying the path of another directory or file will reference this initial point. This is very important, considering that everything we do moving forward will reference our current working directory unless specified otherwise.

<h3>Moving Around Using CD/CHDIR</h3>

As we were busy finding our place on the system, we introduced the cd and chdir commands. However, we did not explore the full functionality of either. Besides listing our current directory, both serve an additional function. These commands will move us to whatever directory we specify after the command. The specified directory can either be a directory relative to our current working directory or an absolute directory starting from the filesystem's root.

Those familiar with Linux should begin to recognize this structure and be familiar with the difference between relative paths and absolute paths. However, assuming that we have not come into contact with either of these terms yet, let us quickly showcase the difference using the following examples:

<h3>Current Working Directory</h3>

C:\htb> cd

C:\htb

This should look familiar, right? It is the same example used in the previous section. Let us expand upon this a bit. First, we need to define our root directory. To keep things simple, think of the root directory as the topmost directory in the structure, as it contains everything else within it. In this example, our root directory is C:\.

Note: C:\ is the root directory of all Windows machines and has been determined so since it is inception in the MS-DOS and Windows 3.0 days. The "C:\" designation was used commonly as typically "A:\" and "B:\" were recognized as floppy drives, whereas "C:\" was recognized as the first internal hard drive of the machine.

<h3>Absolute Path</h3>

C:\htb> cd C:\Users\htb\Pictures

C:\Users\htb\Pictures>

In this example, we can see that our initial working directory is located in C:\htb. We used cd and provided the path as our argument to move ourselves to the C:\Users\htb\Pictures directory. As we can see, the provided path starts with C:\ as it is the root directory and follows the structure until it reaches its destination, being the \Pictures directory. Putting the pieces together, we can conclude that C:\Users\htb\Pictures would be considered the absolute path in this case as it follows the complete structure of the file system starting from the root directory and ending at the destination directory.

<h3>Relative Path</h3>

C:\htb> cd .\Pictures

C:\Users\htb\Pictures>

On the other hand, following this example, we can see that something is slightly off in how our path is specified in the cd command. Instead of starting from the root directory, we are greeted with a . followed by the destination directory (\Pictures). The . character points to one directory down from our current working directory (C:\htb). Using our working directory as the starting point to reference directories either above it or below it in the file system hierarchy is considered a relative path, as its position is relative to the current working directory.

Understanding both of these terms is imperative as we can effectively use this knowledge of the file system's hierarchy to move up and down the file structure with ease. We can piece everything together through one last example to show how quickly we can use what we have learned so far to move about the system.

We are currently in the C:\Users\htb\Pictures directory provided in our previous example. However, we wish to quickly move all the way back to the root of the file system in just one command. To do so, we can perform the following:

C:\Users\htb\Pictures> cd ..\..\..\

C:\>

This one command lets us move up the directory structure, starting from the \Pictures directory and moving up to the root directory in one swift stroke. Pretty neat, huh? Understanding this fundamental concept will be very important moving forward, so we should practice and familiarize ourselves now while we have the chance.

<h3>Exploring the File System</h3>

Using our newfound skills, we should branch out and explore the system earnestly. Thorough exploration is essential, as it can help us gain a considerable advantage in understanding the layout of the system we are interacting with and the files contained within. However, when looking around the filesystem of a Windows host, it can get tedious to change our directory back and forth or to issue the dir command for each sub-directory. To save us a bit of time and gain some efficiency, we can get a printout of the entire path we specify and its subdirectories by utilizing the tree command.

<h3>Listing the Contents of the File System</h3>

C:\htb\student\> tree
