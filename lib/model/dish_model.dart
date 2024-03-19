class DishModel {
  String title;
  String description;
  int calories;
  String imageUrl;
  int dishType;

  DishModel(
      {required this.title,
      this.description = "",
      this.calories = 0,
      this.imageUrl = "",
      this.dishType = -1});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'calories': calories,
      'image': imageUrl,
      'dishType': dishType
    };
  }

  static DishModel fromJson(Map<String, dynamic> input) {
    return DishModel(
        title: input.containsKey("title")
            ? input["title"]
            : throw Exception("No title provided"),
        description:
            input.containsKey("description") ? input["description"] : "",
        calories: input.containsKey("calories") ? input["calories"] : 0,
        imageUrl: input.containsKey("image") ? input["image"] : "",
        dishType: input.containsKey("dishType") ? input["dishType"] : -1);
  }
}
