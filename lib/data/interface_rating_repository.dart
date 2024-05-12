abstract interface class IRatingRepository {
  Future<int> postNewRating(int rating, int dish);
  Future<int> updateRating(int ratingId, int rating, int dish);
}
