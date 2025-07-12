import 'package:junkfood/domain/model/allergen_model.dart';

abstract interface class IAllergenRepository {
  /// Fetches allergens for a specific dish with language support
  ///
  /// [dishId] - The ID of the dish to fetch allergens for
  /// [languageCode] - The language code ('da' for Danish, 'en' for English)
  /// Returns a list of AllergenModel objects with multilingual support
  Future<List<AllergenModel>> fetchAllergensForDish(
    int dishId,
    String languageCode,
  );
}
