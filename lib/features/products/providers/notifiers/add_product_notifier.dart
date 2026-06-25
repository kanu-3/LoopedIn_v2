import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/features/products/providers/states/add_product_state.dart';
class AddProductNotifier
    extends StateNotifier<AddProductState> {
  AddProductNotifier()
      : super(AddProductState.initial());

  void setImages(
      List<Uint8List> files,
      ) {
    state = state.copyWith(
      images: List<Uint8List>.from(files),
    );
  }

  void setAvailability(
      product_availability value,
      ) {
    state = state.copyWith(
      availability: value,
    );
  }

  void setSize(
      String value,
      ) {
    state = state.copyWith(
      size: value,
    );
  }

  void setSubCategory(
      String value,
      ) {
    state = state.copyWith(
      subCategory: value,
    );
  }

  void setQuantity(
      int value,
      ) {
    state = state.copyWith(
      quantity: value,
    );
  }

  void setExpressDelivery(
      bool value,
      ) {
    state = state.copyWith(
      expressDelivery: value,
    );
  }

  void setAlteration(
      bool value,
      ) {
    state = state.copyWith(
      alteration: value,
    );
  }

  void setDryClean(
      bool value,
      ) {
    state = state.copyWith(
      dryClean: value,
    );
  }

  void setDirectContact(
      bool value,
      ) {
    state = state.copyWith(
      directContact: value,
    );
  }

  void setStyle(
      String? value,
      ) {
    state = state.copyWith(
      style: value,
    );
  }

  void setPattern(
      String? value,
      ) {
    state = state.copyWith(
      pattern: value,
    );
  }

  void setCondition(
      String? value,
      ) {
    state = state.copyWith(
      productCondition: value,
    );
  }

  void setBrand(
      String? value,
      ) {
    state = state.copyWith(
      brand: value,
    );
  }

  void setColor(
      String? value,
      ) {
    state = state.copyWith(
      color: value,
    );
  }

  void setFabric(
      String? value,
      ) {
    state = state.copyWith(
      fabric: value,
    );
  }

  void reset() {
    state = AddProductState.initial();
  }

  void loadFromProduct(ProductModel product) {
    state = state.copyWith(
      availability: product.availability,
      size: product.size,
      subCategory: product.subCategory,
      quantity: product.quantity,
      expressDelivery: product.expressDelivery,
      alteration: product.alteration,
      dryClean: product.dryClean,
      directContact: product.directContact,
      style: product.style,
      pattern: product.pattern,
      productCondition: product.productCondition,
      brand: product.brand,
      color: product.color,
      fabric: product.fabric,
    );
  }
}