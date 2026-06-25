import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final image = product.images.isNotEmpty
        ? product.images.first
        : null;

    return InkWell(
      borderRadius: context.borderRadiusM,
      onTap: () {
      context.push(
        RoutePaths.productDetails,
        extra: {"product": product},
      );
    },
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.spacingM),
                  topRight: Radius.circular(context.spacingM),
                ),
                child: image != null
                    ? CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (c, _) => Container(
                    color: AppColors.disabled,
                  ),
                  errorWidget: (c, _, __) => Container(
                    color: AppColors.disabled,
                    child: Icon(AssetPaths.imagebroken),
                  ),
                )
                    : Container(
                  color: AppColors.disabled,
                  child: Icon(AssetPaths.image),
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(context.spacingXS),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      product.availability == product_availability.sell
                          ? "₹${product.price?.toStringAsFixed(0) ?? '0'}"
                          : product.availability == product_availability.rent
                          ? "₹${product.rentPricePerDay?.toStringAsFixed(0) ?? '0'}/day"
                          : "₹${product.price?.toStringAsFixed(0) ?? '0'} | ₹${product.rentPricePerDay?.toStringAsFixed(0) ?? '0'}/day",
                      style: AppTextTheme.textTheme.headlineSmall
                    ),

                    Text(
                      product.availability.name.toUpperCase(),
                      style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.main,
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}