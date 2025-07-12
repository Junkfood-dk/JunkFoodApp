import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:junkfood/data/database.dart';
import 'package:junkfood/data/interface_allergen_repository.dart';
import 'package:junkfood/domain/model/allergen_model.dart';

part 'allergen_repository.g.dart';

class AllergenRepository implements IAllergenRepository {
  SupabaseClient database;

  AllergenRepository({required this.database});

  @override
  Future<List<AllergenModel>> fetchAllergensForDish(
    int dishId,
    String languageCode,
  ) async {
    try {
      final response = await database
          .from('Allergens_to_Dishes')
          .select(
            'Allergens(id, allergen_name_da, allergen_name_en, allergen_name)',
          )
          .filter('dish_id', 'eq', dishId);

      return response.map((json) {
        final allergenData = json['Allergens'];
        return AllergenModel.fromJson(allergenData);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch allergens for dish $dishId: $e');
    }
  }

  /// Legacy method for backwards compatibility with existing code
  Future<List<String>> fetchAllergensForDishLegacy(int id) async {
    try {
      final response = await database
          .from('Allergens_to_Dishes')
          .select('Allergens(allergen_name)')
          .filter('dish_id', 'eq', id);

      return response
          .map(
            (json) =>
                json['Allergens']['allergen_name']?.toString() ?? 'Unknown',
          )
          .toList();
    } catch (e) {
      // Fallback to empty list on error to maintain backwards compatibility
      return [];
    }
  }
}

@riverpod
IAllergenRepository allergenRepository(Ref ref) {
  return AllergenRepository(database: ref.read(databaseProvider));
}
