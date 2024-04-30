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
  //Fetch the dishes thats matches todays date from the database 
  final List<Map<String, dynamic>> result = await database
      .from("Dish_Schedule")
      .select(
          "Dishes(id, title, description, calories, Dish_type(id, dish_type), image)")
      .filter("date", "eq", DateTime.now().toIso8601String())
      .then((response) => response.map<Map<String, dynamic>>((json) => json['Dishes'] as Map<String, dynamic>).toList());
  //Sort the list by dish type
  result.sort((a, b) => a['Dish_type']['id'].compareTo(b['Dish_type']['id']));
  // Convert the sorted list to List<DishModel>
  List<DishModel> dishes =
      result.map((json) => DishModel.fromJson(json)).toList();

  return dishes;
  }
}

@riverpod
IDishRepository dishRepository(DishRepositoryRef ref) {
  return DishRepository(database: ref.read(databaseProvider));
}
