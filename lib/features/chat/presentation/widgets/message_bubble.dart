import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final DateTime time;

  const MessageBubble({
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.spacingXS,
        right: context.spacingXS
      ),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin:  EdgeInsets.symmetric(horizontal: context.scale(8), vertical: context.scale(8)),
          padding:  EdgeInsets.symmetric(horizontal: context.scale(12), vertical: context.scale(12)),
          decoration: BoxDecoration(
            color: isMe ? CoreColors.four : CoreColors.grey400,
            borderRadius: BorderRadius.circular(context.scale(12)),
          ),
          child: Column(
            crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(message),
              SizedBox(height: context.scaleH(8)),
              Text(
                '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}