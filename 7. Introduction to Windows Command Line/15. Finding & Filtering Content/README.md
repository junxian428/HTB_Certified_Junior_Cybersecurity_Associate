<h3>Finding & Filtering Content</h3>

Being able to search for, find, and filter content for what we are looking for is an absolute requirement for any user who utilizes the CLI ( regardless of what shell or OS ). Nevertheless, how do we do this in PowerShell? To answer this question, this section will dive into specifics of how PowerShell utilizes Objects, how we can filter based on Properties and content, and describe components like the PowerShell Pipeline further.

<h3>Explanation of PowerShell Output (Objects Explained)</h3>

With PowerShell, not everything is generic text strings like in Bash or cmd. In PowerShell, everything is an Object. However, what is an object? Let us examine this concept further:

What is an Object? An object is an individual instance of a class within PowerShell. Let us use the example of a computer as our object. The total of everything (parts, time, design, software, etc.) makes a computer a computer.

What is a Class? A class is the schema or 'unique representation of a thing (object) and how the sum of its properties define it. The blueprint used to lay out how that computer should be assembled and what everything within it can be considered a Class.

What are Properties? Properties are simply the data associated with an object in PowerShell. For our example of a computer, the individual parts that we assemble to make the computer are its properties. Each part serves a purpose and has a unique use within the object.

What are Methods? Simply put, methods are all the functions our object has. Our computer allows us to process data, surf the internet, learn new skills, etc. All of these are the methods for our object.

Now, we defined these terms so that we understand all the different properties we will be looking at later and what methods of interaction we have with objects. By understanding how PowerShell interprets objects and utilizes Classes, we can define our own object types. Moving on, we will look at how we can filter and find objects through the PowerShell CLI.

<h3>Finding and Filtering Objects</h3>

Let us look at this through a user object context. A user can do things like access files, run applications, and input/output data. But what is a user? What is it made up of?

<h3>Get an Object (User) and its Properties/Methods</h3>

PS C:\htb> Get-LocalUser administrator | get-member

Now that we can see all of a user's properties let us look at what those properties look like when output by PowerShell. The Select-Object cmdlet will help us achieve this. In this manner, we now understand what makes up a user object.

<h3>Property Output (All)</h3>

PS C:\htb> Get-LocalUser administrator | Select-Object -Property *

A user is a small object realistically, but it can be a lot to look at the output in this manner, especially from items like large lists or tables. So what if we wanted to filter this content down or show it to us in a more precise manner? We could filter out the properties of an object we do not want to see by selecting the few we do. Let's look at our users and see which have set a password recently.

<h3>Filtering on Properties</h3>