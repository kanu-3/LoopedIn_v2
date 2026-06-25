import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class AppBottomNavbar extends StatelessWidget {
  const AppBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.controller,
  });

  final int currentIndex;
  final Function(int) onTap;
  final NotchBottomBarController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedNotchBottomBar(
      notchBottomBarController: controller,

      color: AppColors.main,
      kIconSize: context.spacingL,
      kBottomRadius: context.spacingL,

      bottomBarItems: [
        BottomBarItem(
          inActiveItem: Icon(AssetPaths.home, color: AppColors.bg),
          activeItem: Icon(AssetPaths.home, color: AppColors.main),
          itemLabel: 'Home',
        ),
        BottomBarItem(
          inActiveItem: Icon(AssetPaths.category, color: AppColors.bg),
          activeItem: Icon(AssetPaths.category, color: AppColors.main),
          itemLabel: 'Categories',
        ),
        BottomBarItem(
          inActiveItem: Icon(AssetPaths.sell, color: AppColors.bg),
          activeItem: Icon(AssetPaths.sell, color: AppColors.main),
          itemLabel: 'My Store',
        ),
        BottomBarItem(
          inActiveItem: Icon(AssetPaths.chat, color: AppColors.bg),
          activeItem: Icon(AssetPaths.chat, color: AppColors.main),
          itemLabel: 'Chat',
        ),
        BottomBarItem(
          inActiveItem: Icon(AssetPaths.profile, color: AppColors.bg),
          activeItem: Icon(AssetPaths.profile, color: AppColors.main),
          itemLabel: 'Profile',
        ),
      ],

      onTap: onTap,
    );
  }
}

