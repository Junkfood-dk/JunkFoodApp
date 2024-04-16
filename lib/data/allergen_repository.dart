import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:userapp/data/interface_allergen_repository.dart';

class AllergenRepository implements IAllergenRepository {
  SupabaseClient database;

  AllergenRepository({required this.database});

  @override
  Future<List<String>> fetchAllergensForDish(int id) async {
    return await database
        .from("Allergens_to_Dishes")
        .select("Allergens(allergen_name)")
        .filter("dish_id", "eq", id)
        .then((rows) => rows
            .map((json) => json["Allergens"]["allergen_name"].toString())
            .toList());
  }
}
