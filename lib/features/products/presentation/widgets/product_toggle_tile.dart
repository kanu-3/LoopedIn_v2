import 'package:flutter/material.dart';

class ProductToggleTile
    extends StatelessWidget {
  const ProductToggleTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      title: Text(title),
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}