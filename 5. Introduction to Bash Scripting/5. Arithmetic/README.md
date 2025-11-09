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
