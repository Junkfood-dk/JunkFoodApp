import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/data/interface_local_storage_repository.dart';

part 'local_storage_repository.g.dart';

class LocalStorageRepository implements ILocalStorageRepository {
  SharedPreferences localStorage;

  LocalStorageRepository({required this.localStorage});

  @override
  List<String>? getStringList(String key) {
    return localStorage.getStringList(key);
  }

  @override
  void saveStringList(String key, List<String> value) {
    localStorage.setStringList(key, value);
  }

  @override
  String? getString(String key) {
    return localStorage.getString(key);
  }

  @override
  void saveString(String key, String value) {
    localStorage.setString(key, value);
  }
}

@riverpod
Future<ILocalStorageRepository> localStorageRepository(
    LocalStorageRepositoryRef ref) async {
  var sharedPref = await SharedPreferences.getInstance();
  return LocalStorageRepository(localStorage: sharedPref);
}
