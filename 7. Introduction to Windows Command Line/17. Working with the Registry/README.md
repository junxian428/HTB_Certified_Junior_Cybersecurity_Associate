<h3>Working with the Registry</h3>

We should be comfortable with the CLI at this point. It's time to level our skills again and tackle one of the more complicated aspects of the Windows operating system, the Registry. This section will walk us through what the Registry is, how to navigate it, and how to read key/value pairs and make changes to it as needed.

<h3>What Is The Windows Registry?</h3>

At its core, the Registry can be considered a hierarchal tree that contains two essential elements: keys and values. This tree stores all the required information for the operating system and the software installed to run under subtrees (think of them as branches of a tree). This information can be anything from settings to installation directories to specific options and values that determine how everything functions. As Pentesters, the Registry is a great spot to find helpful information, plant persistence, and more. MITRE provides many great examples of what a threat actor can do with access (locally or remotely) to a host's registry hive.

<h3>What are Keys</h3>

Keys, in essence, are containers that represent a specific component of the PC. Keys can contain other keys and values as data. These entries can take many forms, and naming contexts only require that a Key be named using alphanumeric (printable) characters and is not case-sensitive. As a visual example of Keys, if we look at the image below, each folder within the Green rectangle is a Key and contains sub-keys.

<h3>Keys (Green)</h3>

<img width="713" height="528" alt="image" src="https://github.com/user-attachments/assets/2607e8e1-bb12-43c8-a72e-d2d29e0caff8" />

Registry Key Files

A host systems Registry root keys are stored in several different files and can be accessed from C:\Windows\System32\Config\. Along with these Key files, registry hives are held throughout the host in various other places.

Root Registry Keys

PS C:\htb> Get-ChildItem C:\Windows\System32\config\

For a detailed list of all Registry Hives and their supporting files within the OS, we can look HERE. Now let's discuss Values within the Registry.

<h3>What Are Values</h3>

Values represent data in the form of objects that pertain to that specific Key. These values consist of a name, a type specification, and the required data to identify what it's for. The image below visually represents Values as the data between the Orange lines. Those values are nested within the Installer key, which is, in turn, inside another key.

<h3>Values</h3>


<img width="728" height="424" alt="image" src="https://github.com/user-attachments/assets/5ea7ac30-fdc6-46be-9302-31cc57a2666b" />

We can reference the complete list of Registry Key Values HERE. In all, there are 11 different value types that can be configured.

https://learn.microsoft.com/en-us/windows/win32/sysinfo/registry-value-types

<h3>Registry Hives</h3>

Each Windows host has a set of predefined Registry keys that maintain the host and settings required for use. Below is a breakdown of each hive and what can be found referenced within.

<h3>Hive Breakdown</h3>
