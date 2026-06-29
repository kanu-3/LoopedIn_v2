import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/orders/data/models/offer_model.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/offer_info_card.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/offer_item_card.dart';
import 'package:loopedin_v2/features/orders/providers/notifiers/cart_notifier.dart';

class OfferDetailScreen extends ConsumerWidget {
  final OfferModel offer;

  const OfferDetailScreen({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppHeader(
        title: "Offer Details",
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: context.bodypad,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            OfferInfoCard(
              offer: offer,
            ),

            context.gapL,

            Text(
              "Product",
              style: AppTextTheme
                  .textTheme
                  .titleLarge,
            ),

            context.gapM,

            OfferItemCard(
              offer: offer,
            ),

            context.gapL,

          if (offer.status == OfferStatus.accepted)
      AppButton(
      width: double.infinity,
      text: "Add to Cart",
      onPressed: () async {
        debugPrint("========== ADD OFFER TO CART ==========");
        debugPrint("Offer ID: ${offer.id}");
        debugPrint("Product ID: ${offer.prodId}");
        debugPrint("Offer Price: ${offer.offerPrice}");
        debugPrint("Status: ${offer.status}");

        try {
          await ref
              .read(cartProvider.notifier)
              .addOfferToCart(
            offer,
            context,
          );

          debugPrint("ADD OFFER SUCCESS");

          if (!context.mounted) return;

          AppSnackBar.show(
            context,
            message: "Added to cart successfully",
            isError: false,
          );

          context.pop();
        } catch (e, st) {
          debugPrint("========== ADD OFFER FAILED ==========");
          debugPrint(e.toString());
          debugPrint(st.toString());

          if (!context.mounted) return;

          AppSnackBar.show(
            context,
            message: e.toString(),
            isError: true,
          );
        }
      },
    )
    else
    AppButton(
    width: double.infinity,
    text: offer.status == OfferStatus.pending
    ? "Waiting for Seller"
        : "Offer Rejected",
    onPressed: null,
    )
          ],
        ),
      ),
    );
  }
}