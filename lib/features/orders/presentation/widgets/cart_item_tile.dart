import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';
import 'package:loopedin_v2/features/orders/providers/notifiers/cart_notifier.dart';

class CartItemTile extends ConsumerWidget {
  final CartItemUIModel item;

  const CartItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = item.product;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: item.isSelected,
            onChanged: (_) {
              ref.read(cartProvider.notifier).toggleSelection(
                product.id,
                item.type,
              );
            },
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(context.spacingS),
              decoration: BoxDecoration(
                color: AppColors.whitetext,
                borderRadius: context.borderRadiusM,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: context.borderRadiusS,
                    child: SizedBox(
                      width: context.scaleW(100),
                      height: context.scaleH(100),
                      child: product.images.isNotEmpty
                          ? CachedNetworkImage(
                        imageUrl: product.images.first,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        color: AppColors.disabled,
                        child: Icon(AssetPaths.image),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "Option: ${item.type.name.toUpperCase()}",
                          style: TextStyle(
                            color: AppColors.main,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            if (item.type == PurchaseType.buy &&
                                item.discountedPrice != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "₹${item.discountedPrice!.toStringAsFixed(0)}",
                                    style:  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.main,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "₹${product.price?.toStringAsFixed(0) ?? '0'}",
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: CoreColors.grey700,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                item.type == PurchaseType.buy
                                    ? "₹${product.price?.toStringAsFixed(0) ?? '0'}"
                                    : "₹${product.rentPricePerDay?.toStringAsFixed(0) ?? '0'}/day",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    AssetPaths.remove,
                                    size: context.scale(24),
                                  ),
                                  onPressed: () {
                                    if (item.quantity == 1) {
                                      ref
                                          .read(cartProvider.notifier)
                                          .removeFromCart(
                                        product.id,
                                        item.type,
                                      );
                                    } else {
                                      ref
                                          .read(cartProvider.notifier)
                                          .updateQuantity(
                                        product.id,
                                        item.type,
                                        item.quantity - 1,
                                        product.quantity,
                                        context,
                                      );
                                    }
                                  },
                                ),

                                Text(
                                  "${item.quantity}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),

                                IconButton(
                                  icon: Icon(
                                    AssetPaths.add,
                                    size: context.scale(24),
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .updateQuantity(
                                      product.id,
                                      item.type,
                                      item.quantity + 1,
                                      product.quantity,
                                      context,
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}