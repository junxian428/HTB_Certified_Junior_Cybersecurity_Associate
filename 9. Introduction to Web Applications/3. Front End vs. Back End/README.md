<h3>Front End vs. Back End</h3>

We may have heard the terms front end and back end web development, or the term Full Stack web development, which refers to both front and back end web development. These terms are becoming synonymous with web application development, as they comprise the majority of the web development cycle. However, these terms are very different from each other, as each refers to one side of the web application, and each function and communicate in different areas.

Front End

The front end of a web application contains the user's components directly through their web browser (client-side). These components make up the source code of the web page we view when visiting a web application and usually include HTML, CSS, and JavaScript, which is then interpreted in real-time by our browsers.

<img width="1029" height="388" alt="image" src="https://github.com/user-attachments/assets/b6b11542-1059-4563-afda-e4f0ad0fd4bc" />

This includes everything that the user sees and interacts with, like the page's main elements such as the title and text HTML, the design and animation of all elements CSS, and what function each part of a page performs JavaScript.

In modern web applications, front end components should adapt to any screen size and work within any browser on any device. This contrasts with back end components, which are usually written for a specific platform or operating system. If the front end of a web application is not well optimized, it may make the entire web application slow and unresponsive. In this case, some users may think that the hosting server, or their internet, is slow, while the issue lies entirely on the client-side at the user's browser. This is why the front end of a web application must be optimized for most platforms, devices (including mobile!), and screen sizes.

Aside from frontend code development, the following are some of the other tasks related to front end web application development:

- Visual Concept Web Design
- User Interface (UI) design
- User Experience (UX) design

There are many sites available to us to practice front end coding. One example is this one. Here we can play around with the editor, typing and formatting text and seeing the resulting HTML, CSS, and JavaScript being generated for us. Copy/paste this VERY simple example into the right hand side of the editor:

<table border="1" cellspacing="0" cellpadding="8" style="border-collapse: collapse; width: 100%;">
  <thead>
    <tr>
      <th style="text-align: left;">Code (HTML Snippet)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="background-color: #f5f5f5; font-family: monospace; white-space: pre; padding: 12px;">
&lt;p&gt;&lt;strong&gt;Welcome to Hack The Box Academy&lt;/strong&gt;&lt;/p&gt;
&lt;p&gt;&lt;em&gt;This is some italic text.&lt;/em&gt;&lt;/p&gt;
&lt;p&gt;&lt;span style=&quot;color: #0000ff;&quot;&gt;This is some blue text.&lt;/span&gt;&lt;/p&gt;
      </td>
    </tr>
  </tbody>
</table>

<img width="982" height="510" alt="image" src="https://github.com/user-attachments/assets/11e0a8fd-8a59-47d8-b668-1be613e9152b" />


Watch the simple HTML code render on the left. Play around with the formatting, headers, colors, etc., and watch the code change.

Back End
The back end of a web application drives all of the core web application functionalities, all of which is executed at the back end server, which processes everything required for the web application to run correctly. It is the part we may never see or directly interact with, but a website is just a collection of static web pages without a back end.

There are four main back end components for web applications:

<table border="1" cellspacing="0" cellpadding="8">
  <thead>
    <tr>
      <th>Component</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Back end Servers</td>
      <td>The hardware and operating system that hosts all other components and are usually run on operating systems like Linux, Windows, or using Containers.</td>
    </tr>
    <tr>
      <td>Web Servers</td>
      <td>Web servers handle HTTP requests and connections. Some examples are Apache, NGINX, and IIS.</td>
    </tr>
    <tr>
      <td>Databases</td>
      <td>Databases (DBs) store and retrieve the web application data. Some examples of relational databases are MySQL, MSSQL, Oracle, PostgreSQL, while examples of non-relational databases include NoSQL and MongoDB.</td>
    </tr>
    <tr>
      <td>Development Frameworks</td>
      <td>Development Frameworks are used to develop the core Web Application. Some well-known frameworks include Laravel (PHP), ASP.NET (C#), Spring (Java), Django (Python), and Express (NodeJS JavaScript).</td>
    </tr>
  </tbody>
</table>

It is also possible to host each component of the back end on its own isolated server, or in isolated containers, by utilizing services such as Docker. To maintain logical separation and mitigate the impact of vulnerabilities, different components of the web application, such as the database, can be installed in one Docker container, while the main web application is installed in another, thereby isolating each part from potential vulnerabilities that may affect the other container(s). It is also possible to separate each into its dedicated server, which can be more resource-intensive and time-consuming to maintain. Still, it depends on the business case and design/functionality of the web application in question.

Some of the main jobs performed by back end components include:

- Develop the main logic and services of the back end of the web application

- Develop the main code and functionalities of the web application

- Develop and maintain the back end database

- Develop and implement libraries to be used by the web application

- Implement technical/business needs for the web application

- Implement the main APIs for front end component communications

- Integrate remote servers and cloud services into the web application

<h3> Securing Front/Back End </h3>

Even though in most cases, we will not have access to the back end code to analyze the individual functions and the structure of the code, it does not make the application invulnerable. It could still be exploited by various injection attacks, for example.

Suppose we have a search function in a web application that mistakenly does not process our search queries correctly. In that case, we could use specific techniques to manipulate the queries in such a way that we gain unauthorized access to specific database data SQL injections or even execute operating system commands via the web application, also known as Command Injections.

We will later discuss how to secure each component used on the front and back ends. When we have full access to the source code of front end components, we can perform a code review to find vulnerabilities, which is part of what is referred to as Whitebox Pentesting.

On the other hand, back end components' source code is stored on the back end server, so we do not have access to it by default, which forces us only to perform what is known as Blackbox Pentesting. However, as we will see, some web applications are open source, meaning we likely have access to their source code. Furthermore, some vulnerabilities such as Local File Inclusion could allow us to obtain the source code from the back end server. With this source code in hand, we can then perform a code review on back end components to further understand how the application works, potentially find sensitive data in the source code (such as passwords), and even find vulnerabilities that would be difficult or impossible to find without access to the source code.

The top 20 most common mistakes web developers make that are essential for us as penetration testers are:

<img width="1020" height="774" alt="image" src="https://github.com/user-attachments/assets/83e64810-7a3d-4287-b098-37f273871a64" />

These mistakes lead to the OWASP Top 10 vulnerabilities for web applications, which we will discuss in other modules:

<img width="1011" height="422" alt="image" src="https://github.com/user-attachments/assets/f35f368e-56a8-402a-be8c-76ebbff3f42d" />


It is important to begin to familiarize ourselves with these flaws and vulnerabilities as they form the basis for many of the issues we cover in future web and even non-web related modules. As pentesters, we must have the ability to competently identify, exploit, and explain these vulnerabilities for our clients.

SOURCE:

https://owasp.org/www-community/attacks/Command_Injection

https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion

https://owasp.org/www-project-top-ten/
