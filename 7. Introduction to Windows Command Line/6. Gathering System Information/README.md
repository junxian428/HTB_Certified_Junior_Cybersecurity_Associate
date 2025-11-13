<h3>Gathering System Information</h3>

Now that we are familiar with navigating our Windows host using nothing but the Command Prompt let us move on to a fundamental concept accessible to both Systems Administrators and Penetration Testers: Gathering System Information.

Gathering system information(aka host enumeration) may seem daunting at first; however, it is a crucial step in providing a good foundation for getting to know our environment. Learning the environment and getting a general feel for our surroundings is beneficial to both sides of the aisle, benefitting the red team and the blue team. Those seated on the red team(Penetration Testers, Red Team Operators, hackers, etc.) will find value in being able to scan their hosts and the environment to learn what vulnerable services and machines can be exploited. Whereas the blue team(System Administrators, SOC Analysts, etc.) can use the information to diagnose issues, secure hosts and services, and ensure integrity across the network. Regardless of which team we might find ourselves most interested in or currently involved in, this section aims to provide the following information:

What information can we gather from the system(host)?

Why do we need this information, and what is the importance of thorough enumeration?

How do we get this information via Command Prompt, and what general methodology should we follow?

<h3>What Types of Information Can We Gather from the System?</h3>

Once we have initial access to the system through some command shell, just knowing where to begin searching the system for information can be difficult. Manually enumerating the system with no path in mind on how we wish to proceed can lead to plenty of lost hours searching through troves of what seems to be important information with little to no results to show for all of that time spent. The goal of host enumeration is to provide an overall picture of the target host, its environment, and how it interacts with other systems across the network. Keeping this in mind, the first question that we might find ourselves coming to is:

How do we know what to look for?

To answer this question, we need to have a basic understanding of all the different types of information available to us on a system. Below is a chart that we can reference to give us a generalized outline of the main types of information we need to be aware of while performing host enumeration.

Note: This example is aimed toward the enumeration of the Windows operating system and may not be fully compatible with other system types. Also, note that this example is a partial list of all information found on a system.

<img width="785" height="770" alt="image" src="https://github.com/user-attachments/assets/f6c04660-98d4-48a2-8d69-ace4bb87c5bd" />

As we can see from the diagram above, the types of information that we would be looking for can be broken down into the following categories:

<table style="width:100%; border-collapse:collapse; font-family:Arial, sans-serif;">
  <thead>
    <tr>
      <th style="text-align:left; padding:8px; border-bottom:2px solid #444;">Type</th>
      <th style="text-align:left; padding:8px; border-bottom:2px solid #444;">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="padding:8px; vertical-align:top; border-bottom:1px solid #ddd;">General System Information</td>
      <td style="padding:8px; vertical-align:top; border-bottom:1px solid #ddd;">
        Contains information about the overall target system. Target system information includes but is not limited to the hostname of the machine, OS-specific details (name, version, configuration, etc.), and installed hotfixes/patches for the system.
      </td>
    </tr>
    <tr>
      <td style="padding:8px; vertical-align:top; border-bottom:1px solid #ddd;">Networking Information</td>
      <td style="padding:8px; vertical-align:top; border-bottom:1px solid #ddd;">
        Contains networking and connection information for the target system and system(s) to which the target is connected over the network. Examples include host IP address, available network interfaces, accessible subnets, DNS server(s), known hosts, and network resources.
      </td>
    </tr>
    <tr>
      <td style="padding:8px; vertical-align:top; border-bottom:1px solid #ddd;">Basic Domain Information</td>
      <td style="padding:8px; vertical-align:top; border-bottom:1px solid #ddd;">
        Contains Active Directory information regarding the domain to which the target system is connected.
      </td>
    </tr>
    <tr>
      <td style="padding:8px; vertical-align:top;">User Information</td>
      <td style="padding:8px; vertical-align:top;">
        Contains information regarding local users and groups on the target system. This can typically be expanded to contain anything accessible to these accounts, such as environment variables, currently running tasks, scheduled tasks, and known services.
      </td>
    </tr>
  </tbody>
</table>


Although this is not an exhaustive list of every single piece of information on a system, this will provide us with the means to begin creating a solid methodology for enumeration. Peering back at the diagram with our newfound knowledge, we can see a pattern emerge as to what we should be looking for while performing enumeration on our target host. To keep ourselves on target during enumeration, we want to try and ask ourselves some of the following questions:

What system information can we pull from our target host?

What other system(s) is our target host interacting with over the network?

What user account(s) do we have access to, and what information is accessible from the account(s)?

Think of these questions as a way to provide structure to help us develop a sense of situational awareness and a methodology for testing. Doing so gives us a clearer idea of what we are looking for and what information needs to be filtered out or prioritized during a real-life engagement.

<h3>Why Do We Need This Information?</h3>

In the previous section, we discussed what information can be gathered from a system during enumeration and what we should be aware of during our search. This section will provide more of the why behind gathering information in the first place and the importance of thorough enumeration of a target.

As stated beforehand, our goal with host enumeration here is to use the information gained from the target to provide us with a starting point and guide for how we wish to attack the system. To gain a better grasp on the concept behind the importance of proper host enumeration, let us follow along with the following example:

Example: Imagine you are tasked with working on an assumed breach engagement and have been provided with initial access through what is assumed to be an unprivileged user account. Your task is to get an overall lay of the land and see if you can escalate your privileges beyond the initial access of the compromised user account.

Following this example scenario, we can see that we are provided direct access to our initial host through an assumed unprivileged user account. However, our goal is to eventually escalate our privileges to an account with access to higher privileges or administrative permissions if we are lucky. To do this, we are going to need a thorough understanding of our environment, including the following:

What user account do we have access to?

What groups does our user belong to?

What current working set of privileges does our user have access to?

What resources can our user access over the network?

What tasks and services are running under our user account?

Remember that this only partially encompasses all the questions we can ask ourselves to reach our intended goal but simply a tiny subset of possibilities. Without thinking things through and failing to follow any guided structure while performing enumeration, we will struggle to know if we have all the required information to reach our goal. It can be easy to write off a system as being completely patched and not vulnerable to any current CVEs or the latest vulnerabilities. However, if you only focus on that aspect, it is easy to miss out on the many human configuration errors that could exist in the environment. This very reason is why taking our time and gathering all of the information we can on a system or environment should be prioritized in terms of importance over simply exploiting a system haphazardly.

<h3>How Do We Get This Information?</h3>
