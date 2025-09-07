<h3>Skills Assessment</h3>

Now that we're familiar with the foundational concepts of computer networking, it's time to apply them in a real-world scenario. In this guided assessment, we'll explore the networking behind HTB Academy's lab environments. The assessment is divided into three chapters, but only the first two are required to complete the challenge questions and finish the assessment. The third chapter is optional for those who want to explore further.

Keep me in the Loop

For the first chapter of this assessment, we will be showcasing the HTB Academy Pwnbox --- a fully functional Linux machine running Parrot OS, accessible entirely through a web browser. We provide it to our students to serve as their workstation when completing the various exercises and labs available on our platform. If you've never used Linux before, have no fear. Everything will be completely guided. When you are ready to begin, scroll down to select your Pwnbox location, and click Launch Instance.

Once the Pwnbox is up and running, feel free to press the Full Screen button for more visibility. Then, use your mouse cursor to open the Parrot Terminal as shown in the example below.

Launching the Parrot Terminal

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

Keep me in the Loop

netstat tulp4

When we remove the -n option, the output will be displayed as "hostname:service" rather than "IP:PORT". We can see that the loopback IP address is resolved to localhost. The ens3 IP address is resolved to the hostname of the Pwnbox. Also, it is worthwhile to note that a service listening on 0.0.0.0 is listening on all interfaces.

With this information, we now have some insight as to how we are able to see, and interact, with the Pwnbox. Earlier in the module we learned that protocol used when browsing websites is HTTP, via the well-known port 80. As we can see, the Pwnbox is indeed listening on port 80. This explains how we are able to make a connection via web browser. Subsequently, we can state with confidence that the IP tied to the ens3 interface is the public IP address of the Pwnbox. Remember, public IP's can be accessed over the internet.

We also see the VNC service running on the loopback address. VNC (Virtual Network Computing) is a protocol used for remote screen sharing and remote access. Since students can access the Pwnbox desktop environment through their web browser, there is likely some form of port forwarding in place. This would allow traffic sent over HTTP to be forwarded to the VNC service running on the loopback address.

Port forwarding is a technique that allows traffic sent to one TCP/UDP port to be redirected to another—even across different machines. This also another way the loopback address can be utilized. For example, in the scenario below, a Windows host forwards its local port 8888 to a Linux VM's SSH port (22). The Linux machine is running as a virtual machine with NAT enabled, meaning it does not have a directly accessible IP on the network. Instead, the Windows host acts as an intermediary, forwarding traffic to it.

Note that the topic of port forwarding is beyond the scope of this module. However, it is certainly something to be aware of, and is a wonderful example of the power and possibilities available through computer networking. Now that we've investigated the lo interface (and the ens3 interface in the process), tun0 is all that remains. And with that, we conclude chapter one.

SOURCE:

https://www.virtualbox.org/manual/ch06.html#network_nat
