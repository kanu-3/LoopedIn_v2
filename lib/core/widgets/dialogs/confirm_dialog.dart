import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';

class ConfirmDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String cancelText = 'Cancel',
    String confirmText = 'Confirm',
    Color? confirmColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                confirmText,
                style: TextStyle(
                  color: confirmColor ?? AppColors.onError,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}