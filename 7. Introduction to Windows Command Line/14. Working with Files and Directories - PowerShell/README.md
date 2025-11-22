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
