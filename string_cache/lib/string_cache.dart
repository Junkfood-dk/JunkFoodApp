// Export the public API
export 'src/supabase_localizations.dart';
export 'src/string_cache_service.dart';

// Export initialization functions
import 'src/supabase_localizations_en.dart';
import 'src/supabase_localizations_da.dart';

/// Initialize all language-specific localization caches
/// Call this after loading strings into StringCacheService
Future<void> initializeLocalizationCaches() async {
  await SupabaseLocalizationsEn.initializeCache();
  await SupabaseLocalizationsDa.initializeCache();
}

/// Force refresh all language-specific localization caches
/// Call this when strings are updated in Supabase and need to be refreshed
Future<void> refreshLocalizationCaches() async {
  await SupabaseLocalizationsEn.refreshCache();
  await SupabaseLocalizationsDa.refreshCache();
}
