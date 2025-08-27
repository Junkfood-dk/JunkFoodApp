import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:junkfood/data/allergen_repository.dart';
import 'package:junkfood/data/database.dart';
import 'package:junkfood/data/interface_allergen_repository.dart';
import 'package:junkfood/data/interface_dish_repository.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/domain/model/allergen_model.dart';

part 'dish_repository.g.dart';

class DishRepository implements IDishRepository {
  SupabaseClient database;
  IAllergenRepository allergenRepo;

  DishRepository({required this.database, required this.allergenRepo});

  @override
  Future<List<DishModel>> fetchDishOfDayWithLanguage(
    DateTime date,
    String languageCode,
  ) async {
    //Fetch the dishes that match the specified date from the database
    final List<Map<String, dynamic>> result = await database
        .from('Dish_Schedule')
        .select(
          'Dishes(id, title, description, title_en, description_en, calories, Dish_type(id, dish_type), image)',
        )
        .filter('date', 'eq', date.toIso8601String())
        .then(
          (response) => response
              .map<Map<String, dynamic>>(
                (json) => json['Dishes'] as Map<String, dynamic>,
              )
              .toList(),
        );
    //Sort the list by dish type
    result.sort((a, b) => a['Dish_type']['id'].compareTo(b['Dish_type']['id']));
    // Convert the sorted list to List<DishModel>
    List<DishModel> dishes =
        result.map((json) => DishModel.fromJson(json)).toList();
    //Add allergens with language support
    for (DishModel dish in dishes) {
      var allergenModels =
          await allergenRepo.fetchAllergensForDish(dish.id, languageCode);
      // Also populate the legacy allergens field for backwards compatibility
      dish.allergens = allergenModels
          .map((allergen) => allergen.getNameForLanguage(languageCode))
          .toList();
    }

    return dishes;
  }

  @override
  Future<List<DishModel>> fetchDishOfTheDay() async {
    return fetchDishOfDay(DateTime.now());
  }

  @override
  Future<List<DishModel>> fetchDishOfDay(DateTime date) async {
    //Fetch the dishes that match the specified date from the database
    final List<Map<String, dynamic>> result = await database
        .from('Dish_Schedule')
        .select(
          'Dishes(id, title, description, title_en, description_en, calories, Dish_type(id, dish_type), image)',
        )
        .filter('date', 'eq', date.toIso8601String())
        .then(
          (response) => response
              .map<Map<String, dynamic>>(
                (json) => json['Dishes'] as Map<String, dynamic>,
              )
              .toList(),
        );
    //Sort the list by dish type
    result.sort((a, b) => a['Dish_type']['id'].compareTo(b['Dish_type']['id']));
    // Convert the sorted list to List<DishModel>
    List<DishModel> dishes =
        result.map((json) => DishModel.fromJson(json)).toList();
    //Add allergens using legacy method for backwards compatibility
    for (DishModel dish in dishes) {
      try {
        // Try to use the new multilingual method with English fallback
        var allergenModels =
            await allergenRepo.fetchAllergensForDish(dish.id, 'en');
        dish.allergens = allergenModels
            .map((allergen) => allergen.getNameForLanguage('en'))
            .toList();
      } catch (e) {
        // Fallback to legacy method if new method fails
        var legacyAllergens = await (allergenRepo as AllergenRepository)
            .fetchAllergensForDishLegacy(dish.id);
        dish.allergens = legacyAllergens;
      }
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
