import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:junkfood/data/database.dart';
import 'package:junkfood/data/interface_allergen_repository.dart';

part 'allergen_repository.g.dart';

class AllergenRepository implements IAllergenRepository {
  SupabaseClient database;

  AllergenRepository({required this.database});

  @override
  Future<List<String>> fetchAllergensForDish(int id) async {
    return await database
        .from('Allergens_to_Dishes')
        .select('Allergens(allergen_name)')
        .filter('dish_id', 'eq', id)
        .then(
          (rows) => rows
              .map((json) => json['Allergens']['allergen_name'].toString())
              .toList(),
        );
  }
}

@riverpod
IAllergenRepository allergenRepository(AllergenRepositoryRef ref) {
  return AllergenRepository(database: ref.read(databaseProvider));
}
