import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/widgets/products/products_action_menu.dart';

class MyProductTile extends StatelessWidget {
  const MyProductTile({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    required this.onMarkSold,
    required this.onMarkRented,
    required this.onHide,
  });

  final ProductModel product;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  final VoidCallback onMarkSold;
  final VoidCallback onMarkRented;
  final VoidCallback onHide;

  @override
  Widget build(BuildContext context) {
    final image = product.images.isNotEmpty
        ? product.images.first
        : null;

    return InkWell(
      onTap: onTap,
      borderRadius: context.borderRadiusM,
      child: Container(
        padding: EdgeInsets.all(
          context.spacingS,
        ),
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
                width: context.scaleW(
                  context.scaleW(160),
                ),
                height: context.scaleH(180),
                child: image != null
                    ? CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.fill,
                )
                    : Container(
                  color: AppColors.disabled,
                  child: Icon(
                    AssetPaths.image,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: context.scaleW(12),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  context.gapXXS,

                  Text(
                    "Quantity: ${product.quantity}",
                  ),

                  context.gapXXS,

                  Text(
                    product.availability ==
                        product_availability.sell
                        ? "₹${product.price?.toStringAsFixed(0) ?? '0'}"
                        : product.availability ==
                        product_availability.rent
                        ? "₹${product.rentPricePerDay?.toStringAsFixed(0) ?? '0'}/day"
                        : "₹${product.price?.toStringAsFixed(0) ?? '0'} | ₹${product.rentPricePerDay?.toStringAsFixed(0) ?? '0'}/day",
                    style: const TextStyle(
                      fontWeight:
                      FontWeight.w100,
                    ),
                  ),

                  context.gapXXS,

                  Text(
                    product.status.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.main,
                    ),
                  ),
                ],
              ),
            ),

            ProductActionsMenu(
              onEdit: onEdit,
              onDelete: onDelete,
              onMarkSold: onMarkSold,
              onMarkRented: onMarkRented,
              onHide: onHide,
            ),
          ],
        ),
      ),
    );
  }
}