import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/features/orders/data/models/offer_model.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/offer_status_chip.dart';

class OfferItemCard extends StatelessWidget {
  final OfferModel offer;

  const OfferItemCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {

    final product = offer.product!;

    final image = product.images.isNotEmpty
        ? product.images.first
        : null;

    return Container(
      padding: context.bodypad,
      decoration: BoxDecoration(
        color: AppColors.whitetext,
        borderRadius:
        context.borderRadiusM,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: CoreColors.grey300,
          ),
        ],
      ),
      child: Row(
        children: [

          ClipRRect(
            borderRadius:
            BorderRadius.circular(12),
            child: image != null
                ? CachedNetworkImage(
              imageUrl: image,
              width: 90,
              height: 110,
              fit: BoxFit.cover,
            )
                : Container(
              width: 90,
              height: 110,
              color: CoreColors.grey200,
            ),
          ),

          context.gapM,

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  product.title,
                  style: AppTextTheme
                      .textTheme
                      .titleMedium,
                ),

                context.gapS,

                Text(
                  "Original : ₹${offer.originalPrice.toStringAsFixed(0)}",
                ),

                Text(
                  "Offer : ₹${offer.offerPrice.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: CoreColors.main,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                context.gapS,

                OfferStatusChip(
                  status: offer.status,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}