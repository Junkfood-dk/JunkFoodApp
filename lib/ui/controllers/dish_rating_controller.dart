import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:userapp/data/local_rating_storage_repository.dart';
import 'package:userapp/data/rating_repository.dart';

part 'dish_rating_controller.g.dart';

@riverpod
class DishRatingController extends _$DishRatingController {
  @override
  List<String>? build() {
    var localStorageRepo = ref.watch(localRatingStorageRepositoryProvider);
    List<String>? dateRating = [];
    switch (localStorageRepo) {
      case (AsyncData(:final value)):
        dateRating = value.getRatingForDay(
            DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()));
    }
    return dateRating;
  }

  Future<bool> isRatingForDishDifferent(int dishId, int rating) async {
    var localStorageRepo = ref.watch(localRatingStorageRepositoryProvider);
    List<String>? dateRating;
    switch (localStorageRepo) {
      case (AsyncData(:final value)):
        dateRating = value.getRatingForDay(
            DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()));
    }
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

  void setUserRating(int dishId, int rating) async {
    var localStorageRepo = ref.watch(localRatingStorageRepositoryProvider);
    List<String>? dateRating; 
    switch (localStorageRepo) {
      case (AsyncData(:final value)):
        dateRating = value.getRatingForDay(DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()));
    }
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
      switch (localStorageRepo) {
        case (AsyncData(:final value)):
          value.saveRatingForDay(
              DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()), save);
      }
    } else {
      var ratingId = await ref
          .read(ratingRepositoryProvider)
          .postNewRating(rating, dishId);
      switch (localStorageRepo) {
        case (AsyncData(:final value)):
          value.saveRatingForDay(
              DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()),
              <String>[
                jsonEncode(_RatingStore(
                    dishId: dishId, ratingId: ratingId, rating: rating))
              ]);
      }
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
