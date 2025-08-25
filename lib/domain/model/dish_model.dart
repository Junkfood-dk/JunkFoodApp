class DishModel {
  int id;
  String title;
  String description;
  String? titleEn;
  String? descriptionEn;
  int calories;
  String imageUrl;
  int dishTypeId;
  String dishTypeName;
  List<String> allergens;

  DishModel({
    required this.title,
    this.description = '',
    this.titleEn,
    this.descriptionEn,
    this.calories = 0,
    this.imageUrl = '',
    this.dishTypeId = -1,
    this.dishTypeName = '',
    this.id = -1,
    this.allergens = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'calories': calories,
      'image': imageUrl,
      'dishType': dishTypeName,
    };
  }

  static DishModel fromJson(Map<String, dynamic> input) {
    return DishModel(
      id: input.containsKey('id')
          ? input['id']
          : throw Exception('No id provided'),
      title: input.containsKey('title')
          ? input['title']
          : throw Exception('No title provided'),
      description: input.containsKey('description') ? input['description'] : '',
      titleEn: input['title_en'],
      descriptionEn: input['description_en'],
      calories: input['calories'] ?? 0,
      imageUrl: input.containsKey('image') ? input['image'] : '',
      dishTypeName:
          input['Dish_type'] != null ? input['Dish_type']['dish_type'] : '',
      dishTypeId: input['Dish_type'] != null ? input['Dish_type']['id'] : -1,
    );
  }

  /// Returns the title in the specified language, falling back to Danish if English is not available
  String getTitleForLanguage(String languageCode) {
    if (languageCode == 'en' && titleEn != null && titleEn!.isNotEmpty) {
      return titleEn!;
    }
    return title;
  }

  /// Returns the description in the specified language, falling back to Danish if English is not available
  String getDescriptionForLanguage(String languageCode) {
    if (languageCode == 'en' && descriptionEn != null && descriptionEn!.isNotEmpty) {
      return descriptionEn!;
    }
    return description;
  }
}
