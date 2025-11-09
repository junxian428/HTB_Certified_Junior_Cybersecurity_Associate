<h3>Functions</h3>

The bigger our scripts get, the more chaotic they become. If we use the same routines several times in the script, the script's size will increase accordingly. In such cases, functions are the solution that improves both the size and the clarity of the script many times. We combine several commands in a block between curly brackets ( { ... } ) and call them with a function name defined by us with functions. Once a function has been defined, it can be called and used again during the script.

Functions are an essential part of scripts and programs, as they are used to execute recurring commands for different values and phases of the script or program. Therefore, we do not have to repeat the whole section of code repeatedly but can create a single function that executes the specific commands. The definition of such functions makes the code easier to read and helps to keep the code as short as possible. It is important to note that functions must always be defined logically before the first call since a script is also processed from top to bottom. Therefore the definition of a function is always at the beginning of the script. There are two methods to define the functions:

<h3>Method 1 - Functions</h3>

function name {

<commands>

}

<h3>Method 2 - Functions</h3>

name() {

<commands>

}

We can choose the method to define a function that is most comfortable for us. In our CIDR.sh script, we used the first method because it is easier to read with the keyword "function."

The function is called only by calling the specified name of the function, as we have seen in the case statement.

<h3>Function Execution - CIDR.sh</h3>

<SNIP>
case $opt in

    "1") network_range ;;

    "2") ping_host ;;

    "3") network_range && ping_host ;;

    "*") exit 0 ;;

esac

<h3>Parameter Passing</h3>

Such functions should be designed so that they can be used with a fixed structure of the values or at least only with a fixed format. Like we have already seen in our CIDR.sh script, we used the format of an IP address for the function "network_range". The parameters are optional, and therefore we can call the function without parameters. In principle, the same applies to the passed parameters as to parameters passed to a shell script. These are $1 - $9 (${n}), or $variable as we have already seen. Each function has its own set of parameters. So they do not collide with those of other functions or the parameters of the shell script.

An important difference between bash scripts and other programming languages is that all defined variables are always processed globally unless otherwise declared by "local." This means that the first time we have defined a variable in a function, we will call it in our main script (outside the function). Passing the parameters to the functions is done the same way as we passed the arguments to our script and looks like this:

@htb[/htb]$ ./PrintPars.sh

First parameter Second parameter Third parameter

<h3>Return Values</h3>
