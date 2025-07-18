import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:junkfood/data/interface_local_locale_storage_repository.dart';

part 'local_locale_storage_repository.g.dart';

class LocalLocaleStorageRepository implements ILocalLocaleStorageRepository {
  SharedPreferences localStorage;

  LocalLocaleStorageRepository({required this.localStorage});

  @override
  String? getLocale(String locale) {
    return localStorage.getString(locale);
  }

  @override
  void saveLocale(String locale) {
    localStorage.setString('locale', locale);
  }
}

@riverpod
Future<ILocalLocaleStorageRepository> localLocaleStorageRepository(
  Ref ref,
) async {
  var sharedPref = await SharedPreferences.getInstance();
  return LocalLocaleStorageRepository(localStorage: sharedPref);
}
