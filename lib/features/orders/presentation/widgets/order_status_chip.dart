import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';

class OrderStatusChip extends StatelessWidget {
  final order_status status;

  const OrderStatusChip({
    super.key,
    required this.status,
  });

  Color _color() {
    switch (status) {
      case order_status.pending:
        return CoreColors.pending;
      case order_status.shipped:
        return CoreColors.main;
      case order_status.completed:
        return CoreColors.accepted;
      case order_status.cancelled:
        return CoreColors.rejected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: _color().withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: _color(),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}