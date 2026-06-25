import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class ProductTypeSelector extends StatelessWidget {
  const ProductTypeSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final product_availability value;
  final ValueChanged<product_availability> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildChip(
            context,
            title: "Sell",
            selected:
            value == product_availability.sell,
            onTap: () {
              onChanged(
                product_availability.sell,
              );
            },
          ),
        ),

        context.gapWS,

        Expanded(
          child: _buildChip(
            context,
            title: "Rent",
            selected:
            value == product_availability.rent,
            onTap: () {
              onChanged(
                product_availability.rent,
              );
            },
          ),
        ),

        context.gapWS,

        Expanded(
          child: _buildChip(
            context,
            title: "Both",
            selected:
            value == product_availability.both,
            onTap: () {
              onChanged(
                product_availability.both,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChip(
      BuildContext context, {
        required String title,
        required bool selected,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: context.borderRadiusS,
      child: Container(
        height: context.buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.main
              : AppColors.whitetext,
          borderRadius:
          context.borderRadiusS,
          border: Border.all(
            color: AppColors.main,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? AppColors.whitetext
                : AppColors.main,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}