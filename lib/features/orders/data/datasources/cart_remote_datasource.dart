import 'package:supabase_flutter/supabase_flutter.dart';

class CartRemoteDatasource {
  final SupabaseClient client;

  CartRemoteDatasource(this.client);

  Future<void> addToCart({
    required String productId,
    required int quantity,
    required String availableType,
  }) async {
    try {
      final userId = client.auth.currentUser!.id;

      final response = await client
          .from('cart')
          .upsert({
        'user_id': userId,
        'prod_id': productId,
        'quantity': quantity,
        'available_type': availableType.toLowerCase(),
      }, onConflict: 'user_id,prod_id,available_type')
          .select();

      print("CART SUCCESS: $response");
    } catch (e, st) {
      print("CART ERROR: $e");
      print(st);
      rethrow;
    }
  }

  Future<void> removeFromCart({
    required String productId,
    required String availableType,
  }) async {
    final userId = client.auth.currentUser!.id;

    await client
        .from('cart')
        .delete()
        .eq('user_id', userId)
        .eq('prod_id', productId)
        .eq('available_type', availableType);
  }

  Future<void> updateQuantity({
    required String productId,
    required String availableType,
    required int quantity,
  }) async {
    final userId = client.auth.currentUser!.id;

    await client
        .from('cart')
        .update({'quantity': quantity})
        .eq('user_id', userId)
        .eq('prod_id', productId)
        .eq('available_type', availableType);
  }

  Future<List<Map<String, dynamic>>> fetchCart() async {
    final userId = client.auth.currentUser!.id;

    final response = await client
        .from('cart')
        .select('''
        *,
        products(
          *,
          product_image!product_image_prod_id_fkey(*)
        )
      ''')
        .eq('user_id', userId);

    return List<Map<String, dynamic>>.from(response);
  }
}