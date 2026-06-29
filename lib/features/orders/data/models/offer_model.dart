import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/models/product_model.dart';

class OfferModel {
  final String id;
  final String prodId;
  final String buyerId;
  final String sellerId;

  final double originalPrice;
  final double offerPrice;
  final int discountPercent;

  final OfferStatus status;
  final DateTime createdAt;

  final ProductModel? product;

  OfferModel({
    required this.id,
    required this.prodId,
    required this.buyerId,
    required this.sellerId,
    required this.originalPrice,
    required this.offerPrice,
    required this.discountPercent,
    required this.status,
    required this.createdAt,
    this.product,
  });

  factory OfferModel.fromDb(Map<String, dynamic> json) {
    return OfferModel(
      id: (json['id'] ?? '').toString(),
      prodId: (json['prod_id'] ?? '').toString(),
      buyerId: (json['buyer_id'] ?? '').toString(),
      sellerId: (json['seller_id'] ?? '').toString(),
      originalPrice:
      (json['original_price'] as num?)?.toDouble() ?? 0,
      offerPrice:
      (json['offer_price'] as num?)?.toDouble() ?? 0,
      discountPercent:
      (json['discount_percent'] as num?)?.toInt() ?? 0,
      status: OfferStatusX.fromDb(
        json['status'] ?? 'pending',
      ),
      createdAt: DateTime.tryParse(
        json['created_at'] ?? '',
      ) ??
          DateTime.now(),
      product: json['products'] == null
          ? null
          : ProductModel.fromJson(
        Map<String, dynamic>.from(
          json['products'],
        ),
      ),
    );
  }

  Map<String, dynamic> toInsert({
    required String buyerId,
  }) {
    return {
      'prod_id': prodId,
      'buyer_id': buyerId,
      'seller_id': sellerId,
      'original_price': originalPrice,
      'offer_price': offerPrice,
      'discount_percent': discountPercent,
      'status': status.dbValue,
    };
  }
}