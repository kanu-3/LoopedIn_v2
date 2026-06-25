import 'package:loopedin_v2/features/home/data/models/home_feed_model.dart';
import 'package:loopedin_v2/features/home/data/models/user_search_model.dart';

class HomeState {
  final bool isLoading;
  final List<HomeFeedModel> feedPosts;
  final List<UserSearchModel> storyUsers;
  final List<UserSearchModel> searchedUsers;
  final Set<String> likedProductIds;
  final Set<String> wishlistedProductIds;
  final Set<String> locallyDislikedProductIds;
  final String searchQuery;
  final Map<String, dynamic>? currentUserProfile;

  const HomeState({
    required this.isLoading,
    required this.feedPosts,
    required this.storyUsers,
    required this.searchedUsers,
    required this.likedProductIds,
    required this.wishlistedProductIds,
    required this.locallyDislikedProductIds,
    required this.searchQuery,
    required this.currentUserProfile,
  });

  factory HomeState.initial() {
    return const HomeState(
      isLoading: false,
      feedPosts: [],
      storyUsers: [],
      searchedUsers: [],
      likedProductIds: {},
      wishlistedProductIds: {},
      locallyDislikedProductIds: {},
      searchQuery: '',
      currentUserProfile: null,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    List<HomeFeedModel>? feedPosts,
    List<UserSearchModel>? storyUsers,
    List<UserSearchModel>? searchedUsers,
    Set<String>? likedProductIds,
    Set<String>? wishlistedProductIds,
    Set<String>? locallyDislikedProductIds,
    String? searchQuery,
    Map<String, dynamic>? currentUserProfile,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      feedPosts: feedPosts ?? this.feedPosts,
      storyUsers: storyUsers ?? this.storyUsers,
      searchedUsers: searchedUsers ?? this.searchedUsers,
      likedProductIds: likedProductIds ?? this.likedProductIds,
      wishlistedProductIds: wishlistedProductIds ?? this.wishlistedProductIds,
      locallyDislikedProductIds: locallyDislikedProductIds ?? this.locallyDislikedProductIds,
      searchQuery: searchQuery ?? this.searchQuery,
      currentUserProfile: currentUserProfile ?? this.currentUserProfile,
    );
  }
}