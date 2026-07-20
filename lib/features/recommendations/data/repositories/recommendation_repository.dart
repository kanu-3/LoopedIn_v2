import '../datasources/recommendation_remote_datasource.dart';
import '../models/recommendation_model.dart';

class RecommendationRepository {
  RecommendationRepository({
    required RecommendationRemoteDatasource datasource,
  }) : _datasource = datasource;

  final RecommendationRemoteDatasource _datasource;

  Future<List<RecommendationModel>> recommend({
    required String title,
    required String brand,
    required String category,
    required String size,
  }) async {
    final response = await _datasource.getRecommendations(
      title: title,
      brand: brand,
      category: category,
      size: size,
    );

    return response.recommendations;
  }
}