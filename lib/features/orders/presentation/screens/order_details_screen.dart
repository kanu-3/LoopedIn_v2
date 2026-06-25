import 'package:flutter/material.dart';
import 'package:loopedin_v2/features/orders/data/models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(
            "Order ID: ${order.id}",
          ),

          const SizedBox(height: 10),

          Text(
            "Total: ₹${order.totalPrice}",
          ),

          const SizedBox(height: 10),

          Text(
            "Delivery: ${order.deliveryAddress}",
          ),

          const Divider(),

          ...order.items.map(
                (item) => ListTile(
              title: Text(item.product.title),
              subtitle: Text(
                "Qty: ${item.quantity}",
              ),
              trailing: Text(
                "₹${item.price}",
              ),
            ),
          ),
        ],
      ),
    );
  }
}