import 'package:loopedin_v2/core/models/profile_model.dart';

class SellerProfileState {
  final bool isLoading;
  final ProfileModel? profile;

  const SellerProfileState({
    required this.isLoading,
    required this.profile,
  });

  factory SellerProfileState.initial() {
    return const SellerProfileState(
      isLoading: false,
      profile: null,
    );
  }

  SellerProfileState copyWith({
    bool? isLoading,
    ProfileModel? profile,
  }) {
    return SellerProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
    );
  }
}