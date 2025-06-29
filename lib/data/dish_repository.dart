import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:junkfood/data/allergen_repository.dart';
import 'package:junkfood/data/database.dart';
import 'package:junkfood/data/interface_allergen_repository.dart';
import 'package:junkfood/data/interface_dish_repository.dart';
import 'package:junkfood/domain/model/dish_model.dart';

part 'dish_repository.g.dart';

class DishRepository implements IDishRepository {
  SupabaseClient database;
  IAllergenRepository allergenRepo;

  DishRepository({required this.database, required this.allergenRepo});

  @override
  Future<List<DishModel>> fetchDishOfTheDay() async {
    //Fetch the dishes thats matches todays date from the database
    final List<Map<String, dynamic>> result = await database
        .from('Dish_Schedule')
        .select(
          'Dishes(id, title, description, calories, Dish_type(id, dish_type), image)',
        )
        .filter('date', 'eq', DateTime.now().toIso8601String())
        .then(
          (response) => response
              .map<Map<String, dynamic>>(
                (json) => json['Dishes'] as Map<String, dynamic>,
              )
              .toList(),
        );
    //Sort the list by dish type
    result.sort((a, b) => a['Dish_type']['id'].compareTo(b['Dish_type']['id']));
    // Convert the sorted list to List<DishModel>f
    List<DishModel> dishes =
        result.map((json) => DishModel.fromJson(json)).toList();
    //Add allergens
    for (DishModel dish in dishes) {
      var allergens = await allergenRepo.fetchAllergensForDish(dish.id);
      dish.allergens = allergens;
    }

    return dishes;
  }
}

@riverpod
IDishRepository dishRepository(Ref ref) {
  return DishRepository(
    database: ref.read(databaseProvider),
    allergenRepo: ref.read(allergenRepositoryProvider),
  );
}
