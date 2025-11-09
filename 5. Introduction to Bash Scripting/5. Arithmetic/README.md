<h3>Arithmetic</h3>

In Bash, we have seven different arithmetic operators we can work with. These are used to perform different mathematical operations or to modify certain integers.

<h3>Arithmetic Operators</h3>

<table border="1">
  <thead>
    <tr>
      <th>Operator</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>+</td>
      <td>Addition</td>
    </tr>
    <tr>
      <td>-</td>
      <td>Subtraction</td>
    </tr>
    <tr>
      <td>*</td>
      <td>Multiplication</td>
    </tr>
    <tr>
      <td>/</td>
      <td>Division</td>
    </tr>
    <tr>
      <td>%</td>
      <td>Modulus</td>
    </tr>
    <tr>
      <td>variable++</td>
      <td>Increase the value of the variable by 1</td>
    </tr>
    <tr>
      <td>variable--</td>
      <td>Decrease the value of the variable by 1</td>
    </tr>
  </tbody>
</table>

We can summarize all these operators in a small script:

The output of this script looks like this:

Addition: 10 + 10 = 20

Subtraction: 10 - 10 = 0

Multiplication: 10 \* 10 = 100

Division: 10 / 10 = 1

Modulus: 10 % 4 = 2

Increase Variable: 2

Decrease Variable: 0

We can also calculate the length of the variable. Using this function ${#variable}, every character gets counted, and we get the total number of characters in the variable.

@htb[/htb]$ ./VarLength.sh

10

If we look at our CIDR.sh script, we will see that we have used the increase and decrease operators several times. This ensures that the while loop, which we will discuss later, runs and pings the hosts while the variable "stat" has a value of 1. If the ping command ends with code 0 (successful), we get a message that the host is up and the "stat" variable, as well as the variables "hosts_up" and "hosts_total" get changed.
