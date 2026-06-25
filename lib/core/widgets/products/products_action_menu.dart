import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductActionsMenu extends StatelessWidget {
  const ProductActionsMenu({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.onMarkSold,
    required this.onMarkRented,
    required this.onHide,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onMarkSold;
  final VoidCallback onMarkRented;
  final VoidCallback onHide;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit();
            break;

          case 'sold':
            onMarkSold();
            break;

          case 'rented':
            onMarkRented();
            break;

          case 'hidden':
            onHide();
            break;

          case 'delete':
            onDelete();
            break;
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit Product'),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 'sold',
          child: Text('Mark as Sold'),
        ),
        PopupMenuItem(
          value: 'rented',
          child: Text('Mark as Rented'),
        ),
        PopupMenuItem(
          value: 'hidden',
          child: Text('Hide Product'),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete Product'),
        ),
      ],
    );
  }
}