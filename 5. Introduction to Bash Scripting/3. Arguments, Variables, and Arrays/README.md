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
