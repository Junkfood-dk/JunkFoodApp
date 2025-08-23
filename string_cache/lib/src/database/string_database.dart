import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

part 'string_database.g.dart';

/// Table for caching localized strings from Supabase
class CachedStrings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().withLength(min: 1, max: 255)();
  TextColumn get value => text()();
  TextColumn get language => text().withLength(min: 2, max: 5)();
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {key, language}, // Ensure unique key-language pairs
  ];
}

/// Drift database for caching localized strings
@DriftDatabase(tables: [CachedStrings])
class StringDatabase extends _$StringDatabase {
  StringDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future schema migrations here
      },
    );
  }

  /// Save multiple strings for a specific language
  /// This will replace all existing strings for the language
  Future<void> saveStringsForLanguage(
    Map<String, String> strings,
    String language,
  ) async {
    await transaction(() async {
      // Clear existing strings for this language
      await (delete(
        cachedStrings,
      )..where((tbl) => tbl.language.equals(language))).go();

      // Insert new strings
      final entries = strings.entries
          .map(
            (entry) => CachedStringsCompanion.insert(
              key: entry.key,
              value: entry.value,
              language: language,
            ),
          )
          .toList();

      await batch((batch) {
        batch.insertAll(cachedStrings, entries);
      });
    });
  }

  /// Get all strings for a specific language
  Future<Map<String, String>> getStringsForLanguage(String language) async {
    final query = select(cachedStrings)
      ..where((tbl) => tbl.language.equals(language));

    final results = await query.get();

    return Map.fromEntries(results.map((row) => MapEntry(row.key, row.value)));
  }

  /// Get a specific string by key and language
  Future<String?> getString(String key, String language) async {
    final query = select(cachedStrings)
      ..where((tbl) => tbl.key.equals(key) & tbl.language.equals(language))
      ..limit(1);

    final result = await query.getSingleOrNull();
    return result?.value;
  }

  /// Clear all cached strings
  Future<void> clearAllStrings() async {
    await delete(cachedStrings).go();
  }

  /// Clear strings for a specific language
  Future<void> clearStringsForLanguage(String language) async {
    await (delete(
      cachedStrings,
    )..where((tbl) => tbl.language.equals(language))).go();
  }

  /// Check if strings exist for a language
  Future<bool> hasStringsForLanguage(String language) async {
    final query = selectOnly(cachedStrings)
      ..addColumns([cachedStrings.id.count()])
      ..where(cachedStrings.language.equals(language));

    final result = await query.getSingle();
    return result.read(cachedStrings.id.count())! > 0;
  }

  /// Get the cache timestamp for a language (when strings were last updated)
  Future<DateTime?> getCacheTimestamp(String language) async {
    final query = select(cachedStrings)
      ..where((tbl) => tbl.language.equals(language))
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.cachedAt, mode: OrderingMode.desc),
      ])
      ..limit(1);

    final result = await query.getSingleOrNull();
    return result?.cachedAt;
  }
}

/// Create database connection
QueryExecutor _openConnection() {
  if (kIsWeb) {
    return driftDatabase(
      name: 'string_cache_database',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('https://cdn.jsdelivr.net/npm/sql.js@1.10.2/dist/sql-wasm.wasm'),
        driftWorker: Uri.parse('https://cdn.jsdelivr.net/npm/drift@2.28.1/web/drift_worker.js'),
      ),
    );
  } else {
    return driftDatabase(name: 'string_cache_database');
  }
}
