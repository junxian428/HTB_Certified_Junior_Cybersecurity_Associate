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
