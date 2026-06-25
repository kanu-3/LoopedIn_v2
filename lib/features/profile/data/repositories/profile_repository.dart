import 'dart:typed_data';

import 'package:loopedin_v2/core/models/profile_model.dart';
import 'package:loopedin_v2/features/profile/data/datasources/profile_remote_datasource.dart';

class ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepository(this.remote);

  Future<ProfileModel> fetchProfile(String userId) {
    return remote.getProfile(userId);
  }

  Future<void> followUser(String userId) {
    return remote.followUser(userId);
  }

  Future<void> unfollowUser(String userId) {
    return remote.unfollowUser(userId);
  }

  Future<void> uploadProfilePicture({
    required String userId,
    required Uint8List imageBytes,
  }) {
    return remote.uploadProfilePicture(
      userId: userId,
      imageBytes: imageBytes,
    );
  }

  Future<void> updateProfileField({
    required String userId,
    required String table,
    required String column,
    required dynamic value,
  }) {
    return remote.updateProfileField(
      userId: userId,
      table: table,
      column: column,
      value: value,
    );
  }
}