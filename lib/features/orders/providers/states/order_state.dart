
import 'package:loopedin_v2/features/orders/data/models/order_model.dart';

class OrderState {
  final bool isLoading;
  final bool isPlacingOrder;

  final List<OrderModel> myOrders;
  final List<OrderModel> receivedOrders;

  const OrderState({
    required this.isLoading,
    required this.isPlacingOrder,
    required this.myOrders,
    required this.receivedOrders,
  });

  factory OrderState.initial() {
    return const OrderState(
      isLoading: false,
      isPlacingOrder: false,
      myOrders: [],
      receivedOrders: [],
    );
  }

  OrderState copyWith({
    bool? isLoading,
    bool? isPlacingOrder,
    List<OrderModel>? myOrders,
    List<OrderModel>? receivedOrders,
  }) {
    return OrderState(
      isLoading:
      isLoading ?? this.isLoading,
      isPlacingOrder:
      isPlacingOrder ??
          this.isPlacingOrder,
      myOrders:
      myOrders ?? this.myOrders,
      receivedOrders:
      receivedOrders ??
          this.receivedOrders,
    );
  }
}