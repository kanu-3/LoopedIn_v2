import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.width,
    this.height,
  });

  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? context.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(
            borderRadius: context.borderRadiusS,
          ),
        ),
        child: Row(
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