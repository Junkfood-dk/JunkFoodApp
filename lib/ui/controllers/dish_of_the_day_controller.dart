import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:junkfood/data/dish_repository.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/providers/date_provider.dart';
import 'package:junkfood/ui/controllers/locale_controller.dart';

part 'dish_of_the_day_controller.g.dart';

@riverpod
class DishOfTheDayController extends _$DishOfTheDayController {
  @override
  Future<List<DishModel>> build() {
    var dishRepo = ref.read(dishRepositoryProvider);
    var selectedDate = ref.watch(dateProviderProvider);
    var locale = ref.watch(localeControllerProvider);

    // Get language code from locale, default to English
    String languageCode = locale.value?.languageCode ?? 'en';

    return dishRepo.fetchDishOfDayWithLanguage(selectedDate, languageCode);
  }

  Future<void> refetchDishOfTheDay() async {
    var dishRepo = ref.read(dishRepositoryProvider);
    var selectedDate = ref.read(dateProviderProvider);
    var locale = ref.read(localeControllerProvider);

    // Get language code from locale, default to English
    String languageCode = locale.value?.languageCode ?? 'en';

    state = AsyncData(
      await dishRepo.fetchDishOfDayWithLanguage(selectedDate, languageCode),
    );
  }
}
