import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:junkfood/data/comments_repository.dart';

part 'comments_controller.g.dart';

@riverpod
class CommentController extends _$CommentController {
  @override
  Future<void> build() async {}

  Future<void> submitComment(String commentText) async {
    await ref.read(commentRepositoryProvider).postComment(commentText);
  }
}
