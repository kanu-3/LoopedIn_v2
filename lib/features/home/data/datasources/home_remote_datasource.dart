import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/features/home/data/models/home_feed_model.dart';
import 'package:loopedin_v2/features/home/data/models/user_search_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRemoteDatasource {
  final SupabaseClient client;

  HomeRemoteDatasource(this.client);

  Future<Set<String>> getLikedProductIds(String userId) async {
    final res = await client
        .from('likes')
        .select('prod_id')
        .eq('user_id', userId);

    return (res as List)
        .map((e) => e['prod_id'] as String)
        .toSet();
  }

  Future<void> toggleLike({
    required String productId,
    required String userId,
  }) async {
    final existing = await client
        .from('likes')
        .select('id')
        .eq('prod_id', productId)
        .eq('user_id', userId)
        .maybeSingle();

    if (existing == null) {
      await client.from('likes').insert({
        'prod_id': productId,
        'user_id': userId,
      });
    } else {
      await client
          .from('likes')
          .delete()
          .eq('id', existing['id']);
    }
  }

  Future<Set<String>> getWishlistedProductIds(String userId) async {
    final res = await client
        .from('wishlist')
        .select('prod_id')
        .eq('user_id', userId);

    return (res as List)
        .map((e) => e['prod_id'] as String)
        .toSet();
  }

  Future<void> toggleWishlist({
    required String productId,
    required String userId,
  }) async {
    final existing = await client
        .from('wishlist')
        .select('id')
        .eq('prod_id', productId)
        .eq('user_id', userId)
        .maybeSingle();

    if (existing == null) {
      await client.from('wishlist').insert({
        'prod_id': productId,
        'user_id': userId,
      });
    } else {
      await client
          .from('wishlist')
          .delete()
          .eq('id', existing['id']);
    }
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final res = await client
        .from('user_profile')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    return res;
  }

  Future<List<HomeFeedModel>> getFeedPosts(String currentUserId) async {
    final productsRes = await client
        .from('products')
        .select()
        .eq('status', 'active')
        .neq('seller_id', currentUserId)
        .order('created_at', ascending: false);

    final List<dynamic> products = productsRes;
    if (products.isEmpty) return [];

    final productIds = <String>[];
    final sellerIds = <String>{};

    for (final p in products) {
      final map = p as Map<String, dynamic>;
      final pid = map['id'];
      final sid = map['seller_id'];

      if (pid is String) productIds.add(pid);
      if (sid is String) sellerIds.add(sid);
    }

    final imageMap = await _getImages(productIds);
    final profileMap = await _getProfiles(sellerIds.toList());

    final allLikesRes = await client
        .from('likes')
        .select('prod_id')
        .inFilter('prod_id', productIds);

    final allCommentsRes = await client
        .from('comments')
        .select('prod_id')
        .inFilter('prod_id', productIds);

    final List<dynamic> allLikes = allLikesRes;
    final List<dynamic> allComments = allCommentsRes;

    final feed = <HomeFeedModel>[];

    for (final p in products) {
      final map = p as Map<String, dynamic>;

      final productId = map['id'] as String?;
      final sellerId = map['seller_id'] as String?;

      if (productId == null || sellerId == null) continue;

      final profile = profileMap[sellerId];

      final likesCount = allLikes.where((item) => item['prod_id'] == productId).length;
      final commentsCount = allComments.where((item) => item['prod_id'] == productId).length;

      feed.add(
        HomeFeedModel(
          product: ProductModel(
            id: productId,
            title: map['title'] ?? '',
            price: (map['price'] as num?)?.toDouble(),
            sellerId: sellerId,
            subCategory: map['sub_category'] ?? '',
            images: imageMap[productId] ?? [],
            size: map['size'] ?? '',
            brand: map['brand'],
            style: map['style'],
            pattern: map['pattern'],
            color: map['color'],
            description: map['description'],
            quantity: map['quantity'] ?? 0,
            expressDelivery: map['express_delivery'] ?? false,
            alteration: map['alteration'] ?? false,
            dryClean: map['dry_clean'] ?? false,
            directContact: map['direct_contact'] ?? false,
            fabric: map['fabric'],
            productCondition: map['product_condition'] ?? '',
            rentPricePerDay: (map['rent_price_per_day'] as num?)?.toDouble(),
            status: map['status'] ?? 'active',
            createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
            availability: product_availability.both,
          ),
          sellerName: profile?['name'] ?? 'User',
          sellerUsername: profile?['username'] ?? '',
          sellerProfilePic: profile?['profile_pic'],
          likesCount: likesCount,
          commentsCount: commentsCount,
          isLiked: false, sellerId: sellerId,
        ),
      );
    }

    return feed;
  }

  Future<List<UserSearchModel>> searchUsers(String query) async {
    if (query.trim().isEmpty) return [];

    final res = await client
        .from('users')
        .select('user_id, username, user_profile(name, profile_pic)')
        .ilike('username', '%$query%')
        .limit(15);

    return (res as List).map((e) {
      final m = e as Map<String, dynamic>;

      final profileList = m['user_profile'];
      Map<String, dynamic>? profileData;
      if (profileList is List && profileList.isNotEmpty) {
        profileData = profileList.first as Map<String, dynamic>;
      } else if (profileList is Map<String, dynamic>) {
        profileData = profileList;
      }

      return UserSearchModel(
        userId: m['user_id'] ?? '',
        username: m['username'] ?? '',
        name: profileData?['name'] ?? 'User',
        profilePic: profileData?['profile_pic'],
      );
    }).toList();
  }

  Future<Map<String, dynamic>> _getProfiles(
      List<String> userIds,
      ) async {
    if (userIds.isEmpty) return {};

    final usersRes = await client
        .from('users')
        .select('user_id, username')
        .inFilter('user_id', userIds);

    final profilesRes = await client
        .from('user_profile')
        .select('user_id, name, profile_pic')
        .inFilter('user_id', userIds);

    final map = <String, dynamic>{};

    final Map<String, String> userNamesMap = {
      for (var u in usersRes as List) u['user_id'].toString(): u['username'].toString()
    };

    for (final e in profilesRes as List) {
      final m = e as Map<String, dynamic>;
      final id = m['user_id'] as String?;
      if (id != null) {
        map[id] = {
          'name': m['name'],
          'profile_pic': m['profile_pic'],
          'username': userNamesMap[id] ?? 'user', // <--- Glued here!
        };
      }
    }

    return map;
  }

  Future<Map<String, List<String>>> _getImages(List<String> ids) async {
    if (ids.isEmpty) return {};

    final res = await client
        .from('product_image')
        .select('prod_id, img_url')
        .inFilter('prod_id', ids);

    final map = <String, List<String>>{};

    for (final r in res) {
      final row = r as Map<String, dynamic>;
      final id = row['prod_id'];
      final url = row['img_url'];

      if (id is String && url is String) {
        map.putIfAbsent(id, () => []).add(url);
      }
    }

    return map;
  }
}