import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@riverpod
SupabaseClient database(DatabaseRef ref) {
  return Supabase.instance.client;

}
