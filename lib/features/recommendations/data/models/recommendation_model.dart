class RecommendationModel {
  final String title;
  final String brand;
  final String category;
  final double currentPrice;
  final double rating;
  final String imageUrl;

  const RecommendationModel({
    required this.title,
    required this.brand,
    required this.category,
    required this.currentPrice,
    required this.rating,
    required this.imageUrl,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      currentPrice: (json['current_price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'brand': brand,
      'category': category,
      'current_price': currentPrice,
      'rating': rating,
      'image_url': imageUrl,
    };
  }
}