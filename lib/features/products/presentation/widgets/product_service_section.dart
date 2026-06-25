import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';

class ProductServicesSection extends StatelessWidget {
  const ProductServicesSection({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final services = <String>[];

    if (product.expressDelivery) {
      services.add("Express Delivery");
    }

    if (product.alteration) {
      services.add("Alteration");
    }

    if (product.dryClean) {
      services.add("Dry Clean");
    }

    if (product.directContact) {
      services.add("Direct Contact");
    }

    if (services.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: context.spacingS,
      runSpacing: context.spacingS,
      children: services.map((service) {
        return Chip(
          label: Text(service),
        );
      }).toList(),
    );
  }
}