import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/features/home/data/models/user_search_model.dart';

class UserSearchOverlay extends StatelessWidget {
  const UserSearchOverlay({
    super.key,
    required this.users,
  });

  final List<UserSearchModel> users;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: context.borderRadiusM,
      child: Container(
        constraints: BoxConstraints(maxHeight: context.screenHeight * .4),
        decoration: BoxDecoration(
          color: AppColors.whitetext,
          borderRadius: context.borderRadiusM,
          border: Border.all(color: CoreColors.grey200),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          padding: context.padAllS,
          itemCount: users.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: user.profilePic != null
                    ? CachedNetworkImageProvider(user.profilePic!)
                    : null,
                child: user.profilePic == null ?  Icon(AssetPaths.person) : null,
              ),
              title: Text(
                "@${user.username}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(user.name),
            );
          },
        ),
      ),
    );
  }
}