import 'dart:typed_data';
import 'package:loopedin_v2/core/constants/app_enums.dart';

class AddProductState {
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
  final String? productCondition;
  final String? brand;
  final String? color;
  final String? fabric;

  const AddProductState({
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
    this.productCondition,
    this.brand,
    this.color,
    this.fabric,
  });

  factory AddProductState.initial() {
    return const AddProductState(
      images: [],
      availability: product_availability.sell,
      size: 'M',
      subCategory: 'Tops',
      quantity: 1,
      expressDelivery: false,
      alteration: false,
      dryClean: false,
      directContact: false,
      style: null,
      pattern: null,
      productCondition: null,
      brand: null,
      color: null,
      fabric: null,
    );
  }

  AddProductState copyWith({
    List<Uint8List>? images,
    product_availability? availability,
    String? size,
    String? subCategory,
    int? quantity,
    bool? expressDelivery,
    bool? alteration,
    bool? dryClean,
    bool? directContact,
    String? style,
    String? pattern,
    String? productCondition,
    String? brand,
    String? color,
    String? fabric,
  }) {
    return AddProductState(
      images: images ?? this.images,
      availability: availability ?? this.availability,
      size: size ?? this.size,
      subCategory: subCategory ?? this.subCategory,
      quantity: quantity ?? this.quantity,
      expressDelivery: expressDelivery ?? this.expressDelivery,
      alteration: alteration ?? this.alteration,
      dryClean: dryClean ?? this.dryClean,
      directContact: directContact ?? this.directContact,
      style: style ?? this.style,
      pattern: pattern ?? this.pattern,
      productCondition:
      productCondition ?? this.productCondition,
      brand: brand ?? this.brand,
      color: color ?? this.color,
      fabric: fabric ?? this.fabric,
    );
  }
}