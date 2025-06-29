import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:junkfood/data/database.dart';
import 'package:junkfood/data/interface_comments_repository.dart';

part 'comments_repository.g.dart';

class CommentRepository implements ICommentRepository {
  SupabaseClient database;

  CommentRepository({required this.database});

  @override
  Future<void> postComment(String commentText) async {
    final date =
        DateTime.now().toIso8601String().split('T')[0]; // Gets the date part
    await database
        .from('Comments')
        .insert({'comment_text': commentText, 'comment_date': date});
  }
}

@riverpod
ICommentRepository commentRepository(Ref ref) {
  return CommentRepository(database: ref.read(databaseProvider));
}
