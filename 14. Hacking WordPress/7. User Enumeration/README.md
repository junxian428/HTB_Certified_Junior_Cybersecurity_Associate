<h3>User Enumeration</h3>

Enumerating a list of valid users is a critical phase of a WordPress security assessment. Armed with this list, we may be able to guess default credentials or perform a brute force password attack. If successful, we may be able to log in to the WordPress backend as an author or even as an administrator. This access can potentially be leveraged to modify the WordPress website or even interact with the underlying web server.

There are two methods for performing manual username enumeration.

<h3>First Method</h3>

The first method is reviewing posts to uncover the ID assigned to the user and their corresponding username. If we mouse over the post author link titled "by admin," as shown in the below image, a link to the user's account appears in the web browser's lower-left corner.

<img width="726" height="484" alt="image" src="https://github.com/user-attachments/assets/8e9a0424-b59a-4a1d-b3a8-013f2f007da6" />

The admin user is usually assigned the user ID 1. We can confirm this by specifying the user ID for the author parameter in the URL.

http://blog.inlanefreight.com/?author=1

This can also be done with cURL from the command line. The HTTP response in the below output shows the author that corresponds to the user ID. The URL in the Location header confirms that this user ID belongs to the admin user.

<h3>Existing User</h3>

@htb[/htb]$ curl -s -I http://blog.inlanefreight.com/?author=1

HTTP/1.1 301 Moved Permanently

The above cURL request then redirects us to the user's profile page or the main login page. If the user does not exist, we receive a 404 Not Found error.

<h3>Non-Existing User</h3>

@htb[/htb]$ curl -s -I http://blog.inlanefreight.com/?author=100

HTTP/1.1 404 Not Found

Date: Wed, 13 May 2020 20:47:14 GMT

<h3>Second Method</h3>

The second method requires interaction with the JSON endpoint, which allows us to obtain a list of users. This was changed in WordPress core after version 4.7.1, and later versions only show whether a user is configured or not. Before this release, all users who had published a post were shown by default.

<h3>JSON Endpoint</h3>

@htb[/htb]$ curl http://blog.inlanefreight.com/wp-json/wp/v2/users | jq

[

  {
  
    "id": 1,
    
    "name": "admin",
    
    "url": "",
    
    "description": "",
    
    "link": "http://blog.inlanefreight.com/index.php/author/admin/",
    
    <SNIP>
    
  },
  
  {
  
    "id": 2,
    
    "name": "ch4p",
    
    "url": "",
    
    "description": "",
    
    "link": "http://blog.inlanefreight.com/index.php/author/ch4p/",
    
    <SNIP>
    
  },
  
<SNIP>

 From the last cURL command, what user name is assigned to User ID 2?
 
ch4p
