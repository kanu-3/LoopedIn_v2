import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class SubCategoryCard extends StatelessWidget {
  const SubCategoryCard({
    super.key,
    required this.subCategoryName,
    required this.assetImage,
    required this.onTap,
  });

  final String subCategoryName;
  final String assetImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: context.borderRadiusM,
      onTap: onTap,
      child: ClipRRect(
        borderRadius: context.borderRadiusM,
        child: SizedBox(
          height: context.scaleH(260),
          child: Stack(
            children: [

              Positioned.fill(
                child: Image.asset(
                  assetImage,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}