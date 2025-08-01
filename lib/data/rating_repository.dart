import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:junkfood/data/database.dart';
import 'package:junkfood/data/interface_rating_repository.dart';
import 'package:junkfood/domain/model/rating_model.dart';

part 'rating_repository.g.dart';

class RatingRepository implements IRatingRepository {
  SupabaseClient database;

  RatingRepository({required this.database});

  @override
  Future<int> postNewRating(int rating, int dish /*Guid user*/) async {
    final ratingToPost = RatingModel(rating: rating, dishId: dish);

    try {
      var response = await database
          .from('Ratings')
          .insert(ratingToPost.toJson())
          .select('id');
      return response[0]['id'];
    } catch (error) {
      throw Exception('Failed to save new rating: $error');
    }
  }

  @override
  Future<int> updateRating(int ratingId, int rating, int dish) async {
    var resposne = await database
        .from('Ratings')
        .update({'rating': rating})
        .eq('id', ratingId)
        .select();
    return resposne[0]['id'];
  }
}

@riverpod
IRatingRepository ratingRepository(Ref ref) {
  return RatingRepository(database: ref.read(databaseProvider));
}
