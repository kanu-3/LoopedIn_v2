import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/features/orders/providers/providers/offer_provider.dart';

class OfferBottomSheet extends ConsumerStatefulWidget {
  final double originalPrice;
  final String prodId;
  final String sellerId;

  const OfferBottomSheet({
    super.key,
    required this.originalPrice,
    required this.prodId,
    required this.sellerId,
  });

  @override
  ConsumerState<OfferBottomSheet> createState() =>
      _OfferBottomSheetState();
}

class _OfferBottomSheetState
    extends ConsumerState<OfferBottomSheet> {
  double discount = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final offerPrice =
        widget.originalPrice * (1 - discount / 100);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Discount: ${discount.toInt()}%"),

          Slider(
            value: discount,
            min: 0,
            max: 50,
            divisions: 50,
            label: "${discount.toInt()}%",
            onChanged: isLoading
                ? null
                : (v) => setState(() => discount = v),
          ),

          Text("Offer Price: ₹${offerPrice.toStringAsFixed(0)}"),

          const SizedBox(height: 16),

          AppButton(
            text: isLoading ? "Sending..." : "Send Offer",
            onPressed: isLoading
                ? null
                : () async {
              setState(() => isLoading = true);

              try {
                debugPrint("BUTTON PRESSED");

                final offerNotifier =
                ref.read(offerProvider.notifier);

                await offerNotifier.createOffer(
                  prodId: widget.prodId,
                  sellerId: widget.sellerId,
                  originalPrice: widget.originalPrice,
                  offerPrice: offerPrice,
                  discountPercent: discount.toInt(),
                );

                if (!mounted) return;

                Navigator.pop(context);

                AppSnackBar.show(
                  context,
                  message: "Offer sent successfully",
                  isError: false,
                );
              } catch (e, st) {
                debugPrint("OFFER ERROR: $e");
                debugPrint("$st");

                AppSnackBar.show(
                  context,
                  message: "Offer failed: $e",
                  isError: true,
                );
              } finally {
                if (mounted) {
                  setState(() => isLoading = false);
                }
              }
            },
          )
        ],
      ),
    );
  }
}