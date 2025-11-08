<h3>Comparison Operators</h3>

To compare specific values with each other, we need elements that are called comparison operators. The comparison operators are used to determine how the defined values will be compared. For these operators, we differentiate between:

- string operators

- integer operators

- file operators

- boolean operators

<h3>String Operators</h3>

If we compare strings, then we know what we would like to have in the corresponding value.

<table border="1">
  <tr>
    <th>Operator</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>==</td>
    <td>is equal to</td>
  </tr>
  <tr>
    <td>!=</td>
    <td>is not equal to</td>
  </tr>
  <tr>
    <td>&lt;</td>
    <td>is less than in ASCII alphabetical order</td>
  </tr>
  <tr>
    <td>&gt;</td>
    <td>is greater than in ASCII alphabetical order</td>
  </tr>
  <tr>
    <td>-z</td>
    <td>if the string is empty (null)</td>
  </tr>
  <tr>
    <td>-n</td>
    <td>if the string is not null</td>
  </tr>
</table>

It is important to note here that we put the variable for the given argument ($1) in double-quotes ("$1"). This tells Bash that the content of the variable should be handled as a string. Otherwise, we would get an error.

String comparison operators "< / >" works only within the double square brackets [[<condition>]]. We can find the ASCII table on the Internet or by using the following command in the terminal. We take a look at an example later.

@htb[/htb]$ man ascii

<h3>ASCII Table</h3>

<table border="1">
  <tr>
    <th>Decimal</th>
    <th>Hexadecimal</th>
    <th>Character</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>0</td>
    <td>00</td>
    <td>NUL</td>
    <td>End of a string</td>
  </tr>
  <tr>
    <td>65</td>
    <td>41</td>
    <td>A</td>
    <td>Capital A</td>
  </tr>
  <tr>
    <td>66</td>
    <td>42</td>
    <td>B</td>
    <td>Capital B</td>
  </tr>
  <tr>
    <td>67</td>
    <td>43</td>
    <td>C</td>
    <td>Capital C</td>
  </tr>
  <tr>
    <td>68</td>
    <td>44</td>
    <td>D</td>
    <td>Capital D</td>
  </tr>
  <tr>
    <td>127</td>
    <td>7F</td>
    <td>DEL</td>
    <td>Delete</td>
  </tr>
</table>

ASCII stands for American Standard Code for Information Interchange and represents a 7-bit character encoding. Since each bit can take two values, there are 128 different bit patterns, which can also be interpreted as the decimal integers 0 - 127 or in hexadecimal values 00 - 7F. The first 32 ASCII character codes are reserved as so-called control characters.

<h3>Integer Operators</h3>

Comparing integer numbers can be very useful for us if we know what values we want to compare. Accordingly, we define the next steps and commands how the script should handle the corresponding value.

<table border="1">
  <tr>
    <th>Operator</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>-eq</td>
    <td>is equal to</td>
  </tr>
  <tr>
    <td>-ne</td>
    <td>is not equal to</td>
  </tr>
  <tr>
    <td>-lt</td>
    <td>is less than</td>
  </tr>
  <tr>
    <td>-le</td>
    <td>is less than or equal to</td>
  </tr>
  <tr>
    <td>-gt</td>
    <td>is greater than</td>
  </tr>
  <tr>
    <td>-ge</td>
    <td>is greater than or equal to</td>
  </tr>
</table>

<h3>File Operators</h3>

The file operators are useful if we want to find out specific permissions or if they exist.

<table border="1">
  <tr>
    <th>Operator</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>-e</td>
    <td>if the file exists</td>
  </tr>
  <tr>
    <td>-f</td>
    <td>tests if it is a file</td>
  </tr>
  <tr>
    <td>-d</td>
    <td>tests if it is a directory</td>
  </tr>
  <tr>
    <td>-L</td>
    <td>tests if it is a symbolic link</td>
  </tr>
  <tr>
    <td>-N</td>
    <td>checks if the file was modified after it was last read</td>
  </tr>
  <tr>
    <td>-O</td>
    <td>if the current user owns the file</td>
  </tr>
  <tr>
    <td>-G</td>
    <td>if the file’s group id matches the current user’s</td>
  </tr>
  <tr>
    <td>-s</td>
    <td>tests if the file has a size greater than 0</td>
  </tr>
  <tr>
    <td>-r</td>
    <td>tests if the file has read permission</td>
  </tr>
  <tr>
    <td>-w</td>
    <td>tests if the file has write permission</td>
  </tr>
  <tr>
    <td>-x</td>
    <td>tests if the file has execute permission</td>
  </tr>
</table>
