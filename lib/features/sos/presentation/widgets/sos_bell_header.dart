import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';

class SosBellHeader extends StatelessWidget {
  const SosBellHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: context.padAllL,
      decoration: BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: context.borderRadiusM,
      ),
      child: Column(
        children: [

          SizedBox(
            width: context.scale(180),
            height: context.scale(180),
            child: Stack(
              alignment: Alignment.center,
              children: [

                Container(
                  width: context.scale(180),
                  height: context.scale(180),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CoreColors.five,
                  ),
                ),

                Container(
                  width: context.scale(150),
                  height: context.scale(150),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CoreColors.four,
                  ),
                ),

                Container(
                  width: context.scale(120),
                  height: context.scale(120),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CoreColors.two,
                  ),
                ),

                Container(
                  width: context.scale(92),
                  height: context.scale(92),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CoreColors.one,
                  ),
                ),

                Icon(
                  AssetPaths.bell,
                  color: CoreColors.black,
                  size: context.scale(42),
                ),
              ],
            ),
          ),

          context.gapM,

          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextTheme.textTheme.headlineMedium,
          ),

          context.gapXS,

          Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}