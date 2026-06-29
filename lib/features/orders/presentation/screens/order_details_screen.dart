import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/orders/data/models/order_model.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/order_info_card.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/order_item_card.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: "Order Details",
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: context.bodypad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderInfoCard(
              order: order,
            ),

            context.gapL,

            Text(
              "Items",
              style: AppTextTheme.textTheme.titleLarge,
            ),

            context.gapM,

            ...order.items.map(
                  (item) => Padding(
                padding: EdgeInsets.only(
                  bottom: context.spacingM,
                ),
                child: OrderItemCard(
                  item: item,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}