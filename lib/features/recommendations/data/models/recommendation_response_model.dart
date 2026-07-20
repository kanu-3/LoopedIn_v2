import 'recommendation_model.dart';

class RecommendationResponseModel {
  final List<RecommendationModel> recommendations;

  const RecommendationResponseModel({
    required this.recommendations,
  });

  factory RecommendationResponseModel.fromJson(
      Map<String, dynamic> json) {
    return RecommendationResponseModel(
      recommendations: (json['recommendations'] as List)
          .map(
            (e) => RecommendationModel.fromJson(e),
          )
          .toList(),
    );
  }
}