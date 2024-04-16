Timestamp: April 09, 2024 13:02

## Refetching of data from database ##
With the userapp being a singlepage application, that fetches information from a database, a question arises. 
When to fetch from the database and update information stored in the app.

At first our app constantly ran queries against the database, trying to fetch information. To combat this, 
we have altered the code to only run one initial fetch when the app starts up.

We want it to be able for the user to also refresh the application while having it open. 

### RefreshIndicator ###
To facilitate this behavior of refreshing on-demand, the RefreshIndicator-widget is used.

This widget provides a "pull-to-refresh" functionality, which should follow well-known norms, and hence hopefully lead to an intuitive user experience.
When the RefreshIndicator-widget is triggered, it runs the fetching of data from the database, overwriting previous data stored on the device.
