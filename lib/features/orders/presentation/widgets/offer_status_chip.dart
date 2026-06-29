import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';

class OfferStatusChip extends StatelessWidget {
  final OfferStatus status;

  const OfferStatusChip({super.key, required this.status});

  Color get color {
    switch (status) {
      case OfferStatus.pending:
        return CoreColors.pending;
      case OfferStatus.accepted:
        return CoreColors.accepted;
      case OfferStatus.rejected:
        return CoreColors.rejected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }
}