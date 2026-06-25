import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/products/data/models/product_draft_model.dart';
import 'package:loopedin_v2/features/products/data/repositories/product_repository.dart';
import 'package:loopedin_v2/features/products/providers/states/product_state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductRepository repository;

  ProductNotifier(this.repository) : super(ProductState.initial()) {
    fetchProducts();
    fetchMyProducts();
  }

  Future<void> fetchProductsBySeller(
      String sellerId,
      ) async {
    state = state.copyWith(
      isLoadingSellerProducts: true,
    );

    try {
      final products =
      await repository.getProductsBySeller(
        sellerId,
      );

      state = state.copyWith(
        sellerProducts: products,
        isLoadingSellerProducts: false,
      );
    } catch (_) {
      state = state.copyWith(
        isLoadingSellerProducts: false,
      );
    }
  }

  Future<void> fetchDashboardAnalytics() async {
    state = state.copyWith(isLoadingAnalytics: true);
    try {
      final data = await repository.getSellerDashboardAnalytics();
      state = state.copyWith(
        isLoadingAnalytics: false,
        wishlistCount: data['wishlistCount'],
        weeklyChartData: Map<String, int>.from(data['weeklyChartData']),
      );
    } catch (_) {
      state = state.copyWith(isLoadingAnalytics: false);
    }
  }

  Future<void> fetchMyProductsOnly() async {
    state = state.copyWith(isLoadingMyProducts: true);

    try {
      final products = await repository.getMyProducts();

      state = state.copyWith(
        isLoadingMyProducts: false,
        myProducts: products,
      );
    } catch (_) {
      state = state.copyWith(isLoadingMyProducts: false);
    }
  }

  Future<void> fetchProducts() async {
    state = state.copyWith(isLoadingFeed: true);

    try {
      final products = await repository.getProducts();

      state = state.copyWith(
        isLoadingFeed: false,
        products: products,
      );
    } catch (_) {
      state = state.copyWith(isLoadingFeed: false);
    }
  }

  Future<void> fetchMyProducts() async {
    state = state.copyWith(isLoadingMyProducts: true);

    try {
      final products = await repository.getMyProducts();

      state = state.copyWith(
        isLoadingMyProducts: false,
        myProducts: products,
      );
    } catch (_) {
      state = state.copyWith(isLoadingMyProducts: false);
    }
  }

  Future<bool> createProductFromDraft({
    required ProductDraftModel draft,
  }) async {
    state = state.copyWith(isCreating: true);

    try {
      await repository.createProductFromDraft(draft: draft);

      await fetchMyProducts();

      state = state.copyWith(isCreating: false);
      return true;
    } catch (e, st) {
      debugPrint("CREATE PRODUCT FAILED: $e");
      debugPrint("STACK TRACE: $st");

      state = state.copyWith(isCreating: false);
      return false;
    }
  }

  Future<void> fetchSubCategoryProducts(String subCategory) async {
    state = state.copyWith(
      isLoadingSubCategoryProducts: true,
      subCategoryProducts: [],
    );

    try {
      final userId = SupabaseService.client.auth.currentUser!.id;

      final products =
      await repository.getProductsBySubCategory(
        subCategory,
        userId,
      );

      state = state.copyWith(
        isLoadingSubCategoryProducts: false,
        subCategoryProducts: products,
      );
    } catch (_) {
      state = state.copyWith(
        isLoadingSubCategoryProducts: false,
        subCategoryProducts: [],
      );
    }
  }


  Future<void> updateProductStatus({
    required String productId,
    required String status,
  }) async {
    try {
      await repository.updateProductStatus(
        productId: productId,
        status: status,
      );

      await fetchMyProducts();
    } catch (e, st) {
      debugPrint(
        'UPDATE PRODUCT STATUS FAILED: $e',
      );

      debugPrint(
        'STACK TRACE: $st',
      );
    }
  }

  Future<void> updateProduct({
    required String productId,
    required ProductDraftModel draft,
  }) async {
    try {
      await repository.updateProduct(
        productId: productId,
        draft: draft,
      );

      await fetchMyProducts();
    } catch (e) {
      debugPrint(
        'UPDATE PRODUCT FAILED: $e',
      );
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await repository.deleteProduct(productId);

      await fetchMyProducts();
    } catch (e, st) {
      debugPrint("DELETE PRODUCT FAILED: $e");
      debugPrint("STACK TRACE: $st");
    }
  }
}