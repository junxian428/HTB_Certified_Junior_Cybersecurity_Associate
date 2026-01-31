<h3>Writing and Importing Modules</h3>

To install any new Metasploit modules which have already been ported over by other users, one can choose to update their msfconsole from the terminal, which will ensure that all newest exploits, auxiliaries, and features will be installed in the latest version of msfconsole. As long as the ported modules have been pushed into the main Metasploit-framework branch on GitHub, we should be updated with the latest modules.

However, if we need only a specific module and do not want to perform a full upgrade, we can download that module and install it manually. We will focus on searching ExploitDB for readily available Metasploit modules, which we can directly import into our version of msfconsole locally.

ExploitDB is a great choice when searching for a custom exploit. We can use tags to search through the different exploitation scenarios for each available script. One of these tags is Metasploit Framework (MSF), which, if selected, will display only scripts that are also available in Metasploit module format. These can be directly downloaded from ExploitDB and installed in our local Metasploit Framework directory, from where they can be searched and called from within the msfconsole.

<img width="992" height="527" alt="image" src="https://github.com/user-attachments/assets/81bdb48a-5a64-4a8c-9ad0-0495981f4b8f" />

Let's say we want to use an exploit found for Nagios3, which will take advantage of a command injection vulnerability. The module we are looking for is Nagios3 - 'statuswml.cgi' Command Injection (Metasploit). So we fire up msfconsole and try to search for that specific exploit, but we cannot find it. This means that our Metasploit framework is not up to date or that the specific Nagios3 exploit module we are looking for is not in the official updated release of the Metasploit Framework.

<h3>MSF - Search for Exploits</h3>

msf6 > search nagios

We can, however, find the exploit code inside ExploitDB's entries. Alternatively, if we do not want to use our web browser to search for a specific exploit within ExploitDB, we can use the CLI version, searchsploit.

@htb[/htb]$ searchsploit nagios3

Note that the hosted file terminations that end in .rb are Ruby scripts that most likely have been crafted specifically for use within msfconsole. We can also filter only by .rb file terminations to avoid output from scripts that cannot run within msfconsole. Note that not all .rb files are automatically converted to msfconsole modules. Some exploits are written in Ruby without having any Metasploit module-compatible code in them. We will look at one of these examples in the following sub-section.

@htb[/htb]$ searchsploit -t Nagios3 --exclude=".py"

We have to download the .rb file and place it in the correct directory. The default directory where all the modules, scripts, plugins, and msfconsole proprietary files are stored is /usr/share/metasploit-framework. The critical folders are also symlinked in our home and root folders in the hidden ~/.msf4/ location.

<h3>MSF - Directory Structure</h3>

@htb[/htb]$ ls /usr/share/metasploit-framework/

@htb[/htb]$ ls .msf4/

history  local  logos  logs  loot  modules  plugins  store

We copy it into the appropriate directory after downloading the exploit. Note that our home folder .msf4 location might not have all the folder structure that the /usr/share/metasploit-framework/ one might have. So, we will just need to mkdir the appropriate folders so that the structure is the same as the original folder so that msfconsole can find the new modules. After that, we will be proceeding with copying the .rb script directly into the primary location.

Please note that there are certain naming conventions that, if not adequately respected, will generate errors when trying to get msfconsole to recognize the new module we installed. Always use snake-case, alphanumeric characters, and underscores instead of dashes.

For example:

nagios3_command_injection.rb

our_module_here.rb

<h3>MSF - Loading Additional Modules at Runtime</h3>

@htb[/htb]$ cp ~/Downloads/9861.rb /usr/share/metasploit-framework/modules/exploits/unix/webapp/nagios3_command_injection.rb

@htb[/htb]$ msfconsole -m /usr/share/metasploit-framework/modules/

<h3>MSF - Loading Additional Modules</h3>

msf6> loadpath /usr/share/metasploit-framework/modules/

Alternatively, we can also launch msfconsole and run the reload_all command for the newly installed module to appear in the list. After the command is run and no errors are reported, try either the search [name] function inside msfconsole or directly with the use [module-path] to jump straight into the newly installed module.

msf6 > reload_all

msf6 > use exploit/unix/webapp/nagios3_command_injection 

msf6 exploit(unix/webapp/nagios3_command_injection) > show options

Module options (exploit/unix/webapp/nagios3_command_injection):

Now we are ready to launch it against our target.

<h3>Porting Over Scripts into Metasploit Modules</h3>

To adapt a custom Python, PHP, or any type of exploit script to a Ruby module for Metasploit, we will need to learn the Ruby programming language. Note that Ruby modules for Metasploit are always written using hard tabs.

When starting with a port-over project, we do not need to start coding from scratch. Instead, we can take one of the existing exploit modules from the category our project fits in and repurpose it for our current port-over script. Keep in mind to always keep our custom modules organized so that we and other penetration testers can benefit from a clean, organized environment when searching for custom modules.

We start by picking some exploit code to port over to Metasploit. In this example, we will go for Bludit 3.9.2 - Authentication Bruteforce Mitigation Bypass. We will need to download the script, 48746.rb and proceed to copy it into the /usr/share/metasploit-framework/modules/exploits/linux/http/ folder. If we boot into msfconsole right now, we will only be able to find a single Bludit CMS exploit in the same folder as above, confirming that our exploit has not been ported over yet. It is good news that there is already a Bludit exploit in that folder because we will use it as boilerplate code for our new exploit.

<h3>Porting MSF Modules</h3>

@htb[/htb]$ ls /usr/share/metasploit-framework/modules/exploits/linux/http/ | grep bludit

bludit_upload_images_exec.rb

@htb[/htb]$ cp ~/Downloads/48746.rb /usr/share/metasploit-framework/modules/exploits/linux/http/bludit_auth_bruteforce_mitigation_bypass.rb

At the beginning of the file we copied, which is where we will be filling in our information, we can notice the include statements at the beginning of the boilerplate module. These are the mixins mentioned in the Plugins and Mixins section, and we will need to change these to the appropriate ones for our module.

If we want to find the appropriate mixins, classes, and methods required for our module to work, we will need to look up the different entries on the Metasploit Documentation.

<h3>Writing Our Module</h3>

We will often face a custom-built network running proprietary code to serve its clients during specific assessments. Most of the modules we have at hand do not even make a dent in their perimeter, and we cannot seem to scan and document the target with anything we have correctly. This is where we might find it helpful to dust off our Ruby skills and start coding our modules.

All necessary information about Metasploit Ruby coding can be found on the Metasploit Documentation related page. From scanners to other auxiliary tools, from custom-made exploits to ported ones, coding in Ruby for the Framework is an amazingly applicable skill.

Please look below at a similar module that we can use as boilerplate code for our exploit port-over. This is the Bludit Directory Traversal Image File Upload Vulnerability exploit, which has already been imported into msfconsole. Take a moment to acknowledge all the different fields included in the module before the exploit proof-of-concept (POC). Note that this code has not been changed in the snippet below to fit our current import but is a direct snapshot of the pre-existing module mentioned above. The information will need to be adjusted accordingly for the new port-over project.

<h3>Proof-of-Concept - Requirements</h3>

##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

class MetasploitModule < Msf::Exploit::Remote

  Rank = ExcellentRanking

  include Msf::Exploit::Remote::HttpClient
  
  include Msf::Exploit::PhpEXE
  
  include Msf::Exploit::FileDropper
  
  include Msf::Auxiliary::Report

We can look at the include statements to see what each one does. This can be done by cross-referencing them with the Metasploit documentation. Below are their respective functions as explained in the documentation:

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Function</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Msf::Exploit::Remote::HttpClient</td>
      <td>
        Provides methods for acting as an HTTP client when exploiting an HTTP server.
      </td>
    </tr>
    <tr>
      <td>Msf::Exploit::PhpEXE</td>
      <td>
        Generates a first-stage PHP payload that executes a Windows EXE.
      </td>
    </tr>
    <tr>
      <td>Msf::Exploit::FileDropper</td>
      <td>
        Transfers files to the target and handles automatic cleanup after a session is established.
      </td>
    </tr>
    <tr>
      <td>Msf::Auxiliary::Report</td>
      <td>
        Provides methods for reporting and storing data in the Metasploit database.
      </td>
    </tr>
  </tbody>
</table>

Looking at their purposes above, we conclude that we will not need the FileDropper method, and we can drop it from the final module code.

We see that there are different sections dedicated to the info page of the module, the options section. We fill them in appropriately, offering the credit due to the individuals who discovered the exploit, the CVE information, and other relevant details.

<h3>Proof-of-Concept - Module Information</h3>

<img width="1013" height="776" alt="image" src="https://github.com/user-attachments/assets/10a837bf-7294-4895-879d-e6ce23ef5f43" />


After the general identification information is filled in, we can move over to the options menu variables:

<h3>Proof-of-Concept - Functions</h3>

 register_options(
 
      [
      
        OptString.new('TARGETURI', [true, 'The base path for Bludit', '/']),
        
        OptString.new('BLUDITUSER', [true, 'The username for Bludit']),
        
        OptString.new('BLUDITPASS', [true, 'The password for Bludit'])
        
      ])
      
  end

Looking back at our exploit, we see that a wordlist will be required instead of the BLUDITPASS variable for the module to brute-force the passwords for the same username. It would look something like the following snippet:

OptPath.new('PASSWORDS', [ true, 'The list of passwords',
          File.join(Msf::Config.data_directory, "wordlists", "passwords.txt") ])

The rest of the exploit code needs to be adjusted according to the classes, methods, and variables used in the porting to the Metasploit Framework for the module to work in the end. The final version of the module would look like this:

<h3>Proof-of-Concept</h3>

If you would like to learn more about porting scripts into the Metasploit Framework, check out the Metasploit: A Penetration Tester's Guide book from No Starch Press. Rapid7 has also created blog posts on this topic, which can be found here.

