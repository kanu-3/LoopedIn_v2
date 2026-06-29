import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/orders/data/datasources/offer_remote_datasource.dart';
import 'package:loopedin_v2/features/orders/data/models/offer_model.dart';

class OfferRepository {
  final OfferRemoteDatasource remote;

  OfferRepository(this.remote);

  Future<void> createOffer(OfferModel offer) =>
      remote.createOffer(offer);

  Future<List<OfferModel>> fetchBuyerOffers() =>
      remote.fetchBuyerOffers();

  Future<List<OfferModel>> fetchSellerOffers() =>
      remote.fetchSellerOffers();

  Future<void> updateOfferStatus({
    required String offerId,
    required OfferStatus status,
  }) =>
      remote.updateOfferStatus(
        offerId: offerId,
        status: status,
      );
}