import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/products/product_card.dart';
import 'package:loopedin_v2/features/products/providers/providers/product_provider.dart';

class SubCategoryProductsScreen
    extends ConsumerStatefulWidget {

  const SubCategoryProductsScreen({
    super.key,
    required this.subCategory,
  });

  final String subCategory;

  @override
  ConsumerState<
      SubCategoryProductsScreen>
  createState() =>
      _SubCategoryProductsScreenState();
}

class _SubCategoryProductsScreenState
    extends ConsumerState<
        SubCategoryProductsScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(
        productProvider.notifier,
      )
          .fetchSubCategoryProducts(
        widget.subCategory,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final state =
    ref.watch(productProvider);

    return Scaffold(
      appBar: AppHeader(
        title:
        widget.subCategory,
      ),

      body: state.isLoadingSubCategoryProducts
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : state.subCategoryProducts.isEmpty
          ? const AppEmptyWidget(
        title: "No products found",
        subtitle: "There are no items in this category right now.",
        icon: AssetPaths.empty,
      )
          : GridView.builder(
        padding: context.bodypad,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: context.spacingS,
          mainAxisSpacing: context.spacingS,
          childAspectRatio: .68,
        ),
        itemCount: state.subCategoryProducts.length,
        itemBuilder: (context, index) {
          final product = state.subCategoryProducts[index];

          return ProductCard(
            product: product,
            onTap: () {
              context.push(
                RoutePaths.productDetails,
                extra: {"product": product},
              );
            },
          );
        },
      ),
    );
  }
}