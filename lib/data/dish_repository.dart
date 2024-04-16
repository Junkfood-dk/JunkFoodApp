import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:userapp/data/database.dart';
import 'package:userapp/data/interface_dish_repository.dart';
import 'package:userapp/domain/model/dish_model.dart';

part 'dish_repository.g.dart';

class DishRepository implements IDishRepository {
  SupabaseClient database;

  DishRepository({required this.database});

  @override
  Future<List<DishModel>> fetchDishOfTheDay() async {
    return await database
        .from("Dish_Schedule")
        .select(
            "Dishes(id, title, description, calories, Dish_type(id, dish_type), image)")
        .filter("date", "eq", DateTime.now().toIso8601String())
        .then((rows) =>
            rows.map((json) => DishModel.fromJson(json["Dishes"])).toList());
  }
}

@riverpod
IDishRepository dishRepository(DishRepositoryRef ref) {
  return DishRepository(database: ref.read(databaseProvider));
}
