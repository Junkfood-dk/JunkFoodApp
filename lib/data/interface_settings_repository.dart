import 'package:junkfood/domain/model/settings_model.dart';

abstract interface class ISettingsRepository {
  /// Fetches the app settings from Supabase.
  Future<SettingsModel> fetchSettings();
}
