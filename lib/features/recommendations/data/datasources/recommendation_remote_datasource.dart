import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/recommendation_response_model.dart';

class RecommendationRemoteDatasource {
  RecommendationRemoteDatasource();

  static const String baseUrl =
      "YOUR_RENDER_URL";

  Future<RecommendationResponseModel> getRecommendations({
    required String title,
    required String brand,
    required String category,
    required String size,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/recommend"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "title": title,
        "brand": brand,
        "category": category,
        "size": size,
      }),
    );

    if (response.statusCode == 200) {
      return RecommendationResponseModel.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception("Unable to fetch recommendations");
  }
}