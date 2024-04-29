class RatingModel {
  int id;
  int rating;
  String user_guid; // for only accepting one answer per user per dish
  int dish_id;

  RatingModel(
      {this.id = -1,
      required this.rating,
      this.user_guid = "placeholder",
      required this.dish_id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'future_user_guid': user_guid,
      'dish_id': dish_id,
    };
  }
}
