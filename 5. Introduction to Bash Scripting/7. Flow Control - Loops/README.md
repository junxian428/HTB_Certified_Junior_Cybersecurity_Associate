<h3>Flow Control - Loops</h3>

The control of the flow of our scripts is essential. We have already learned about the if-else conditions, which are also part of flow control. After all, we want our script to work quickly and efficiently, and for this, we can use other components to increase efficiency and allow error-free processing. Each control structure is either a branch or a loop. Logical expressions of boolean values usually control the execution of a control structure. These control structures include:

Branches:

- If-Else Conditions

- Case Statements

Loops:

- For Loops

- While Loops

- Until Loops

<h3>For Loops</h3>

Let us start with the For loops. The For loop is executed on each pass for precisely one parameter, which the shell takes from a list, calculates from an increment, or takes from another data source. The for loop runs as long as it finds corresponding data. This type of loop can be structured and defined in different ways. For example, the for loops are often used when we need to work with many different values from an array. This can be used to scan different hosts or ports. We can also use it to execute specific commands for known ports and their services to speed up our enumeration process. The syntax for this can be as follows:

<h3>Syntax - Examples</h3>

for variable in 1 2 3 4

do

echo $variable

done

---

for variable in file1 file2 file3

do

echo $variable

done

---

for ip in "10.10.10.170 10.10.10.174 10.10.10.175"

do

ping -c 1 $ip

done

Of course, we can also write these commands in a single line. Such a command would look like this:

@htb[/htb]$ for ip in 10.10.10.170 10.10.10.174;do ping -c 1 $ip;done

PING 10.10.10.170 (10.10.10.170): 56 data bytes

64 bytes from 10.10.10.170: icmp_seq=0 ttl=63 time=42.106 ms

--- 10.10.10.170 ping statistics ---

1 packets transmitted, 1 packets received, 0.0% packet loss

round-trip min/avg/max/stddev = 42.106/42.106/42.106/0.000 ms

PING 10.10.10.174 (10.10.10.174): 56 data bytes

64 bytes from 10.10.10.174: icmp_seq=0 ttl=63 time=45.700 ms

--- 10.10.10.174 ping statistics ---

1 packets transmitted, 1 packets received, 0.0% packet loss

round-trip min/avg/max/stddev = 45.700/45.700/45.700/0.000 ms

Let us have another look at our CIDR.sh script. We have added several for loops to the script, but let us stick with this little code section.

As in the previous example, for each IP address from the array "ipaddr" we make a "whois" request, whose output is filtered for "NetRange" and "CIDR." This helps us to determine which address range our target is located in. We can use this information to search for additional hosts during a penetration test, if approved by the client. The results that we receive are displayed accordingly and stored in the file "CIDR.txt."

<h3>While Loops</h3>

The while loop is conceptually simple and follows the following principle:

A statement is executed as long as a condition is fulfilled (true).

We can also combine loops and merge their execution with different values. It is important to note that the excessive combination of several loops in each other can make the code very unclear and lead to errors that can be hard to find and follow. Such a combination can look like in our CIDR.sh script.

<h3>CIDR.sh</h3>

<SNIP>
		stat=1

    	while [ $stat -eq 1 ]

    	do

    		ping -c 2 $host > /dev/null 2>&1

    		if [ $? -eq 0 ]

    		then

    			echo "$host is up."

    			((stat--))

    			((hosts_up++))

    			((hosts_total++))

    		else

    			echo "$host is down."

    			((stat--))

    			((hosts_total++))
    		fi

    	done

<SNIP>

The while loops also work with conditions like if-else. A while loop needs some sort of a counter to orientate itself when it has to stop executing the commands it contains. Otherwise, this leads to an endless loop. Such a counter can be a variable that we have declared with a specific value or a boolean value. While loops run while the boolean value is "True". Besides the counter, we can also use the command "break," which interrupts the loop when reaching this command like in the following example:

<h3>WhileBreaker.sh</h3>
