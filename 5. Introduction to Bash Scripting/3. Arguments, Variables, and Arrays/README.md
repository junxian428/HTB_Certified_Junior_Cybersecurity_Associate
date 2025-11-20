<h3>Arguments, Variables, and Arrays</h3>

<h4>Arguments</h4>

The advantage of bash scripts is that we can always pass up to 9 arguments ($0-$9) to the script without assigning them to variables or setting the corresponding requirements for these. 9 arguments because the first argument $0 is reserved for the script. As we can see here, we need the dollar sign ($) before the name of the variable to use it at the specified position. The assignment would look like this in comparison:

@htb[/htb]$ ./script.sh ARG1 ARG2 ARG3 ... ARG9

ASSIGNMENTS: $0 $1 $2 $3 ... $9

This means that we have automatically assigned the corresponding arguments to the predefined variables in this place. These variables are called special variables. These special variables serve as placeholders. If we now look at the code section again, we will see where and which arguments have been used.

There are several ways how we can execute our script. However, we must first set the script's execution privileges before executing it with the interpreter defined in it.

<h3>CIDR.sh - Set Execution Privileges</h3>

@htb[/htb]$ chmod +x cidr.sh

<h3>CIDR.sh - Execution without Arguments</h3>

@htb[/htb]$ ./cidr.sh

You need to specify the target domain.

Usage:

cidr.sh <domain>

<h3>CIDR.sh - Execution without Execution Permissions</h3>

@htb[/htb]$ bash cidr.sh

You need to specify the target domain.

Usage:

cidr.sh <domain>

<h3>Special Variables</h3>

Special variables use the Internal Field Separator (IFS) to identify when an argument ends and the next begins. Bash provides various special variables that assist while scripting. Some of these variables are:

<table border="1">
  <tr>
    <th>Special Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>$#</td>
    <td>This variable holds the number of arguments passed to the script.</td>
  </tr>
  <tr>
    <td>$@</td>
    <td>This variable can be used to retrieve the list of command-line arguments.</td>
  </tr>
  <tr>
    <td>$n</td>
    <td>Each command-line argument can be selectively retrieved using its position. For example, the first argument is found at $1.</td>
  </tr>
  <tr>
    <td>$$</td>
    <td>The process ID of the currently executing process.</td>
  </tr>
  <tr>
    <td>$?</td>
    <td>The exit status of the script. This variable is useful to determine a command's success. The value 0 represents successful execution, while 1 is a result of a failure.</td>
  </tr>
</table>

Of the ones shown above, we have 3 such special variables in our if-else condition.

<table border="1">
  <tr>
    <th>Special Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>$#</td>
    <td>In this case, we need just one variable that needs to be assigned to the domain variable. This variable is used to specify the target we want to work with. If we provide just an FQDN as the argument, the $# variable will have a value of 1.</td>
  </tr>
  <tr>
    <td>$0</td>
    <td>This special variable is assigned the name of the executed script, which is then shown in the "Usage:" example.</td>
  </tr>
  <tr>
    <td>$1</td>
    <td>Separated by a space, the first argument is assigned to that special variable.</td>
  </tr>
</table>

<h3>Variables</h3>

We also see at the end of the if-else loop that we assign the value of the first argument to the variable called "domain". The assignment of variables takes place without the dollar sign ($). The dollar sign is only intended to allow this variable's corresponding value to be used in other code sections. When assigning variables, there must be no spaces between the names and values.

<SNIP>

else

    domain=$1

fi

<SNIP>

In contrast to other programming languages, there is no direct differentiation and recognition between the types of variables in Bash like "strings," "integers," and "boolean." All contents of the variables are treated as string characters. Bash enables arithmetic functions depending on whether only numbers are assigned or not. It is important to note when declaring variables that they do not contain a space. Otherwise, the actual variable name will be interpreted as an internal function or a command.

<h3>Declaring a Variable - Error</h3>

@htb[/htb]$ variable = "this will result with an error."

command not found: variable

<h3>Declaring a Variable - Without an Error</h3>

@htb[/htb]$ variable="Declared without an error."

@htb[/htb]$ echo $variable

<h3>Declared without an error.</h3>

@htb[/htb]$ variable="Declared without an error."

@htb[/htb]$ echo $variable

Declared without an error.

<h3>Arrays</h3>

There is also the possibility of assigning several values to a single variable in Bash. This can be beneficial if we want to scan multiple domains or IP addresses. These variables are called arrays that we can use to store and process an ordered sequence of specific type values. Arrays identify each stored entry with an index starting with 0. When we want to assign a value to an array component, we do so in the same way as with standard shell variables. All we do is specify the field index enclosed in square brackets. The declaration for arrays looks like this in Bash:

<h3>Arrays.sh</h3>

#!/bin/bash

domains=(www.inlanefreight.com ftp.inlanefreight.com vpn.inlanefreight.com www2.inlanefreight.com)

echo ${domains[0]}

We can also retrieve them individually using the index using the variable with the corresponding index in curly brackets. Curly brackets are used for variable expansion.

@htb[/htb]$ ./Arrays.sh

www.inlanefreight.com

It is important to note that single quotes (' ... ') and double quotes (" ... ") prevent the separation by a space of the individual values in the array. This means that all spaces between the single and double quotes are ignored and handled as a single value assigned to the array.

@htb[/htb]$ ./Arrays.sh

www.inlanefreight.com ftp.inlanefreight.com vpn.inlanefreight.com

Questions

Answer the question(s) below to complete this Section and earn cubes!

- 2 Submit the echo statement that would print "www2.inlanefreight.com" when running the last "Arrays.sh" script.

  echo ${domains[1]}
