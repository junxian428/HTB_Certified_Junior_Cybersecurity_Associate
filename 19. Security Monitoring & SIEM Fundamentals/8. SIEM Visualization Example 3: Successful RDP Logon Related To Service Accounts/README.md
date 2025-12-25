<h3>SIEM Visualization Example 3: Successful RDP Logon Related To Service Accounts</h3>

In this SIEM visualization example, we aim to create a visualization to monitor successful RDP logons specifically related to service accounts. Service account credentials are never used for RDP logons in corporate/real-world environments. We have been informed by the IT Operations department that all service accounts on the environment start with svc-.

The motivation for this visualization stems from the fact that service accounts often possess exceptionally high privileges. We need to keep a close eye on how service accounts are used.

Our visualization will be based on the following Windows event log.

4624: An account was successfully logged on

Navigate to the bottom of this section and click on Click here to spawn the target system!.

Navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard".

A prebaked dashboard should be visible. Let's click on the "pencil"/edit icon.

<img width="977" height="328" alt="image" src="https://github.com/user-attachments/assets/9ca5915c-1630-436e-a2cf-a14d1acf1cdc" />

Now, to initiate the creation of our first visualization, we simply have to click on the "Create visualization" button.

Upon initiating the creation of our first visualization, the following new window will appear with various options and settings.

<img width="987" height="613" alt="image" src="https://github.com/user-attachments/assets/89e52812-d747-469f-963b-4b22659a02d7" />

There are five things for us to notice on this window:

1. A filter option that allows us to filter the data before creating a graph. In this case our goal is to display successful RDP logons specifically related to service accounts. We can use a filter to only consider event IDs that match 4624 – An account was successfully logged on. In this case though, we should also take into account the logon type which should be RemoteInteractive (winlog.logon.type field). The following images demonstrates how we can specify such filters.

<img width="943" height="531" alt="image" src="https://github.com/user-attachments/assets/4e1d627e-f54a-487f-bbd4-a8ea70de0ffc" />

<img width="950" height="535" alt="image" src="https://github.com/user-attachments/assets/3290a573-36f6-4076-8205-f4984fcf85b5" />


2. This field indicates the data set (index) that we are going to use. It is common for data from various infrastructure sources to be separated into different indices, such as network, Windows, Linux, etc. In this particular example, we will specify windows* in the "Index pattern".

3. This search bar provides us with the ability to double-check the existence of a specific field within our data set, serving as another way to ensure that we are looking at the correct data. We are interested in the user.name.keyword field. We can use the search bar to quickly perform a search and verify if this field is present and discovered within our selected data set. This allows us to confirm that we are accessing the desired field and working with accurate data.

<img width="946" height="852" alt="image" src="https://github.com/user-attachments/assets/937e6292-5926-4d8d-949c-ff8c2c6eedd3" />

<img width="910" height="817" alt="image" src="https://github.com/user-attachments/assets/9519106d-825f-4175-80c8-bf36f4d37b90" />

4. Lastly, this drop-down menu enables us to select the type of visualization we want to create. The default option displayed in the earlier image is "Bar vertical stacked". If we click on that button, it will reveal additional available options (image redacted as not all options fit on the screen). From this expanded list, we can choose the desired visualization type that best suits our requirements and data presentation needs.

<img width="932" height="727" alt="image" src="https://github.com/user-attachments/assets/d5a01c63-922c-4710-96e1-e904eb0e3724" />

For this visualization, let's select the "Table" option. After selecting the "Table", we can proceed to click on the "Rows" option. This will allow us to choose the specific data elements that we want to include in the table view.

<img width="1002" height="488" alt="image" src="https://github.com/user-attachments/assets/d5be355c-6387-4663-adad-bd511354e2f2" />

Let's configure the "Rows" settings as follows.

<img width="988" height="803" alt="image" src="https://github.com/user-attachments/assets/858c44ef-705c-45fa-97f4-058e0e234a6f" />

Moving forward, let's close the "Rows" window and proceed to enter the "Metrics" configuration.

<img width="975" height="716" alt="image" src="https://github.com/user-attachments/assets/6da956b3-9b6c-465c-a45b-283812b6c49d" />

In the "Metrics" window, let's select "count" as the desired metric.

<img width="990" height="726" alt="image" src="https://github.com/user-attachments/assets/c7fd4159-b78e-4f2a-aadb-c614ba927f78" />

One final addition to the table is to include two more "Rows" settings to show the machine where the successful RDP logon attempt occurred and the machine that initiated the successful RDP logon attempt. To do this, we will select the host.hostname.keyword field that represents the computer reporting the successful RDP logon attempt and the related.ip.keyword field that represents the IP of the computer initiating the succsessful RDP logon attempt. This will allow us to display the involved machines alongside the count of successful logon attempts, as shown in the image.

<img width="957" height="840" alt="image" src="https://github.com/user-attachments/assets/90ef7736-0091-4af0-bce1-7c34f2b8e527" />

<img width="955" height="857" alt="image" src="https://github.com/user-attachments/assets/ea194414-fe13-4e77-bfbe-804142d4619d" />

As discussed, we want to monitor successful RDP logons specifically related to service accounts, knowing for a fact that all service accounts of the environment start with svc-. So, to conclude our visualization we need to specify the following KQL query.

user.name: svc-*

Note: As you can see we don't use the .keyword field in KQL queries.

<img width="990" height="670" alt="image" src="https://github.com/user-attachments/assets/09a37443-d751-43f9-91f0-bf407f169377" />

Now we can see four columns in the table, which contain the following information:

1. The service account whose credentials generated the successful RDP logon attempt event.

2. The machine on which the logon attempt occurred.

3. The IP of the machine that initiated the logon attempt.

4. The number of times the event has occurred (based on the specified time frame or the entire data set, depending on the settings).

Finally, click on "Save and return", and you will observe that the new visualization is added to the dashboard.

Please allow 3-5 minutes for Kibana to become available after spawning the target of the questions below.

Navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard". Browse the visualization we created or the "RDP logon for service account" visualization, if it is available, and enter the IP of the machine that initiated the successful RDP logon using service account credentials as your answer.

192.168.28.130
