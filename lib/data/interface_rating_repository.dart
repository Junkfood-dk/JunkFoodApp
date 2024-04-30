import 'package:userapp/domain/model/rating_model.dart';

abstract interface class IRatingRepository {
  void postNewRating(int rating, int dish);
}
