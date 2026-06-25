import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/common/app_image_carousel.dart';
import 'package:loopedin_v2/core/widgets/dialogs/app_success_dialog.dart';
import 'package:loopedin_v2/features/products/data/models/product_draft_model.dart';
import 'package:loopedin_v2/features/products/providers/providers/add_product_provider.dart';
import 'package:loopedin_v2/features/products/providers/providers/product_provider.dart';

class ProductPreviewScreen extends ConsumerStatefulWidget {
  final ProductDraftModel draft;

  const ProductPreviewScreen({
    super.key,
    required this.draft,
  });

  @override
  ConsumerState<ProductPreviewScreen> createState() =>
      _ProductPreviewScreenState();
}

class _ProductPreviewScreenState
    extends ConsumerState<ProductPreviewScreen> {

  Future<void> _upload() async {
    final isCreating =
        ref.read(productProvider).isCreating;

    if (isCreating) return;

    try {
      final success = await ref
          .read(productProvider.notifier)
          .createProductFromDraft(
        draft: widget.draft,
      );

      if (!mounted) return;

      if (!success) {
        AppSnackBar.show(
          context,
          message: "Failed to upload product",
          isError: true,
        );
        return;
      }

      ref
          .read(addProductProvider.notifier)
          .reset();

      await showDialog(
        context: context,
        builder: (_) {
          return AppSuccessDialog(
            title: "Successful",
            subtitle:
            "Your product is now live on LoopedIn",
            primaryText: "View My Products",
            secondaryText: "Continue Browsing",
            onPrimaryTap: () {
              Navigator.pop(context);
            },
            onSecondaryTap: () {
              debugPrint("Tapped");
              context.go(RoutePaths.home);
            },
          );
        },
      );

      if (!mounted) return;

      context.go('/my-products');
    } catch (e) {
      AppSnackBar.show(
        context,
        message: e.toString(),
        isError: true,
      );
    }
  }


  Widget _info(
      String label,
      String value,
      ) {

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final d = widget.draft;
    final isCreating =
        ref.watch(productProvider).isCreating;

    return Scaffold(

      appBar: const AppHeader(
        title: "Preview Product",
      ),

      body: SingleChildScrollView(
        padding: context.bodypad,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            AppImageCarousel(
              images: d.images,
              height: context.scaleH(440),
            ),

            context.gapL,

            _info(
              "Title",
              d.title,
            ),

            if (d.price != null)
              _info(
                "Sell Price",
                "₹${d.price}",
              ),

            if (d.rentPricePerDay != null)
              _info(
                "Rent Price",
                "₹${d.rentPricePerDay}/day",
              ),

            _info(
              "Availability",
              d.availability.name,
            ),

            _info(
              "Sub Category",
              d.subCategory,
            ),

            _info(
              "Size",
              d.size,
            ),

            _info(
              "Condition",
              d.productCondition ?? "-",
            ),

            _info(
              "Brand",
              d.brand ?? "-",
            ),

            _info(
              "Style",
              d.style ?? "-",
            ),

            _info(
              "Pattern",
              d.pattern ?? "-",
            ),

            _info(
              "Color",
              d.color ?? "-",
            ),

            _info(
              "Fabric",
              d.fabric ?? "-",
            ),

            _info(
              "Quantity",
              d.quantity.toString(),
            ),

            _info(
              "Description",
              d.description ?? "-",
            ),

            _info(
              "Express Delivery",
              d.expressDelivery
                  ? "Yes"
                  : "No",
            ),

            _info(
              "Alteration",
              d.alteration
                  ? "Yes"
                  : "No",
            ),

            _info(
              "Dry Clean",
              d.dryClean
                  ? "Yes"
                  : "No",
            ),

            _info(
              "Direct Contact",
              d.directContact
                  ? "Yes"
                  : "No",
            ),

            context.gapL,

            AppButton(
              width: double.infinity,
              text: "Confirm Upload",
              isLoading: isCreating,
              onPressed:
              isCreating
                  ? null
                  : _upload,
            ),

            context.gapL,
          ],
        ),
      ),
    );
  }
}