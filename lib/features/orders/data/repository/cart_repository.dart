import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/features/orders/data/datasources/cart_remote_datasource.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';

class CartRepository {
  final CartRemoteDatasource remote;

  CartRepository(this.remote);

  Future<void> addToCart(ProductModel product, PurchaseType type) {
    return remote.addToCart(
      productId: product.id,
      quantity: 1,
      availableType: type.name,
    );
  }

  Future<void> removeFromCart(String productId, PurchaseType type) {
    return remote.removeFromCart(
      productId: productId,
      availableType: type.name,
    );
  }

  Future<void> updateQuantity(
      String productId,
      PurchaseType type,
      int qty,
      ) {
    return remote.updateQuantity(
      productId: productId,
      availableType: type.name,
      quantity: qty,
    );
  }

  Future<List<CartItemUIModel>> fetchCart() async {
    final raw = await remote.fetchCart();

    return raw.map((e) {
      final product = ProductModel.fromJson(e['products']);

      final type = PurchaseType.values.firstWhere(
            (t) => t.name.toLowerCase() ==
            e['available_type'].toString().toLowerCase(),
        orElse: () => PurchaseType.buy,
      );

      return CartItemUIModel(
        product: product,
        type: type,
        quantity: e['quantity'] ?? 1,
        isSelected: true,
      );
    }).toList();
  }
}