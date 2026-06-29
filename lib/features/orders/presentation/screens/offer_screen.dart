import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/buyer_offers_tab.dart';
import 'package:loopedin_v2/features/orders/presentation/screens/seller_offers_tab.dart';
import 'package:loopedin_v2/features/orders/providers/providers/offer_provider.dart';

class OffersScreen extends ConsumerStatefulWidget {
  const OffersScreen({super.key});

  @override
  ConsumerState<OffersScreen> createState() =>
      _OffersScreenState();
}

class _OffersScreenState extends ConsumerState<OffersScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);

    Future.microtask(() {
      ref.read(offerProvider.notifier)
        ..fetchBuyerOffers()
        ..fetchSellerOffers();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(offerProvider);

    return Scaffold(
      appBar: AppHeader(
        title: "Offers",
        tabBar: TabBar(
          controller: controller,
          tabs: const [
            Tab(text: "My Offers"),
            Tab(text: "Received"),
          ],
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: controller,
        children: const [
          BuyerOffersTab(),
          SellerOffersTab(),
        ],
      ),
    );
  }
}