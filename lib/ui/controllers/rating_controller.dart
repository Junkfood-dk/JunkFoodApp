import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:userapp/data/rating_repository.dart';

part 'rating_controller.g.dart';

@riverpod
class RatingController extends _$RatingController {
  @override
  int build() {
    return -1;
  }

  void changeRating(int rating) {
    state = rating;
  }

  void postRating(int dishId){
    ref.read(ratingRepositoryProvider).postNewRating(state, dishId);
  }
}
