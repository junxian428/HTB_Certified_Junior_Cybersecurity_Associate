<h3>Input and Output</h3>

<h3>Input Control</h3>

We may get results from our sent requests and executed commands, which we have to decide manually on how to proceed. Another example would be that we have defined several functions in our script designed for different scenarios. We have to decide which of them should be executed after a manual check and based on the results. It is also quite possible that specific scans or activities may not be allowed to be performed. Therefore, we need to be familiar with how to get a running script to wait for our instructions. If we look at our CIDR.sh script again, we see that we have added such a call to decide further steps.

The first echo lines serve as a display menu for the options available to us. With the read command, the line with "Select your option:" is displayed, and the additional option -p ensures that our input remains on the same line. Our input is stored in the variable opt, which we then use to execute the corresponding functions with the case statement, which we will look at later. Depending on the number we enter, the case statement determines which functions are executed.

<h3>Output Control</h3>

We have already learned about the output redirections of output in the Linux Fundamentals module. Nevertheless, the problem with the redirections is that we do not get any output from the respective command. It will be redirected to the appropriate file. If our scripts become more complicated later, they can take much more time than just a few seconds. To avoid sitting inactively and waiting for our script's results, we can use the tee utility. It ensures that we see the results we get immediately and that they are stored in the corresponding files. In our CIDR.sh script, we have used this utility twice in different ways.

When using tee, we transfer the received output and use the pipe (|) to forward it to tee. The "-a / --append" parameter ensures that the specified file is not overwritten but supplemented with the new results. At the same time, it shows us the results and how they will be found in the file.

@htb[/htb]$ cat discovered_hosts.txt CIDR.txt

165.22.119.202

NetRange: 165.22.0.0 - 165.22.255.255

CIDR: 165.22.0.0/16
