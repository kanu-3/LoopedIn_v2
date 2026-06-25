import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';

class AppColorScheme {
  AppColorScheme._();

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.main,
    onPrimary: AppColors.whitetext,

    secondary: AppColors.blacktext,
    onSecondary: AppColors.whitetext,

    background: AppColors.bg,
    onBackground: Colors.black,

    surface: AppColors.bg,
    onSurface: Colors.black,

    error: Colors.red,
    onError: Colors.white,
  );

//   static const ColorScheme darkColorScheme = ColorScheme(
//     brightness: Brightness.dark,
//     primary: AppColors.whitetext,
//     onPrimary: AppColors.blacktext,
//
//     secondary: AppColors.whitetext,
//     onSecondary: AppColors.blacktext,
//
//     background: AppColors.dark_bg,
//     onBackground: AppColors.whitetext,
//
//     surface: AppColors.dark_bg,
//     onSurface: AppColors.whitetext,
//
//     error: Colors.red,
//     onError: Colors.black,
//   );

}