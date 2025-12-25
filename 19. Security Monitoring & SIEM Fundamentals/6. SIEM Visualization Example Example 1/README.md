<h3>SIEM Visualization Example 1: Failed Logon Attempts (All Users)</h3>

Dashboards in SIEM solutions serve as containers for multiple visualizations, allowing us to organize and display data in a meaningful way.

In this and the following sections, we will create a dashboard and some visualizations from scratch.

<h3>Developing Our First Dashboard & Visualization</h3>

Navigate to the bottom of this section and click on Click here to spawn the target system!

Now, navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard".

Delete the existing "SOC-Alerts" dashboard as follows.

<img width="826" height="342" alt="image" src="https://github.com/user-attachments/assets/ce6940ee-33cf-4eb0-af60-a2661f11ee7d" />

When visiting the Dashboard page again we will be presented with a message indicating that no dashboards currently exist. Additionally, there will be an option available to create a new Dashboard and its first visualization. To initiate the creation of our first dashboard, we simply have to click on the "Create new dashboard" button.

<img width="822" height="505" alt="image" src="https://github.com/user-attachments/assets/962ec60e-3add-4303-a57c-539d3b4b46d6" />

Now, to initiate the creation of our first visualization, we simply have to click on the "Create visualization" button.

<img width="826" height="691" alt="image" src="https://github.com/user-attachments/assets/d0bd5d56-2217-4447-bc11-5f6ab9265f08" />

Upon initiating the creation of our first visualization, the following new window will appear with various options and settings.

Before proceeding with any configuration, it is important for us to first click on the calendar icon to open the time picker. Then, we need to specify the date range as "last 15 years". Finally, we can click on the "Apply" button to apply the specified date range to the data.

<img width="826" height="507" alt="image" src="https://github.com/user-attachments/assets/86552ff1-6952-4e05-a3d8-f13ef47f92ce" />

There are four things for us to notice on this window:

1. A filter option that allows us to filter the data before creating a graph. For example, if our goal is to display failed logon attempts, we can use a filter to only consider event IDs that match 4625 – Failed logon attempt on a Windows system. The following image demonstrates how we can specify such a filter.

<img width="791" height="491" alt="image" src="https://github.com/user-attachments/assets/ea0c2f9e-574e-4efb-ba1f-dbed0036d2c0" />

2. This field indicates the data set (index) that we are going to use. It is common for data from various infrastructure sources to be separated into different indices, such as network, Windows, Linux, etc. In this particular example, we will specify windows* in the "Index pattern".

3. This search bar provides us with the ability to double-check the existence of a specific field within our data set, serving as another way to ensure that we are looking at the correct data. For example, let's say we are interested in the user.name.keyword field. We can use the search bar to quickly perform a search and verify if this field is present and discovered within our selected data set. This allows us to confirm that we are accessing the desired field and working with accurate data.

<img width="810" height="762" alt="image" src="https://github.com/user-attachments/assets/ca44d103-d361-43a6-8435-a07f56322abf" />

<img width="983" height="671" alt="image" src="https://github.com/user-attachments/assets/f4e0d6e6-f3e7-440a-84f7-34c6015fa53f" />

"Why user.name.keyword and not user.name?", you may ask. We should use the .keyword field when it comes to aggregations. Please refer to this stackoverflow question for a more elaborate answer.

4. Lastly, this drop-down menu enables us to select the type of visualization we want to create. The default option displayed in the earlier image is "Bar vertical stacked". If we click on that button, it will reveal additional available options (image redacted as not all options fit on the screen). From this expanded list, we can choose the desired visualization type that best suits our requirements and data presentation needs.

<img width="993" height="747" alt="image" src="https://github.com/user-attachments/assets/61324e6e-9ba9-4ad7-861c-542f15d3d616" />


For this visualization, let's select the "Table" option. After selecting the "Table", we can proceed to click on the "Rows" option. This will allow us to choose the specific data elements that we want to include in the table view.

<img width="1026" height="486" alt="image" src="https://github.com/user-attachments/assets/c6c8538b-a1bf-4ffe-b96b-4d0bd2f6f902" />

Let's configure the "Rows" settings as follows.

<img width="1041" height="657" alt="image" src="https://github.com/user-attachments/assets/3d63adf5-6873-4b88-9655-4875daf29137" />

Note: You will notice Rank by Alphabetical and not Rank by Count of records like in the screenshot above. This is OK. By the time you perform the next configuration below, Count of records will become available.

Moving forward, let's close the "Rows" window and proceed to enter the "Metrics" configuration.

<img width="1022" height="707" alt="image" src="https://github.com/user-attachments/assets/7abb2bca-a867-46dc-a3d2-5f97ca6b6d20" />

In the "Metrics" window, let's select "count" as the desired metric.

<img width="802" height="696" alt="image" src="https://github.com/user-attachments/assets/4ad04c3c-5a08-40c2-baa8-5fa03efdce08" />

As soon as we select "Count" as the metric, we will observe that the table gets populated with data (assuming that there are events present in the selected data set)

<img width="810" height="397" alt="image" src="https://github.com/user-attachments/assets/57a9d1c4-2b7f-4faf-b11d-e850e3826677" />

One final addition to the table is to include another "Rows" setting to show the machine where the failed logon attempt occurred. To do this, we will select the host.hostname.keyword field, which represents the computer reporting the failed logon attempt. This will allow us to display the hostname or machine name alongside the count of failed logon attempts, as shown in the image.

<img width="818" height="315" alt="image" src="https://github.com/user-attachments/assets/72884a81-cd63-4dcb-a075-2e7a59a99fe1" />

Now we can see three columns in the table, which contain the following information:

1. The username of the individuals logging in (Note: It currently displays both users and computers. Ideally, a filter should be implemented to exclude computer devices and only display users).

2. The machine on which the logon attempt occurred.

3. The number of times the event has occurred (based on the specified time frame or the entire data set, depending on the settings).

Finally, click on "Save and return", and you will observe that the new visualization is added to the dashboard, appearing as shown in the following image.

<img width="815" height="603" alt="image" src="https://github.com/user-attachments/assets/75b7fdb0-ba72-49e0-adb4-147f9b050dac" />

Let's not forget to save the dashboard as well. We can do so by simply clicking on the "Save" button.

<img width="815" height="452" alt="image" src="https://github.com/user-attachments/assets/e9d2476d-1415-480f-8472-fca22bc214ba" />

<h3>Refining The Visualization</h3>

Suppose the SOC Manager suggested the following refinements:

- Clearer column names should be specified in the visualization

- The Logon Type should be included in the visualization

- The results in the visualization should be sorted

- The DESKTOP-DPOESND, WIN-OK9BH1BCKSD, and WIN-RMMGJA7T9TC usernames should not be monitored

- Computer accounts should not be monitored (not a good practice)

Let's refine the visualization we created, so that it fulfills the suggestions above.

Navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard".

The dashboard we previously created should be visible. Let's click on the "pencil"/edit icon.

<img width="813" height="280" alt="image" src="https://github.com/user-attachments/assets/276d04c2-bb14-4fa9-9d55-d5444d088515" />

Let's now click on the "gear" button at the upper-right corner of our visualization, and then click on "Edit lens".

<img width="812" height="415" alt="image" src="https://github.com/user-attachments/assets/dfe65f62-4f05-4c25-a1e3-0319512cf6ef" />

"Top values of user.name.keyword" should be changed as follows.

<img width="798" height="561" alt="image" src="https://github.com/user-attachments/assets/74530658-c9e0-4f76-949b-8da9a3210615" />

<img width="803" height="702" alt="image" src="https://github.com/user-attachments/assets/eb5bab4b-1c1f-4b72-839c-698c2e4b4438" />

"Top values of host.hostname.keyword" should be changed as follows.

<img width="822" height="707" alt="image" src="https://github.com/user-attachments/assets/b692675b-f238-48df-bb40-28cde52c2ba3" />

The "Logon Type" can be added as follows (we will use the winlog.logon.type.keyword field).

<img width="830" height="747" alt="image" src="https://github.com/user-attachments/assets/cccb1992-611e-4e4f-ab33-789385a8e3d9" />

<img width="797" height="771" alt="image" src="https://github.com/user-attachments/assets/4e7d4dbf-3065-4e1a-b650-658f4ea1b072" />

"Count of records" should be changed as follows.

<img width="825" height="482" alt="image" src="https://github.com/user-attachments/assets/536789b5-a903-445e-a3c8-5f032cc42cbc" />

We can introduce result sorting as follows. Elastic dashboard showing a table with columns: Username, Event logged by, Logon Type, and '# of logins' sorted descending.

<img width="817" height="508" alt="image" src="https://github.com/user-attachments/assets/1a494e1f-35fe-477c-8ec9-3637a8fb9716" />

All we have to do now is click on "Save and return".

The DESKTOP-DPOESND, WIN-OK9BH1BCKSD, and WIN-RMMGJA7T9TC usernames can be excluded by specifying additional filters as follows.

<img width="816" height="600" alt="image" src="https://github.com/user-attachments/assets/2070793e-9a31-4548-9804-06c6bdbc852c" />

Computer accounts can be excluded by specifying the following KQL query and clicking on the "Update" button.

NOT user.name: *$ AND winlog.channel.keyword: Security

The AND winlog.channel.keyword: Security part is to ensure that no unrelated logs are accounted for.

<img width="820" height="455" alt="image" src="https://github.com/user-attachments/assets/594f4eaf-9199-40aa-a8c7-3ebdb0dba11b" />

This is our visualization after all the refinements we performed.

<img width="818" height="455" alt="image" src="https://github.com/user-attachments/assets/53dcf980-b19d-4dd7-96e9-38002eda2fe8" />

Finally, let's give our visualization a title by clicking on "No Title".

<img width="812" height="457" alt="image" src="https://github.com/user-attachments/assets/307af3d3-02f3-49ac-84f6-882d23bc590b" />

Don't forget to click on the "Save" button (the one on the upper-right hand side of the window).

Please allow 3-5 minutes for Kibana to become available after spawning the target of the questions below.

 Navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard". Browse the refined visualization we created or the "Failed logon attempts [All users]" visualization, if it is available, and enter the number of logins for the sql-svc1 account as your answer.
 
2
