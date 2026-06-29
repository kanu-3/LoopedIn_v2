import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/features/orders/data/models/order_model.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/order_status_chip.dart';

class OrderInfoCard extends StatelessWidget {
  final OrderModel order;

  const OrderInfoCard({
    super.key,
    required this.order,
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
                "Order #${order.id.substring(0, 6)}",
                style: AppTextTheme
                    .textTheme
                    .titleMedium,
              ),
              OrderStatusChip(
                status: order.status,
              ),
            ],
          ),

          context.gapM,

          _infoRow(
            "Total",
            "₹${order.totalPrice.toStringAsFixed(2)}",
          ),

          context.gapS,

          _infoRow(
            "Buyer",
            order.buyerName,
          ),

          context.gapS,

          _infoRow(
            "Phone",
            order.buyerPhone,
          ),

          context.gapS,

          _infoRow(
            "Address",
            order.deliveryAddress,
          ),

          context.gapS,

          _infoRow(
            "Items",
            "${order.items.length}",
          ),

          context.gapS,

        ],
      ),
    );
  }

  Widget _infoRow(
      String label,
      String value,
      ) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
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
}