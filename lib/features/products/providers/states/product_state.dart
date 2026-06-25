import 'package:loopedin_v2/core/models/product_model.dart';

class ProductState {
  final bool isLoadingFeed;
  final bool isLoadingMyProducts;
  final bool isCreating;
  final bool isLoadingSubCategoryProducts;
  final bool isLoadingAnalytics;
  final List<ProductModel> subCategoryProducts;
  final List<ProductModel> products;
  final List<ProductModel> myProducts;
  final int wishlistCount;
  final Map<String, int> weeklyChartData;
  final List<ProductModel> sellerProducts;
  final bool isLoadingSellerProducts;

  const ProductState({
    required this.isLoadingFeed,
    required this.isLoadingMyProducts,
    required this.isCreating,
    required this.products,
    required this.myProducts,
    required this.isLoadingSubCategoryProducts,
    required this.subCategoryProducts,
    required this.isLoadingAnalytics,
    required this.wishlistCount,
    required this.weeklyChartData,
    required this.sellerProducts,
    required this.isLoadingSellerProducts,

  });

  factory ProductState.initial() {
    return const ProductState(
      isLoadingFeed: false,
      isLoadingMyProducts: false,
      isCreating: false,

      products: [],
      myProducts: [],

      isLoadingSubCategoryProducts: false,
      subCategoryProducts: [],

      isLoadingAnalytics: false,

      wishlistCount: 0,

      weeklyChartData: {
        'SUN': 0,
        'MON': 0,
        'TUES': 0,
        'WED': 0,
        'THUR': 0,
        'FRI': 0,
        'SAT': 0,
      },

      sellerProducts: [],
      isLoadingSellerProducts: false,
    );
  }

  ProductState copyWith({
    bool? isLoadingFeed,
    bool? isLoadingMyProducts,
    bool? isCreating,
    bool? isLoadingSubCategoryProducts,
    bool? isLoadingAnalytics,

    List<ProductModel>? products,
    List<ProductModel>? myProducts,
    List<ProductModel>? subCategoryProducts,

    int? wishlistCount,
    Map<String, int>? weeklyChartData,

    List<ProductModel>? sellerProducts,
    bool? isLoadingSellerProducts,
  }) {
    return ProductState(
      isLoadingFeed: isLoadingFeed ?? this.isLoadingFeed,
      isLoadingMyProducts:
      isLoadingMyProducts ?? this.isLoadingMyProducts,
      isCreating: isCreating ?? this.isCreating,
      isLoadingSubCategoryProducts:
      isLoadingSubCategoryProducts ??
          this.isLoadingSubCategoryProducts,
      isLoadingAnalytics:
      isLoadingAnalytics ?? this.isLoadingAnalytics,

      products: products ?? this.products,
      myProducts: myProducts ?? this.myProducts,

      subCategoryProducts:
      subCategoryProducts ??
          this.subCategoryProducts,

      wishlistCount:
      wishlistCount ?? this.wishlistCount,

      weeklyChartData:
      weeklyChartData ?? this.weeklyChartData,

      sellerProducts:
      sellerProducts ?? this.sellerProducts,

      isLoadingSellerProducts:
      isLoadingSellerProducts ??
          this.isLoadingSellerProducts,
    );
  }
}