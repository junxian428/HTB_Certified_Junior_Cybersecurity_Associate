<h3>Working with the Registry</h3>

We should be comfortable with the CLI at this point. It's time to level our skills again and tackle one of the more complicated aspects of the Windows operating system, the Registry. This section will walk us through what the Registry is, how to navigate it, and how to read key/value pairs and make changes to it as needed.

<h3>What Is The Windows Registry?</h3>

At its core, the Registry can be considered a hierarchal tree that contains two essential elements: keys and values. This tree stores all the required information for the operating system and the software installed to run under subtrees (think of them as branches of a tree). This information can be anything from settings to installation directories to specific options and values that determine how everything functions. As Pentesters, the Registry is a great spot to find helpful information, plant persistence, and more. MITRE provides many great examples of what a threat actor can do with access (locally or remotely) to a host's registry hive.

<h3>What are Keys</h3>

Keys, in essence, are containers that represent a specific component of the PC. Keys can contain other keys and values as data. These entries can take many forms, and naming contexts only require that a Key be named using alphanumeric (printable) characters and is not case-sensitive. As a visual example of Keys, if we look at the image below, each folder within the Green rectangle is a Key and contains sub-keys.

