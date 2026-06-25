import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: controller,
      onChanged: onChanged,

      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.bg,
        focusColor: AppColors.blacktext,
        hintText: "Search users",

        prefixIcon: const Icon(
          AssetPaths.search,
        ),

        suffixIcon: Icon(
            AssetPaths.more
        ),

        border: OutlineInputBorder(
          borderRadius: context.borderRadiusM,
        ),
      ),
    );
  }
}