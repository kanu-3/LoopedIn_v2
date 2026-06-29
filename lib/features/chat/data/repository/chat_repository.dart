import 'package:loopedin_v2/features/chat/data/datasource/chat_remote_datasource.dart';

class ChatRepository {
  final ChatRemoteDatasource remote;

  ChatRepository(this.remote);

  Future<String> getOrCreateRoom(String a, String b) {
    return remote.getOrCreateRoom(a, b);
  }

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String message,
  }) {
    return remote.sendMessage(
      roomId: roomId,
      senderId: senderId,
      message: message,
    );
  }

  Stream<List<Map<String, dynamic>>> watchMessages(String roomId) {
    return remote.streamMessages(roomId);
  }

  Future<List<Map<String, dynamic>>> getChatRooms(String userId) {
    return remote.fetchUserRooms(userId);
  }

  Future<Map<String, dynamic>?> getLastMessage(String roomId) {
    return remote.fetchLastMessage(roomId);
  }
}