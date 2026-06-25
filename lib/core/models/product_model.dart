import 'package:loopedin_v2/core/constants/app_enums.dart';

class ProductModel {
  final String id;
  final String title;
  final double? price;
  final product_availability availability;
  final String sellerId;
  final String? subCategory;
  final List<String> images;
  final String size;
  final String? brand;
  final String? style;
  final String? pattern;
  final String? color;
  final String? description;
  final int quantity;
  final bool expressDelivery;
  final bool alteration;
  final bool dryClean;
  final bool directContact;
  final String? fabric;
  final String? productCondition;
  final double? rentPricePerDay;
  final String status;
  final DateTime createdAt;

  const ProductModel({
    required this.id,
    required this.title,
    this.price,
    required this.availability,
    required this.sellerId,
    this.subCategory,
    required this.images,
    required this.size,
    this.brand,
    this.style,
    this.pattern,
    this.color,
    this.description,
    required this.quantity,
    required this.expressDelivery,
    required this.alteration,
    required this.dryClean,
    required this.directContact,
    this.fabric,
    this.productCondition,
    this.rentPricePerDay,
    required this.status,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] as String,
      title: data['title'] as String,
      price: data['price'] != null ? (data['price'] as num).toDouble() : null,
      availability: product_availability.values.firstWhere(
            (e) => e.name == data['available'],
        orElse: () => product_availability.sell,
      ),
      sellerId: data['seller_id'] as String,
      subCategory: data['sub_category'] ?? '',
      images: (data['product_image'] as List?)
          ?.map((i) => (i as Map<String, dynamic>)['img_url'] as String)
          .toList() ??
          [],
      size: data['size'] ?? '',
      brand: data['brand'] as String?,
      style: data['style'] as String?,
      pattern: data['pattern'] as String?,
      color: data['color'] as String?,
      description: data['description'] as String?,
      quantity: data['quantity'] ?? 1,
      expressDelivery: data['express_delivery'] ?? false,
      alteration: data['alteration'] ?? false,
      dryClean: data['dry_clean'] ?? false,
      directContact: data['direct_contact'] ?? false,
      fabric: data['fabric'] as String?,
      productCondition: data['product_condition'] as String?,
      rentPricePerDay: data['rent_price_per_day'] != null
          ? (data['rent_price_per_day'] as num).toDouble()
          : null,
      status: data['status'] ?? 'active',
      createdAt: DateTime.parse(data['created_at']),
    );
  }
}