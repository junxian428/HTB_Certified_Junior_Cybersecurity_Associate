<h3>Working with Files and Directories - PowerShell</h3>

We already know how to navigate around the host and manage users and groups utilizing only PowerShell; now, it is time to explore files and directories. In this section, we will experiment with creating, modifying, and deleting files and directories, along with a quick introduction to file permissions and how to enumerate them. By now, we should be familiar with the Get, Set, New verbs, among others, so we will speed this up with our examples by combining several commands into a single shell session.

<h3>Creating/Moving/Deleting Files & Directories</h3>

Many of the cmdlets we will discuss in this section can apply to working with files and folders, so we will combine some of our actions to work more efficiently (as any good pentester or sysadmin should strive to.). The table below lists the commonly used cmdlets used when dealing with objects in PowerShell.

<h3>Common Commands Used for File & Folder Management</h3>

<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>Command</th>
      <th>Alias</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Get-Item</td>
      <td>gi</td>
      <td>Retrieve an object (could be a file, folder, registry object, etc.)</td>
    </tr>
    <tr>
      <td>Get-ChildItem</td>
      <td>ls / dir / gci</td>
      <td>Lists out the content of a folder or registry hive.</td>
    </tr>
    <tr>
      <td>New-Item</td>
      <td>md / mkdir / ni</td>
      <td>Create new objects (can be files, folders, symlinks, registry entries, and more)</td>
    </tr>
    <tr>
      <td>Set-Item</td>
      <td>si</td>
      <td>Modify the property values of an object.</td>
    </tr>
    <tr>
      <td>Copy-Item</td>
      <td>copy / cp / ci</td>
      <td>Make a duplicate of the item.</td>
    </tr>
    <tr>
      <td>Rename-Item</td>
      <td>ren / rni</td>
      <td>Changes the object name.</td>
    </tr>
    <tr>
      <td>Remove-Item</td>
      <td>rm / del / rmdir</td>
      <td>Deletes the object.</td>
    </tr>
    <tr>
      <td>Get-Content</td>
      <td>cat / type</td>
      <td>Displays the content within a file or object.</td>
    </tr>
    <tr>
      <td>Add-Content</td>
      <td>ac</td>
      <td>Append content to a file.</td>
    </tr>
    <tr>
      <td>Set-Content</td>
      <td>sc</td>
      <td>Overwrite any content in a file with new data.</td>
    </tr>
    <tr>
      <td>Clear-Content</td>
      <td>clc</td>
      <td>Clear the content of the files without deleting the file itself.</td>
    </tr>
    <tr>
      <td>Compare-Object</td>
      <td>diff / compare</td>
      <td>Compare two or more objects against each other, including the object itself and its content.</td>
    </tr>
  </tbody>
</table>

Scenario: Greenhorn's new Security Chief, Mr. Tanaka, has requested that a set of files and folders be created for him. He plans to use them for SOP documentation for the Security team. Since he just got host access, we have agreed to set the file & folder structure up for him. If you would like to follow along with the examples below, please feel free. For your practice, we removed the folders and files discussed below so you can take a turn recreating them.

First, we are going to start with the folder structure he requested. We are going to make three folders named :

SOPs

Physical Sec

Cyber Sec

Training

We will use the Get-Item, Get-ChildItem, and New-Item commands to create our folder structure. Let us get started. We first need to determine where we are in the host and then move to Mr. Tanaka's Documents folder.

<h3>Finding Our Place</h3>

PS C:\htb> Get-Location

## Path

C:\Users\MTanaka

PS C:\Users\MTanaka> cd Documents

PS C:\Users\MTanaka\Documents>

Now that we are in the correct directory, it's time to get to work. Next, we need to make the SOPs folder. The New-Item Cmdlet can be used to accomplish this.

New-Item

Working with Files and Directories - PowerShell

PS C:\Users\MTanaka\Documents> new-item -name "SOPs" -type directory

    Directory: C:\Users\MTanaka\Documents

Mode LastWriteTime Length Name

---

d----- 10/5/2022 12:20 PM SOPs

Awesome. Our main directory exists now. Let us create our nested folders Physical Sec, Cyber Sec, and Training. We can utilize the same command from last time or the alias mkdir. First, we need to move into the SOPs Directory.

<h3>Making More Directories</h3>

PS C:\Users\MTanaka\Documents> cd SOPs

PS C:\Users\MTanaka\Documents\SOPs> mkdir "Physical Sec"

Now that we have our directory structure in place. It's time to start populating the files required. Mr. Tanaka asked for a Markdown file in each folder like so:

SOPs > ReadMe.md

Physical Sec > Physical-Sec-draft.md

Cyber Sec > Cyber-Sec-draft.md

Training > Employee-Training-draft.md

In each file, he has requested this header at the top:

Title: Insert Document Title Here

Date: x/x/202x

Author: MTanaka

Version: 0.1 (Draft)

We should be able to quickly knock this out using the New-Item cmdlet and the Add-Content cmdlet.

<h3>Making Files</h3>

PS C:\htb> PS C:\Users\MTanaka\Documents\SOPs> new-Item "Readme.md" -ItemType File

Now that we have our files, we need to add content inside them. We can do so with the Add-Content cmdlet.

<h3>Adding Content</h3>

PS C:\htb> Add-Content .\Readme.md "Title: Insert Document Title Here

We would then perform this same process we did for Readme.md in every other file we created for Mr. Tanaka. This scenario felt a bit tedious, right? Creating files over and over by hand can get tiresome. This is where automation and scripting come into place. It is a bit out of reach right now, but in a later section in this module, we will discuss how to make a quick PowerShell Module, using variables and writing scripts to make things easier.

Scenario Cont.: Mr. Tanaka has asked us to change the name of the file `Cyber-Sec-draft.md` to `Infosec-SOP-draft.md`.

We can quickly knock this task out using the Rename-Item cmdlet. Lets' give it a try:

<h3>Renaming An Object</h3>

PS C:\Users\MTanaka\Documents\SOPs\Cyber Sec> ls

    Directory: C:\Users\MTanaka\Documents\SOPs\Cyber Sec

All we needed to do above was issue the Rename-Item cmdlet, give it the original filename we want to change (Cyber-Sec-draft.md), and then tell it our new name with the -NewName (Infosec-SOP-draft.md) parameter. Seems simple right? We could take this further and rename all files within a directory or change the file type or several different actions. In our example below, we will change the names of all text files in Mr. Tanakas Desktop from file.txt to file.md.

<h3>Files1-5.txt are on MTanaka's Desktop
</h3>

PS C:\Users\MTanaka\Desktop> ls

    Directory: C:\Users\MTanaka\Desktop

Mode LastWriteTime Length Name

---

-a---- 10/13/2022 1:05 PM 0 file-1.txt

-a---- 10/13/2022 1:05 PM 0 file-2.txt

-a---- 10/13/2022 1:06 PM 0 file-3.txt

PS C:\Users\MTanaka\Desktop> get-childitem -Path \*.txt | rename-item -NewName {$\_.name -replace ".txt",".md"}

PS C:\Users\MTanaka\Desktop> ls

As we can see above, we had five text files on the Desktop. We changed them to .md files using get-childitem -Path \*.txt to select the objects and used | to send those objects to the rename-item -NewName {$_.name -replace ".txt",".md"} cmdlet which renames everything from its original name ($\_.name) and replaces the .txt from name to .md. This is a much faster way to interact with files and perform bulk actions. Now that we have completed all of Mr. Tanakas' requests, let us discuss File and Directory permissions for a second.

What are File & Directory Permissions
Permissions, simplified, are our host's way of determining who has access to a specific object and what they can do with it. These permissions allow us to apply granular security control over our objects to maintain a proper security posture. In environments like large organizations with multiple departments (like HR, IT, Sales, etc.), want to ensure they keep information access on a "need to know" basis. This ensures that an outsider cannot corrupt or misuse the data. The Windows file system has many basic and advanced permissions. Some of the key permission types are:

Permission Types Explained

Full Control: Full Control allows for the user or group specified the ability to interact with the file as they see fit. This includes everything below, changing the permissions, and taking ownership of the file.

Modify: Allows reading, writing, and deleting files and folders.

List Folder Contents: This makes viewing and listing folders and subfolders possible along with executing files. This only applies to folders.

Read and Execute: Allows users to view the contents within files and run executables (.ps1, .exe, .bat, etc.)

Write: Write allows a user the ability to create new files and subfolders along with being able to add content to files.

Read: Allows for viewing and listing folders and subfolders and viewing a file's contents.

Traverse Folder: Traverse allows us to give a user the ability to access files or subfolders within a tree but not have access to the higher-level folder's contents. This is a way to provide selective access from a security perspective.

Windows ( NTFS, in general ) allows us to set permissions on a parent directory and have those permissions populate each file and folder located within that directory. This saves us a ton of time compared to manually setting the permissions on each object contained within. This inheritance can be disabled as necessary for specific files, folders, and sub-folders. If done, we will have to set the permissions we want on the affected files manually. Working with permissions can be a complex task and a bit much to do just from the CLI, so we will leave playing with permissions to the Windows Fundamentals Module.

Working with Files and Directories is straightforward, even if sometimes a bit tedious. Moving forward, we will add another layer to our CLI foundation and look at how we can find and filter content within files on the host.

What Cmdlet has an alias of "cat" ?

Get-Content

- 0 What Cmdlet can we use to create new files and folders?

  New-Item

- 0 Using the skills discussed in this section, practice creating, editing, and removing files and directories on the target host provided. Type COMPLETE as the answer below when you are ready to move on.

COMPLETE
