import 'package:loopedin_v2/core/models/product_model.dart';

class HomeFeedModel {
  final ProductModel product;

  final String sellerName;
  final String sellerUsername;
  final String? sellerProfilePic;
  final String sellerId;

  final int likesCount;
  final int commentsCount;

  final bool isLiked;

  const HomeFeedModel({
    required this.product,
    required this.sellerName,
    required this.sellerUsername,
    required this.sellerProfilePic,
    required this.sellerId,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
  });

  HomeFeedModel copyWith({
    ProductModel? product,
    String? sellerName,
    String? sellerUsername,
    String? sellerProfilePic,
    String? sellerId,
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
  }) {
    return HomeFeedModel(
      product: product ?? this.product,
      sellerName: sellerName ?? this.sellerName,
      sellerUsername: sellerUsername ?? this.sellerUsername,
      sellerProfilePic: sellerProfilePic ?? this.sellerProfilePic,
      sellerId: sellerId ?? this.sellerId,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}