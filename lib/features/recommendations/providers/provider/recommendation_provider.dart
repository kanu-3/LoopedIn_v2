import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/features/recommendations/data/datasources/recommendation_remote_datasource.dart';
import 'package:loopedin_v2/features/recommendations/data/repositories/recommendation_repository.dart';
import 'package:loopedin_v2/features/recommendations/providers/provider/recommendation_notifier.dart';
import 'package:loopedin_v2/features/recommendations/providers/states/recommendation_state.dart';

final recommendationDatasourceProvider =
Provider<RecommendationRemoteDatasource>((ref) {
  return RecommendationRemoteDatasource();
});

final recommendationRepositoryProvider =
Provider<RecommendationRepository>((ref) {
  return RecommendationRepository(
    datasource: ref.watch(
      recommendationDatasourceProvider,
    ),
  );
});

final recommendationProvider = StateNotifierProvider<
    RecommendationNotifier,
    RecommendationState>(
      (ref) {
    return RecommendationNotifier(
      ref.watch(
        recommendationRepositoryProvider,
      ),
    );
  },
);