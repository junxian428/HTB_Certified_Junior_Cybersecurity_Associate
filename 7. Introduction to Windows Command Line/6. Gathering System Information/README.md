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
