class OfferModel {
  final String id;
  final String sellerId;
  final String buyerId;
  final String productId;
  final double offerPrice;
  final String? extraComments;
  final String status;
  final DateTime createdAt;

  const OfferModel({
    required this.id,
    required this.sellerId,
    required this.buyerId,
    required this.productId,
    required this.offerPrice,
    this.extraComments,
    required this.status,
    required this.createdAt,
  });
}