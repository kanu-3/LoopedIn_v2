import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartRemoteDatasource {
  final SupabaseClient client;

  CartRemoteDatasource(this.client);

  String get _uid => client.auth.currentUser!.id;

  Future<void> addToCart({
    required String productId,
    required int quantity,
    required String availableType,
  }) async {
    try {
      final response = await client
          .from('cart')
          .upsert(
        {
          'user_id': _uid,
          'prod_id': productId,
          'quantity': quantity,
          'available_type': availableType,
        },
        onConflict: 'user_id,prod_id,available_type',
      )
          .select();

      debugPrint("NORMAL CART INSERT");
      debugPrint(response.toString());
    } catch (e, st) {
      debugPrint("NORMAL CART ERROR");
      debugPrint(e.toString());
      debugPrint(st.toString());
      rethrow;
    }
  }

  Future<void> addOfferToCart({
    required String productId,
    required String offerId,
    required double discountedPrice,
    required int quantity,
    required String availableType,
  }) async {
    try {
      final response = await client
          .from('cart')
          .upsert(
        {
          'user_id': _uid,
          'prod_id': productId,
          'offer_id': offerId,
          'discounted_price': discountedPrice,
          'quantity': quantity,
          'available_type': availableType,
        },
        onConflict: 'user_id,prod_id,available_type',
      )
          .select();

      debugPrint("OFFER CART INSERT");
      debugPrint(response.toString());
    } catch (e, st) {
      debugPrint("OFFER CART ERROR");
      debugPrint(e.toString());
      debugPrint(st.toString());
      rethrow;
    }
  }

  Future<void> removeFromCart({
    required String productId,
    required String availableType,
  }) async {
    await client
        .from('cart')
        .delete()
        .eq('user_id', _uid)
        .eq('prod_id', productId)
        .eq('available_type', availableType);
  }

  Future<void> updateQuantity({
    required String productId,
    required String availableType,
    required int quantity,
  }) async {
    await client
        .from('cart')
        .update({
      'quantity': quantity,
    })
        .eq('user_id', _uid)
        .eq('prod_id', productId)
        .eq('available_type', availableType);
  }

  Future<List<Map<String, dynamic>>> fetchCart() async {
    final response = await client
        .from('cart')
        .select('''
          *,
          products(
            *,
            product_image!product_image_prod_id_fkey(*)
          )
        ''')
        .eq('user_id', _uid);

    debugPrint("FETCH CART");
    debugPrint(response.toString());

    return List<Map<String, dynamic>>.from(response);
  }
}