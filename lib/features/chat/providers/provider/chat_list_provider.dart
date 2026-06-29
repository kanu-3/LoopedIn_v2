import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/models/chat_model.dart';
import 'package:loopedin_v2/core/models/profile_model.dart';
import 'package:loopedin_v2/features/chat/providers/provider/chat_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final chatListProvider = FutureProvider<List<ChatModel>>((ref) async {
  final repo = ref.read(chatRepositoryProvider);
  final userId = Supabase.instance.client.auth.currentUser!.id;

  final rooms = await repo.getChatRooms(userId);

  final chats = <ChatModel>[];

  for (final room in rooms) {
    final roomId = room['id'];

    final lastMsg = await repo.getLastMessage(roomId);

    final otherUserId =
    room['user1_id'] == userId ? room['user2_id'] : room['user1_id'];

    final profile = await Supabase.instance.client
        .from('user_profile')
        .select()
        .eq('user_id', otherUserId)
        .maybeSingle();

    chats.add(ChatModel(
      roomId: roomId,
      otherUser: ProfileModel.fromJson(profile!),
      lastMessage: lastMsg?['message'] ?? '',
      lastMessageTime: DateTime.parse(
        lastMsg?['created_at'] ?? room['created_at'],
      ),
      isLastMessageMine: lastMsg?['sender_id'] == userId,
      unreadCount: 0,
    ));
  }

  chats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
  return chats;
});