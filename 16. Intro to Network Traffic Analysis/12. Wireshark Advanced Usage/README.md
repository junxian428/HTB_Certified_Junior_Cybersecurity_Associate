<h3>Wireshark Advanced Usage</h3>

In this section, we will cover some advanced usage with Wireshark. The project developers have included many different capabilities ranging from tracking TCP conversations to cracking wireless credentials. The inclusion of many different plugins makes Wireshark one of the best traffic analysis tools.

<h3>Plugins</h3>

The analyze and statistics radials provide a plethora of plugins to run against the capture. In this section, we will work through a couple of them. We would cover all of which Wireshark offers, but sadly, it is simply not achievable in an introductory module. I urge everyone to experiment and play as we go through this journey.

<h3>The Statistics and Analyze Tabs</h3>

The Statistics and Analyze tabs can provide us with great insight into the data we are examining. From these points, we can utilize many of the baked-in plugins Wireshark has to offer.

The plugins here can give us detailed reports about the network traffic being utilized. It can show us everything from the top talkers in our environment to specific conversations and even breakdown by IP and protocol.

<h3>Statistics Tab</h3>

<img width="824" height="462" alt="image" src="https://github.com/user-attachments/assets/6bc79e5a-e6dd-45a7-98c3-2af000f89e0d" />

<h3>Analyze</h3>

From the Analyze tab, we can utilize plugins that allow us to do things such as following TCP streams, filter on conversation types, prepare new packet filters and examine the expert info Wireshark generates about the traffic. Below are a few examples of how to use these plugins.

<h3>Analyze Tab</h3>

<img width="830" height="710" alt="image" src="https://github.com/user-attachments/assets/c1f1cc96-a289-4c79-88d0-4c11d23c4bae" />

<h3>Following TCP Streams</h3>

Wireshark can stitch TCP packets back together to recreate the entire stream in a readable format. This ability also allows us to pull data (images, files, etc.) out of the capture. This works for almost any protocol that utilizes TCP as a transport mechanism.

To utilize this feature:

- right-click on a packet from the stream we wish to recreate.

- select follow → TCP

- this will open a new window with the stream stitched back together. From here, we can see the entire conversation.

<h3>Follow A Stream Via GUI</h3>

<img width="829" height="428" alt="image" src="https://github.com/user-attachments/assets/80e040a2-f79d-4610-8b4d-1aa2654d1f9b" />

Alternatively, we can utilize the filter tcp.stream eq # to find and track conversations captured in the pcap file.

<h3>Filter For A Specific TCP Stream</h3>

<img width="863" height="578" alt="image" src="https://github.com/user-attachments/assets/c04f453b-9f4c-4ae9-a937-2bf546786f92" />

<h3>Extract Files From The GUI</h3>

<img width="835" height="678" alt="image" src="https://github.com/user-attachments/assets/96554d21-902b-4443-b14c-052b145beb47" />

<h3>FTP Disector</h3>

<img width="836" height="668" alt="image" src="https://github.com/user-attachments/assets/1a85f7ce-daff-4e44-94f0-be0bdfc517b4" />

<h3>FTP-Request-Command Filter</h3>

<img width="847" height="707" alt="image" src="https://github.com/user-attachments/assets/ee054c29-7558-4fce-b4e6-6b7bd48fc527" />

<h3>FTP-Data Filter</h3>

<img width="831" height="630" alt="image" src="https://github.com/user-attachments/assets/ce491aba-b558-4dd5-b450-a30ad34ac5d7" />

Since FTP utilizes TCP as its transport mechanism, we can utilize the follow tcp stream function we utilized earlier in the section to group any conversation we wish to explore. The basic steps to dissect FTP data from a pcap are as follows:

1. Identify any FTP traffic using the ftp display filter.

2. Look at the command controls sent between the server and hosts to determine if anything was transferred and who did so with the ftp.request.command filter.

3. Choose a file, then filter for ftp-data. Select a packet that corresponds with our file of interest and follow the TCP stream that correlates to it.

4. Once done, Change "Show and save data as" to "Raw" and save the content as the original file name.

5. Validate the extraction by checking the file type.

 Which plugin tab can provide us with a way to view conversation metadata and even protocol breakdowns for the entire PCAP file?
 
Statistics

+ 0  What plugin tab will allow me to accomplish tasks such as applying filters, following streams, and viewing expert info?
  
Analyze

+ 0  What stream oriented Transport protocol enables us to follow and rebuild conversations and the included data?

  
TCP

+ 0  True or False: Wireshark can extract files from HTTP traffic.
  
True

+ 0  True or False: The ftp-data filter will show us any data sent over TCP port 21.
  
False
