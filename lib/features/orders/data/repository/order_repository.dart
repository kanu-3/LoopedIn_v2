import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';
import 'package:loopedin_v2/features/orders/data/models/order_model.dart';

class OrderRepository {
  final OrderRemoteDatasource remote;

  OrderRepository(this.remote);

  Future<void> placeOrder({
    required List<CartItemUIModel> items,
    required String buyerName,
    required String buyerPhone,
    required String deliveryAddress,
    required double totalPrice,
  }) {
    return remote.placeOrder(
      items: items,
      buyerName: buyerName,
      buyerPhone: buyerPhone,
      deliveryAddress: deliveryAddress,
      totalPrice: totalPrice,
    );
  }

  Future<List<OrderModel>>
  fetchBuyerOrders() {
    return remote.fetchBuyerOrders();
  }

  Future<List<OrderModel>>
  fetchSellerOrders() {
    return remote.fetchSellerOrders();
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required order_status status,
  }) {
    return remote.updateOrderStatus(
      orderId: orderId,
      status: status,
    );
  }
}