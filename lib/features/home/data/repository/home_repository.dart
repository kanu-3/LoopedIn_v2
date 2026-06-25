import 'package:loopedin_v2/features/home/data/datasources/home_remote_datasource.dart';
import 'package:loopedin_v2/features/home/data/models/home_feed_model.dart';
import 'package:loopedin_v2/features/home/data/models/user_search_model.dart';

class HomeRepository {
  final HomeRemoteDatasource datasource;

  HomeRepository(this.datasource);

  Future<List<HomeFeedModel>> getFeedPosts(String userId) {
    return datasource.getFeedPosts(userId);
  }

  Future<Set<String>> getLikedProductIds(String userId) {
    return datasource.getLikedProductIds(userId);
  }

  Future<void> toggleLike({
    required String productId,
    required String userId,
  }) {
    return datasource.toggleLike(
      productId: productId,
      userId: userId,
    );
  }

  Future<Set<String>> getWishlistedProductIds(String userId) {
    return datasource.getWishlistedProductIds(userId);
  }

  Future<void> toggleWishlist({
    required String productId,
    required String userId,
  }) {
    return datasource.toggleWishlist(
      productId: productId,
      userId: userId,
    );
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) {
    return datasource.getUserProfile(userId);
  }

  Future<List<UserSearchModel>> searchUsers(String query) {
    return datasource.searchUsers(query);
  }
}