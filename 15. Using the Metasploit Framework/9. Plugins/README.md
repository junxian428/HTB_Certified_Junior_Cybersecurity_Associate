<h3>Plugins</h3>

Plugins are readily available software that has already been released by third parties and have given approval to the creators of Metasploit to integrate their software inside the framework. These can represent commercial products that have a Community Edition for free use but with limited functionality, or they can be individual projects developed by individual people.

The use of plugins makes a pentester's life even easier, bringing the functionality of well-known software into the msfconsole or Metasploit Pro environments. Whereas before, we needed to cycle between different software to import and export results, setting options and parameters over and over again, now, with the use of plugins, everything is automatically documented by msfconsole into the database we are using and hosts, services and vulnerabilities are made available at-a-glance for the user. Plugins work directly with the API and can be used to manipulate the entire framework. They can be useful for automating repetitive tasks, adding new commands to the msfconsole, and extending the already powerful framework.

<h3>Using Plugins</h3>

To start using a plugin, we will need to ensure it is installed in the correct directory on our machine. Navigating to /usr/share/metasploit-framework/plugins, which is the default directory for every new installation of msfconsole, should show us which plugins we have to our availability:

htb[/htb]$ ls /usr/share/metasploit-framework/plugins

If the plugin is found here, we can fire it up inside msfconsole and will be met with the greeting output for that specific plugin, signaling that it was successfully loaded in and is now ready to use:

<h3>MSF - Load Nessus</h3>

msf6 > load nessus

msf6 > nessus_help

If the plugin is not installed correctly, we will receive the following error upon trying to load it.

msf6 > load Plugin_That_Does_Not_Exist

To start using the plugin, start issuing the commands available to us in the help menu of that specific plugin. Each cross-platform integration offers us a unique set of interactions that we can use during our assessments, so it is helpful to read up on each of these before employing them to get the most out of having them at our fingertips.

<h3>Installing new Plugins</h3>

New, more popular plugins are installed with each update of the Parrot OS distro as they are pushed out towards the public by their makers, collected in the Parrot update repo. To install new custom plugins not included in new updates of the distro, we can take the .rb file provided on the maker's page and place it in the folder at /usr/share/metasploit-framework/plugins with the proper permissions.

For example, let us try installing DarkOperator's Metasploit-Plugins. Then, following the link above, we get a couple of Ruby (.rb) files which we can directly place in the folder mentioned above.

<h3>Downloading MSF Plugins</h3>

@htb[/htb]$ git clone https://github.com/darkoperator/Metasploit-Plugins

@htb[/htb]$ ls Metasploit-Plugins

Here we can take the plugin pentest.rb as an example and copy it to /usr/share/metasploit-framework/plugins.

<h3>MSF - Copying Plugin to MSF</h3>

@htb[/htb]$ sudo cp ./Metasploit-Plugins/pentest.rb /usr/share/metasploit-framework/plugins/pentest.rb

Afterward, launch msfconsole and check the plugin's installation by running the load command. After the plugin has been loaded, the help menu at the msfconsole is automatically extended by additional functions.

<h3>MSF - Load Plugin</h3>

@htb[/htb]$ msfconsole -q

msf6 > load pentest

Many people write many different plugins for the Metasploit framework. They all have a specific purpose and can be an excellent help to save time after familiarizing ourselves with them. Check out the list of popular plugins below:

nMap (pre-installed)	NexPose (pre-installed)	Nessus (pre-installed)

Mimikatz (pre-installed V.1)	Stdapi (pre-installed)	Railgun

Priv	Incognito (pre-installed)	Darkoperator's

<h3>Mixins</h3>

The Metasploit Framework is written in Ruby, an object-oriented programming language. This plays a big part in what makes msfconsole excellent to use. Mixins are one of those features that, when implemented, offer a large amount of flexibility to both the creator of the script and the user.

Mixins are classes that act as methods for use by other classes without having to be the parent class of those other classes. Thus, it would be deemed inappropriate to call it inheritance but rather inclusion. They are mainly used when we:

1. Want to provide a lot of optional features for a class.

2. Want to use one particular feature for a multitude of classes.

Most of the Ruby programming language revolves around Mixins as Modules. The concept of Mixins is implemented using the word include, to which we pass the name of the module as a parameter. We can read more about mixins here.

If we are just starting with Metasploit, we should not worry about the use of Mixins or their impact on our assessment. However, they are mentioned here as a note of how complex the customization of Metasploit can become.
