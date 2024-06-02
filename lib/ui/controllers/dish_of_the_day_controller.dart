import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:junkfood/data/dish_repository.dart';
import 'package:junkfood/domain/model/dish_model.dart';

part 'dish_of_the_day_controller.g.dart';

@riverpod
class DishOfTheDayController extends _$DishOfTheDayController {
  @override
  Future<List<DishModel>> build() {
    var dishRepo = ref.read(dishRepositoryProvider);
    return dishRepo.fetchDishOfTheDay();
  }

  Future<void> refetchDishOfTheDay() async {
    state =
        AsyncData(await ref.read(dishRepositoryProvider).fetchDishOfTheDay());
  }
}
