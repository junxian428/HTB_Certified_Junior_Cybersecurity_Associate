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

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Name</th>
      <th>Abbreviation</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>HKEY_LOCAL_MACHINE</td>
      <td>HKLM</td>
      <td>This subtree contains information about the computer's physical state, such as hardware and operating system data, bus types, memory, device drivers, and more.</td>
    </tr>
    <tr>
      <td>HKEY_CURRENT_CONFIG</td>
      <td>HKCC</td>
      <td>This section contains records for the host's current hardware profile (shows the variance between current and default setups). Think of this as a redirection of the HKLM CurrentControlSet profile key.</td>
    </tr>
    <tr>
      <td>HKEY_CLASSES_ROOT</td>
      <td>HKCR</td>
      <td>Filetype information, UI extensions, and backward compatibility settings are defined here.</td>
    </tr>
    <tr>
      <td>HKEY_CURRENT_USER</td>
      <td>HKCU</td>
      <td>Value entries here define the specific OS and software settings for each specific user. Roaming profile settings, including user preferences, are stored under HKCU.</td>
    </tr>
    <tr>
      <td>HKEY_USERS</td>
      <td>HKU</td>
      <td>The default User profile and current user configuration settings for the local computer are defined under HKU.</td>
    </tr>
  </tbody>
</table>

There are other predefined keys for the Registry, but they are specific to certain versions and regional settings in Windows. For more information on those entries and Registry keys in general, check out the documentation provided by Microsoft

<h3>Why Is The Information Stored Within The Registry Important?</h3>

As a pentester, the Registry can be a treasure trove of information that can help us further our engagements. Everything from what software is installed, current OS revision, pertinent security settings, control of Defender, and more can be found in the Registry. Can we find all of this information in other places? Yes. But there is no better single point to find all of it and have the ability to make widespread changes to the host simultaneously. From an offensive perspective, the Registry is hard for Defenders to protect. The hives are enormous and filled with hundreds of entries. Finding a singular change or addition among the hives is like hunting for a needle in a haystack (unless they keep solid backups of their configurations and host states). Having a general understanding of the Registry and where key values are within can help us take action quicker and for defenders spot any issues sooner.

<h3>How Do We Access the Information?</h3>

From the CLI, we have several options to access the Registry and manage our keys. The first is using reg.exe. Reg is a dos executable explicitly made for use in managing Registry settings. The second is using the Get-Item and Get-ItemProperty cmdlets to read keys and values. If we wish to make a change, the use of New-ItemProperty will do the trick.

<h3>Querying Registry Entries</h3>

We will look at using Get-Item and Get-ChildItem first. Below we can see the output from using Get-Item and piping the result to Select-Object.

<h3>Get-Item</h3>

PS C:\htb> Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run | Select-Object -ExpandProperty Property

It's a simple output and only shows us the name of the services/applications currently running. If we wished to see each key and object within a hive, we could also use Get-ChildItem with the -Recurse parameter like so:

<h3>Recursive Search</h3>

PS C:\htb> Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion -Recurse

Hive: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths

Now we snipped the output because it is expanding and showing each key and associated values within the HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion key. We can make our output easier to read using the Get-ItemProperty cmdlet. Let's try that same query but with Get-ItemProperty.

<h3>Get-ItemProperty</h3>

PS C:\htb> Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

Now let's break this down. We issued the Get-ItemProperty command, specified out path as looking into the Registry, and specified the key HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run. The output provides us with the name of the services started and the value that was used to run them (the path they were executed from). This Registry key is used to start services/applications when a user logs in to the host. It is a great key to have visibility over and to keep in mind as a penetration tester. There are several versions of this key which we will discuss a little later in this section. Using Get-ItemProperty is much more readable than Get-Item was. When it comes to querying information, we can also use Reg.exe. Let's take a look at the output from that. We are going to look at a more straightforward key for this example.

<h3>Reg.exe</h3>

PS C:\htb> reg query HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip

We queried the HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip key with Reg.exe, which provided us with the associated values. We can see that two values are set, Path and Path64, the ValueType is a Reg_SZ value which specifies that it contains a Unicode or ASCII string, and that value is the path to 7-Zip C:\Program Files\7-Zip\.

<h3>Finding Info In The Registry</h3>

For us as pentesters and administrators, finding data within the Registry is a must-have skill. This is where Reg.exe really shines for us. We can use it to search for keywords and strings like Password and Username through key and value names or the data contained. Before we put it to use, let's break down the use of Reg Query. We will look at the command string REG QUERY HKCU /F "password" /t REG_SZ /S /K.

- Reg query: We are calling on Reg.exe and specifying that we want to query data.

- HKCU: This portion is setting the path to search. In this instance, we are looking in all of HKey_Current_User.

- /f "password": /f sets the pattern we are searching for. In this instance, we are looking for "Password".

- /t REG_SZ: /t is setting the value type to search. If we do not specify, reg query will search through every type.

- /s: /s says to search through all subkeys and values recursively.

- /k: /k narrows it down to only searching through Key names.

<h3>Searching With Reg Query</h3>

PS C:\htb> REG QUERY HKCU /F "Password" /t REG_SZ /S /K

Our results from this query could be more exciting, but it's still worth taking a look and using a similar search for other keywords and phrases like Username, Credentials, and Keys. We could be surprised by what we find. As we can see, querying registry keys and values is relatively easy. What if we want to set a new value or create a new key?

<h3>Creating and Modifying Registry Keys and Values</h3>

When dealing with the modification or creation of new keys and values, we can use standard PowerShell cmdlets like New-Item, Set-Item, New-ItemProperty, and Set-ItemProperty or utilize Reg.exe again to make the changes we need. Let's try and create a new Registry Key below. For our example, we will create a new test key in the RunOnce hive HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce named TestKey. By placing the key and value in RunOnce, after it executes, it will be deleted.

Scenario: We have landed on a host and can add a new registry key for persistence. We need to set a key named TestKey and a value of C:\Users\htb-student\Downloads\payload.exe that tells RunOnce to run our payload we leave on the host the next time the user logs in. This will ensure that if the host restarts or we lose access, the next time the user logs in, we will get a new shell.

<h3>New Registry Key</h3>

PS C:\htb> New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\ -Name TestKey

We now have a new key within the RunOnce key. By specifying the -Path parameter, we avoid changing our location in the shell to where we want to add a key in the Registry, letting us work from anywhere as long as we specify the absolute path. Let's set a Property and a value now.

<h3>Set New Registry Item Property</h3>

PS C:\htb> New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\TestKey -Name "access" -PropertyType String -Value "C:\Users\htb-student\Downloads\payload.exe"

After using New-ItemProperty to set our value named access and specifying the value as C:\Users\htb-student\Downloads\payload.exe we can see in the results that our value was created successfully, and the corresponding information, such as path location and Key name. Just to show that our key was created, we can see the new key and its values in the image below from the GUI Registry editor.

<h3>TestKey Creation</h3>

<img width="976" height="587" alt="image" src="https://github.com/user-attachments/assets/09dd76c3-b097-4cbe-be4e-4e26f9b10386" />

If we wanted to add the same key/value pair using Reg.exe, we would do so like this:

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce\TestKey" /v access /t REG_SZ /d "C:\Users\htb-student\Downloads\payload.exe"

Now in a real pentest, we would have left an executable payload on the host, and in the instance that the host reboots or the user logs in, we would acquire a new shell to our C2. This value doesn't do much for us right now, so let's practice deleting it.

<h3>Delete Reg properties</h3>

PS C:\htb> Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\TestKey -Name "access"

PS C:\htb> Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\TestKey

If no error window popped up, our key/value pair was deleted successfully. However, this is one of those things you should be extremely careful with. Removing entries from the Windows Registry could negatively affect the host and how it functions. Be sure you know what it is you are removing before. In the wise words of Uncle Ben, "With great power comes great responsibility."

Onwards

Now that we have Registry management down, it's time to move on to handling Event Logs through PowerShell.

A registry entry is made up of two pieces, a 'Key' and ' ' . What is the second piece?

Values

- 0 What is the abbreviation for " HKey_Current_User".

  HKCU

- 0 Take some time to practice adding and modifying the registry. Use the target host as a testbed and type "COMPLETE" as the answer below when you are done.

  COMPLETE
