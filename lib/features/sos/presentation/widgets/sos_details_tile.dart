import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';

class SosDetailTile extends StatelessWidget {
  const SosDetailTile({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [

          SizedBox(
            width: 90,
            child: Text(
              title + " :",
              style: AppTextTheme.textTheme.headlineSmall,
            ),
          ),

          Expanded(
            child: Text(
              value.isEmpty ? "-" : value,
              style: AppTextTheme.textTheme.bodyMedium,
            ),
          ),
        ],
      );
  }
}