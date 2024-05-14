abstract interface class ILocalRatingStorageRepository {
  List<String>? getRatingForDay(String date);
  void saveRatingForDay(String date, List<String> ratingObject);
}
