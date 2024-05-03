import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/data/rating_repository.dart';
part 'shared_preference_controller.g.dart';

@riverpod
class SharedPreferencesController extends _$SharedPreferencesController {
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
      prefs!.setStringList(
          DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()), save);
      debugPrint(prefs!
          .getStringList(
              DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()))
          .toString());
    } else {
      var ratingId = await ref
          .read(ratingRepositoryProvider)
          .postNewRating(rating, dishId);
      prefs!.setStringList(
          DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()),
          <String>[
            jsonEncode(_RatingStore(
                dishId: dishId, ratingId: ratingId, rating: rating))
          ]);
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
