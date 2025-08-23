import 'package:flutter/foundation.dart';
import 'database/string_database.dart';

/// Service for managing cached localized strings
class StringCacheService {
  static StringCacheService? _instance;
  static StringDatabase? _database;
  
  // In-memory fallback for web platform when database fails
  static Map<String, Map<String, String>> _memoryCache = {};
  static bool _isDatabaseAvailable = true;

  /// Singleton instance
  static StringCacheService get instance {
    _instance ??= StringCacheService._();
    return _instance!;
  }

  StringCacheService._();

  /// Initialize the service with a database instance
  static Future<void> initialize() async {
    _database ??= StringDatabase();
  }

  /// Get the database instance
  StringDatabase get _db {
    if (_database == null) {
      throw StateError('StringCacheService not initialized. Call initialize() first.');
    }
    return _database!;
  }

  /// Save strings for a specific language
  /// This will replace all existing strings for the language
  Future<void> saveStrings(Map<String, String> strings, String language) async {
    // Always save to memory cache as fallback
    _memoryCache[language] = Map<String, String>.from(strings);
    
    if (_isDatabaseAvailable) {
      try {
        await _db.saveStringsForLanguage(strings, language);
        debugPrint('StringCacheService: Saved ${strings.length} strings for language: $language');
      } catch (e) {
        debugPrint('StringCacheService: Error saving strings for $language: $e');
        if (kIsWeb) {
          debugPrint('StringCacheService: Database failed, using memory cache on web platform');
          _isDatabaseAvailable = false;
          return; // Don't rethrow on web, use memory cache
        }
        rethrow;
      }
    } else {
      debugPrint('StringCacheService: Using memory cache for ${strings.length} strings for language: $language');
    }
  }

  /// Get all strings for a specific language
  Future<Map<String, String>> getStrings(String language) async {
    // First try memory cache (immediate fallback for web issues)
    if (_memoryCache.containsKey(language)) {
      final strings = _memoryCache[language]!;
      debugPrint('StringCacheService: Retrieved ${strings.length} strings from memory cache for language: $language');
      return strings;
    }
    
    // If database is available, try to get from database
    if (_isDatabaseAvailable) {
      try {
        final strings = await _db.getStringsForLanguage(language);
        debugPrint('StringCacheService: Retrieved ${strings.length} strings from database for language: $language');
        return strings;
      } catch (e) {
        debugPrint('StringCacheService: Error retrieving strings for $language: $e');
        if (kIsWeb) {
          debugPrint('StringCacheService: Database failed, marking as unavailable');
          _isDatabaseAvailable = false;
        }
      }
    }
    
    debugPrint('StringCacheService: No strings available for language: $language');
    return <String, String>{}; // Return empty map if no strings available
  }

  /// Get a specific string by key and language
  Future<String?> getString(String key, String language) async {
    try {
      return await _db.getString(key, language);
    } catch (e) {
      debugPrint('StringCacheService: Error retrieving string $key for $language: $e');
      return null;
    }
  }

  /// Check if strings exist for a language
  Future<bool> hasStrings(String language) async {
    // Check memory cache first
    if (_memoryCache.containsKey(language) && _memoryCache[language]!.isNotEmpty) {
      return true;
    }
    
    // If database is available, check database
    if (_isDatabaseAvailable) {
      try {
        return await _db.hasStringsForLanguage(language);
      } catch (e) {
        debugPrint('StringCacheService: Error checking strings for $language: $e');
        if (kIsWeb) {
          _isDatabaseAvailable = false;
        }
      }
    }
    
    return false;
  }

  /// Get the timestamp when strings were last cached for a language
  Future<DateTime?> getCacheTimestamp(String language) async {
    try {
      return await _db.getCacheTimestamp(language);
    } catch (e) {
      debugPrint('StringCacheService: Error getting cache timestamp for $language: $e');
      return null;
    }
  }

  /// Clear all cached strings
  Future<void> clearCache() async {
    try {
      await _db.clearAllStrings();
      debugPrint('StringCacheService: Cleared all cached strings');
    } catch (e) {
      debugPrint('StringCacheService: Error clearing cache: $e');
      rethrow;
    }
  }

  /// Clear strings for a specific language
  Future<void> clearLanguage(String language) async {
    try {
      await _db.clearStringsForLanguage(language);
      debugPrint('StringCacheService: Cleared strings for language: $language');
    } catch (e) {
      debugPrint('StringCacheService: Error clearing strings for $language: $e');
      rethrow;
    }
  }

  /// Check if the cache is fresh (has strings and is not too old)
  /// Returns true if strings exist for the language
  Future<bool> isCacheFresh(String language, {Duration maxAge = const Duration(hours: 24)}) async {
    try {
      final hasStrings = await this.hasStrings(language);
      if (!hasStrings) return false;

      final timestamp = await getCacheTimestamp(language);
      if (timestamp == null) return false;

      final age = DateTime.now().difference(timestamp);
      return age <= maxAge;
    } catch (e) {
      debugPrint('StringCacheService: Error checking cache freshness for $language: $e');
      return false;
    }
  }

  /// Dispose resources
  static Future<void> dispose() async {
    await _database?.close();
    _database = null;
    _instance = null;
  }
}