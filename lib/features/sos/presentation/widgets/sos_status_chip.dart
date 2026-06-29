import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';

class SosStatusChip extends StatelessWidget {
  const SosStatusChip({
    super.key,
    required this.status,
  });

  final SosStatus status;

  @override
  Widget build(BuildContext context) {

    Color color;

    switch(status){

      case SosStatus.open:
        color = CoreColors.accepted;
        break;

      case SosStatus.closed:
        color = CoreColors.rejected;
        break;

      case SosStatus.expired:
        color = CoreColors.pending;
        break;
    }

    return Chip(
      label: Text(
        status.name.toUpperCase(),
      ),
      backgroundColor: color.withOpacity(.12),
      labelStyle: TextStyle(
        color: color,
      ),
    );
  }
}