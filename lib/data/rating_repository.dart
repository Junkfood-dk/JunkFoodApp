import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:userapp/data/database.dart';
import 'package:userapp/data/interface_rating_repository.dart';
import 'package:userapp/domain/model/rating_model.dart';

part 'rating_repository.g.dart';

class RatingRepository implements IRatingRepository {
  SupabaseClient database;

  RatingRepository({required this.database});

  @override
  Future<RatingModel> postNewRating(int rating, int dish /*Guid user*/) async {
    final ratingToPost = RatingModel(rating: rating, dish_id: dish);

    try {
      return await database
          .from("Ratings")
          .insert(ratingToPost.toJson())
          .select()
          .then((rows) => RatingModel.fromJson(rows[0]));
    } catch (error) {
      debugPrint("Error saving new rating: $error");
      throw Exception("Failed to save new rating: $error");
    }
  }

  
}

@riverpod
IRatingRepository ratingRepository(RatingRepositoryRef ref) {
  return RatingRepository(database: ref.read(databaseProvider));
}
