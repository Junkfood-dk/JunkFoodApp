import 'package:userapp/domain/model/dish_model.dart';

abstract interface class IDishRepository {
  Future<List<DishModel>> fetchDishOfTheDay();
}
