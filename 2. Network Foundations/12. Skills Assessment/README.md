<h3>Skills Assessment</h3>

Now that we're familiar with the foundational concepts of computer networking, it's time to apply them in a real-world scenario. In this guided assessment, we'll explore the networking behind HTB Academy's lab environments. The assessment is divided into three chapters, but only the first two are required to complete the challenge questions and finish the assessment. The third chapter is optional for those who want to explore further.

<h3>Chapter 1. - Keep me in the Loop</h3>

Keep me in the Loop

For the first chapter of this assessment, we will be showcasing the HTB Academy Pwnbox --- a fully functional Linux machine running Parrot OS, accessible entirely through a web browser. We provide it to our students to serve as their workstation when completing the various exercises and labs available on our platform. If you've never used Linux before, have no fear. Everything will be completely guided. When you are ready to begin, scroll down to select your Pwnbox location, and click Launch Instance.

Once the Pwnbox is up and running, feel free to press the Full Screen button for more visibility. Then, use your mouse cursor to open the Parrot Terminal as shown in the example below.

<h4>Launching the Parrot Terminal</h4>

We will start by investigating the network interfaces available on the Pwnbox. Type the following command into the terminal and press enter.

Code: shell

ifconfig -a

The ifconfig tool is used to configure network interfaces and display their current status. By default, it only shows active interfaces, but using the -a flag will display all interfaces, including those that are currently down. After running the command, we should see three interfaces: ens3, lo, and tun0, along with a detailed output. Take a few moments to review the information and note any similarities or differences between the interfaces. Don't worry if some of it isn't clear yet. Everything will make more sense as we continue.

There is certainly a lot to unpack. We see three unique IPv4 addresses. We see some IPv6 addresses as well. However, one interface in particular stands out from the rest. Something seems very different about the lo interface.

What we are looking at is known as the loopback address, and it is always associated to the IPv4 address 127.0.0.1. It's the IP address used when a device needs to send network data to itself. You may be wondering what purpose this serves; there are actually several. It's often used for testing, as a way to make sure an application is working as intended before going live on the network. It is also used by servers to keep certain services hidden from outside users. Think of an e-commerce website that utilizes authentication with its clients (i.e. registered acounts with usernames and passwords). Credentials and session cookies are typically stored in a database. Rather than have the database exposed to the public, it instead can only be accessed by the server itself. When a user attempts to log into the website, the website acts as an API between the user and the database. The server queries its own database to retrieve information on behalf of the end user.

Let's see if the Pwnbox makes use of the loopback address. In your terminal, enter the following command:

netstat -tulnp4

The netstat utility displays network connections, routing tables, and interface statistics. With the options shown above, it lists all open or listening TCP and UDP ports for IPv4 in the format "IP:PORT". If permissions allow, it may also show the name of the program responsible for each open port. Take a moment to review the output. Do you notice any services running on the loopback address?

Now, try running the command shown below.

netstat tulp4

When we remove the -n option, the output will be displayed as "hostname:service" rather than "IP:PORT". We can see that the loopback IP address is resolved to localhost. The ens3 IP address is resolved to the hostname of the Pwnbox. Also, it is worthwhile to note that a service listening on 0.0.0.0 is listening on all interfaces.

With this information, we now have some insight as to how we are able to see, and interact, with the Pwnbox. Earlier in the module we learned that protocol used when browsing websites is HTTP, via the well-known port 80. As we can see, the Pwnbox is indeed listening on port 80. This explains how we are able to make a connection via web browser. Subsequently, we can state with confidence that the IP tied to the ens3 interface is the public IP address of the Pwnbox. Remember, public IP's can be accessed over the internet.

We also see the VNC service running on the loopback address. VNC (Virtual Network Computing) is a protocol used for remote screen sharing and remote access. Since students can access the Pwnbox desktop environment through their web browser, there is likely some form of port forwarding in place. This would allow traffic sent over HTTP to be forwarded to the VNC service running on the loopback address.

Port forwarding is a technique that allows traffic sent to one TCP/UDP port to be redirected to another—even across different machines. This also another way the loopback address can be utilized. For example, in the scenario below, a Windows host forwards its local port 8888 to a Linux VM's SSH port (22). The Linux machine is running as a virtual machine with NAT enabled, meaning it does not have a directly accessible IP on the network. Instead, the Windows host acts as an intermediary, forwarding traffic to it.

Note that the topic of port forwarding is beyond the scope of this module. However, it is certainly something to be aware of, and is a wonderful example of the power and possibilities available through computer networking. Now that we've investigated the lo interface (and the ens3 interface in the process), tun0 is all that remains. And with that, we conclude chapter one.

<h3>Chapter 2. - Having Tuns of Fun</h3>

At the beginning of chapter one, we mentioned that the Pwnbox is used to interact with target machines in our lab environments. At the end of chapter one, we successfully investigated two out of the three available network interfaces:

- Loopback (lo): Allows the Pwnbox to send network traffic to itself.

- Public IP (ens3): Enables the Pwnbox to communicate with us over the internet.

That leaves one remaining interface: tun0. Based on its name, we can infer that it’s a tunnel interface, commonly associated with VPNs (Virtual Private Networks). Since lab targets exist on a separate private network, the Pwnbox must establish a secure connection to that environment, enabling us to reach them.

Let's confirm this by checking which route the Pwnbox takes to communicate with the target. Scroll to the end of this section and press Click here to spawn the target system!. After a few moments, a target machine will spawn, and we will be given its IP address.

Then, return to the Pwnbox and enter the following command into the Parrot Terminal:

ip route get <target ip>

This command will display the route taken for any traffic sent from the Pwnbox to reach the target.

Our theory has been confirmed—all traffic to the target is routed through tun0, a VPN tunnel that connects the Pwnbox to the private lab network. This allows us to interact with lab machines as if they were on the same local network. By using a VPN configuration file and software such as OpenVPN, computers will connect to the VPN server, which provides access to the network. HTB Academy's VPN is available to download at https://academy.hackthebox.com/vpn, for those who prefer to use their own workstation rather than Pwnbox.

Let's begin our first interaction with the target machine. We typically always begin by using ping. The ping is a networking utility used to test the reachability of a host on a network. It does not use TCP or UDP ports, making it a Layer 3 protocol in terms of the OSI model. Type the following command into your terminal and observe the output.

ping -c 4 <target ip>

Here, we are sending four pings towards our target. Note that in Linux, if we do not specify the ping count, it will send pings indefinitely until we press Ctrl + C into the terminal.

We've now confirmed that the target is reachable from our attack host. A few things to take note of are the ttl and the time. The ttl , which stands for time-to-live, tells us how many "hops" our packets are allowed to take in order to reach the target. This rarely applies to devices on the same local network as us, but rather devices on the internet that require our packets to hop through multiple routers in order to reach their intended destination. The information next to time gives us an idea of how much latency there is on the network. In this example above, we see each ping takes roughly 71 milliseconds.

We have just confirmed that our attack host can communicate with the target, by pinging the IP address of the target machine. Our next step is to enumerate open TCP/UDP ports on the machine. Just as we used the netstat utility to view the open ports on the Pwnbox, there is another tool we can use to determine the open ports on a remote machine. This tool is nmap, and it is absolutely fundamental for any current or aspiring infosec professional. Let's begin by enumerating the open TCP ports on our target. Enter the following command into your terminal.

nmap <target IP>

After a few moments, we will see nmap return the open TCP ports present on the target.

We see several open ports available. Ports 135,139,and 445 will typically always be open on a Windows-based host. Port 3389 is the port used for Remote Desktop Protocol, or RDP for short. It is another common service seen on Windows machines. Port 5357 is used for Microsoft's Web Services for Devices API - another Windows protocol, used for device discovery on the network.

We've now come to a thorough understanding of the three network interfaces of the Pwnbox and have verified that we can interact with the target machine. With that, Chapter Two concludes. You're now ready to complete the challenge questions and assessment.

If you'd like to continue further, Chapter Three is optional and will guide you through interacting with the target machine using specific ports and protocols.

<h3> Chapter 3. - Target Acquired (OPTIONAL)</h3>

- 2 What IPv4 address is used when a host wants to send and receive network traffic to itself?

  127.0.0.1

- 2 What is the the name of the Program listening on localhost:5901 of the Pwnbox?

Xtigervnc

- 2 Which network interface allows us to interact with target machines in the HTB lab environment?

tun0

- 2 What command-line tool is used to configure network interfaces and display their current status?

ifconfig

- 2 What command-line tool is used to display network connections, routing information, and interface statistics?

netstat

Optional Exercises

Challenge your understanding of the Module content and answer the optional question(s) below. These are considered supplementary content and are not required to complete the Module. You can reveal the answer at any time to check your work.

Target(s): XXX (ACADEMY-NETFOUNDATION-WINDOWS)

Life Left: 107 minute(s)

What is the FTP command used to retrieve a file? (Format: XXXX)
RETR

Bypass the request filtering found on the target machine's HTTP service, and submit the flag found in the response. The flag will be in the format: HTB{...}

HTB{S00n_2_B_N3tw0rk1ng_GURU!}

SOURCE:

https://www.virtualbox.org/manual/ch06.html#network_nat
