import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:userapp/data/database.dart';
import 'package:userapp/data/interface_comments_repository.dart';

part 'comments_repository.g.dart';

class CommentRepository implements ICommentRepository {
  SupabaseClient database;

  CommentRepository({required this.database});

  @override
  Future<void> postComment(String commentText, String name) async {
    final date = DateTime.now().toIso8601String().split('T')[0]; // Gets the date part
    await database.from('Comments')
      .insert({
        'comment_text': commentText,
        'comment_date': date,
        'name' : name
      });
  }
}

@riverpod
ICommentRepository commentRepository(CommentRepositoryRef ref) {
  return CommentRepository(database: ref.read(databaseProvider));
}
