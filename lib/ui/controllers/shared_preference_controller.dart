import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'shared_preference_controller.g.dart';

@riverpod
class SharedPreferencesController extends _$SharedPreferencesController {
  int rating = -1;
  SharedPreferences? prefs;
  @override
  Future<SharedPreferences?> build() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  void setUserRating(int dishId, int rating) async {
    var dateRating = prefs!.getStringList(
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()));
    var save = <String>[];
    var dishHasBeenUpdated = false;
    if (dateRating != null) {
      for (var json in dateRating) {
        var userMap = jsonDecode(json) as Map<String, dynamic>;
        var decoded = _RatingStore.fromJsonString(userMap);
        if (decoded.dishId == dishId) {
          dishHasBeenUpdated = true;
          if (decoded.rating != rating) {
            // Make DB call to decoded.ratingId;
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
      prefs!.setStringList(
          DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()), save);
      debugPrint(prefs!
          .getStringList(
              DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()))
          .toString());
    } else {
      // Post to db get rating id back
      prefs!.setStringList(
          DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()),
          <String>[
            jsonEncode(
                _RatingStore(dishId: dishId, ratingId: 1, rating: rating))
          ]);
    }
  }

  void setRating(int val) {
    rating = val;
  }

  int getRating() {
    return rating;
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
