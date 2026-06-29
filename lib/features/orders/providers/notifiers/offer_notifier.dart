import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/orders/data/models/offer_model.dart';
import 'package:loopedin_v2/features/orders/data/repository/offer_repository.dart';
import 'package:loopedin_v2/features/orders/providers/states/offer_state.dart';

class OfferNotifier extends StateNotifier<OfferState> {
  final OfferRepository repository;

  OfferNotifier(this.repository) : super(OfferState.initial());

  String get _uid => repository.remote.client.auth.currentUser!.id;

  Future<void> createOffer({
    required String prodId,
    required String sellerId,
    required double originalPrice,
    required double offerPrice,
    required int discountPercent,
  }) async {
    state = state.copyWith(isCreating: true);

    try {
      final offer = OfferModel(
        id: '',
        prodId: prodId,
        buyerId: _uid,
        sellerId: sellerId,
        originalPrice: originalPrice,
        offerPrice: offerPrice,
        discountPercent: discountPercent,
        status: OfferStatus.pending,
        createdAt: DateTime.now(),
      );

      await repository.createOffer(offer);

      await fetchBuyerOffers();
    } finally {
      state = state.copyWith(isCreating: false);
    }
  }

  Future<void> fetchBuyerOffers() async {
    final offers = await repository.fetchBuyerOffers();
    state = state.copyWith(buyerOffers: offers);
  }

  Future<void> fetchSellerOffers() async {
    final offers = await repository.fetchSellerOffers();
    state = state.copyWith(sellerOffers: offers);
  }

  Future<void> updateStatus({
    required String offerId,
    required OfferStatus status,
  }) async {
    await repository.updateOfferStatus(
      offerId: offerId,
      status: status,
    );

    await Future.wait([
      fetchBuyerOffers(),
      fetchSellerOffers(),
    ]);
  }
}