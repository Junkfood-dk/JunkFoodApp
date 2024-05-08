abstract interface class ILocalStorageRepository {
  List<String>? getStringList(String key);
  void saveStringList(String key, List<String> value);
  String? getString(String key);
  void saveString(String key, String value);
}
