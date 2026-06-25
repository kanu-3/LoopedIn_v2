import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';

class ProfileDetailTile extends StatelessWidget {
  final String label;
  final String value;
  final Widget leadingIcon;
  final VoidCallback onTap;

  const ProfileDetailTile({
    super.key,
    required this.label,
    required this.value,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.whitetext,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85), // Matches your screenshot canvas tint
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  IconTheme(
                    data: IconThemeData(color: AppColors.blacktext, size: 20),
                    child: leadingIcon,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        color: AppColors.blacktext,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    AssetPaths.forward,
                    color: AppColors.blacktext.withOpacity(0.4),
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}