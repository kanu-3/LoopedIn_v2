import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/features/orders/data/models/offer_model.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/offer_status_chip.dart';

class OfferInfoCard extends StatelessWidget {
  final OfferModel offer;

  const OfferInfoCard({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Offer #${offer.id.substring(0, 6)}",
                style: AppTextTheme.textTheme.titleMedium,
              ),
              OfferStatusChip(
                status: offer.status,
              ),
            ],
          ),

          context.gapM,

          _infoRow(
            "Original",
            "₹${offer.originalPrice.toStringAsFixed(0)}",
          ),

          context.gapS,

          _infoRow(
            "Offer Price",
            "₹${offer.offerPrice.toStringAsFixed(0)}",
          ),

          context.gapS,

          _infoRow(
            "Discount",
            "${offer.discountPercent}%",
          ),

          context.gapS,

          _infoRow(
            "Buyer",
            _shortId(offer.buyerId),
          ),

          context.gapS,

          _infoRow(
            "Seller",
            _shortId(offer.sellerId),
          ),

          context.gapS,

          _infoRow(
            "Created",
            _formatDate(offer.createdAt),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
      String label,
      String value,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: CoreColors.grey600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _shortId(String id) {
    if (id.length <= 6) return id;
    return id.substring(0, 6);
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}