import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onPressed,
    this.icon,
  });

  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.scale(28),
      height: context.scale(28),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed ?? () => Navigator.pop(context),
          child: Center(
            child: Icon(
              icon ?? AssetPaths.back,
              color: AppColors.whitetext,
              size: context.scaleH(28),
            ),
          ),
        ),
      ),
    );
  }
}