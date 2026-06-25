class MessageModel {
  final String id;
  final String roomId;
  final String senderId;
  final String message;
  final DateTime createdAt;
  final DateTime? readAt;

  const MessageModel({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.message,
    required this.createdAt,
    required this.readAt,
  });
}