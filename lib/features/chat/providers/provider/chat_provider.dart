import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:loopedin_v2/features/chat/data/repository/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(
    ChatRemoteDatasource(Supabase.instance.client),
  );
});