import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';

class ProductAttributeGrid extends StatelessWidget {
  final ProductModel product;

  const ProductAttributeGrid({
    super.key,
    required this.product,
  });

  Widget tile(BuildContext context, String label, String value) {
    return Container(
      padding: context.padAllXS,
      decoration: BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: context.borderRadiusM,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextTheme.textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTextTheme.textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics:
      const NeverScrollableScrollPhysics(),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.2,
      ),
      children: [
        tile(context, "Size", product.size),
        tile(
          context,
          "Condition",
          product.productCondition ?? "-",
        ),
        tile(
          context,
          "Brand",
          product.brand ?? "-",
        ),
        tile(
          context,
          "Fabric",
          product.fabric ?? "-",
        ),
        tile(
          context,
          "Color",
          product.color ?? "-",
        ),
        tile(
          context,
          "Style",
          product.style ?? "-",
        ),
      ],
    );
  }
}