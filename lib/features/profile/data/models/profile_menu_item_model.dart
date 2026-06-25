import 'package:flutter/cupertino.dart';

class ProfileMenuItemModel {
  final IconData leadingIcon;
  final String title;
  final IconData trailingIcon;
  final VoidCallback onTap;

  const ProfileMenuItemModel({
    required this.leadingIcon,
    required this.title,
    required this.trailingIcon,
    required this.onTap,
  });
}