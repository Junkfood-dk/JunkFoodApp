import 'package:junkfood/domain/model/dish_model.dart';

abstract interface class IDishRepository {
  Future<List<DishModel>> fetchDishOfTheDay();
  Future<List<DishModel>> fetchDishOfDay(DateTime date);
}
