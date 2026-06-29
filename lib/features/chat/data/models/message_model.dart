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
    this.readAt,
  });

  bool get isRead => readAt != null;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      roomId: json['room_id'],
      senderId: json['sender_id'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      readAt: json['read_at'] != null
          ? DateTime.parse(json['read_at'])
          : null,
    );
  }
}