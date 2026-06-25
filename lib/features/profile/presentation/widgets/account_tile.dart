import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    super.key,
    required this.title,
    required this.leading,
    this.trailing,
    required this.onTap,
  });

  final String title;
  final Widget leading;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: context.borderRadiusS,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacingS,
          vertical: context.spacingS,
        ),
        child: Row(
          children: [
            leading,
            SizedBox(width: context.spacingS),

            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),

            trailing ??
                 Icon(AssetPaths.forward),
          ],
        ),
      ),
    );
  }
}