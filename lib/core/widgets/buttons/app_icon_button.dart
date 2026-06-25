import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size,
    this.tooltip,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final double? size;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? context.scale(48);

    return Tooltip(
      message: tooltip ?? '',
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onPressed,
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}