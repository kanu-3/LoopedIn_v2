import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/offer_card.dart';
import 'package:loopedin_v2/features/orders/providers/providers/offer_provider.dart';

class BuyerOffersTab extends ConsumerWidget {
  const BuyerOffersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(offerProvider);

    if (state.isLoading && state.buyerOffers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final offers = state.buyerOffers;

    if (offers.isEmpty) {
      return AppEmptyWidget(title: "No offers sent", subtitle: "Your sent offers appear here");
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: offers.length,
      itemBuilder: (_, i) {
        final offer = offers[i];

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: OfferCard(
            offer: offer,
            isSeller: false,
          ),
        );
      },
    );
  }
}