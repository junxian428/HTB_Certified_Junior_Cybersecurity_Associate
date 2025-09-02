<h3>Network Communication</h3>

For a network to function and facilitate communication properly, there are three crucial components: MAC addresses, IP addresses, and ports. Together, these elements ensure that data is correctly sent and received between devices across both local and global networks, forming the backbone of seamless network communication.

MAC Addresses
What is a MAC Address?
A Media Access Control (MAC) address is a unique identifier assigned to the network interface card (NIC) of a device, allowing it to be recognized on a local network. Operating at the Data Link Layer (Layer 2) of the OSI model, the MAC address is crucial for communication within a local network segment, ensuring that data reaches the correct physical device. Each MAC address is 48 bits long and is typically represented in hexadecimal format, appearing as six pairs of hexadecimal digits separated by colons or hyphensfor (e.g., 00:1A:2B:3C:4D:5E). The uniqueness of a MAC address comes from its structure: the first 24 bits represent the Organizationally Unique Identifier (OUI) assigned to the manufacturer, while the remaining 24 bits are specific to the individual device. This design ensures that every MAC address is globally unique, allowing devices worldwide to communicate without address conflicts.

The Windows GETMAC command will return the MAC address of every network interface card on the host.

How MAC Addresses are Used in Network Communication

MAC addresses are fundamental for local communication within a local area network (LAN), as they are used to deliver data frames to the correct physical device. When a device sends data, it encapsulates the information in a frame containing the destination MAC address; network switches then use this address to forward the frame to the appropriate port. Additionally, the Address Resolution Protocol (ARP) plays a crucial role by mapping IP addresses to MAC addresses, allowing devices to find the MAC address associated with a known IP address within the same network. This mapping is bridging the gap between logical IP addressing and physical hardware addressing within the LAN.

Imagine two computers, Computer A (with an IP address of 192.168.1.2, which we will discuss shortly) and Computer B (192.168.1.5), connected to the same network switch. Computer A has the MAC address 00:1A:2B:3C:4D:5E, while Computer B's MAC address is 00:1A:2B:3C:4D:5F. When Computer A wants to send data to Computer B, it first uses the Address Resolution Protocol (ARP) to discover Computer B's MAC address associated with its IP address. After obtaining this information, Computer A sends a data frame with the destination MAC address set to 00:1A:2B:3C:4D:5F. The switch receives this frame and forwards it to the specific port where Computer B is connected, ensuring that the data reaches the correct device. This is illustrated in the following diagram.
