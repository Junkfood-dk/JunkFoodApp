import 'package:junkfood/domain/model/dish_model.dart';

abstract interface class IDishRepository {
  /// Fetches dish for specific date with language support for allergens
  Future<List<DishModel>> fetchDishOfDayWithLanguage(
    DateTime date,
    String languageCode,
  );

  /// Legacy methods for backwards compatibility
  Future<List<DishModel>> fetchDishOfTheDay();
  Future<List<DishModel>> fetchDishOfDay(DateTime date);
}
