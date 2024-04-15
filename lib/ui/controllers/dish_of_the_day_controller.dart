import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:userapp/data/dish_repository.dart';
import 'package:userapp/domain/model/dish_model.dart';

part 'dish_of_the_day_controller.g.dart';

@riverpod
class DishOfTheDayController extends _$DishOfTheDayController {
  Future<List<DishModel>> build() {
    var dishRepo = ref.read(dishRepositoryProvider);
    return dishRepo.fetchDishOfTheDay();
  }
}
