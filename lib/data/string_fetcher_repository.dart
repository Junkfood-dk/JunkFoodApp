import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'interface_string_fetcher_repository.dart';

part 'string_fetcher_repository.g.dart';

/// Repository for fetching localized strings from Supabase
class StringFetcherRepository implements InterfaceStringFetcherRepository {
  final SupabaseClient _supabase;

  StringFetcherRepository({required SupabaseClient supabase})
      : _supabase = supabase;

  @override
  Future<Map<String, String>> fetchStringsForLanguage(String language) async {
    try {
      debugPrint(
        'StringFetcherRepository: Fetching strings for language: $language',
      );

      final List<Map<String, dynamic>> result = await _supabase
          .from('Strings')
          .select('key, value')
          .eq('language', language)
          .order('key');

      final Map<String, String> strings = Map.fromEntries(
        result.map(
          (row) => MapEntry(
            row['key'] as String,
            row['value'] as String,
          ),
        ),
      );

      debugPrint(
        'StringFetcherRepository: Fetched ${strings.length} strings for $language',
      );
      return strings;
    } catch (e) {
      debugPrint(
        'StringFetcherRepository: Error fetching strings for $language: $e',
      );
      // Check if it's a table not found error (common during development)
      if (e.toString().contains('relation "Strings" does not exist') ||
          e.toString().contains('Table \'Strings\' doesn\'t exist')) {
        debugPrint(
          'StringFetcherRepository: Strings table not found, returning empty map for graceful fallback',
        );
        return <String, String>{};
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, Map<String, String>>> fetchAllStrings() async {
    try {
      debugPrint('StringFetcherRepository: Fetching strings for all languages');

      final List<Map<String, dynamic>> result = await _supabase
          .from('Strings')
          .select('key, value, language')
          .order('language')
          .order('key');

      final Map<String, Map<String, String>> allStrings =
          <String, Map<String, String>>{};

      for (final row in result) {
        final language = row['language'] as String;
        final key = row['key'] as String;
        final value = row['value'] as String;

        allStrings.putIfAbsent(language, () => <String, String>{});
        allStrings[language]![key] = value;
      }

      debugPrint(
        'StringFetcherRepository: Fetched strings for ${allStrings.keys.length} languages',
      );
      return allStrings;
    } catch (e) {
      debugPrint('StringFetcherRepository: Error fetching all strings: $e');
      // Check if it's a table not found error (common during development)
      if (e.toString().contains('relation "Strings" does not exist') ||
          e.toString().contains('Table \'Strings\' doesn\'t exist')) {
        debugPrint(
          'StringFetcherRepository: Strings table not found, returning empty map for graceful fallback',
        );
        return <String, Map<String, String>>{};
      }
      rethrow;
    }
  }
}

/// Riverpod provider for StringFetcherRepository
@riverpod
StringFetcherRepository stringFetcherRepository(Ref ref) {
  return StringFetcherRepository(supabase: Supabase.instance.client);
}
