## Initial database model

We have choosen an intial database model based on our interview of the chefs and business administrator of Junkfood.

### Dishes
A table consisting of the title, the image and the description of the dish.

### Dishtype
We have chosen to create a table called DishType as a way of differentiating between main, alternative and desserts, to make it easier to present the dishes in the right order, such that every dish gets a reference to a dishtype.

### Category
Junkfood wants a way to gather data of their dishes and how much the users likes them. Therefore we add this table to collect data in the future.
In this manner, a dish does not have to be directly rated, but rather; the category. That is because it is not necessarily the same instance of the dish that is used multiple times, and therefore the data could be corrupted.

### Allergens
Is a list of allergens.

### DishSchedule
Here a dish is stored by its id together with a serving date. This way you can query the table for all dishes for the current day, thereby creating a menu, if more dishes is added to the same date.

### ServingSpots
A list of serving spots and a specifiction on which day they serve Junkfood's food, which of, at the present moment, just serves a staic list on the app, which junkfood can add to, if a new serving spot is found. 
In the future this could be related to the DishSchedule, so that the list on the app is dynamic, only showing the spots where the food is served on the current day.

![Intial-IR-diagramv4 drawio](https://github.com/Junkfood-dk/JunkFoodAdmin/assets/118807770/513a771f-8855-4af1-89f6-84958172a0aa)




