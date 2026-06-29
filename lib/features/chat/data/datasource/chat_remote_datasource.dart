import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRemoteDatasource {
  final SupabaseClient client;

  ChatRemoteDatasource(this.client);

  Future<String> getOrCreateRoom(String userA, String userB) async {
    final ids = [userA, userB]..sort();
    final u1 = ids[0];
    final u2 = ids[1];

    final existing = await client
        .from('chat_rooms')
        .select('id')
        .eq('user1_id', u1)
        .eq('user2_id', u2)
        .maybeSingle();

    if (existing != null) {
      return existing['id'];
    }

    final inserted = await client
        .from('chat_rooms')
        .insert({
      'user1_id': u1,
      'user2_id': u2,
    })
        .select('id')
        .single();

    return inserted['id'];
  }

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String message,
  }) async {
    await client.from('messages').insert({
      'room_id': roomId,
      'sender_id': senderId,
      'message': message,
    });
  }

  Stream<List<Map<String, dynamic>>> streamMessages(String roomId) {
    return client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order('created_at', ascending: true);
  }

  Future<List<Map<String, dynamic>>> fetchUserRooms(String userId) async {
    return await client
        .from('chat_rooms')
        .select()
        .or('user1_id.eq.$userId,user2_id.eq.$userId');
  }

  Future<Map<String, dynamic>?> fetchLastMessage(String roomId) async {
    return await client
        .from('messages')
        .select()
        .eq('room_id', roomId)
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();
  }
}