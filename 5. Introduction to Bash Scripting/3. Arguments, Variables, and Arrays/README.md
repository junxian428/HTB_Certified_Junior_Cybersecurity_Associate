<h3>Arguments, Variables, and Arrays</h3>

<h4>Arguments</h4>

The advantage of bash scripts is that we can always pass up to 9 arguments ($0-$9) to the script without assigning them to variables or setting the corresponding requirements for these. 9 arguments because the first argument $0 is reserved for the script. As we can see here, we need the dollar sign ($) before the name of the variable to use it at the specified position. The assignment would look like this in comparison:

@htb[/htb]$ ./script.sh ARG1 ARG2 ARG3 ... ARG9

ASSIGNMENTS: $0 $1 $2 $3 ... $9
