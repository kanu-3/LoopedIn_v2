import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/features/profile/presentation/widgets/address_edit_overlay.dart';

class AddressSection extends StatelessWidget {
  final String userId;
  final String defaultAddress;

  final Future<bool> Function({
  required String table,
  required String column,
  required dynamic value,
  }) onSave;

  const AddressSection({
    super.key,
    required this.userId,
    required this.defaultAddress,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacingM),
      decoration: BoxDecoration(
        borderRadius: context.borderRadiusM,
        color: AppColors.whitetext,
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black12,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Address",
                style: AppTextTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  AddressEditOverlay.show(
                    context,
                    userId: userId,
                    onSave: onSave,
                  );
                },
                child: const Text("Change"),
              )
            ],
          ),

          context.gapS,

          if (defaultAddress.isEmpty)
            const Text(
              "No address added",
              style: TextStyle(
                color: CoreColors.grey400,
                fontWeight: FontWeight.w500,
              ),
            )
          else
            Text(
              defaultAddress,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
        ],
      ),
    );
  }
}