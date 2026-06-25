import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';

class ProductPriceSection extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onChat;

  const ProductPriceSection({
    super.key,
    required this.product,
    required this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padAllM,
      decoration: BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: context.borderRadiusM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: Text(
                  product.title,
                  style: AppTextTheme.textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              context.gapS,

              InkWell(
                onTap: onChat,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.main.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.main,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        AssetPaths.chat,
                        size: context.scale(20),
                        color: AppColors.main,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Chat",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          color: AppColors.main,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),



          Text(
            product.subCategory ?? "Uncategorized",
            style: AppTextTheme.textTheme.bodyMedium,
          ),

          context.gapS,

          if (product.availability ==
              product_availability.sell)
            Text(
              "₹${product.price?.toStringAsFixed(0) ?? "0"}",
              style: AppTextTheme.textTheme.headlineLarge,
            ),

          if (product.availability ==
              product_availability.rent)
            Text(
              "₹${product.rentPricePerDay?.toStringAsFixed(0) ?? "0"}/day",
              style: AppTextTheme.textTheme.headlineLarge,
            ),

          if (product.availability ==
              product_availability.both)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Buy: ₹${product.price?.toStringAsFixed(0) ?? "0"}",
                  style: AppTextTheme.textTheme.headlineSmall,
                ),
                Text(
                  "Rent: ₹${product.rentPricePerDay?.toStringAsFixed(0) ?? "0"}/day",
                  style: AppTextTheme.textTheme.headlineSmall,
                ),
              ],
            ),
        ],
      ),
    );
  }
}