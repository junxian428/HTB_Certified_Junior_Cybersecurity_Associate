<h3>SIEM Visualization Example 2: Failed Logon Attempts (Disabled Users)</h3>

In this SIEM visualization example we want to create visualization to monitor failed login attempts against disabled users.

We mention "failed" because it is not possible to log in with a disabled user, so it will never be successful even if the correct credentials are provided. In a scenario where the correct credentials are provided, the Windows logs will contain an additional SubStatus value of 0xC0000072, that indicates the reason of the failure.

Navigate to the bottom of this section and click on Click here to spawn the target system!.

Navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard".

A prebaked dashboard should be visible. Let's click on the "pencil"/edit icon.

<img width="976" height="342" alt="image" src="https://github.com/user-attachments/assets/9522c442-2f26-4c0a-8b79-337fff638ada" />

Now, to initiate the creation of our first visualization, we simply have to click on the "Create visualization" button.

Upon initiating the creation of our first visualization, the following new window will appear with various options and settings.

<img width="983" height="607" alt="image" src="https://github.com/user-attachments/assets/6d7be284-91f0-4ebc-bc55-acf395746688" />

There are four things for us to notice on this window:

1. A filter option that allows us to filter the data before creating a graph. In this case our goal is to display failed logon attempts against disabled users only. We can use a filter to only consider event IDs that match 4625 – Failed logon attempt on a Windows system, like we did in the previous visualization example. In this case though, we should also take into account the SubStatus (winlog.event_data.SubStatus field) that indicates, when set to 0xC0000072, that the failure is due to a logon with disabled user. The following image demonstrates how we can specify such a filter.

<img width="938" height="488" alt="image" src="https://github.com/user-attachments/assets/4b65b64d-3dfc-4d44-ab8a-9bfad10f5a8d" />

2. This field indicates the data set (index) that we are going to use. It is common for data from various infrastructure sources to be separated into different indices, such as network, Windows, Linux, etc. In this particular example, we will specify windows* in the "Index pattern".

3. This search bar provides us with the ability to double-check the existence of a specific field within our data set, serving as another way to ensure that we are looking at the correct data. Like in the previous visualization, we are interested in the user.name.keyword field. We can use the search bar to quickly perform a search and verify if this field is present and discovered within our selected data set. This allows us to confirm that we are accessing the desired field and working with accurate data.

<img width="941" height="846" alt="image" src="https://github.com/user-attachments/assets/f4bcc231-c377-47d3-a3ba-4dde3de6dd39" />

4. Lastly, this drop-down menu enables us to select the type of visualization we want to create. The default option displayed in the earlier image is "Bar vertical stacked". If we click on that button, it will reveal additional available options (image redacted as not all options fit on the screen). From this expanded list, we can choose the desired visualization type that best suits our requirements and data presentation needs.

<img width="940" height="728" alt="image" src="https://github.com/user-attachments/assets/6fae1339-1133-4499-aa76-7e192b77975b" />

For this visualization, let's select the "Table" option. After selecting the "Table", we can proceed to click on the "Rows" option. This will allow us to choose the specific data elements that we want to include in the table view.

<img width="986" height="476" alt="image" src="https://github.com/user-attachments/assets/2db2285d-9096-4d71-a693-608367af5423" />

Let's configure the "Rows" settings as follows.

<img width="982" height="626" alt="image" src="https://github.com/user-attachments/assets/617f9f97-4e72-44bf-8c26-495fbe23022f" />

Moving forward, let's close the "Rows" window and proceed to enter the "Metrics" configuration.

<img width="965" height="327" alt="image" src="https://github.com/user-attachments/assets/b9d03bec-43e5-4319-9f97-d126e5e25a17" />

In the "Metrics" window, let's select "count" as the desired metric.

<img width="978" height="807" alt="image" src="https://github.com/user-attachments/assets/c9b6b90f-1523-46d3-b753-87e8ac0571bd" />

One final addition to the table is to include another "Rows" setting to show the machine where the failed logon attempt occurred. To do this, we will select the host.hostname.keyword field, which represents the computer reporting the failed logon attempt. This will allow us to display the hostname or machine name alongside the count of failed logon attempts, as shown in the image.

<img width="987" height="273" alt="image" src="https://github.com/user-attachments/assets/48da62a3-02e5-4cf4-a717-c2d8bdff74bb" />

Now we can see three columns in the table, which contain the following information:

1. The disabled user whose credentials generated the failed logon attempt event.

2. The machine on which the logon attempt occurred.

3. The number of times the event has occurred (based on the specified time frame or the entire data set, depending on the settings).

Finally, click on "Save and return", and you will observe that the new visualization is added to the dashboard.

Please allow 3-5 minutes for Kibana to become available after spawning the target of the questions below.


Navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard". Either create a new visualization or edit the "Failed logon attempts [Disabled user]" visualization, if it is available, so that it includes failed logon attempt data related to disabled users including the logon type. What is the logon type in the returned document?

Interactive

+ 1  Navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard". Either create a new visualization or edit the "Failed logon attempts [Admin users only]" visualization, if it is available, so that it includes failed logon attempt data where the username field contains the keyword "admin" anywhere within it. What should you specify after user.name: in the KQL query?

*admin*

