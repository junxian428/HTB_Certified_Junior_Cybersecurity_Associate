<h3>SIEM Visualization Example 4: Users Added Or Removed From A Local Group (Within A Specific Timeframe)</h3>

In this SIEM visualization example, we aim to create a visualization to monitor user additions or removals from the local "Administrators" group from March 5th 2023 to date.

Our visualization will be based on the following Windows event logs.

4732: A member was added to a security-enabled local group

4733: A member was removed from a security-enabled local group

Navigate to the bottom of this section and click on Click here to spawn the target system!.

Navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard".

A prebaked dashboard should be visible. Let's click on the "pencil"/edit icon.

<img width="978" height="342" alt="image" src="https://github.com/user-attachments/assets/39bf5097-414d-4906-8620-fbc2706efcdf" />

Now, to initiate the creation of our first visualization, we simply have to click on the "Create visualization" button.

Upon initiating the creation of our first visualization, the following new window will appear with various options and settings.

<img width="992" height="605" alt="image" src="https://github.com/user-attachments/assets/642dd9f2-5de3-407d-bc48-fd93b30d3d3e" />

There are four things for us to notice on this window:

1. A filter option that allows us to filter the data before creating a graph. In this case our goal is to display user additions or removals from the local "Administrators" group. We can use a filter to only consider event IDs that match 4732 – A member was added to a security-enabled local group and 4733 – A member was removed from a security-enabled local group. We can also use a filter to only consider 4732 and 4733 events where the local group is the "Administrators" one.

<img width="948" height="433" alt="image" src="https://github.com/user-attachments/assets/fbb72228-9b42-465f-adab-48f9aff506d4" />

2. This field indicates the data set (index) that we are going to use. It is common for data from various infrastructure sources to be separated into different indices, such as network, Windows, Linux, etc. In this particular example, we will specify windows* in the "Index pattern".

3. This search bar provides us with the ability to double-check the existence of a specific field within our data set, serving as another way to ensure that we are looking at the correct data. We are interested in the user.name.keyword field. We can use the search bar to quickly perform a search and verify if this field is present and discovered within our selected data set. This allows us to confirm that we are accessing the desired field and working with accurate data.

 <img width="937" height="871" alt="image" src="https://github.com/user-attachments/assets/b6bb046a-256f-46f3-bd8a-e940efd788f3" />

<img width="936" height="832" alt="image" src="https://github.com/user-attachments/assets/517144da-510f-4aba-9cdc-b9132658dda8" />

4. Lastly, this drop-down menu enables us to select the type of visualization we want to create. The default option displayed in the earlier image is "Bar vertical stacked". If we click on that button, it will reveal additional available options (image redacted as not all options fit on the screen). From this expanded list, we can choose the desired visualization type that best suits our requirements and data presentation needs.

<img width="945" height="730" alt="image" src="https://github.com/user-attachments/assets/75ca5619-ecd2-431d-b770-e49a793eb0e7" />

For this visualization, let's select the "Table" option. After selecting the "Table", we can proceed to click on the "Rows" option. This will allow us to choose the specific data elements that we want to include in the table view.

<img width="985" height="712" alt="image" src="https://github.com/user-attachments/assets/517ff901-1124-4525-a569-f10b66cad265" />

Let's configure the "Rows" settings as follows.

<img width="982" height="635" alt="image" src="https://github.com/user-attachments/assets/d71b1eb0-22a4-439f-9339-905fe15171d7" />

Moving forward, let's close the "Rows" window and proceed to enter the "Metrics" configuration.

<img width="968" height="563" alt="image" src="https://github.com/user-attachments/assets/ab254f7a-4e9e-4aff-8860-c1dc78344052" />

In the "Metrics" window, let's select "count" as the desired metric.

<img width="986" height="711" alt="image" src="https://github.com/user-attachments/assets/94543b6a-1f54-4dda-b941-d3a49ef23b22" />

One final addition to the table is to include some more "Rows" settings to enhance our understanding.

- Which user was added to or removed from the group? (winlog.event_data.MemberSid.keyword field)

- To which group was the addition or the removal performed? (double-checking that it is the "Administrators" one) (group.name.keyword field)

- Was the user added to or removed from the group? (event.action.keyword field)

- On which machine did the action occur? (host.name.keyword field)

Click on "Save and return", and you will observe that the new visualization is added to the dashboard.

As discussed, we want to monitor user additions or removals from the local "Administrators" group within a specific timeframe (March 5th 2023 to date).

We can narrow the scope of our visualization as follows.

<img width="985" height="722" alt="image" src="https://github.com/user-attachments/assets/6b810207-30ef-4ce8-88c2-748e8a812dd3" />

<img width="983" height="721" alt="image" src="https://github.com/user-attachments/assets/6bb119ed-2f7b-4791-9a0d-36c74faa32ef" />

<img width="987" height="716" alt="image" src="https://github.com/user-attachments/assets/120403f1-b5b9-4f8f-9437-be416fbea3ae" />


Finally, let's click on the "Save" button so that all our edits persist.

Please allow 3-5 minutes for Kibana to become available after spawning the target of the questions below.

Note: As Elasticsearch uses buckets to aggregate data (time ranges, etc.) into groups, we must use an absolute time range on every occasion when creating the visualization. If we don't consider this, the bucket will showcase a weekly interval instead of a daily one. For example, an absolute time range can be January 1st to January 31st, 2023.

 Navigate to http://[Target IP]:5601, click on the side navigation toggle, and click on "Dashboard". Extend the visualization we created or the "User added or removed from a local group" visualization, if it is available, and enter the common date on which all returned events took place as your answer. Answer format: 20XX-0X-0X

2023-03-05
