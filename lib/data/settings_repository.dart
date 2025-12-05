import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:junkfood/data/database.dart';
import 'package:junkfood/data/interface_settings_repository.dart';
import 'package:junkfood/domain/model/settings_model.dart';

part 'settings_repository.g.dart';

class SettingsRepository implements ISettingsRepository {
  final SupabaseClient database;

  SettingsRepository({required this.database});

  @override
  Future<SettingsModel> fetchSettings() async {
    final List<Map<String, dynamic>> result =
        await database.from('Settings').select().limit(1);

    if (result.isEmpty) {
      throw Exception('No settings found in database');
    }

    return SettingsModel.fromJson(result.first);
  }
}

@riverpod
ISettingsRepository settingsRepository(Ref ref) {
  return SettingsRepository(
    database: ref.read(databaseProvider),
  );
}
