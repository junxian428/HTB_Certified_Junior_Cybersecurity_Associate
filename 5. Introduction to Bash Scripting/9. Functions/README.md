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
