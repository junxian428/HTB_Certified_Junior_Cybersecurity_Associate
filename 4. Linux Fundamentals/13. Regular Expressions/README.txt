<h3>Regular Expressions</h3>

Regular expressions (RegEx) are like the art of crafting precise blueprints for searching patterns in text or files. They allow you to find, replace, and manipulate data with incredible precision. Think of RegEx as a highly customizable filter that lets you sift through strings of text, looking for exactly what you need—whether it's analyzing data, validating input, or performing advanced search operations.

At its core, a regular expression is a sequence of characters and symbols that together form a search pattern. These patterns often involve special symbols called metacharacters, which define the structure of the search rather than representing literal text. For example, metacharacters allow you to specify whether you're searching for digits, letters, or any character that fits a certain pattern.

RegEx is available in many programming languages and tools, such as grep or sed, making it a versatile and powerful tool in a our toolkit.

<h3>Grouping</h3>

Among other things, regex offers us the possibility to group the desired search patterns. Basically, regex follows three different concepts, which are distinguished by the three different brackets:

<h3>Grouping Operators</h3>

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Operators</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>(a)</td>
      <td>The round brackets are used to group parts of a regex. Within the brackets, you can define further patterns which should be processed together.</td>
    </tr>
    <tr>
      <td>[a-z]</td>
      <td>The square brackets are used to define character classes. Inside the brackets, you can specify a list of characters to search for.</td>
    </tr>
    <tr>
      <td>{1,10}</td>
      <td>The curly brackets are used to define quantifiers. Inside the brackets, you can specify a number or a range that indicates how often a previous pattern should be repeated.</td>
    </tr>
    <tr>
      <td>|</td>
      <td>Also called the OR operator and shows results when one of the two expressions matches.</td>
    </tr>
    <tr>
      <td>.*</td>
      <td>Operates similarly to an AND operator by displaying results only when both expressions are present and match in the specified order.</td>
    </tr>
  </tbody>
</table>

Suppose we use the OR operator. The regex searches for one of the given search parameters. In the next example, we search for lines containing the word my or false. To use these operators, you need to apply the extended regex using the -E option in grep.
