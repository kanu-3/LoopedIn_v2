import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.assetImage,
    required this.onTap,
    this.fit = BoxFit.contain,
    this.color= Colors.transparent,
  });

  final String category;
  final String assetImage;
  final VoidCallback onTap;
  final BoxFit fit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.onError,
      borderRadius: context.borderRadiusM,
      onTap: onTap,
      child: ClipRRect(
        borderRadius: context.borderRadiusM,
        child: SizedBox(
          height: context.cardHeightMedium,
          width: double.infinity,
          child: Stack(
            children: [

              Positioned.fill(
                child: Container(
                  color: color,
                  child: Image.asset(
                    assetImage,
                    fit: fit,
                  ),
                ),
              ),

              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  height: context.spacingXL,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacingS,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.whitetext,
                    borderRadius: BorderRadius.circular(context.spacingS),
                  ),
                  child: Text(
                    category,
                    style: AppTextTheme.textTheme.headlineMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}