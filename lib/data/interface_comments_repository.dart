abstract class ICommentRepository {
  Future<void> postComment(String commentText, String name);
}
