import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/features/chat/providers/provider/chat_provider.dart';

final chatMessagesProvider =
StreamProvider.family<List<Map<String, dynamic>>, String>((ref, roomId) {
  final repo = ref.read(chatRepositoryProvider);
  return repo.watchMessages(roomId);
});