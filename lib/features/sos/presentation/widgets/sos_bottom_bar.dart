import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_outline_button.dart';

class SosBottomBar extends StatelessWidget {
  const SosBottomBar({
    super.key,
    required this.primaryText,
    required this.onPrimary,
    this.secondaryText,
    this.onSecondary,
  });

  final String primaryText;
  final VoidCallback onPrimary;

  final String? secondaryText;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: context.bodypad,
        child: Row(
          children: [

            if(secondaryText!=null)...[

              Expanded(
                child: AppOutlinedButton(
                  text: secondaryText!,
                  onPressed: onSecondary!,
                ),
              ),

              context.gapWS,
            ],

            Expanded(
              child: AppButton(
                text: primaryText,
                onPressed: onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}