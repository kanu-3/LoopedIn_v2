import 'package:loopedin_v2/core/models/profile_model.dart';

class ProfileState {
  final bool isLoading;
  final ProfileModel? profile;
  final String? error;

  const ProfileState({
    required this.isLoading,
    required this.profile,
    required this.error,
  });

  factory ProfileState.initial() => const ProfileState(
    isLoading: false,
    profile: null,
    error: null,
  );

  ProfileState copyWith({
    bool? isLoading,
    ProfileModel? profile,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      error: error,
    );
  }
}