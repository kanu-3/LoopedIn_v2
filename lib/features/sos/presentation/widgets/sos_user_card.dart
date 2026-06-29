import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_outline_button.dart';
import 'package:loopedin_v2/features/sos/data/models/user_preview_model.dart';

class SosUserCard extends ConsumerWidget {
  const SosUserCard({
    super.key,
    required this.user,
    required this.onChat,
  });

  final UserPreviewModel user;
  final VoidCallback onChat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        context.push(
          RoutePaths.userProfile,
          extra: user.userId,
        );
      },
      leading: CircleAvatar(
        backgroundImage: user.profilePic != null
            ? NetworkImage(user.profilePic!)
            : null,
      ),
      title: Text(user.name),
      subtitle: Text("@${user.username}"),
      trailing: AppOutlinedButton(
        width:  context.scaleW(120),
        text: "Chat",
        onPressed: onChat,
      ),
    );
  }
}