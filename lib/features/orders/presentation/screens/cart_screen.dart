import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/cart_item_tile.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/order_summary_bottom_sheet.dart';
import 'package:loopedin_v2/features/orders/providers/notifiers/cart_notifier.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final selectedItems = cartItems
        .where((e) => e.isSelected)
        .toList();

    return Scaffold(
      appBar: const AppHeader(
        title: "My Cart",
        showBackButton: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: AppEmptyWidget(
          title: "Your cart is empty",
          subtitle: "Continue shopping",
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemTile(item: item);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              width: double.infinity,
              text: "Proceed (${selectedItems.length})",
              onPressed: selectedItems.isEmpty
                  ? null
                  : () async {
                final total = await showModalBottomSheet<double>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => OrderSummaryBottomSheet(
                    items: selectedItems,
                  ),
                );

                if (total == null || !context.mounted) {
                  return;
                }

                context.push(
                  RoutePaths.checkout,
                  extra: {
                    "total": total,
                    "items": selectedItems,
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}