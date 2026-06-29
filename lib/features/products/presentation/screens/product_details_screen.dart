import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/common/network_image_carousel.dart';
import 'package:loopedin_v2/core/widgets/dialogs/confirm_dialog.dart';
import 'package:loopedin_v2/features/chat/providers/provider/chat_provider.dart';
import 'package:loopedin_v2/features/home/providers/home_providers.dart';
import 'package:loopedin_v2/features/orders/presentation/widgets/offer_bottom_sheet.dart';
import 'package:loopedin_v2/features/orders/providers/notifiers/cart_notifier.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/product_action_bar.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/product_attribute_grid.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/product_description_section.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/products_price_section.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/purchase_type_selector_sheet.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/seller_card.dart';
import 'package:loopedin_v2/features/products/providers/providers/product_provider.dart';
import 'package:loopedin_v2/features/profile/providers/provider/profile_provider.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  bool get isOwner {
    final currentUser = SupabaseService.client.auth.currentUser;
    return currentUser?.id == widget.product.sellerId;
  }

  Future<void> _handleAddToCart(ProductModel product) async {
    final availability = product.availability;

    final hasBuy = availability == product_availability.sell ||
        availability == product_availability.both;

    final hasRent = availability == product_availability.rent ||
        availability == product_availability.both;

    PurchaseType? selectedType;

    if (hasBuy && hasRent) {
      selectedType = await showModalBottomSheet<PurchaseType>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) => const PurchaseTypeSelectorSheet(),
      );

      if (selectedType == null) return;
    } else {
      selectedType = hasBuy ? PurchaseType.buy : PurchaseType.rent;
    }

    ref.read(cartProvider.notifier).addToCart(product, selectedType, context);

    if (mounted) {
      AppSnackBar.show(
        context,
        message: "${product.title} added to cart (${selectedType.name.toUpperCase()})",
        isError: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppHeader(
        title: widget.product.title,
        showBackButton: true,
        showCloseButton: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      NetworkImageCarousel(
                        imageUrls: widget.product.images,
                        height: context.scaleH(520),
                      ),
                      Positioned(
                        top: context.spacingM,
                        right: context.spacingM,
                        child: Row(
                          children: [
                            if (isOwner)
                              PopupMenuButton<String>(
                                itemBuilder: (_) => const [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                                onSelected: (value) async {
                                  if (value == 'edit') {
                                    context.push(
                                      RoutePaths.editProduct,
                                      extra: widget.product,
                                    );
                                  }

                                  if (value == 'delete') {
                                    await ref
                                        .read(productProvider.notifier)
                                        .deleteProduct(widget.product.id);

                                    if (mounted) {
                                      context.pop();
                                    }
                                  }
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ProductPriceSection(
                    product: widget.product,
                    onChat: () async {
                      final repo = ref.read(chatRepositoryProvider);

                      final currentUserId =
                          SupabaseService.client.auth.currentUser!.id;

                      final roomId = await repo.getOrCreateRoom(
                        currentUserId,
                        widget.product.sellerId,
                      );

                      if (!context.mounted) return;

                      context.push(
                        '/chat/$roomId',
                        extra: {
                          'otherUser': await ref
                              .read(profileProvider.notifier)
                              .getProfile(widget.product.sellerId),
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductAttributeGrid(
                          product: widget.product,
                        ),
                        ProductDescriptionSection(
                          description: widget.product.description,
                        ),
                        SellerCard(
                          sellerId: widget.product.sellerId,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ProductActionBar(
            product: widget.product,
            mode: isOwner
                ? ProductActionBarMode.owner
                : ProductActionBarMode.visitor,

            onAddToCart: () => _handleAddToCart(widget.product),
            onOffer: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => OfferBottomSheet(
                  originalPrice: widget.product.basePrice,
                  prodId: widget.product.id,
                  sellerId: widget.product.sellerId,
                ),
              );
            },

            onEdit: () {
              context.push(
                RoutePaths.editProduct,
                extra: widget.product,
              );
            },

            onDelete: () async {
              final confirmed = await ConfirmDialog.show(
                context: context,
                title: "Delete Product",
                message: "This action cannot be undone. Do you want to continue?",
                confirmText: "Delete",
                confirmColor: AppColors.onError,
              );

              if (confirmed != true) return;

              await ref
                  .read(productProvider.notifier)
                  .deleteProduct(widget.product.id);

              if (mounted) {
                context.pop();
              }
            },
          )
        ],
      ),
    );
  }
}