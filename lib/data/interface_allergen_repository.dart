abstract interface class IAllergenRepository {
    Future<List<String>> fetchAllergensForDish(int id);
}