<h3>Network Security</h3>

In networking, the term security refers to the measures taken to protect data, applications, devices, and systems within this network from unauthorized access or damage. The goal is to uphold and maintain the CIA triad:

 <table>
      <caption>Core information security principles</caption>
      <thead>
        <tr>
          <th scope="col">Principle</th>
          <th scope="col">Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Confidentiality</td>
          <td>Only authorized users can view the data.</td>
        </tr>
        <tr>
          <td>Integrity</td>
          <td>The data remains accurate and unaltered.</td>
        </tr>
        <tr>
          <td>Availability</td>
          <td>Network resources are accessible when needed.</td>
        </tr>
      </tbody>
    </table>

In the next paragraphs, we will discuss two critical components of network security: Firewalls and Intrusion Detection/Prevention Systems (IDS/IPS).

<h3>Firewalls</h3>

A Firewall is a network security device, either hardware, software, or a combination of both, that monitors incoming and outgoing network traffic. Firewalls enforce a set of rules (known as firewall policies or access control lists) to determine whether to allow or block specific traffic. We can imagine a firewall as a security guard at the entrance of a building, checking who is allowed in or out based on a list of rules. If a visitor doesn’t meet the criteria (e.g., not on the guest list), they are denied entry.

The open source router/firewall pfSense. Its large number of plugins (known as "Packages") give it a range of capabilities.

Firewalls operate by analyzing packets of data according to predefined rules and policies, commonly focusing on factors such as IP addresses, port numbers, and protocols. This process, known as traffic filtering, is defined by system administrators as permitting or denying traffic based on specific conditions, ensuring that only authorized connections are allowed. Additionally, firewalls can log traffic events and generate alerts about any suspicious activity. Below are some of the different types of firewalls.

1. Packet Filtering Firewall

<table>
<tr>
 <th>Description</th>
</tr>
<tr>
 <td>Operates at Layer 3 (Network) and Layer 4 (Transport) of the OSI model.
</td>
</tr>

<tr>
 <td>Examines source/destination IP, source/destination port, and protocol type.
</td>
</tr>

<tr>
 <td>Example: A simple router ACL that only allows HTTP (port 80) and HTTPS (port 443) while blocking other ports.
</td>
</tr>

</table>

2. Stateful Inspection Firewall

<table>
<tr>
 <th>Description</th>
</tr>
<tr>
 <td>Tracks the state of network connections.
</td>
</tr>

<tr>
 <td>More intelligent than packet filters because they understand the entire conversation.
</td>
</tr>

<tr>
 <td>Example: Only allows inbound data that matches an already established outbound request.
</td>
</tr>

</table>

3. Application Layer Firewall (Proxy Firewall)

<table>
<tr>
 <th>Description</th>
</tr>
<tr>
 <td>Operates up to Layer 7 (Application) of the OSI model.
</td>
</tr>

<tr>
 <td>Can inspect the actual content of traffic (e.g., HTTP requests) and block malicious requests.
</td>
</tr>

<tr>
 <td>Example: A web proxy that filters out malicious HTTP requests containing suspicious patterns.
</td>
</tr>

</table>

4. Next-Generation Firewall (NGFW)

<table>
<tr>
 <th>Description</th>
</tr>
<tr>
 <td>Combines stateful inspection with advanced features like deep packet inspection, intrusion detection/prevention, and application control.
</td>
</tr>

<tr>
 <td>Example: A modern firewall that can block known malicious IP addresses, inspect encrypted traffic for threats, and enforce application-specific policies.
</td>
</tr>

</table>

Firewalls stand between the internet and the internal network, examining traffic before letting it through. In a home environment, our router/modem often has a built-in firewall (software-based). In that case, it’s all in one device, and the firewall function is inside the router. In larger networks (e.g., business environments), the firewall is often a separate device placed after the modem/router and before the internal network, ensuring all traffic must pass through it.

<h3>Intrusion Detection and Prevention Systems (IDS/IPS)</h3>

Intrusion Detection and Prevention Systems (IDS/IPS) are security solutions designed to monitor and respond to suspicious network or system activity. An Intrusion Detection System (IDS) observes traffic or system events to identify malicious behavior or policy violations, generating alerts but not blocking the suspicious traffic. In contrast, an Intrusion Prevention System (IPS) operates similarly to an IDS but takes an additional step by preventing or rejecting malicious traffic in real time. The key difference lies in their actions: an IDS detects and alerts, while an IPS detects and prevents.

The widely used Suricata software can function as both an IDS and an IPS. Here, we see the user enable a detection rule, then begin inline monitoring. GIF showcasing the rule enablement in Suricata.

Both IDS and IPS solutions analyze network packets and compare them to known attack signatures or typical traffic patterns. This process involves:

 <table>
    <caption>Intrusion Detection Techniques</caption>
    <thead>
      <tr>
        <th>Technique</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Signature-based detection</td>
        <td>Matches traffic against a database of known exploits.</td>
      </tr>
      <tr>
        <td>Anomaly-based detection</td>
        <td>Detects anything unusual compared to normal activity.</td>
      </tr>
    </tbody>
  </table>

When suspicious or malicious behavior is identified, an IDS will generate an alert for further investigation, while an IPS goes one step further by blocking or rejecting the malicious traffic in real time.

Suricata in IDS mode.

Below are some of the different types of firewalls IDS/IPS.

1. Network-Based IDS/IPS (NIDS/NIPS)

   Description

   Hardware device or software solution placed at strategic points in the network to inspect all passing traffic.

   Example: A sensor connected to the core switch that monitors traffic within a data center.

2. Host-Based IDS/IPS (HIDS/HIPS)

   Description

   Runs on individual hosts or devices, monitoring inbound/outbound traffic and system logs for suspicious behavior on that specific machine.

   Example: An antivirus or endpoint security agent installed on a server.

IDS/IPS can be placed at several strategic locations in a network. One option is to position them behind the firewall, where the firewall filters obvious threats, and the IDS/IPS inspects any remaining traffic. Another common placement is in the DMZ (Demilitarized Zone), a separate network segment within the larger network directly exposed to the internet, where they monitor traffic moving in and out of publicly accessible servers. Finally, IDS/IPS solutions can also run directly on endpoint devices, such as servers or workstations, to detect suspicious activity at the host level. The following diagram shows an IDS/IPS positioned after the firewall.

<h3>Best Practices</h3>

Here are the best practices for enhancing network security, summarized in the following table:

 <table>
    <caption>Firewall & IDS/IPS Best Practices</caption>
    <thead>
      <tr>
        <th>Practice</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Define Clear Policies</td>
        <td>Consistent firewall rules based on the principle of least privilege (only allow what is necessary).</td>
      </tr>
      <tr>
        <td>Regular Updates</td>
        <td>Keep firewall, IDS/IPS signatures, and operating systems up to date to defend against the latest threats.</td>
      </tr>
      <tr>
        <td>Monitor and Log Events</td>
        <td>Regularly review firewall logs, IDS/IPS alerts, and system logs to identify suspicious patterns early.</td>
      </tr>
      <tr>
        <td>Layered Security</td>
        <td>Use defense in depth (a strategy that leverages multiple security measures to slow down an attack) with multiple layers: Firewalls, IDS/IPS, antivirus, and endpoint protection to cover different attack vectors.</td>
      </tr>
      <tr>
        <td>Periodic Penetration Testing</td>
        <td>Test the effectiveness of the security policies and devices by simulating real attacks.</td>
      </tr>
    </tbody>
  </table>


SOURCE:

https://www.pfsense.org/

https://suricata.io/
