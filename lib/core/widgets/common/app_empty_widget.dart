import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = AssetPaths.empty,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: context.bodypad,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              icon,
              size: context.scaleH(80),
              color: CoreColors.grey400,
            ),

            context.gapM,

            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            context.gapS,

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                color: CoreColors.grey500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}