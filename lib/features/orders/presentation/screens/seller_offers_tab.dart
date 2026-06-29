import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/offer_card.dart';
import 'package:loopedin_v2/features/orders/providers/providers/offer_provider.dart';

class SellerOffersTab extends ConsumerWidget {
  const SellerOffersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(offerProvider);

    if (state.isLoading && state.sellerOffers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final offers = state.sellerOffers;

    if (offers.isEmpty) {
      return  AppEmptyWidget(title: 'No offers receive', subtitle: 'You will see offers received here');
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
            isSeller: true,
            onAccept: () {
              ref.read(offerProvider.notifier).updateStatus(
                offerId: offer.id,
                status: OfferStatus.accepted,
              );
            },
            onReject: () {
              ref.read(offerProvider.notifier).updateStatus(
                offerId: offer.id,
                status: OfferStatus.rejected,
              );
            },
          ),
        );
      },
    );
  }
}