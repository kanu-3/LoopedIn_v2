import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padAllS,
      decoration: BoxDecoration(
        border: Border.all(
          color: CoreColors.grey300,
        ),
        borderRadius:
        context.borderRadiusS,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: quantity > 1
                ? () => onChanged(
              quantity - 1,
            )
                : null,
            icon: Icon(
              AssetPaths.remove,
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                quantity.toString(),
              ),
            ),
          ),

          IconButton(
            onPressed: () => onChanged(
              quantity + 1,
            ),
            icon: const Icon(
              AssetPaths.add,
            ),
          ),
        ],
      ),
    );
  }
}