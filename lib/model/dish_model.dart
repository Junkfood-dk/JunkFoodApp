import 'dart:ui';

class DishModel {
  int id;
  String title;
  String description;
  int calories;
  String imageUrl;
  String dishType;
  List<String> allergens;

  DishModel(
      {required this.title,
      this.description = "",
      this.calories = 0,
      this.imageUrl = "",
      this.dishType = "",
      this.id = -1,
      this.allergens = const [],
      });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'calories': calories,
      'image': imageUrl,
      'dishType': dishType,
    };
  }

  static DishModel fromJson(Map<String, dynamic> input) {
    return DishModel(
      id: input.containsKey("id")
          ? input["id"]
          : throw Exception("No id provided"),
      title: input.containsKey("title")
          ? input["title"]
          : throw Exception("No title provided"),
      description: input.containsKey("description") ? input["description"] : "",
      calories: input.containsKey("calories") ? input["calories"] : 0,
      imageUrl: input.containsKey("image") ? input["image"] : "",
      dishType: input.containsKey("dish_type") ? input["dish_type"] : "",
    );
  }
}
