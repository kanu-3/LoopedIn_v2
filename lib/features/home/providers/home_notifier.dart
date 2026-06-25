import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/home/data/repository/home_repository.dart';
import 'package:loopedin_v2/features/home/providers/home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository repository;

  HomeNotifier(this.repository) : super(HomeState.initial()) {
    initialize();
  }

  String? _currentUserId;

  Future<void> initialize() async {
    final userId = SupabaseService.client.auth.currentUser?.id;
    if (userId == null) return;

    _currentUserId = userId;
    state = state.copyWith(isLoading: true);

    try {
      final profile = await repository.getUserProfile(userId);
      final likedIds = await repository.getLikedProductIds(userId);
      final wishlistIds = await repository.getWishlistedProductIds(userId);
      final posts = await repository.getFeedPosts(userId);

      state = state.copyWith(
        isLoading: false,
        feedPosts: posts,
        likedProductIds: likedIds,
        wishlistedProductIds: wishlistIds,
        currentUserProfile: profile,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> toggleLike(String productId) async {
    final userId = _currentUserId;
    if (userId == null) return;

    final updatedLikes = Set<String>.from(state.likedProductIds);
    final updatedDislikes = Set<String>.from(state.locallyDislikedProductIds);
    final isLiked = updatedLikes.contains(productId);

    if (isLiked) {
      updatedLikes.remove(productId);
    } else {
      updatedLikes.add(productId);
      updatedDislikes.remove(productId);
    }

    final updatedFeed = state.feedPosts.map((post) {
      if (post.product.id == productId) {
        final modernCount = isLiked
            ? (post.likesCount - 1).clamp(0, double.infinity).toInt()
            : (post.likesCount + 1);

        return post.copyWith(likesCount: modernCount);
      }
      return post;
    }).toList();

    state = state.copyWith(
      likedProductIds: updatedLikes,
      locallyDislikedProductIds: updatedDislikes,
      feedPosts: updatedFeed,
    );

    try {
      await repository.toggleLike(
        productId: productId,
        userId: userId,
      );
    } catch (_) {
      final freshLikes = await repository.getLikedProductIds(userId);
      final freshFeed = await repository.getFeedPosts(userId);
      state = state.copyWith(
        likedProductIds: freshLikes,
        feedPosts: freshFeed,
      );
    }
  }

  void toggleDislike(String productId) {
    final updatedDislikes = Set<String>.from(state.locallyDislikedProductIds);
    final updatedLikes = Set<String>.from(state.likedProductIds);

    if (updatedDislikes.contains(productId)) {
      updatedDislikes.remove(productId);
    } else {
      updatedDislikes.add(productId);
      updatedLikes.remove(productId);
    }

    state = state.copyWith(
      locallyDislikedProductIds: updatedDislikes,
      likedProductIds: updatedLikes,
    );
  }

  Future<void> toggleWishlist(String productId) async {
    final userId = _currentUserId;
    if (userId == null) return;

    final updated = Set<String>.from(state.wishlistedProductIds);
    if (updated.contains(productId)) {
      updated.remove(productId);
    } else {
      updated.add(productId);
    }
    state = state.copyWith(wishlistedProductIds: updated);

    try {
      await repository.toggleWishlist(
        productId: productId,
        userId: userId,
      );
    } catch (_) {
      final fresh = await repository.getWishlistedProductIds(userId);
      state = state.copyWith(wishlistedProductIds: fresh);
    }
  }

  Future<void> searchUsers(String query) async {
    state = state.copyWith(searchQuery: query);

    if (query.trim().isEmpty) {
      state = state.copyWith(searchedUsers: []);
      return;
    }

    final users = await repository.searchUsers(query);

    state = state.copyWith(
      searchedUsers: users,
    );
  }

  Future<void> refreshFeed() => initialize();
}