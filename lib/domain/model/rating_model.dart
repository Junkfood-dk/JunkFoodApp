class RatingModel {
  int rating;
  // String user_guid; // for only accepting one answer per user per dish
  int dishId;

  RatingModel({
    required this.rating,
    // this.user_guid = "placeholder",
    required this.dishId,
  });

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      // 'future_user_guid': user_guid,
      'dish_id': dishId,
    };
  }

  static RatingModel fromJson(Map<String, dynamic> input) {
    return RatingModel(
      rating: input.containsKey(
        'rating',
      ) // if contains key from database (name of column in db)
          ? input['rating'] // then insert the value from the name
          : throw Exception('Missing rating input'),
      dishId: input.containsKey('dish_id')
          ? input['dish_id']
          : throw Exception('Missing dish_id input'),
    );
  }
}
