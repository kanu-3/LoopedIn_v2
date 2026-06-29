import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';
import 'package:loopedin_v2/features/orders/data/repository/order_repository.dart';
import 'package:loopedin_v2/features/orders/providers/states/order_state.dart';

class OrderNotifier
    extends StateNotifier<OrderState> {
  final OrderRepository repository;

  OrderNotifier(this.repository)
      : super(OrderState.initial());

  Future<bool> placeOrder({
    required List<CartItemUIModel> items,
    required String buyerName,
    required String buyerPhone,
    required String deliveryAddress,
    required double totalPrice,
  }) async {
    try {
      state = state.copyWith(
        isPlacingOrder: true,
      );

      await repository.placeOrder(
        items: items,
        buyerName: buyerName,
        buyerPhone: buyerPhone,
        deliveryAddress: deliveryAddress,
        totalPrice: totalPrice,
      );

      await Future.wait([
        fetchBuyerOrders(),
        fetchSellerOrders(),
      ]);

      state = state.copyWith(
        isPlacingOrder: false,
      );

      return true;
    } catch (e, st) {
      debugPrint(
        'PLACE ORDER FAILED: $e',
      );

      debugPrint(
        st.toString(),
      );

      state = state.copyWith(
        isPlacingOrder: false,
      );

      return false;
    }
  }

  Future<void> fetchBuyerOrders() async {
    try {
      state = state.copyWith(
        isLoading: true,
      );

      final orders =
      await repository
          .fetchBuyerOrders();

      state = state.copyWith(
        isLoading: false,
        myOrders: orders,
      );
    } catch (e) {
      debugPrint(
        'FETCH BUYER ORDERS FAILED: $e',
      );

      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<void> fetchSellerOrders() async {
    try {
      state = state.copyWith(
        isLoading: true,
      );

      final orders =
      await repository
          .fetchSellerOrders();

      state = state.copyWith(
        isLoading: false,
        receivedOrders: orders,
      );
    } catch (e) {
      debugPrint(
        'FETCH SELLER ORDERS FAILED: $e',
      );

      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required order_status status,
  }) async {
    try {
      await repository
          .updateOrderStatus(
        orderId: orderId,
        status: status,
      );

      await Future.wait([
        fetchBuyerOrders(),
        fetchSellerOrders(),
      ]);
    } catch (e) {
      debugPrint(
        'UPDATE ORDER FAILED: $e',
      );
    }
  }
}