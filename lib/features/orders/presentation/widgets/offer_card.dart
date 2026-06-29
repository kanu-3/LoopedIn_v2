import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_outline_button.dart';
import 'package:loopedin_v2/features/orders/data/models/offer_model.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/offer_status_chip.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;
  final bool isSeller;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const OfferCard({
    super.key,
    required this.offer,
    this.isSeller = false,
    this.onAccept,
    this.onReject,
  });

  String shortId(String? id) {
    if (id == null || id.isEmpty) return "NA";
    return id.length > 6 ? id.substring(0, 6) : id;
  }

  Color _borderColor(OfferStatus status) {
    switch (status) {
      case OfferStatus.pending:
        return CoreColors.pending;
      case OfferStatus.accepted:
        return CoreColors.accepted;
      case OfferStatus.rejected:
        return CoreColors.rejected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          RoutePaths.offerdetails,
          extra: offer,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: _borderColor( offer.status,),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Offer #${shortId(offer.id)}"),
                OfferStatusChip(status: offer.status),
              ],
            ),

            const SizedBox(height: 8),

            Text("Offer Price: ₹${offer.offerPrice}"),

            const SizedBox(height: 8),

            Text(
              isSeller
                  ? "Buyer: ${shortId(offer.buyerId)}"
                  : "Seller: ${shortId(offer.sellerId)}",
            ),

            const SizedBox(height: 10),

            if (isSeller && offer.status == OfferStatus.pending)
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      height: context.scaleH(56),
                        text: "Accept", onPressed: onAccept)
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppOutlinedButton(
                      height: context.scaleH(56),
                        text: "Reject", onPressed: onReject)
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}