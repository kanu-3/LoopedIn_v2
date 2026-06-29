import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';

class OrderSummaryBottomSheet extends StatelessWidget {
  final List<CartItemUIModel> items;

  const OrderSummaryBottomSheet({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    double subtotal = 0.0;
    double alterationFee = 0.0;
    double dryCleanFee = 0.0;

    bool hasExpress = false;

    const double deliveryFee = 100.0;

    for (final item in items) {
      final p = item.product;

      final basePrice = item.type == PurchaseType.buy
          ? (item.discountedPrice ?? p.price ?? 0)
          : (p.rentPricePerDay ?? 0);

      subtotal += basePrice * item.quantity;

      if (p.alteration) {
        alterationFee += 90.0 * item.quantity;
      }

      if (p.dryClean) {
        dryCleanFee += 120.0 * item.quantity;
      }

      if (p.expressDelivery) {
        hasExpress = true;
      }
    }

    final double expressFee = hasExpress ? 199.0 : 0.0;

    final double tax = subtotal * 0.02;

    final double total = subtotal +
        alterationFee +
        dryCleanFee +
        expressFee +
        deliveryFee +
        tax;

    return Padding(
      padding: EdgeInsets.all(context.spacingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _row("Subtotal", subtotal),
          _row("Alteration", alterationFee),
          _row("Dry Clean", dryCleanFee),
          _row("Express Delivery", expressFee),
          _row("Delivery Fee", deliveryFee),
          _row("Tax (2%)", tax),

          const Divider(),

          _row("Total", total, bold: true),

          context.gapXS,

          AppButton(
            width: double.infinity,
            text: "Continue",
            onPressed: () {
              Navigator.pop<double>(context, total);
            },
          )
        ],
      ),
    );
  }

  Widget _row(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            "₹${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}