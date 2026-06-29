import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/features/orders/data/models/order_model.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/order_status_chip.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final bool isSeller;

  const OrderCard({
    super.key,
    required this.order,
    this.isSeller = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          RoutePaths.orderdetails,
          extra: order,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CoreColors.grey300,
          ),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OrderStatusChip(
                  status: order.status,
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              "₹${order.totalPrice}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Items: ${order.items.length}",
            ),

            const SizedBox(height: 6),

            Text(
              isSeller
                  ? "Buyer: ${order.buyerName}"
                  : "Seller: ${order.sellerId.substring(0, 6)}",
              style: TextStyle(
                color: CoreColors.grey600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}