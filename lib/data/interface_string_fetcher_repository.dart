/// Interface for fetching localized strings from Supabase
abstract interface class InterfaceStringFetcherRepository {
  /// Fetch all strings for a specific language from Supabase
  /// Returns a map of key-value pairs where key is the string identifier
  /// and value is the localized text
  Future<Map<String, String>> fetchStringsForLanguage(String language);

  /// Fetch strings for all supported languages
  /// Returns a map where the outer key is the language code ('en', 'da')
  /// and the inner map contains string key-value pairs
  Future<Map<String, Map<String, String>>> fetchAllStrings();
}