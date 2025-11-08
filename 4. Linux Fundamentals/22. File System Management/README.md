<h3>File System Management</h3>

Managing file systems on Linux is a crucial task that involves organizing, storing, and maintaining data on a disk or other storage device. Linux is a versatile operating system that supports many different file systems, including ext2, ext3, ext4, XFS, Btrfs, and NTFS, among others. Each of these file systems has unique features and is suited to specific use cases. The best file system choice depends on the specific requirements of the application or user such as:

ext2 is an older file system with no journaling capabilities, which makes it less suited for modern systems but still useful in certain low-overhead scenarios (like USB drives).

ext3 and ext4 are more advanced, with journaling (which helps in recovering from crashes), and ext4 is the default choice for most modern Linux systems because it offers a balance of performance, reliability, and large file support.

Btrfs is known for advanced features like snapshotting and built-in data integrity checks, making it ideal for complex storage setups.

XFS excels at handling large files and has high performance. It is best suited for environments with high I/O demands

NTFS, originally developed for Windows, is useful for compatibility when dealing with dual-boot systems or external drives that need to work on both Linux and Windows systems.

When selecting a file system, it’s essential to analyze the needs of the application or user factors such as performance, data integrity, compatibility, and storage requirements will influence the decision.

Linux's file system architecture is based on the Unix model, organized in a hierarchical structure. This structure consists of several components, the most critical being inodes. Inodes are data structures that store metadata about each file and directory, including permissions, ownership, size, and timestamps. Inodes do not store the file’s actual data or name, but they contain pointers to the blocks where the file’s data is stored on the disk.

The inode table is a collection of these inodes, essentially acting as a database that the Linux kernel uses to track every file and directory on the system. This structure allows the operating system to efficiently access and manage files. Understanding and managing inodes is a crucial aspect of file system management in Linux, especially in scenarios where a disk is running out of inode space before running out of actual storage capacity.

Let's use an analogy, think of the Linux file system like a library. The inodes are like index cards in the library’s catalog system (inode table). Each card contains detailed information about a book (file) its title, author, location, and other details but not the actual book. The inode table is the entire catalog that helps the library (operating system) quickly find and manage the books (files).

In Linux, files can be stored in one of several key types:

- Regular files

- Directories

- Symbolic links

<h3>Regular Files</h3>

Regular files are the most common type and typically consist of text data (such as ASCII) and/or binary data (such as images, audio, or executables). They reside in various directories throughout the file system, not just in the root directory. The root directory (/) is simply the top of the hierarchical directory tree, and files can exist in any directory within that structure.

<h3>Directories</h3>

Directories are special types of files that act as containers for other files (both regular files and other directories). When a file is stored in a directory, that directory is referred to as the file’s parent directory. Directories help organize files within the Linux file system, allowing for an efficient way to manage collections of files.

<h3>Symbolic Links</h3>

In addition to regular files and directories, Linux also supports symbolic links (symlinks), which act as shortcuts or references to other files or directories. Symbolic links allow quick access to files located in different parts of the file system without duplicating the file itself. Symlinks can be used to streamline access or organize complex directory structures by pointing to important files across various locations.

Each category of user can have different permission levels. For example, the owner of a file may have permission to read, write, and execute it, while others may only have read access. These permissions are independent for each category, meaning changes to one user’s permissions do not necessarily affect others.

@htb[/htb]$ ls -il

total 0

10678872 -rw-r--r-- 1 cry0l1t3 htb 234123 Feb 14 19:30 myscript.py

10678869 -rw-r--r-- 1 cry0l1t3 htb 43230 Feb 14 11:52 notes.txt

<h3>Disks & Drives</h3>

Disk management on Linux involves managing physical storage devices, including hard drives, solid-state drives, and removable storage devices. The main tool for disk management on Linux is the fdisk, which allows us to create, delete, and manage partitions on a drive. It can also display information about the partition table, including the size and type of each partition. Partitioning a drive on Linux involves dividing the physical storage space into separate, logical sections. Each partition can then be formatted with a specific file system, such as ext4, NTFS, or FAT32, and can be mounted as a separate file system. The most common partitioning tool on Linux is also fdisk, gpart, and GParted.

<h3>Fdisk</h3>

@htb[/htb]$ sudo fdisk -l

Disk /dev/vda: 160 GiB, 171798691840 bytes, 335544320 sectors

Units: sectors of 1 \* 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes

Disklabel type: dos

Disk identifier: 0x5223435f

Device Boot Start End Sectors Size Id Type

/dev/vda1 \* 2048 158974027 158971980 75.8G 83 Linux

/dev/vda2 158974028 167766794 8792767 4.2G 82 Linux swap / Solaris

Disk /dev/vdb: 452 KiB, 462848 bytes, 904 sectors

Units: sectors of 1 \* 512 = 512 bytes

Sector size (logical/physical): 512 bytes / 512 bytes

I/O size (minimum/optimal): 512 bytes / 512 bytes
