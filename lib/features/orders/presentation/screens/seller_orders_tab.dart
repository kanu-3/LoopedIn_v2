import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/order_card.dart';
import 'package:loopedin_v2/features/orders/providers/providers/order_provider.dart';

class SellerOrdersTab extends ConsumerWidget {
  const SellerOrdersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderProvider).receivedOrders;

    if (orders.isEmpty) {
      return AppEmptyWidget(title: "No incoming orders", subtitle: "Your orders appear here");

    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final order = orders[index];

        return OrderCard(order: order, isSeller: true);
      },
    );
  }
}