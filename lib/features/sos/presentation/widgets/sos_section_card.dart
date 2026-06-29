import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';

class SosSectionCard extends StatelessWidget {
  const SosSectionCard({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: context.spacingM, left: context.spacingM),
      decoration: BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: context.borderRadiusM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: AppTextTheme.textTheme.headlineSmall,
          ),

          context.gapXXS,

          child,

          context.gapM,
          Divider(height: context.scaleH(12),)
        ],
      ),
    );
  }
}