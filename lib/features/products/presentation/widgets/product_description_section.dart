import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';

class ProductDescriptionSection
    extends StatelessWidget {
  final String? description;

  const ProductDescriptionSection({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (description == null ||
        description!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: context.borderRadiusM,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style:
            AppTextTheme.textTheme.headlineSmall,
          ),
          context.gapXXS,
          Text(description!),
        ],
      ),
    );
  }
}