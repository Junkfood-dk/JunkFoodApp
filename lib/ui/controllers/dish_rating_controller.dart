import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/data/rating_repository.dart';

part 'dish_rating_controller.g.dart';

@riverpod
class DishRatingController extends _$DishRatingController {
  SharedPreferences? prefs;
  @override
  Future<SharedPreferences?> build() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<List<String>?> getRatingFromDay(DateTime date) async {
    return prefs!
        .getStringList(DateFormat(DateFormat.YEAR_MONTH_DAY).format(date));
  }

  Future<bool> isRatingForDishDifferent(int dishId, int rating) async {
    var dateRating = await getRatingFromDay(DateTime.now());
    if (dateRating != null) {
      for (var json in dateRating) {
        var userMap = jsonDecode(json) as Map<String, dynamic>;
        var decoded = _RatingStore.fromJsonString(userMap);
        if (decoded.dishId == dishId) {
          return rating != decoded.rating;
        }
      }
    }
    return false;
  }

  void saveRatingsForDay(List<String> ratingList, DateTime date) {
    prefs!.setStringList(
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()),
        ratingList);
  }

  void setUserRating(int dishId, int rating) async {
    var dateRating = await getRatingFromDay(DateTime.now());
    var save = <String>[];
    var dishHasBeenUpdated = false;
    if (dateRating != null) {
      for (var json in dateRating) {
        var userMap = jsonDecode(json) as Map<String, dynamic>;
        var decoded = _RatingStore.fromJsonString(userMap);
        if (decoded.dishId == dishId) {
          dishHasBeenUpdated = true;
          if (decoded.rating != rating) {
            ref
                .read(ratingRepositoryProvider)
                .updateRating(decoded.ratingId, rating, dishId);
            decoded.rating = rating;
          }
        }
        var encoded = jsonEncode(decoded);
        save.add(encoded);
      }
      if (!dishHasBeenUpdated) {
        save.add(jsonEncode(
            _RatingStore(dishId: dishId, ratingId: 1, rating: rating)));
      }
      saveRatingsForDay(save, DateTime.now());
    } else {
      var ratingId = await ref
          .read(ratingRepositoryProvider)
          .postNewRating(rating, dishId);
      saveRatingsForDay(<String>[
        jsonEncode(
            _RatingStore(dishId: dishId, ratingId: ratingId, rating: rating))
      ], DateTime.now());
    }
  }
}

class _RatingStore {
  int dishId;
  int ratingId;
  int rating;

  _RatingStore(
      {required this.dishId, required this.ratingId, required this.rating});

  Map<String, dynamic> toJson() =>
      {'dish_id': dishId, 'rating_id': ratingId, 'rating': rating};

  _RatingStore.fromJsonString(Map<String, dynamic> json)
      : dishId = json['dish_id'] as int,
        ratingId = json['rating_id'] as int,
        rating = json['rating'] as int;
}
