<h3>WPScan Enumeration</h3>

<h3>Enumerating a Website with WPScan</h3>

The --enumerate flag is used to enumerate various components of the WordPress application such as plugins, themes, and users. By default, WPScan enumerates vulnerable plugins, themes, users, media, and backups. However, specific arguments can be supplied to restrict enumeration to specific components. For example, all plugins can be enumerated using the arguments --enumerate ap. Let's run a normal enumeration scan against a WordPress website.

Note: The default number of threads used is 5, however, this value can be changed using the "-t" flag.

<h3>WPScan Enumeration</h3>

7@htb[/htb]$ wpscan --url http://blog.inlanefreight.com --enumerate --api-token Kffr4fdJzy9qVcTk<SNIP>

[+] URL: http://blog.inlanefreight.com/  
