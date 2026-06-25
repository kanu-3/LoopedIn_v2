import 'dart:typed_data';
import 'package:loopedin_v2/core/constants/app_enums.dart';

class ProductDraftModel {
  final String title;
  final double? price;
  final double? rentPricePerDay;
  final List<Uint8List> images;
  final product_availability availability;
  final String size;
  final String subCategory;
  final int quantity;
  final bool expressDelivery;
  final bool alteration;
  final bool dryClean;
  final bool directContact;
  final String? style;
  final String? pattern;
  final String? color;
  final String? brand;
  final String? fabric;
  final String? description;
  final String status;
  final String? productCondition;

  const ProductDraftModel({
    required this.title,
    this.price,
    this.rentPricePerDay,
    required this.images,
    required this.availability,
    required this.size,
    required this.subCategory,
    required this.quantity,
    required this.expressDelivery,
    required this.alteration,
    required this.dryClean,
    required this.directContact,
    this.style,
    this.pattern,
    this.color,
    this.brand,
    this.fabric,
    this.description,
    required this.status,
    this.productCondition,
  });
}