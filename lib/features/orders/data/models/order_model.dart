import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'order_item_model.dart';

class OrderModel {
  final String id;
  final String sellerId;
  final String buyerId;

  final String buyerName;
  final String buyerPhone;
  final String deliveryAddress;

  final double totalPrice;

  final order_status status;

  final DateTime createdAt;

  final List<OrderItemModel> items;

  const OrderModel({
    required this.id,
    required this.sellerId,
    required this.buyerId,
    required this.buyerName,
    required this.buyerPhone,
    required this.deliveryAddress,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return OrderModel(
      id: json['id'],
      sellerId: json['seller_id'],
      buyerId: json['buyer_id'],

      buyerName: json['buyer_name'] ?? '',
      buyerPhone: json['buyer_phone'] ?? '',
      deliveryAddress:
      json['delivery_address'] ?? '',

      totalPrice:
      (json['total_price'] as num)
          .toDouble(),

      status: order_status.values.firstWhere(
            (e) => e.name == json['status'],
      ),

      createdAt: DateTime.parse(
        json['created_at'],
      ),

      items:
      (json['order_items'] as List?)
          ?.map(
            (e) => OrderItemModel.fromJson(
          e,
        ),
      )
          .toList() ??
          [],
    );
  }
}