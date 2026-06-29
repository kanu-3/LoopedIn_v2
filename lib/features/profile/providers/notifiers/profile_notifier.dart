import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/models/profile_model.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/profile/data/repositories/profile_repository.dart';
import 'package:loopedin_v2/features/profile/providers/states/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository repository;

  ProfileNotifier(this.repository) : super(ProfileState.initial());

  Future<void> loadSellerProfile(
      String sellerId,
      ) async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final profile =
      await repository.fetchProfile(
        sellerId,
      );

      state = state.copyWith(
        isLoading: false,
        profile: profile,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> toggleFollow() async {
    final profile = state.profile;

    if (profile == null) return;

    if (profile.isFollowing) {
      await repository.unfollowUser(
        profile.userId,
      );
    } else {
      await repository.followUser(
        profile.userId,
      );
    }

    await loadProfile(profile.userId);
  }

  Future<void> uploadProfilePicture(
      Uint8List imageBytes,
      ) async {
    try {
      final userId =
          SupabaseService.client.auth.currentUser?.id;

      if (userId == null) return;

      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      await repository.uploadProfilePicture(
        userId: userId,
        imageBytes: imageBytes,
      );

      final profile =
      await repository.fetchProfile(userId);

      state = state.copyWith(
        isLoading: false,
        profile: profile,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadProfile(String userId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

        final profile = await repository.fetchProfile(userId);

        state = state.copyWith(
          isLoading: false,
          profile: profile,
        );
      } catch (e) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
        );
      }
    }

  Future<ProfileModel?> getProfile(String userId) async {
    try {
      final profile = await repository.fetchProfile(userId);
      return profile;
    } catch (e) {
      debugPrint("❌ GetProfile Error: $e");
      return null;
    }
  }

    Future<bool> updateField({
      required String table,
      required String column,
      required dynamic value,
    }) async {
      try {
        final userId = SupabaseService.client.auth.currentUser?.id;
        if (userId == null) return false;

        await repository.updateProfileField(
          userId: userId,
          table: table,
          column: column,
          value: value,
        );

        await loadProfile(userId);
        return true;
      } catch (e) {
        debugPrint("❌ Database Update Error: $e");
        state = state.copyWith(error: e.toString());
        return false;
      }
    }
  }