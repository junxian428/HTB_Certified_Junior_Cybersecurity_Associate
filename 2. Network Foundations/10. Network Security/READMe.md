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

SOURCE:

https://www.pfsense.org/
