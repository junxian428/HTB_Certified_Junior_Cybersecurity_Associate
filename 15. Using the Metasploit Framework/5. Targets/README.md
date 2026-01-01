<h3>Targets</h3>

Targets are unique operating system identifiers taken from the versions of those specific operating systems which adapt the selected exploit module to run on that particular version of the operating system. The show targets command issued within an exploit module view will display all available vulnerable targets for that specific exploit, while issuing the same command in the root menu, outside of any selected exploit module, will let us know that we need to select an exploit module first.

<h3>MSF - Show Targets</h3>

msf6 > show targets

When looking at our previous exploit module, this would be what we see:

msf6 exploit(windows/smb/ms17_010_psexec) > options

<h3>Selecting a Target</h3>

We can see that there is only one general type of target set for this type of exploit. What if we change the exploit module to something that needs more specific target ranges? The following exploit is aimed at:

MS12-063 Microsoft Internet Explorer execCommand Use-After-Free Vulnerability.

If we want to find out more about this specific module and what the vulnerability behind it does, we can use the info command. This command can help us out whenever we are unsure about the origins or functionality of different exploits or auxiliary modules. Keeping in mind that it is always considered best practice to audit our code for any artifact generation or 'additional features', the info command should be one of the first steps we take when using a new module. This way, we can familiarize ourselves with the exploit functionality while assuring a safe, clean working environment for both our clients and us.

<h3>MSF - Target Selection</h3>

msf6 exploit(windows/browser/ie_execcommand_uaf) > info

Looking at the description, we can get a general idea of what this exploit will accomplish for us. Keeping this in mind, we would next want to check which versions are vulnerable to this exploit.

msf6 exploit(windows/browser/ie_execcommand_uaf) > options

Module options (exploit/windows/browser/ie_execcommand_uaf):

We see options for both different versions of Internet Explorer and various Windows versions. Leaving the selection to Automatic will let msfconsole know that it needs to perform service detection on the given target before launching a successful attack.

If we, however, know what versions are running on our target, we can use the set target <index no.> command to pick a target from the list.

msf6 exploit(windows/browser/ie_execcommand_uaf) > show targets

<h3>Target Types</h3>

There is a large variety of target types. Every target can vary from another by service pack, OS version, and even language version. It all depends on the return address and other parameters in the target or within the exploit module.

The return address can vary because a particular language pack changes addresses, a different software version is available, or the addresses are shifted due to hooks. It is all determined by the type of return address required to identify the target. This address can be jmp esp, a jump to a specific register that identifies the target, or a pop/pop/ret. For more on the topic of return addresses, see the Stack-Based Buffer Overflows on Windows x86 module. Comments in the exploit module's code can help us determine what the target is defined by.

To identify a target correctly, we will need to:

- Obtain a copy of the target binaries

- Use msfpescan to locate a suitable return address

Later in the module, we will be delving deeper into exploit development, payload generation, and target identification.
