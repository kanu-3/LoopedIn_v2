import 'package:loopedin_v2/core/models/profile_model.dart';

class ChatModel {
  final String roomId;
  final ProfileModel otherUser;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ChatModel({
   required this.roomId,
   required this.otherUser,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
});
}