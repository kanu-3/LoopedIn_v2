import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/profile_model.dart';
import 'package:loopedin_v2/core/widgets/navigation/app_back_button.dart';

class ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  final ProfileModel user;

  const ChatHeader({
    super.key,
    required this.user,
  });

  @override
  Size get preferredSize => const Size.fromHeight(122);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.main,
      automaticallyImplyLeading: false,
      toolbarHeight: context.scaleH(128),

      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: context.spacingM * 3,
                  bottom: context.spacingL,
                  right: context.spacingL,
                  left: context.spacingL,
                ),

                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      AppBackButton(
                        icon: AssetPaths.back,
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/chats');
                          }
                        },
                      ),

                      SizedBox(width: context.scaleW(12)),

                      Expanded(
                        child: Center(
                          child: Text(
                            user.name.isNotEmpty ? user.name : 'User',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              color: AppColors.whitetext,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}