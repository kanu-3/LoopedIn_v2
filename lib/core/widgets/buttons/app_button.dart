import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

enum ButtonVariant {
  primary,
  white,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
    this.variant = ButtonVariant.primary,

  });

  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isLoading;
  final double? width;
  final double? height;
  final ButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = switch (variant) {
      ButtonVariant.primary => colorScheme.primary,
      ButtonVariant.white => AppColors.whitetext,
    };

    final foregroundColor = switch (variant) {
      ButtonVariant.primary => colorScheme.onPrimary,
      ButtonVariant.white => AppColors.blacktext,
    };


    return SizedBox(
      width: width,
      height: height ?? context.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor.withOpacity(0.6),
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: context.borderRadiusS,
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: context.spacingL,
          width: context.spacingL,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: foregroundColor,
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              context.gapWXXS,
            ],
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                color: foregroundColor,
                fontSize: context.scaledFont(16),
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}