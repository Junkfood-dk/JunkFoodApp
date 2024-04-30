
-- Basic seed for one dish, no categories or alergenes
INSERT INTO "Dish_type" (id, dish_type) VALUES (0, 'Main Course');
INSERT INTO "Dishes" (id, title, description, image, dish_type, calories) VALUES (0, 'Flæskesteg', 'Flæskesteg m. kartofler og sovs', 'https://ff234d58.rocketcdn.me/wp-content/uploads/2019/10/IMG_8163-min.jpg', 0, 5000);
INSERT INTO "Dish_Schedule" (id, date) VALUES (0, '2024-04-30');