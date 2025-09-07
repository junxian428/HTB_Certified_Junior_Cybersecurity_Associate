<h3>Sensitive Data Exposure</h3>

All of the front end components we covered are interacted with on the client-side. Therefore, if they are attacked, they do not pose a direct threat to the core back end of the web application and usually will not lead to permanent damage. However, as these components are executed on the client-side, they put the end-user in danger of being attacked and exploited if they do have any vulnerabilities. If a front end vulnerability is leveraged to attack admin users, it could result in unauthorized access, access to sensitive data, service disruption, and more.

Although the majority of web application penetration testing is focused on back end components and their functionality, it is important also to test front end components for potential vulnerabilities, as these types of vulnerabilities can sometimes be utilized to gain access to sensitive functionality (i.e., an admin panel), which may lead to compromising the entire server.

Sensitive Data Exposure refers to the availability of sensitive data in clear-text to the end-user. This is usually found in the source code of the web page or page source on the front end of web applications. This is the HTML source code of the application, not to be confused with the back end code that is typically only accessible on the server itself. We can view any website's page source in our browser by right-clicking anywhere on the page and selecting View Page Source from the pop-up menu. Sometimes a developer may disable right-clicking on a web application, but this does not prevent us from viewing the page source as we can merely type ctrl + u or view the page source through a web proxy such as Burp Suite. Let's take a look at the google.com page source. Right-click and choose View Page Source, and a new tab will open in our browser with the URL view-source:https://www.google.com/. Here we can see the HTML, JavaScript, and external links. Take a moment to browse the page source a bit.

SOURCE:

https://owasp.org/www-project-top-ten/2017/A3_2017-Sensitive_Data_Exposure
