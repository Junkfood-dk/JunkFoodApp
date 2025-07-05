import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:junkfood/data/dish_repository.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/providers/date_provider.dart';

part 'dish_of_the_day_controller.g.dart';

@riverpod
class DishOfTheDayController extends _$DishOfTheDayController {
  @override
  Future<List<DishModel>> build() {
    var dishRepo = ref.read(dishRepositoryProvider);
    var selectedDate = ref.watch(dateProviderProvider);
    return dishRepo.fetchDishOfDay(selectedDate);
  }

  Future<void> refetchDishOfTheDay() async {
    var selectedDate = ref.read(dateProviderProvider);
    state =
        AsyncData(await ref.read(dishRepositoryProvider).fetchDishOfDay(selectedDate));
  }
}
