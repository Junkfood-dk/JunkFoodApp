import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:junkfood/data/string_fetcher_repository.dart';
import 'package:string_cache/string_cache.dart' hide refreshLocalizationCaches;
import 'package:string_cache/src/supabase_localizations_en.dart';
import 'package:string_cache/src/supabase_localizations_da.dart';

part 'string_controller.g.dart';

/// Controller for managing string loading from Supabase and caching
@riverpod
class StringController extends _$StringController {
  
  @override
  Future<bool> build() async {
    // Initialize the string cache service
    await StringCacheService.initialize();
    
    // Load strings on first build
    return await loadStrings();
  }

  /// Load strings from Supabase and cache them locally
  /// Returns true if successful, false otherwise
  Future<bool> loadStrings() async {
    try {
      debugPrint('StringController: Starting string loading process');
      
      final stringRepo = ref.read(stringFetcherRepositoryProvider);
      
      // Fetch strings for all supported languages
      final allStrings = await stringRepo.fetchAllStrings();
      
      if (allStrings.isEmpty) {
        debugPrint('StringController: No strings fetched from Supabase, using fallback strings');
        // Still initialize the caches so the app works with fallback strings
        await _initializeLocalizationCaches();
        return true; // Return true to indicate app can continue with fallbacks
      }

      final cacheService = StringCacheService.instance;
      
      // Save strings for each language to cache
      for (final entry in allStrings.entries) {
        final language = entry.key;
        final strings = entry.value;
        
        await cacheService.saveStrings(strings, language);
        debugPrint('StringController: Cached ${strings.length} strings for language: $language');
      }
      
      // Initialize the language-specific caches for the localizations
      await _initializeLocalizationCaches();
      
      debugPrint('StringController: String loading completed successfully');
      return true;
      
    } catch (e) {
      debugPrint('StringController: Error loading strings: $e');
      state = AsyncError(e, StackTrace.current);
      return false;
    }
  }

  /// Refresh strings from Supabase and update all caches
  Future<void> refreshStrings() async {
    state = const AsyncLoading();
    
    // Clear local cache first to force fresh data
    await clearCache();
    
    final success = await loadStrings();
    if (success) {
      state = const AsyncData(true);
    }
  }

  /// Check if strings are cached and available for a language
  Future<bool> isLanguageAvailable(String language) async {
    try {
      final cacheService = StringCacheService.instance;
      return await cacheService.hasStrings(language);
    } catch (e) {
      debugPrint('StringController: Error checking language availability: $e');
      return false;
    }
  }

  /// Get cache timestamp for a language
  Future<DateTime?> getCacheTimestamp(String language) async {
    try {
      final cacheService = StringCacheService.instance;
      return await cacheService.getCacheTimestamp(language);
    } catch (e) {
      debugPrint('StringController: Error getting cache timestamp: $e');
      return null;
    }
  }

  /// Clear all cached strings
  Future<void> clearCache() async {
    try {
      final cacheService = StringCacheService.instance;
      await cacheService.clearCache();
      debugPrint('StringController: Cache cleared');
    } catch (e) {
      debugPrint('StringController: Error clearing cache: $e');
    }
  }

  /// Initialize the language-specific caches for the localizations
  /// This allows the localizations to access strings synchronously
  Future<void> _initializeLocalizationCaches() async {
    await SupabaseLocalizationsEn.refreshCache();
    await SupabaseLocalizationsDa.refreshCache();
    debugPrint('StringController: Language-specific localization caches refreshed');
  }

  /// Force refresh strings and restart the app's localization caches
  /// Useful during development when strings change in Supabase
  Future<void> forceRefreshStrings() async {
    debugPrint('StringController: Force refreshing strings from Supabase');
    await refreshStrings();
  }
}