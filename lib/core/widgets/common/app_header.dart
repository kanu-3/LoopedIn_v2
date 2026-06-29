import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/navigation/app_back_button.dart';

class AppHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.showCloseButton = false,
    this.onClose,
    this.tabBar,
  });

  final String title;
  final bool showBackButton;
  final bool showCloseButton;
  final VoidCallback? onClose;

  final PreferredSizeWidget? tabBar;

  @override
  Size get preferredSize => Size.fromHeight(
    tabBar == null ? 122 : 170,
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.main,
      automaticallyImplyLeading: false,
      toolbarHeight: tabBar == null ? context.scaleH(128) : context.scaleW(170),

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
                      if (showBackButton)
                        AppBackButton(
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/home');
                            }
                          },
                          icon: AssetPaths.back,
                        ),

                      Expanded(
                        child: Center(
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              color: AppColors.whitetext,
                            ),
                          ),
                        ),
                      ),

                      showCloseButton
                          ? IconButton(
                        onPressed: onClose ??
                                () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go('/home');
                              }
                            },
                        icon: Icon(
                          AssetPaths.cross,
                          color: AppColors.whitetext,
                          size: context.scaleH(28),
                        ),
                      )
                          : SizedBox(
                        width: context.scaleW(28),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (tabBar != null)
              Container(
                color: CoreColors.white,
                child: tabBar,
              ),
          ],
        ),
      ),
    );
  }
}