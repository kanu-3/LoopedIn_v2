import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/services/storage_service.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/products/data/models/product_draft_model.dart';
import 'package:loopedin_v2/features/products/data/models/uploaded_image_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRemoteDatasource {
  final SupabaseClient client;

  ProductRemoteDatasource(this.client);


  Future<List<ProductModel>> getProductsBySeller(
      String sellerId,
      ) async {
    final response = await client
        .from('products')
        .select()
        .eq('seller_id', sellerId)
        .eq('status', 'active')
        .order(
      'created_at',
      ascending: false,
    );

    final ids = response
        .map((e) => e['id'] as String)
        .toList();

    final imageMap =
    await getImagesForProducts(ids);

    return response.map<ProductModel>((data) {
      return _map(
        data,
        imageMap[data['id']] ?? [],
      );
    }).toList();
  }

  Future<Map<String, dynamic>> getSellerDashboardAnalytics() async {
    final user = client.auth.currentUser;
    if (user == null) return {'wishlistCount': 0, 'weeklyChartData': <String, int>{}};

    final myProductsRes = await client
        .from('products')
        .select('id, created_at')
        .eq('seller_id', user.id);

    int wishlistCount = 0;
    final Map<String, int> weeklyChartData = {
      'SUN': 0, 'MON': 0, 'TUES': 0, 'WED': 0, 'THUR': 0, 'FRI': 0, 'SAT': 0
    };
    final weekdays = ['MON', 'TUES', 'WED', 'THUR', 'FRI', 'SAT', 'SUN'];

    if (myProductsRes != null && myProductsRes.isNotEmpty) {
      final List<String> productIds = myProductsRes.map<String>((p) => p['id'] as String).toList();

      final wishlistRes = await client
          .from('wishlist')
          .select('id')
          .inFilter('prod_id', productIds);

      if (wishlistRes != null) {
        wishlistCount = wishlistRes.length;
      }

      for (var row in myProductsRes) {
        if (row['created_at'] != null) {
          final date = DateTime.parse(row['created_at']);
          final dayLabel = weekdays[date.weekday - 1];
          weeklyChartData[dayLabel] = (weeklyChartData[dayLabel] ?? 0) + 1;
        }
      }
    }

    return {
      'wishlistCount': wishlistCount,
      'weeklyChartData': weeklyChartData,
    };
  }

  Future<void> updateProduct({
    required String productId,
    required ProductDraftModel draft,
  }) async {
    await client
        .from('products')
        .update({
      'title': draft.title,
      'price': draft.price,
      'rent_price_per_day':
      draft.rentPricePerDay,
      'available':
      draft.availability.name,
      'sub_category':
      draft.subCategory,
      'size': draft.size,
      'brand': draft.brand,
      'style': draft.style,
      'pattern': draft.pattern,
      'color': draft.color,
      'description':
      draft.description,
      'quantity': draft.quantity,
      'express_delivery':
      draft.expressDelivery,
      'alteration':
      draft.alteration,
      'dry_clean':
      draft.dryClean,
      'direct_contact':
      draft.directContact,
      'fabric': draft.fabric,
      'product_condition':
      draft.productCondition,
    })
        .eq('id', productId);
  }

  Future<List<ProductModel>> getProductsBySubCategory(
      String subCategory,
      String currentUserId,
      ) async {
    final response = await client
        .from('products')
        .select()
        .eq('sub_category', subCategory)
        .eq('status', product_status.active.name)
        .neq('seller_id', currentUserId) // FIX HERE
        .order('created_at', ascending: false);

    final ids = response.map((e) => e['id'] as String).toList();
    final imageMap = await getImagesForProducts(ids);

    return response.map<ProductModel>((data) {
      return _map(data, imageMap[data['id']] ?? []);
    }).toList();
  }

  Future<Map<String, List<String>>> getImagesForProducts(
      List<String> productIds,
      ) async {
    if (productIds.isEmpty) return {};

    final response = await client
        .from('product_image')
        .select('prod_id, img_url')
        .inFilter('prod_id', productIds);

    final map = <String, List<String>>{};

    for (final row in response) {
      final id = row['prod_id'] as String;
      map.putIfAbsent(id, () => []).add(row['img_url']);
    }

    return map;
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await client
        .from('products')
        .select()
        .order('created_at', ascending: false);

    final ids = response.map((e) => e['id'] as String).toList();
    final imageMap = await getImagesForProducts(ids);

    return response.map<ProductModel>((data) {
      return _map(data, imageMap[data['id']] ?? []);
    }).toList();
  }

  Future<List<ProductModel>> getMyProducts() async {
    final user = SupabaseService.client.auth.currentUser;
    if (user == null) return [];

    final response = await client
        .from('products')
        .select()
        .eq('seller_id', user.id)
        .order('created_at', ascending: false);

    final ids = response.map((e) => e['id'] as String).toList();
    final imageMap = await getImagesForProducts(ids);

    return response.map<ProductModel>((data) {
      return _map(data, imageMap[data['id']] ?? []);
    }).toList();
  }

  Future<ProductModel> getProductById(String id) async {
    final data =
    await client.from('products').select().eq('id', id).single();

    final images = await getImagesForProducts([id]);

    return _map(data, images[id] ?? []);
  }

  Future<void> createProduct({
    required ProductDraftModel draft,
  }) async {
    final userId = SupabaseService.client.auth.currentUser!.id;

    final uploadedPaths = <String>[];
    List<UploadedImageModel> uploadedImages = [];

    try {
      uploadedImages = await StorageService.uploadProductImages(
        images: draft.images,
        userId: userId,
      );

      uploadedPaths.addAll(
        uploadedImages.map((e) => e.storagePath),
      );

      final inserted = await client
          .from('products')
          .insert({
        'title': draft.title,
        'price': draft.price,
        'rent_price_per_day': draft.rentPricePerDay,
        'available': draft.availability.name,
        'seller_id': userId,
        'sub_category': draft.subCategory,

        'style': draft.style,
        'pattern': draft.pattern,
        'product_condition': draft.productCondition,
        'status': draft.status,

        'size': draft.size,
        'brand': draft.brand,
        'color': draft.color,
        'description': draft.description,
        'quantity': draft.quantity,

        'express_delivery': draft.expressDelivery,
        'alteration': draft.alteration,
        'dry_clean': draft.dryClean,
        'direct_contact': draft.directContact,

        'fabric': draft.fabric,
        'main_img_id': null,
      })
          .select('id')
          .single();

      final productId = inserted['id'];

      final images = await client
          .from('product_image')
          .insert(
        uploadedImages.map((image) => {
          'prod_id': productId,
          'img_url': image.url,
          'storage_path': image.storagePath,
        }).toList(),
      )
          .select('id');

      await client
          .from('products')
          .update({
        'main_img_id': images.first['id'],
      })
          .eq('id', productId);

    } catch (e) {

      if (uploadedPaths.isNotEmpty) {
        try {
          await client.storage
              .from(StorageService.productBucket)
              .remove(uploadedPaths);
        } catch (_) {}
      }

      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {

    final images = await client
        .from('product_image')
        .select('storage_path')
        .eq('prod_id', productId);

    final paths = images
        .map<String>(
          (e) => e['storage_path'] as String,
    )
        .toList();

    if (paths.isNotEmpty) {
      await client.storage
          .from(StorageService.productBucket)
          .remove(paths);
    }

    await client
        .from('product_image')
        .delete()
        .eq('prod_id', productId);

    await client
        .from('products')
        .delete()
        .eq('id', productId);
  }

  Future<void> updateProductStatus({
    required String productId,
    required String status,
  }) async {
    await client
        .from('products')
        .update({
      'status': status,
    })
        .eq('id', productId);
  }

  ProductModel _map(Map<String, dynamic> data, List<String> images) {
    return ProductModel(
      id: data['id'],
      title: data['title'],
      price: data['price'] != null
          ? (data['price'] as num).toDouble()
          : null,
      availability: product_availability.values.firstWhere(
            (e) => e.name == data['available'],
      ),
      sellerId: data['seller_id'],
      subCategory: data['sub_category'],
      images: images,
      size: data['size'],
      brand: data['brand'],
      style: data['style'],
      pattern: data['pattern'],
      color: data['color'],
      description: data['description'],
      quantity: data['quantity'],
      expressDelivery: data['express_delivery'] ?? false,
      alteration: data['alteration'] ?? false,
      dryClean: data['dry_clean'] ?? false,
      directContact: data['direct_contact'] ?? false,
      productCondition: data['product_condition'],
      rentPricePerDay: data['rent_price_per_day'] != null
          ? (data['rent_price_per_day'] as num).toDouble()
          : null,
      status: data['status'],
      createdAt: DateTime.parse(data['created_at']),
      fabric: data['fabric'],
    );
  }
}