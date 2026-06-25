import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/features/products/data/datasources/product_remote_datasource.dart';
import 'package:loopedin_v2/features/products/data/models/product_draft_model.dart';

class ProductRepository {
  final ProductRemoteDatasource remote;

  ProductRepository(this.remote);

  Future<void> updateProduct({
    required String productId,
    required ProductDraftModel draft,
  }) {
    return remote.updateProduct(
      productId: productId,
      draft: draft,
    );
  }

  Future<List<ProductModel>> getProductsBySeller(
      String sellerId,
      ) {
    return remote.getProductsBySeller(sellerId);
  }

  Future<Map<String, dynamic>> getSellerDashboardAnalytics() => remote.getSellerDashboardAnalytics();

  Future<List<ProductModel>> getProductsBySubCategory(
      String subCategory,
      String currentUserId,
      ) {
    return remote.getProductsBySubCategory(
      subCategory,
      currentUserId,
    );
  }


  Future<List<ProductModel>> getProducts() =>
      remote.getProducts();

  Future<List<ProductModel>> getMyProducts() =>
      remote.getMyProducts();

  Future<ProductModel> getProductById(String id) =>
      remote.getProductById(id);

  Future<void> createProductFromDraft({
    required ProductDraftModel draft,
  }) =>
      remote.createProduct(draft: draft);

  Future<void> deleteProduct(String productId) =>
      remote.deleteProduct(productId);

  Future<void> updateProductStatus({
    required String productId,
    required String status,
  }) =>
      remote.updateProductStatus(
        productId: productId,
        status: status,
      );
}