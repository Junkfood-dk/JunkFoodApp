import 'package:junkfood/domain/model/dish_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dish_controller.g.dart';

@riverpod
class DishController extends _$DishController {
  @override
  DishModel? build() {
    return null;
  }

  void set(DishModel dish) {
    state = dish;
  }
}
