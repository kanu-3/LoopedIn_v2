import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/models/product_model.dart';

class OrderItemModel {
  final ProductModel product;
  final int quantity;
  final double price;
  final PurchaseType purchaseType;

  const OrderItemModel({
    required this.product,
    required this.quantity,
    required this.price,
    required this.purchaseType,
  });

  factory OrderItemModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return OrderItemModel(
      product: ProductModel.fromJson(
        Map<String, dynamic>.from(json['products'] ?? {}),
      ),
      quantity: json['quantity'] ?? 1,
      price: (json['price'] as num).toDouble(),
      purchaseType: PurchaseType.values.firstWhere(
            (e) => e.name == json['available_type'],
        orElse: () => PurchaseType.buy,
      ),
    );
  }
}