abstract interface class ILocalLocaleStorageRepository {
  String? getLocale(String locale);
  void saveLocale(String locale);
}
