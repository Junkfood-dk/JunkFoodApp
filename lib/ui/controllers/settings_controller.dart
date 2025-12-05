import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:junkfood/data/settings_repository.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  Future<bool> build() async {
    final settings = await ref.read(settingsRepositoryProvider).fetchSettings();
    return settings.showNoDishMessage;
  }

  /// Refreshes the settings from the database.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final settings =
          await ref.read(settingsRepositoryProvider).fetchSettings();
      return settings.showNoDishMessage;
    });
  }
}
