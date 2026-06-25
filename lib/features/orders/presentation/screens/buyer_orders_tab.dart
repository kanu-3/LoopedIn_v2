import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/order_card.dart';
import 'package:loopedin_v2/features/orders/providers/order_provider.dart';

class BuyerOrdersTab extends ConsumerWidget {
  const BuyerOrdersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderProvider).myOrders;

    if (orders.isEmpty) {
      return const Center(
        child: Text("No orders yet"),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final order = orders[index];

        return OrderCard(order: order);
      },
    );
  }
}