import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/buyer_orders_tab.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/seller_orders_tab.dart';
import 'package:loopedin_v2/features/orders/providers/providers/order_provider.dart';

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
      appBar: AppHeader(
        showBackButton: true,
        title: "Orders",
        tabBar: TabBar(
          controller: controller,

          indicatorSize: TabBarIndicatorSize.label,

          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 3,
              color: AppColors.main,
            ),
          ),

          dividerColor: Colors.transparent,

          labelColor: AppColors.main,
          unselectedLabelColor: CoreColors.grey500,

          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),

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