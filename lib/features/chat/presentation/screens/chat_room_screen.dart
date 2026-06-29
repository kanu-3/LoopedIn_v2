import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/models/profile_model.dart';
import 'package:loopedin_v2/features/chat/presentation/widgets/chat_header.dart';
import 'package:loopedin_v2/features/chat/presentation/widgets/message_bubble.dart';
import 'package:loopedin_v2/features/chat/presentation/widgets/message_input.dart';
import 'package:loopedin_v2/features/chat/providers/provider/chat_provider.dart';
import 'package:loopedin_v2/features/chat/providers/provider/chat_room_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final String roomId;
  final ProfileModel otherUser;

  const ChatRoomScreen({
    super.key,
    required this.roomId,
    required this.otherUser,
  });

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.roomId));

    final userId =
        Supabase.instance.client.auth.currentUser!.id;

    return Scaffold(
      appBar: ChatHeader(user: widget.otherUser),

      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                final sorted = [...messages]
                  ..sort((a, b) =>
                      DateTime.parse(a['created_at'])
                          .compareTo(DateTime.parse(b['created_at'])));

                return ListView.builder(
                  itemCount: sorted.length,
                  itemBuilder: (context, index) {
                    final msg = sorted[index];

                    final isMe = msg['sender_id'] == userId;

                    return MessageBubble(
                      message: msg['message'],
                      isMe: isMe,
                      time: DateTime.parse(msg['created_at']),
                    );
                  },
                );
              },
              loading: () =>
              const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),

          MessageInput(
            controller: _controller,
            onSend: () async {
              final text = _controller.text.trim();
              if (text.isEmpty) return;

              await ref.read(chatRepositoryProvider).sendMessage(
                roomId: widget.roomId,
                senderId: userId,
                message: text,
              );

              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}