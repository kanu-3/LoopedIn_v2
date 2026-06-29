import 'package:flutter/cupertino.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/orders/data/models/cart_item_model.dart';
import 'package:loopedin_v2/features/orders/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRemoteDatasource {
  final SupabaseClient client;

  OrderRemoteDatasource(this.client);

  Future<List<OrderModel>> fetchBuyerOrders() async {
    final userId = client.auth.currentUser!.id;


    final data = await client
        .from('orders')
        .select('''
          *,
          order_items(
            *,
            products(
              *,
              product_image!product_image_prod_id_fkey(*)
            )
          )
        ''')
        .eq('buyer_id', userId)
        .order('created_at', ascending: false);

    final list = data as List<dynamic>;

    return list.map((e) {
      final map = Map<String, dynamic>.from(e);
      return OrderModel.fromJson(map);
    }).toList();
  }

  Future<List<OrderModel>> fetchSellerOrders() async {
    final userId = client.auth.currentUser!.id;

    final data = await client
        .from('orders')
        .select('''
          *,
          order_items(
            *,
            products(
              *,
              product_image!product_image_prod_id_fkey(*)
            )
          )
        ''')
        .eq('seller_id', userId)
        .order('created_at', ascending: false);

    final list = data as List<dynamic>;

    return list.map((e) {
      final map = Map<String, dynamic>.from(e);
      return OrderModel.fromJson(map);
    }).toList();
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required order_status status,
  }) async {
    await client
        .from('orders')
        .update({
      'status': status.name,
    })
        .eq('id', orderId);
  }

  Future<void> placeOrder({
    required List<CartItemUIModel> items,
    required String buyerName,
    required String buyerPhone,
    required String deliveryAddress,
    required double totalPrice,
  }) async {
    final buyerId = client.auth.currentUser!.id;

    debugPrint("========== PLACE ORDER START ==========");
    debugPrint("Buyer ID: $buyerId");
    debugPrint("Items Count: ${items.length}");

    final grouped = <String, List<CartItemUIModel>>{};

    for (final item in items) {
      grouped.putIfAbsent(
        item.product.sellerId,
            () => [],
      );

      grouped[item.product.sellerId]!.add(item);
    }

    for (final entry in grouped.entries) {
      final sellerId = entry.key;
      final sellerItems = entry.value;

      try {
        debugPrint("========== INSERTING ORDER ==========");
        debugPrint("sellerId: $sellerId");
        debugPrint("buyerId: $buyerId");
        debugPrint("buyerName: $buyerName");
        debugPrint("buyerPhone: $buyerPhone");
        debugPrint("deliveryAddress: $deliveryAddress");
        debugPrint("totalPrice: $totalPrice");

        final order = await client
            .from('orders')
            .insert({
          'seller_id': sellerId,
          'buyer_id': buyerId,
          'buyer_name': buyerName,
          'buyer_phone': buyerPhone,
          'delivery_address': deliveryAddress,
          'total_price': totalPrice,
        })
            .select()
            .single();

        debugPrint("ORDER CREATED");
        debugPrint(order.toString());

        final orderId = order['id'];

        final orderItems = sellerItems.map((item) {
          final originalUnitPrice = item.type == PurchaseType.buy
              ? (item.product.price ?? 0)
              : (item.product.rentPricePerDay ?? 0);

          final finalUnitPrice =
              item.discountedPrice ?? originalUnitPrice;

          return {
            'order_id': orderId,
            'prod_id': item.product.id,
            'quantity': item.quantity,
            'price': finalUnitPrice * item.quantity,
            'original_price': originalUnitPrice,
            'offer_id': item.offerId,
            'available_type': item.type.name,
          };
        }).toList();

        debugPrint("INSERTING ORDER ITEMS");
        debugPrint(orderItems.toString());

        await client
            .from('order_items')
            .insert(orderItems);

        debugPrint("ORDER ITEMS INSERTED");

        for (final item in sellerItems) {
          debugPrint(
            "========== REDUCING PRODUCT STOCK ==========",
          );

          await client.rpc(
            'reduce_product_quantity',
            params: {
              'p_product_id': item.product.id,
              'p_quantity': item.quantity,
              'p_purchase_type': item.type.name,
            },
          );

          debugPrint(
            "PRODUCT STOCK UPDATED: ${item.product.id}",
          );

          await client
              .from('cart')
              .delete()
              .eq(
            'user_id',
            buyerId,
          )
              .eq(
            'prod_id',
            item.product.id,
          )
              .eq(
            'available_type',
            item.type.name,
          );

          debugPrint(
            "CART ITEM REMOVED: ${item.product.id}",
          );
        }

        debugPrint(
          "ORDER FLOW COMPLETED FOR SELLER $sellerId",
        );
      } catch (e, st) {
        debugPrint(
          "ORDER CREATION FAILED",
        );

        debugPrint(
          e.toString(),
        );

        debugPrint(
          st.toString(),
        );

        rethrow;
      }
    }

    debugPrint(
      "PLACE ORDER END",
    );
  }
}