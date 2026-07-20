import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:lottie/lottie.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget{
  const HomeHeader({
    super.key,
    required this.username,
  });
  static const double headerHeight = 122;
  final String username;
  @override
  Size get preferredSize => Size.fromHeight(headerHeight) ;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 0,
      titleSpacing: 0,
      backgroundColor: AppColors.main,
      toolbarHeight: headerHeight,

      title: Padding(
        padding:  EdgeInsets.only(
            top: context.spacingM*3,
            bottom: context.spacingL,
            right: context.spacingL,
          left: context.spacingL
        ),
        child: Row(
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    'Hello 👋',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.whitetext),
                  ),

                  Text(
                    username,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.whitetext),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    context.push(RoutePaths.recommendations);
                  },
                  child: SizedBox(
                    width: context.scaleW(62),
                    height: context.scaleH(62),
                    child: Lottie.asset(
                      AssetPaths.robot,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  context.push(
                    RoutePaths.createSos,
                  );
                },
                    icon: Icon(AssetPaths.emergency, color: AppColors.bg,)),
                IconButton(onPressed: (){
                  context.push(
                    RoutePaths.cart
                  );
                }, icon: Icon(AssetPaths.cart, color: AppColors.bg,))
              ],
            ),
          ],
        ),
      ),
    );
  }
}