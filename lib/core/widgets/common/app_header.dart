import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
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
  });

  final String title;
  final bool showBackButton;
  final bool showCloseButton;
  final VoidCallback? onClose;

  @override
  Size get preferredSize =>
      const Size.fromHeight(122);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.main,
      automaticallyImplyLeading: false,
      toolbarHeight: 122,

      title: null,

      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: context.spacingM*3,
              bottom: context.spacingL,
              right: context.spacingL,
              left: context.spacingL
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: Colors.white,
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
                  icon:  Icon(
                    AssetPaths.cross,
                    color: Colors.white,
                    size: context.scaleH(28),
                  ),
                )
                    :  SizedBox(width: context.scaleW(28)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}