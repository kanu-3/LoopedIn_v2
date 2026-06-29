import 'package:loopedin_v2/features/orders/data/models/offer_model.dart';

class OfferState {
  final bool isLoading;
  final bool isCreating;

  final List<OfferModel> buyerOffers;
  final List<OfferModel> sellerOffers;

  const OfferState({
    required this.isLoading,
    required this.isCreating,
    required this.buyerOffers,
    required this.sellerOffers,
  });

  factory OfferState.initial() => const OfferState(
    isLoading: false,
    isCreating: false,
    buyerOffers: [],
    sellerOffers: [],
  );

  OfferState copyWith({
    bool? isLoading,
    bool? isCreating,
    List<OfferModel>? buyerOffers,
    List<OfferModel>? sellerOffers,
  }) {
    return OfferState(
      isLoading: isLoading ?? this.isLoading,
      isCreating: isCreating ?? this.isCreating,
      buyerOffers: buyerOffers ?? this.buyerOffers,
      sellerOffers: sellerOffers ?? this.sellerOffers,
    );
  }
}