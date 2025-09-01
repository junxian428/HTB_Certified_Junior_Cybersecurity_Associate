<h3> Linux Structure </h3>

Linux, as you might already know, is an operating system used for personal computers, servers, and even mobile devices. However, Linux stands as a fundamental pillar in cybersecurity, renowned for its robustness, flexibility, and open-source nature. In this section we are going to cover the Linux structure, history, philosophy, architecture, and file system hierarchy—essential knowledge for any cybersecurity professional. You can think of this as your first driving lesson for a new car, getting a basic understanding of the vehicle, what it consists of, and why it is the way it currently is.

To begin, let's define what Linux is. Linux is an operating system, just like Windows, macOS, iOS, or Android. An operating system (OS) is software that manages all the hardware resources of a computer, facilitating communication between software applications and hardware components. Unlike some other operating systems, Linux comes in many different distributions—often called "distros"—which are versions of Linux tailored to various needs and preferences.

History
Many events led up to creating the first Linux kernel and, ultimately, the Linux operating system (OS), starting with the Unix operating system's release by Ken Thompson and Dennis Ritchie (whom both worked for AT&T at the time) in 1970. The Berkeley Software Distribution (BSD) was released in 1977, but since it contained the Unix code owned by AT&T, a resulting lawsuit limited the development of BSD. Richard Stallman started the GNU project in 1983. His goal was to create a free Unix-like operating system, and part of his work resulted in the GNU General Public License (GPL) being created. Projects by others over the years failed to result in a working, free kernel that would become widely adopted until the creation of the Linux kernel.

At first, Linux was a personal project started in 1991 by a Finnish student named Linus Torvalds. His goal was to create a new, free operating system kernel. Over the years, the Linux kernel has gone from a small number of files written in C under licensing that prohibited commercial distribution to the latest version with over 23 million source code lines (comments excluded), licensed under the GNU General Public License v2.

Linux is available in over 600 distributions (or an operating system based on the Linux kernel and supporting software and libraries). Some of the most popular and well-known being Ubuntu, Debian, Fedora, OpenSUSE, elementary, Manjaro, Gentoo Linux, RedHat, and Linux Mint.

Linux is generally considered more secure than other operating systems, and while it has had many kernel vulnerabilities in the past, it is becoming less and less frequent. It is less susceptible to malware than Windows operating systems and is very frequently updated. Linux is also very stable and generally affords very high performance to the end-user. However, it can be more difficult for beginners and does not have as many hardware drivers as Windows.

Since Linux is free and open-source, the source code can be modified and distributed commercially or non-commercially by anyone. Linux-based operating systems run on servers, mainframes, desktops, embedded systems such as routers, televisions, video game consoles, and more. The overall Android operating system that runs on smartphones and tablets is based on the Linux kernel, and because of this, Linux is the most widely installed operating system.

Linux is an operating system like Windows, iOS, Android, or macOS. An OS is software that manages all of the hardware resources associated with our computer. That means that an OS manages the whole communication between software and hardware. Also, there exist many different distributions (distro). It is like a version of Windows operating systems.

With the interactive instances, we get access to the Pwnbox, a customized version of Parrot OS. This will be the primary OS we will work with through the modules. Parrot OS is a Debian-based Linux distribution that focuses on security, privacy, and development.

Imagine Linux as a thriving company where its components are the dedicated employees, each with specific roles and responsibilities to keep operations running smoothly. The architecture serves as the organizational structure, outlining how these employees are arranged into departments and how they communicate to achieve efficiency and productivity. The philosophy represents the company's culture and core values, guiding how these employees work individually and collaboratively, promoting principles like simplicity, transparency, and cooperation to reach common goals.

Philosophy

The Linux philosophy centers on simplicity, modularity, and openness. It advocates for building small, single-purpose programs that perform one task well. These programs can be combined in various ways to accomplish complex operations, promoting efficiency and flexibility. Linux follows five core principles:

<table>
  <thead>
    <tr>
      <th>Principle</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Everything is a file</td>
      <td>All configuration files for the various services running on the Linux operating system are stored in one or more text files.</td>
    </tr>
    <tr>
      <td>Small, single-purpose programs</td>
      <td>Linux offers many different tools that we will work with, which can be combined to work together.</td>
    </tr>
    <tr>
      <td>Ability to chain programs together to perform complex tasks</td>
      <td>The integration and combination of different tools enable us to carry out many large and complex tasks, such as processing or filtering specific data results.</td>
    </tr>
    <tr>
      <td>Avoid captive user interfaces</td>
      <td>Linux is designed to work mainly with the shell (or terminal), which gives the user greater control over the operating system.</td>
    </tr>
    <tr>
      <td>Configuration data stored in a text file</td>
      <td>An example of such a file is the /etc/passwd file, which stores all users registered on the system.</td>
    </tr>
  </tbody>
</table>

Components

<table>
  <thead>
    <tr>
      <th>Component</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Bootloader</td>
      <td>A piece of code that runs to guide the booting process to start the operating system. Parrot Linux uses the GRUB Bootloader.</td>
    </tr>
    <tr>
      <td>OS Kernel</td>
      <td>The kernel is the main component of an operating system. It manages the resources for system's I/O devices at the hardware level.</td>
    </tr>
    <tr>
      <td>Daemons</td>
      <td>Background services are called "daemons" in Linux. Their purpose is to ensure that key functions such as scheduling, printing, and multimedia are working correctly. These small programs load after we booted or log into the computer.</td>
    </tr>
    <tr>
      <td>OS Shell</td>
      <td>The operating system shell or the command language interpreter (also known as the command line) is the interface between the OS and the user. This interface allows the user to tell the OS what to do. The most commonly used shells are Bash, Tcsh/Csh, Ksh, Zsh, and Fish.</td>
    </tr>
    <tr>
      <td>Graphics server</td>
      <td>This provides a graphical sub-system (server) called "X" or "X-server" that allows graphical programs to run locally or remotely on the X-windowing system.</td>
    </tr>
    <tr>
      <td>Window Manager</td>
      <td>Also known as a graphical user interface (GUI). There are many options, including GNOME, KDE, MATE, Unity, and Cinnamon. A desktop environment usually has several applications, including file and web browsers. These allow the user to access and manage the essential and frequently accessed features and services of an operating system.</td>
    </tr>
    <tr>
      <td>Utilities</td>
      <td>Applications or utilities are programs that perform particular functions for the user or another program.</td>
    </tr>
  </tbody>
</table>

<h3>Linux Architecture </h3>

The Linux operating system can be broken down into layers:

<table>
  <thead>
    <tr>
      <th>Layer</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Hardware</td>
      <td>Peripheral devices such as the system's RAM, hard drive, CPU, and others.</td>
    </tr>
    <tr>
      <td>Kernel</td>
      <td>The core of the Linux operating system whose function is to virtualize and control common computer hardware resources like CPU, allocated memory, accessed data, and others. The kernel gives each process its own virtual resources and prevents/mitigates conflicts between different processes.</td>
    </tr>
    <tr>
      <td>Shell</td>
      <td>A command-line interface (CLI), also known as a shell that a user can enter commands into to execute the kernel's functions.</td>
    </tr>
    <tr>
      <td>System Utility</td>
      <td>Makes available to the user all of the operating system's functionality.</td>
    </tr>
  </tbody>
</table>

File System Hierarchy

The Linux operating system is structured in a tree-like hierarchy and is documented in the Filesystem Hierarchy Standard (FHS). Linux is structured with the following standard top-level directories:

<table>
  <thead>
    <tr>
      <th>Path</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>/</td>
      <td>The top-level directory is the root filesystem and contains all of the files required to boot the operating system before other filesystems are mounted, as well as the files required to boot the other filesystems. After boot, all of the other filesystems are mounted at standard mount points as subdirectories of the root.</td>
    </tr>
    <tr>
      <td>/bin</td>
      <td>Contains essential command binaries.</td>
    </tr>
    <tr>
      <td>/boot</td>
      <td>Consists of the static bootloader, kernel executable, and files required to boot the Linux OS.</td>
    </tr>
    <tr>
      <td>/dev</td>
      <td>Contains device files to facilitate access to every hardware device attached to the system.</td>
    </tr>
    <tr>
      <td>/etc</td>
      <td>Local system configuration files. Configuration files for installed applications may be saved here as well.</td>
    </tr>
    <tr>
      <td>/home</td>
      <td>Each user on the system has a subdirectory here for storage.</td>
    </tr>
    <tr>
      <td>/lib</td>
      <td>Shared library files that are required for system boot.</td>
    </tr>
    <tr>
      <td>/media</td>
      <td>External removable media devices such as USB drives are mounted here.</td>
    </tr>
    <tr>
      <td>/mnt</td>
      <td>Temporary mount point for regular filesystems.</td>
    </tr>
    <tr>
      <td>/opt</td>
      <td>Optional files such as third-party tools can be saved here.</td>
    </tr>
    <tr>
      <td>/root</td>
      <td>The home directory for the root user.</td>
    </tr>
    <tr>
      <td>/sbin</td>
      <td>This directory contains executables used for system administration (binary system files).</td>
    </tr>
    <tr>
      <td>/tmp</td>
      <td>The operating system and many programs use this directory to store temporary files. This directory is generally cleared upon system boot and may be deleted at other times without any warning.</td>
    </tr>
    <tr>
      <td>/usr</td>
      <td>Contains executables, libraries, man files, etc.</td>
    </tr>
    <tr>
      <td>/var</td>
      <td>This directory contains variable data files such as log files, email in-boxes, web application related files, cron files, and more.</td>
    </tr>
  </tbody>
</table>
