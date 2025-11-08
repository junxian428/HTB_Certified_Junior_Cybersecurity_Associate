<h3>Package Management</h3>

Whether working as a system administrator, maintaining our own Linux machines at home, or building/upgrading/maintaining our penetration testing distribution of choice, it is crucial to have a firm grasp on the available Linux package managers and the various ways to utilize them to install, update, or remove packages. Packages are archives that contain binaries of software, configuration files, information about dependencies and keep track of updates and upgrades. The features that most package management systems provide are:

- Package downloading

- Dependency resolution

- A standard binary package format

- Common installation and configuration locations

- Additional system-related configuration and functionality

- Quality control

We can use many different package management systems that cover different types of files like ".deb", ".rpm", and others. The package management requirement is that the software to be installed is available as a corresponding package. Typically this is created, offered, and maintained centrally under Linux distributions. In this way, the software is integrated directly into the system, and its various directories are distributed throughout the system. The package management software retrieves the necessary changes for system installation from the package itself and then implements these changes to install the package successfully. If the package management software recognizes that additional packages are required for the proper functioning of the package that has not yet been installed, a dependency is included and either warns the administrator or tries to reload the missing software from a repository, for example, and install it in advance.

If an installed software has been deleted, the package management system then retakes the package's information, modifies it based on its configuration, and deletes files. There are different package management programs that we can use for this. Here is a list of examples of such programs:

<table border="1" cellspacing="0" cellpadding="6">
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>dpkg</td>
      <td>The dpkg is a tool to install, build, remove, and manage Debian packages. The primary and more user-friendly front-end for dpkg is aptitude.</td>
    </tr>
    <tr>
      <td>apt</td>
      <td>Apt provides a high-level command-line interface for the package management system.</td>
    </tr>
    <tr>
      <td>aptitude</td>
      <td>Aptitude is an alternative to apt and is a high-level interface to the package manager.</td>
    </tr>
    <tr>
      <td>snap</td>
      <td>Install, configure, refresh, and remove snap packages. Snaps enable the secure distribution of the latest apps and utilities for the cloud, servers, desktops, and the internet of things.</td>
    </tr>
    <tr>
      <td>gem</td>
      <td>Gem is the front-end to RubyGems, the standard package manager for Ruby.</td>
    </tr>
    <tr>
      <td>pip</td>
      <td>Pip is a Python package installer recommended for installing Python packages that are not available in the Debian archive. It can work with version control repositories (currently only Git, Mercurial, and Bazaar repositories), logs output extensively, and prevents partial installs by downloading all requirements before starting installation.</td>
    </tr>
    <tr>
      <td>git</td>
      <td>Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.</td>
    </tr>
  </tbody>
</table>

It is highly recommended to set up our virtual machine (VM) locally to experiment with it. Let us experiment a bit in our local VM and extend it with a few additional packages. First, let us install git by using apt.

<h3>Advanced Package Manager (APT)</h3>

Debian-based Linux distributions use the APT package manager. A package is an archive file containing multiple ".deb" files. The dpkg utility is used to install programs from the associated ".deb" file. APT makes updating and installing programs easier because many programs have dependencies. When installing a program from a standalone ".deb" file, we may run into dependency issues and need to download and install one or multiple additional packages. APT makes this easier and more efficient by packaging together all of the dependencies needed to install a program.

Each Linux distribution uses software repositories that are updated often. When we update a program or install a new one, the system queries these repositories for the desired package. Repositories can be labeled as stable, testing, or unstable. Most Linux distributions utilize the most stable or "main" repository. This can be checked by viewing the contents of the /etc/apt/sources.list file. The repository list for Parrot OS is at /etc/apt/sources.list.d/parrot.list.

@htb[/htb]$ cat /etc/apt/sources.list.d/parrot.list

# parrot repository

# this file was automatically generated by parrot-mirror-selector

deb http://htb.deb.parrot.sh/parrot/ rolling main contrib non-free

#deb-src https://deb.parrot.sh/parrot/ rolling main contrib non-free

deb http://htb.deb.parrot.sh/parrot/ rolling-security main contrib non-free

#deb-src https://deb.parrot.sh/parrot/ rolling-security main contrib non-free

APT uses a database called the APT cache. This is used to provide information about packages installed on our system offline. We can search the APT cache, for example, to find all Impacket related packages.

@htb[/htb]$ apt-cache search impacket

impacket-scripts - Links to useful impacket scripts examples

polenum - Extracts the password policy from a Windows system

python-pcapy - Python interface to the libpcap packet capture library (Python 2)

python3-impacket - Python3 module to easily build and dissect network protocols

python3-pcapy - Python interface to the libpcap packet capture library (Python 3)
