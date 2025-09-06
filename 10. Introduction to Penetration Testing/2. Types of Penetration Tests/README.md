<h3>Types of Penetration Tests</h3>

Penetration tests are a critical part of any strong security strategy and can be classified in several ways, each offering unique insights into an organization’s cybersecurity posture. One of the most prevalent methods of classification is based on the amount and type of information given to the tester- commonly known as Black Box, White Box, or Grey Box testing. This approach helps tailor the test to the organization’s specific needs, defines the scope and depth of the assessment, and mimics various real-world attack scenarios.

To illustrate these concepts, let's consider a real-world example of a penetration test conducted on a mid-sized financial institution:

A large financial institution, concerned about growing cyber threats and potential security gaps, hired a well-known cybersecurity firm to perform a thorough penetration test. The goal was to uncover weaknesses in their systems before attackers could exploit them. The cybersecurity team evaluated the security of the bank's online banking platform, internal networks, and physical security controls, such as access to server rooms and critical infrastructure. To ensure a realistic assessment, the team used multiple testing approaches:

Black Box Testing

The team began with a black box test, simulating an external attacker with no prior knowledge of the bank's systems. They attempted to gain unauthorized access to the online banking platform by exploiting public-facing vulnerabilities. This phase revealed several critical issues, including an outdated SSL certificate and a SQL injection vulnerability in the login page.

White Box Testing

Next, the team conducted a white box test with full access to the bank's network architecture, source code, and system configurations. This insider perspective allowed them to identify misconfigurations in the firewall rules, weak password policies for internal systems, and unpatched software on several servers.

Gray Box Testing

Finally, a gray box test was performed, simulating a scenario where an attacker had gained limited internal access. With partial knowledge of the network, the team discovered an unsecured Wi-Fi network in a branch office and exploited it to gain further access to the internal network.

These types of penetration tests differ primarily based on the amount of information provided by the target organization to the testing team.

In addition to technical assessments, the penetration test incorporated social engineering exercises with physical security evaluations to assess human-centric vulnerabilities. Through a series of carefully planned attempts, the testing team demonstrated multiple ways of exploiting the human element of the organization's defense. Most notably, they successfully circumvented physical access controls by employing a tailgating technique, following closely behind an authorized employee to gain entry into restricted areas.

During their unauthorized access, the team documented numerous security violations, including multiple instances of sensitive documentation being left exposed, software credentials written on whiteboards in magic marker, and unattended on workstations, highlighting significant gaps in the organization's clean desk policy and overall security awareness.

This comprehensive approach allowed the financial institution to identify and address vulnerabilities across their entire security infrastructure, from external-facing systems to internal processes and employee awareness. The results of the test led to significant improvements in the bank's overall security posture, including enhanced network segmentation, updated security policies, and increased employee training on security best practices.

Another classification is based on the perspective of the test:

External testing focuses on assets and services that are publicly accessible via the internet, including but not limited to web servers, email servers, DNS servers, and other externally-facing infrastructure components. This type of testing simulates how an attacker might attempt to breach an organization's defenses from the outside, evaluating the security of internet-facing systems and identifying potential vulnerabilities that could be exploited by malicious actors operating remotely.

Internal testing, on the other hand, is conducted from within the organization's network infrastructure. Unlike a hacker shielded by the anonymity of the internet, this type of testing simulates attacks that could be initiated by malicious insiders with legitimate access, or external threat actors who have successfully breached the network's perimeter defenses. Internal testing provides valuable insight, exposing the possible attack vectors available to those with a pre-existing foothold to the network (such as through compromised credentials, social engineering, or other means of unauthorized access.)

Questions
Answer the question(s) below to complete this Section and earn cubes!

- 1 Which type of a penetration test do we simulate with no prior knowledge of company's infrastructure? (Format: two words))

Black Box

SOURCE: https://www.enisa.europa.eu/publications/enisa-threat-landscape-2024
