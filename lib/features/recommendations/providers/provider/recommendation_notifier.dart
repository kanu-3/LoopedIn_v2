import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/features/recommendations/data/repositories/recommendation_repository.dart';
import 'package:loopedin_v2/features/recommendations/providers/states/recommendation_state.dart';

class RecommendationNotifier
    extends StateNotifier<RecommendationState> {
  RecommendationNotifier(this._repository)
      : super(RecommendationState.initial());

  final RecommendationRepository _repository;

  Future<void> recommend({
    required String title,
    required String brand,
    required String category,
    required String size,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final products = await _repository.recommend(
        title: title,
        brand: brand,
        category: category,
        size: size,
      );

      state = state.copyWith(
        isLoading: false,
        recommendations: products,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clear() {
    state = RecommendationState.initial();
  }
}