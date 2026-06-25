import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';

class OwnerActionsSection
    extends StatelessWidget {

  const OwnerActionsSection({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        AppButton(
          text: "Edit Product",
          onPressed: () {
            context.push(
              RoutePaths.editProduct,
              extra: product,
            );
          },
        ),

        context.gapS,

        AppButton(
          text: "Mark Sold",
          onPressed: () {},
        ),

        context.gapS,

        AppButton(
          text: "Mark Rented",
          onPressed: () {},
        ),

        context.gapS,

        AppButton(
          text: "Delete Product",
          onPressed: () {},
        ),
      ],
    );
  }
}