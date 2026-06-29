import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageInput({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: context.bodypad,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Start typing...',
                  border: OutlineInputBorder(),
                    focusColor: AppColors.main,
                ),
              ),
            ),
            SizedBox(width: context.scaleH(12)),
            IconButton(
              onPressed: onSend,
              icon: Icon(AssetPaths.send),color: AppColors.main,
            )
          ],
        ),
      ),
    );
  }
}