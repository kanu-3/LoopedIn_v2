import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/features/orders/data/models/order_item_model.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItemModel item;

  const OrderItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.product.images.isNotEmpty
        ? item.product.images.first
        : null;

    return Container(
      padding: context.bodypad,
      decoration: BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: context.borderRadiusM,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: CoreColors.grey300,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.circular(12),
            child: imageUrl != null
                ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: 90,
              height: 110,
              fit: BoxFit.cover,
            )
                : Container(
              width: 90,
              height: 110,
              color: CoreColors.grey200,
              child:  Icon(
                AssetPaths.imagebroken,
              ),
            ),
          ),

          context.gapM,

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: AppTextTheme
                      .textTheme
                      .titleMedium,
                ),

                context.gapXXS,

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.main
                        .withOpacity(0.08),
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.purchaseType.name
                        .toUpperCase(),
                    style: TextStyle(
                      color: AppColors.main,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),

                context.gapXXS,

                Text(
                  "Quantity: ${item.quantity}",
                  style: AppTextTheme
                      .textTheme
                      .bodyMedium,
                ),

                context.gapXXS,

                Text(
                  "Unit Price: ₹${(item.price / item.quantity).toStringAsFixed(0)}",
                  style: AppTextTheme
                      .textTheme
                      .bodyMedium,
                ),
              ],
            ),
          ),

          Text(
            "₹${item.price.toStringAsFixed(0)}",
            style: AppTextTheme
                .textTheme
                .titleMedium
                ?.copyWith(
              fontWeight:
              FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}