import 'package:loopedin_v2/features/recommendations/data/models/recommendation_model.dart';

class RecommendationState {
  final bool isLoading;
  final String? error;
  final List<RecommendationModel> recommendations;

  const RecommendationState({
    this.isLoading = false,
    this.error,
    this.recommendations = const [],
  });

  RecommendationState copyWith({
    bool? isLoading,
    String? error,
    List<RecommendationModel>? recommendations,
  }) {
    return RecommendationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      recommendations: recommendations ?? this.recommendations,
    );
  }

  factory RecommendationState.initial() {
    return const RecommendationState();
  }
}