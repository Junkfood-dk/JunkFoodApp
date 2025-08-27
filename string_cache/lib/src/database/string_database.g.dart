// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_database.dart';

// ignore_for_file: type=lint
class $CachedStringsTable extends CachedStrings
    with TableInfo<$CachedStringsTable, CachedString> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedStringsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 5,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, key, value, language, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_strings';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedString> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {key, language},
  ];
  @override
  CachedString map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedString(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedStringsTable createAlias(String alias) {
    return $CachedStringsTable(attachedDatabase, alias);
  }
}

class CachedString extends DataClass implements Insertable<CachedString> {
  final int id;
  final String key;
  final String value;
  final String language;
  final DateTime cachedAt;
  const CachedString({
    required this.id,
    required this.key,
    required this.value,
    required this.language,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['language'] = Variable<String>(language);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedStringsCompanion toCompanion(bool nullToAbsent) {
    return CachedStringsCompanion(
      id: Value(id),
      key: Value(key),
      value: Value(value),
      language: Value(language),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedString.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedString(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      language: serializer.fromJson<String>(json['language']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'language': serializer.toJson<String>(language),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedString copyWith({
    int? id,
    String? key,
    String? value,
    String? language,
    DateTime? cachedAt,
  }) => CachedString(
    id: id ?? this.id,
    key: key ?? this.key,
    value: value ?? this.value,
    language: language ?? this.language,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedString copyWithCompanion(CachedStringsCompanion data) {
    return CachedString(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      language: data.language.present ? data.language.value : this.language,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedString(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('language: $language, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value, language, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedString &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value &&
          other.language == this.language &&
          other.cachedAt == this.cachedAt);
}

class CachedStringsCompanion extends UpdateCompanion<CachedString> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> value;
  final Value<String> language;
  final Value<DateTime> cachedAt;
  const CachedStringsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.language = const Value.absent(),
    this.cachedAt = const Value.absent(),
  });
  CachedStringsCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String value,
    required String language,
    this.cachedAt = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       language = Value(language);
  static Insertable<CachedString> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? language,
    Expression<DateTime>? cachedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (language != null) 'language': language,
      if (cachedAt != null) 'cached_at': cachedAt,
    });
  }

  CachedStringsCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? value,
    Value<String>? language,
    Value<DateTime>? cachedAt,
  }) {
    return CachedStringsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      language: language ?? this.language,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedStringsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('language: $language, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$StringDatabase extends GeneratedDatabase {
  _$StringDatabase(QueryExecutor e) : super(e);
  $StringDatabaseManager get managers => $StringDatabaseManager(this);
  late final $CachedStringsTable cachedStrings = $CachedStringsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedStrings];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CachedStringsTableCreateCompanionBuilder =
    CachedStringsCompanion Function({
      Value<int> id,
      required String key,
      required String value,
      required String language,
      Value<DateTime> cachedAt,
    });
typedef $$CachedStringsTableUpdateCompanionBuilder =
    CachedStringsCompanion Function({
      Value<int> id,
      Value<String> key,
      Value<String> value,
      Value<String> language,
      Value<DateTime> cachedAt,
    });

class $$CachedStringsTableFilterComposer
    extends Composer<_$StringDatabase, $CachedStringsTable> {
  $$CachedStringsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedStringsTableOrderingComposer
    extends Composer<_$StringDatabase, $CachedStringsTable> {
  $$CachedStringsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedStringsTableAnnotationComposer
    extends Composer<_$StringDatabase, $CachedStringsTable> {
  $$CachedStringsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedStringsTableTableManager
    extends
        RootTableManager<
          _$StringDatabase,
          $CachedStringsTable,
          CachedString,
          $$CachedStringsTableFilterComposer,
          $$CachedStringsTableOrderingComposer,
          $$CachedStringsTableAnnotationComposer,
          $$CachedStringsTableCreateCompanionBuilder,
          $$CachedStringsTableUpdateCompanionBuilder,
          (
            CachedString,
            BaseReferences<_$StringDatabase, $CachedStringsTable, CachedString>,
          ),
          CachedString,
          PrefetchHooks Function()
        > {
  $$CachedStringsTableTableManager(
    _$StringDatabase db,
    $CachedStringsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedStringsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedStringsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedStringsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
              }) => CachedStringsCompanion(
                id: id,
                key: key,
                value: value,
                language: language,
                cachedAt: cachedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String value,
                required String language,
                Value<DateTime> cachedAt = const Value.absent(),
              }) => CachedStringsCompanion.insert(
                id: id,
                key: key,
                value: value,
                language: language,
                cachedAt: cachedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedStringsTableProcessedTableManager =
    ProcessedTableManager<
      _$StringDatabase,
      $CachedStringsTable,
      CachedString,
      $$CachedStringsTableFilterComposer,
      $$CachedStringsTableOrderingComposer,
      $$CachedStringsTableAnnotationComposer,
      $$CachedStringsTableCreateCompanionBuilder,
      $$CachedStringsTableUpdateCompanionBuilder,
      (
        CachedString,
        BaseReferences<_$StringDatabase, $CachedStringsTable, CachedString>,
      ),
      CachedString,
      PrefetchHooks Function()
    >;

class $StringDatabaseManager {
  final _$StringDatabase _db;
  $StringDatabaseManager(this._db);
  $$CachedStringsTableTableManager get cachedStrings =>
      $$CachedStringsTableTableManager(_db, _db.cachedStrings);
}
