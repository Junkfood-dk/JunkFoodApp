import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:junkfood/data/interface_local_rating_storage_repository.dart';

part 'local_rating_storage_repository.g.dart';

class LocalRatingStorageRepository implements ILocalRatingStorageRepository {
  SharedPreferences localStorage;

  LocalRatingStorageRepository({required this.localStorage});

  @override
  List<String>? getRatingForDay(String key) {
    return localStorage.getStringList(key);
  }

  @override
  void saveRatingForDay(String key, List<String> value) {
    localStorage.setStringList(key, value);
  }
}

@riverpod
Future<ILocalRatingStorageRepository> localRatingStorageRepository(
    LocalRatingStorageRepositoryRef ref) async {
  var sharedPref = await SharedPreferences.getInstance();
  return LocalRatingStorageRepository(localStorage: sharedPref);
}
