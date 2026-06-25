import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/buyer_orders_tab.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/seller_orders_tab.dart';
import 'package:loopedin_v2/features/orders/providers/order_provider.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() =>
      _OrdersScreenState();
}

class _OrdersScreenState
    extends ConsumerState<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);

    Future.microtask(() {
      ref.read(orderProvider.notifier)
        ..fetchBuyerOrders()
        ..fetchSellerOrders();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        bottom: TabBar(
          controller: controller,
          tabs: const [
            Tab(text: "My Orders"),
            Tab(text: "Received"),
          ],
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: controller,
        children: const [
          BuyerOrdersTab(),
          SellerOrdersTab(),
        ],
      ),
    );
  }
}