import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';

class PurchaseTypeSelectorSheet extends StatelessWidget {
  const PurchaseTypeSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padAllM,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Choose option",
            style: AppTextTheme.textTheme.headlineMedium,
          ),

          const SizedBox(height: 16),

          AppButton(
            width: double.infinity,
            text: "Buy",
            onPressed: () {
              Navigator.pop(context, PurchaseType.buy);
            },
          ),

          SizedBox(height: context.scaleH(12)),

          AppButton(
            width: double.infinity,
            text: "Rent",
            variant: ButtonVariant.white,
            onPressed: () {
              Navigator.pop(context, PurchaseType.rent);
            },
          ),
        ],
      ),
    );
  }
}