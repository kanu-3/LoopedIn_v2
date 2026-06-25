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
            product_image(*)
          )
        )
      ''')
        .eq('buyer_id', userId)
        .order('created_at', ascending: false);

    final list = data as List<dynamic>;

    return list
        .map((e) {
      final map = Map<String, dynamic>.from(e);

      return OrderModel.fromJson(map);
    })
        .toList();
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
            product_image(*)
          )
        )
      ''')
        .eq('seller_id', userId)
        .order('created_at', ascending: false);

    final list = data as List<dynamic>;

    return list
        .map((e) {
      final map = Map<String, dynamic>.from(e);

      return OrderModel.fromJson(map);
    })
        .toList();
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
        .eq(
      'id',
      orderId,
    );
  }

  Future<void> placeOrder({
    required List<CartItemUIModel> items,
    required String buyerName,
    required String buyerPhone,
    required String deliveryAddress,
  }) async {
    final buyerId =
        client.auth.currentUser!.id;

    final grouped =
    <String, List<CartItemUIModel>>{};

    for (final item in items) {
      grouped.putIfAbsent(
        item.product.sellerId,
            () => [],
      );

      grouped[item.product.sellerId]!
          .add(item);
    }

    for (final entry in grouped.entries) {
      final sellerId = entry.key;

      final sellerItems = entry.value;

      double total = 0;

      for (final item in sellerItems) {
        final itemPrice =
        item.type == PurchaseType.buy
            ? (item.product.price ?? 0)
            : (item.product.rentPricePerDay ??
            0);

        total +=
            itemPrice * item.quantity;
      }

      final order =
      await client
          .from('orders')
          .insert({
        'seller_id': sellerId,
        'buyer_id': buyerId,
        'buyer_name': buyerName,
        'buyer_phone': buyerPhone,
        'delivery_address':
        deliveryAddress,
        'total_price': total,
      })
          .select()
          .single();

      final orderId = order['id'];

      final orderItems =
      sellerItems
          .map(
            (item) => {
          'order_id': orderId,
          'prod_id':
          item.product.id,
          'quantity':
          item.quantity,
          'price':
          item.type ==
              PurchaseType
                  .buy
              ? item.product
              .price
              : item.product
              .rentPricePerDay,
          'available_type':
          item.type.name,
          'original_price':
          item.type ==
              PurchaseType
                  .buy
              ? item.product
              .price
              : item.product
              .rentPricePerDay,
        },
      )
          .toList();

      await client
          .from('order_items')
          .insert(orderItems);

      for (final item in sellerItems) {
        final remainingQuantity =
            item.product.quantity -
                item.quantity;

        await client
            .from('products')
            .update({
          'quantity':
          remainingQuantity,
          'status':
          remainingQuantity <= 0
              ? (item.type ==
              PurchaseType
                  .buy
              ? 'sold'
              : 'rented')
              : 'active',
        })
            .eq(
          'id',
          item.product.id,
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
      }
    }
  }
}