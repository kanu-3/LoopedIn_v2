import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/features/orders/data/datasources/cart_remote_datasource.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';
import 'package:loopedin_v2/features/orders/data/repository/cart_repository.dart';
import 'package:flutter/material.dart';

final cartProvider =
StateNotifierProvider<CartNotifier, List<CartItemUIModel>>((ref) {
  return CartNotifier(
    CartRepository(
      CartRemoteDatasource(SupabaseService.client),
    ),
  );
});

class CartNotifier extends StateNotifier<List<CartItemUIModel>> {
  final CartRepository repo;

  CartNotifier(this.repo) : super([]) {
    loadCart();
  }

  Future<void> loadCart() async {
    state = await repo.fetchCart();
  }

  Future<void> addToCart(
      ProductModel product,
      PurchaseType type,
      BuildContext context,
      ) async {
    try {
      final index = state.indexWhere(
            (e) => e.product.id == product.id && e.type == type,
      );

      if (index != -1) {
        final current = state[index].quantity;

        if (current + 1 > product.quantity) {
          AppSnackBar.show(
            context,
            message: "Stock limit reached",
            isError: true,
          );
          return;
        }

        await updateQuantity(
          product.id,
          type,
          current + 1,
          product.quantity,
          context,
        );
        return;
      }

      await repo.addToCart(product, type);

      // IMPORTANT: refresh AFTER success
      await loadCart();

      if (context.mounted) {
        AppSnackBar.show(
          context,
          message: "Added to cart",
          isError: false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        AppSnackBar.show(
          context,
          message: "Failed to add item to cart",
          isError: true,
        );
      }
    }
  }

  Future<void> removeFromCart(String productId, PurchaseType type) async {
    final previous = state;

    state = state
        .where((e) => !(e.product.id == productId && e.type == type))
        .toList();

    try {
      await repo.removeFromCart(productId, type);
    } catch (_) {
      state = previous;
    }
  }

  Future<void> updateQuantity(
      String productId,
      PurchaseType type,
      int qty,
      int maxQty,
      BuildContext context,
      ) async {
    if (qty < 1) return;

    if (qty > maxQty) {
      AppSnackBar.show(
        context,
        message: "Only $maxQty available",
        isError: true,
      );
      return;
    }

    final prev = state;

    state = [
      for (final item in state)
        if (item.product.id == productId && item.type == type)
          item.copyWith(quantity: qty)
        else
          item
    ];

    try {
      await repo.updateQuantity(productId, type, qty);
    } catch (_) {
      state = prev;
    }
  }

  void toggleSelection(String productId, PurchaseType type) {
    state = [
      for (final item in state)
        if (item.product.id == productId && item.type == type)
          item.copyWith(isSelected: !item.isSelected)
        else
          item
    ];
  }
}