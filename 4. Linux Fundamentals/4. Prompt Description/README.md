<h3>Prompt Description</h3>

The bash prompt is simple to understand. By default, it shows information like your username (who you are), your computer's name (hostname), and the folder/directory you're currently working in. It's a line of text that appears on the screen to let you know the system is ready for you. The prompt appears on a new line, and the cursor (the blinking line or box) is placed right after it, waiting for you to type a command.

It can be customized to provide useful information to the user. The format can look something like this:

<img width="1051" height="804" alt="image" src="https://github.com/user-attachments/assets/dd3e9b67-40fe-44f2-813f-8bb10f2d6853" />

The PS1 variable in Linux systems controls how your command prompt looks in the terminal. It's like a template that defines the text you see each time the system is ready for you to type a command. By customizing the PS1 variable, you can change the prompt to display information such as your username, your computer's name, the current folder you're in, or even add colors and special characters. This allows you to personalize the command-line interface to make it more informative or visually appealing.

In addition to displaying basic information like your username and current folder, you can customize the command prompt to show other useful details such as the IP address, date, time, and the success or failure of the last command. This customization is especially helpful during penetration tests because it allows you to keep track of your actions more effectively. For instance, you can set the prompt to show the full path of the current working directory instead of just its name, and even include the target's IP address if needed. Using tools like script or reviewing the .bash_history file (located in the user's home directory), you can record all the commands you've used and organize them by date and time, which aids in documentation and analysis.

The prompt can be customized using special characters and variables in the shell’s configuration file (.bashrc for the Bash shell). For example, we can use: the \u character to represent the current username, \h for the hostname, and \w for the current working directory.

<img width="788" height="542" alt="image" src="https://github.com/user-attachments/assets/8a118024-48d0-41be-b883-0684d7fec365" />

Customizing the prompt can be a useful way to make your terminal experience more personalized and efficient. It can also be a helpful tool for troubleshooting and problem-solving, as it can provide important information about the system’s state at any given time.

In addition to customizing the prompt, we can customize their terminal environment with different color schemes, fonts, and other settings to make their work environment more visually appealing and easier to use.

However, we see the same as when working on the Windows GUI here. We are logged in as a user on a computer with a specific name, and we know which directory we are in when we navigate through our system. Bash prompt can also be customized and changed to our own needs. The adjustment of the bash prompt is outside the scope of this module. However, we can look at the bash-prompt-generator and powerline, which gives us the possibility to adapt our prompt to our needs.
