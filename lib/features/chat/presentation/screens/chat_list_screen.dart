import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/utils/formatters.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/chat/providers/provider/chat_list_provider.dart';
import 'package:loopedin_v2/features/chat/providers/provider/chat_provider.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatAsync = ref.watch(chatListProvider);

    return Scaffold(
      appBar: AppHeader(
        title: 'Chats',
        showCloseButton: false,
        showBackButton: false,
      ),
      body: chatAsync.when(
        data: (chats) {
          if (chats.isEmpty) {
            return AppEmptyWidget(title: "No chats", subtitle: "Your chats appear here");
          }

          return ListView.separated(
            itemCount: chats.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final chat = chats[index];

              return ListTile(
                onTap: () async {
                  final repo = ref.read(chatRepositoryProvider);
                  final userId = repo.remote.client.auth.currentUser!.id;

                  final roomId = await repo.getOrCreateRoom(
                    userId,
                    chat.otherUser.userId,
                  );

                  if (!context.mounted) return;

                  context.push(
                    '/chat/$roomId',
                    extra: {
                      'otherUser': chat.otherUser,
                    },
                  );
                },

                leading: CircleAvatar(
                  backgroundImage: chat.otherUser.profilePic != null
                      ? NetworkImage(chat.otherUser.profilePic!)
                      : null,
                  child: chat.otherUser.profilePic == null
                      ? Icon(AssetPaths.person)
                      : null,
                ),

                title: Text(
                  chat.otherUser.name ?? 'User',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                subtitle: Text(
                  chat.lastMessage.isNotEmpty
                      ? chat.lastMessage
                      : 'No messages yet',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatTime(chat.lastMessageTime),
                      style:  TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: context.scaleH(8)),

                    if (!chat.isLastMessageMine)
                      Icon(
                        AssetPaths.circle,
                        size: 10,
                        color: CoreColors.main,
                      ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}