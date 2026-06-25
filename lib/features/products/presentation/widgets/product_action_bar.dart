import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';

class ProductActionBar extends StatelessWidget {
  final ProductModel product;
  final ProductActionBarMode mode;

  final VoidCallback onAddToCart;
  final VoidCallback onOffer;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductActionBar({
    super.key,
    required this.product,
    required this.mode,
    required this.onAddToCart,
    required this.onOffer,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: context.padAllM,
        decoration: const BoxDecoration(
          color: AppColors.whitetext,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            if (mode == ProductActionBarMode.visitor) ...[
              Expanded(
                child: AppButton(
                  text: "Add to Cart",
                  onPressed: onAddToCart,
                ),
              ),
              SizedBox(width: context.scaleW(20)),
              Expanded(
                child: AppButton(
                  text: "Make Offer",
                  variant: ButtonVariant.white,
                  onPressed: onOffer,
                ),
              ),
            ] else ...[
              Expanded(
                child: AppButton(
                  text: "Edit",
                  onPressed: onEdit,
                ),
              ),
              SizedBox(width: context.scaleW(20)),
              Expanded(
                child: AppButton(
                  text: "Delete",
                  variant: ButtonVariant.white,
                  onPressed: onDelete,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}