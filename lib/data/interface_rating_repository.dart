import 'package:userapp/domain/model/rating_model.dart';

abstract interface class IRatingRepository {
  Future<RatingModel> postNewRating(String);
}
