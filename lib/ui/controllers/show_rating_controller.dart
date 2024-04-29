
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_rating_controller.g.dart';

@riverpod 
class ShowRatingController extends _$ShowRatingController{
  @override
  bool build() {
    return false;
  }

  bool showRating() {
    state = !state;
    return state;
  }
}