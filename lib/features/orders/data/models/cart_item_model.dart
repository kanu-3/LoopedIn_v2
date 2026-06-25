import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/models/product_model.dart';

class CartItemUIModel {
  final ProductModel product;
  final PurchaseType type;
  final int quantity;
  final bool isSelected;

  const CartItemUIModel({
    required this.product,
    required this.type,
    required this.quantity,
    this.isSelected = true,
  });

  CartItemUIModel copyWith({
    ProductModel? product,
    PurchaseType? type,
    int? quantity,
    bool? isSelected,
  }) {
    return CartItemUIModel(
      product: product ?? this.product,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}