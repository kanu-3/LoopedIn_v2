import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:loopedin_v2/features/profile/data/repositories/profile_repository.dart';
import 'package:loopedin_v2/features/profile/providers/notifiers/profile_notifier.dart';
import 'package:loopedin_v2/features/profile/providers/states/profile_state.dart';

final profileProvider =
StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final client = SupabaseService.client;

  return ProfileNotifier(
    ProfileRepository(
      ProfileRemoteDataSource(client),
    ),
  );
});
