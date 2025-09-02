Bash is the scripting language we use to communicate with Unix-based OS and give commands to the system. Since May 2019, Windows provides a Windows Subsystem for Linux that allows us to use Bash in a Windows environment. It is essential to master the language to work efficiently with it. The main difference between scripting and programming languages is that we don't need to compile the code to execute the scripting language, as opposed to programming languages.

As penetration testers, we must be able to work with any operating system, whether it is Windows or Unix-based. Efficiency depends mainly on the knowledge of the systems, especially in the privilege escalation field. On Unix-based systems, it is essential to learn how to use the terminal, filter data, and automate these processes. Especially in large Unix-based enterprise networks, we will have to deal with large amounts of data. We have to sort and filter out accordingly to determine potential gaps and information as fast as possible.

It is also essential to learn how to combine several commands and work with individual results. This is where scripting comes in, increasing our speed and efficiency. Like a programming language, a scripting language has almost the same structure, which can be divided into:

- Input & Output

- Arguments, Variables & Arrays

- Conditional execution

- Arithmetic

- Loops

- Comparison operators

- Functions

It is often common to automate some processes not to repeat them all the time or process and filter a large amount of information. In general, a script does not create a process, but it is executed by the interpreter that executes the script, in this case, the Bash. To execute a script, we have to specify the interpreter and tell it which script it should process. Such a call looks like this:

Let us look at such a script and see how they can be created to get specific results. If we execute this script and specify a domain, we see what information this script provides.

<img width="1039" height="448" alt="image" src="https://github.com/user-attachments/assets/7f4ace4e-5c15-4c74-ae5c-0a3a9a833eae" />

As we can see, we have commented here several parts of the script into which we can split it.

Check for given arguments

Identify network range for the specified IP address(es)

Ping discovered IP address(es)

Identify IP address(es) of the specified domain

Available options

1. Check for given arguments

   In the first part of the script, we have an if-else statement that checks if we have specified a domain representing the target company.

2. Identify network range for the specified IP address(es)

   Here we have created a function that makes a "whois" query for each IP address and displays the line for the reserved network range, and stores it in the CIDR.txt.

3. Ping discovered IP address(es)

   This additional function is used to check if the found hosts are reachable with the respective IP addresses. With the For-Loop, we ping every IP address in the network range and count the results.

4. Identify IP address(es) of the specified domain

   As the first step in this script, we identify the IPv4 address of the domain returned to us.

5. Available Options

   Then we decide which functions we want to use to find out more information about the infrastructure.
