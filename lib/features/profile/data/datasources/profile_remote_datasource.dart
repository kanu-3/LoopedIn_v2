import 'dart:typed_data';

import 'package:loopedin_v2/core/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRemoteDataSource {
  final SupabaseClient client;

  ProfileRemoteDataSource(this.client);

  Future<void> followUser(String userId) async {
    await client.from('followers').insert({
      'follower_id': client.auth.currentUser!.id,
      'following_id': userId,
    });
  }

  Future<void> unfollowUser(String userId) async {
    await client
        .from('followers')
        .delete()
        .eq(
      'follower_id',
      client.auth.currentUser!.id,
    )
        .eq(
      'following_id',
      userId,
    );
  }

  Future<ProfileModel> getProfile(String userId) async {
    final currentUserId = client.auth.currentUser?.id;

    final results = await Future.wait<dynamic>([
      client.from('users').select('user_id, username, email, phone_no').eq('user_id', userId).maybeSingle(),
      client.from('user_profile').select('name, bio, profile_pic, social_media_handle').eq('user_id', userId).maybeSingle(),
      client.from('user_address').select('address_line, city').eq('user_id', userId).eq('is_default', true).maybeSingle(),
      client.from('user_verification').select('govt_id_type, is_face_verified').eq('user_id', userId).maybeSingle(),
      client.from('user_bank_details').select('user_bank_name').eq('user_id', userId).maybeSingle(),
      client.from('followers').select('id').eq('following_id', userId),
      client.from('followers').select('id').eq('follower_id', userId),
      client.from('products').select('id').eq('seller_id', userId).eq('status', 'active'),
      client.from('products').select('id').eq('seller_id', userId).eq('status', 'sold'),
      client.from('products').select('id').eq('seller_id', userId).eq('status', 'rented'),
      (currentUserId != null && currentUserId != userId)
          ? client.from('followers').select('id').eq('follower_id', currentUserId).eq('following_id', userId).maybeSingle()
          : Future.value(null),
    ]);

    final [
    userRes as Map<String, dynamic>?,
    profileRes as Map<String, dynamic>?,
    addressRes as Map<String, dynamic>?,
    verificationRes as Map<String, dynamic>?,
    bankRes as Map<String, dynamic>?,
    followersRes as List<dynamic>,
    followingRes as List<dynamic>,
    productsRes as List<dynamic>,
    soldRes as List<dynamic>,
    rentedRes as List<dynamic>,
    followRes,
    ] = results;

    final String formattedAddress = addressRes != null
        ? "${addressRes['address_line']}, ${addressRes['city']}"
        : "No default address configured";

    return ProfileModel(
      userId: userId,
      username: userRes?['username'] ?? '',
      email: userRes?['email'] ?? '',
      phoneNo: userRes?['phone_no'] ?? '',
      name: profileRes?['name'] ?? '',
      bio: profileRes?['bio'] ?? '',
      profilePic: profileRes?['profile_pic'],
      socialMediaHandle: profileRes?['social_media_handle'] ?? 'Not added',
      defaultAddress: formattedAddress,
      govtIdType: verificationRes?['govt_id_type'] ?? 'Not uploaded',
      isFaceVerified: verificationRes?['is_face_verified'] ?? false,
      bankName: bankRes?['user_bank_name'] ?? 'Not linked',
      followers: followersRes.length,
      following: followingRes.length,
      activeListings: productsRes.length,
      soldListings: soldRes.length,
      rentedListings: rentedRes.length,
      isFollowing: followRes != null,
    );
  }

  Future<void> uploadProfilePicture({
    required String userId,
    required Uint8List imageBytes,
  }) async {
    try {
      print("STEP 1");

      final path = '$userId/profile.jpg';

      print("STEP 2");
      print("AUTH ID = ${client.auth.currentUser?.id}");

      print("USER ID = $userId");
      print("PATH = $path");

      await client.storage
          .from('profile-pictures')
          .uploadBinary(
        path,
        imageBytes,
        fileOptions: const FileOptions(
          upsert: true,
        ),
      );

      print("STEP 3");

      final imageUrl = client.storage
          .from('profile-pictures')
          .getPublicUrl(path);

      print("URL = $imageUrl");

      await client
          .from('user_profile')
          .update({
        'profile_pic': imageUrl,
      })
          .eq('user_id', userId);

      print("STEP 4");
    } catch (e, st) {
      print("ERROR = $e");
      print(st);
    }
  }

  Future<void> updateProfileField({
    required String userId,
    required String table,
    required String column,
    required dynamic value,
  }) async {
    try {
      print("🚀 Attempting DB Update -> Table: $table, Column: $column, Value: $value");

      if (table == 'user_address' && value is Map<String, dynamic>) {
        if (value['is_default'] == true) {
          await client
              .from('user_address')
              .update({'is_default': false})
              .eq('user_id', userId);
        }

        final existingAddress = await client
            .from('user_address')
            .select('id')
            .eq('user_id', userId)
            .eq('address_type', value['address_type'])
            .maybeSingle();

        if (existingAddress != null) {
          await client
              .from('user_address')
              .update(value)
              .eq('id', existingAddress['id']);
        } else {
          await client
              .from('user_address')
              .insert({
            ...value,
            'user_id': userId,
          });
        }
        print("✅ Address table updated successfully.");
        return;
      }

      if (table == 'user_verification') {
        final existingVerification = await client
            .from('user_verification')
            .select('user_id')
            .eq('user_id', userId)
            .maybeSingle();

        if (existingVerification != null) {
          await client
              .from('user_verification')
              .update({column: value})
              .eq('user_id', userId);
        } else {
          await client
              .from('user_verification')
              .insert({
            'user_id': userId,
            column: value,
          });
        }
        print("✅ Verification table updated successfully.");
        return;
      }

      if (table == 'user_profile') {
        final existingProfile = await client
            .from('user_profile')
            .select('user_id')
            .eq('user_id', userId)
            .maybeSingle();

        if (existingProfile != null) {
          await client
              .from('user_profile')
              .update({column: value})
              .eq('user_id', userId);
        } else {
          await client
              .from('user_profile')
              .insert({
            'user_id': userId,
            column: value,
          });
        }
        print("✅ Profile table updated successfully.");
        return;
      }

      await client
          .from(table)
          .update({column: value})
          .eq('user_id', userId);

      print("✅ Base table ($table) updated successfully.");

    } catch (e, stacktrace) {
      print("❌ Error updating profile field: $e");
      print("📋 Stacktrace: $stacktrace");
      rethrow;
    }
  }
}