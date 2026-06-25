import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/dialogs/confirm_dialog.dart';
import 'package:loopedin_v2/features/products/presentation/screens/add_product_screen.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/my_product_tile.dart';
import 'package:loopedin_v2/features/products/providers/providers/product_provider.dart';

class MyProductsScreen extends ConsumerStatefulWidget {
  const MyProductsScreen({super.key});

  @override
  ConsumerState<MyProductsScreen> createState() =>
      _MyProductsScreenState();
}

class _MyProductsScreenState
    extends ConsumerState<MyProductsScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(productProvider.notifier).fetchMyProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);

    return Scaffold(
      appBar: const AppHeader(
        title: 'My Products',
      ),

      body: state.isLoadingMyProducts
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : state.myProducts.isEmpty
          ? const AppEmptyWidget(
        title: 'No Products Yet',
        subtitle: 'Start listing products to see them here.',
      )
          : ListView.separated(
        padding: context.bodypad,
        itemCount: state.myProducts.length,
        separatorBuilder: (_, __) => context.gapM,
        itemBuilder: (context, index) {
          final product = state.myProducts[index];

          return MyProductTile(
            product: product,

            onTap: () {},

            onEdit: () {
              context.push(
                '/edit-product',
                extra: product,
              );
            },

            onDelete: () async {
              final confirm =
              await ConfirmDialog.show(
                context: context,
                title: 'Delete Product',
                message:
                'Are you sure you want to delete this product?',
                confirmText: 'Delete',
                confirmColor: AppColors.onError,
              );

              if (confirm != true) return;

              await ref
                  .read(productProvider.notifier)
                  .deleteProduct(product.id);
            },

            onMarkSold: () async {
              await ref
                  .read(productProvider.notifier)
                  .updateProductStatus(
                productId: product.id,
                status:
                product_status.sold.name,
              );
            },

            onMarkRented: () async {
              await ref
                  .read(productProvider.notifier)
                  .updateProductStatus(
                productId: product.id,
                status:
                product_status.rented.name,
              );
            },

            onHide: () async {
              await ref
                  .read(productProvider.notifier)
                  .updateProductStatus(
                productId: product.id,
                status:
                product_status.inactive.name,
              );
            },
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: context.spacingL,
          right: context.spacingL,
          bottom: context.spacingL * 2,
          top: context.spacingM,
        ),
        child: AppButton(
          width: double.infinity,
          text: 'Add Product',
          onPressed: () {
            context.push('/add-product');
          },
        ),
      ),
    );
  }
}