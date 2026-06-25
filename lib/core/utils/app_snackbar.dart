import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        bool isError = false,
        Duration duration = const Duration(seconds: 3),
      }) {
    final color = isError ? AppColors.onError : AppColors.sucess;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: AppColors.blacktext,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}