import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/orders/data/models/offer_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OfferRemoteDatasource {
  final SupabaseClient client;

  OfferRemoteDatasource(this.client);

  String get _uid {
    final id = client.auth.currentUser?.id;
    if (id == null) throw Exception("Not logged in");
    return id;
  }

  Future<void> createOffer(OfferModel offer) async {
    final payload = offer.toInsert(buyerId: _uid);

    await client
        .from('offers')
        .insert(payload)
        .select()
        .single();
  }

  Future<List<OfferModel>> fetchBuyerOffers() async {
    final res = await client
        .from('offers')
        .select('''
        *,
        products:prod_id(
          *,
          product_image!product_image_prod_id_fkey(*)
        )
      ''')
        .eq('buyer_id', _uid)
        .order('created_at', ascending: false);

    return (res as List)
        .map((e) => OfferModel.fromDb(
      Map<String, dynamic>.from(e),
    ))
        .toList();
  }

  Future<List<OfferModel>> fetchSellerOffers() async {
    final res = await client
        .from('offers')
        .select('''
        *,
        products:prod_id(
          *,
          product_image!product_image_prod_id_fkey(*)
        )
      ''')
        .eq('seller_id', _uid)
        .order('created_at', ascending: false);

    return (res as List)
        .map((e) => OfferModel.fromDb(
      Map<String, dynamic>.from(e),
    ))
        .toList();
  }

  Future<void> updateOfferStatus({
    required String offerId,
    required OfferStatus status,
  }) async {
    await client
        .from('offers')
        .update({'status': status.dbValue})
        .eq('id', offerId);
  }
}