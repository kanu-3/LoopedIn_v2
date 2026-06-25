import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/features/profile/data/repositories/profile_repository.dart';
import 'package:loopedin_v2/features/profile/providers/states/seller_profile_state.dart';

class SellerProfileNotifier
    extends StateNotifier<SellerProfileState> {

  final ProfileRepository repository;

  SellerProfileNotifier(this.repository)
      : super(SellerProfileState.initial());

  Future<void> loadSeller(
      String sellerId,
      ) async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      final profile =
      await repository.fetchProfile(
        sellerId,
      );

      state = state.copyWith(
        isLoading: false,
        profile: profile,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<void> toggleFollow() async {
    final profile = state.profile;

    if (profile == null) return;

    try {
      if (profile.isFollowing) {
        await repository.unfollowUser(
          profile.userId,
        );
      } else {
        await repository.followUser(
          profile.userId,
        );
      }

      final updatedProfile =
      await repository.fetchProfile(
        profile.userId,
      );

      state = state.copyWith(
        profile: updatedProfile,
      );
    } catch (e) {
      print("❌ Error toggling seller follow status: $e");
    }
  }
}