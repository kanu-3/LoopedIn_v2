import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/theme/color_scheme.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.bg,
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      textTheme: AppTextTheme.textTheme.apply(
        bodyColor: AppColorScheme.lightColorScheme.onBackground,
        displayColor: AppColorScheme.lightColorScheme.onBackground,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.blacktext,
        size: 24,
      ),
      colorScheme: AppColorScheme.lightColorScheme,
      // elevatedButtonTheme: AppElevatedButtonTheme.light(context),
      // outlinedButtonTheme: AppOutlineButtonTheme.light(context),
      // inputDecorationTheme: AppFormFieldTheme.light(context),
    );
  }

  // static ThemeData darkTheme(BuildContext context) {
  //   return ThemeData(
  //     scaffoldBackgroundColor: AppColors.dark_bg,
  //     brightness: Brightness.dark,
  //     fontFamily: 'Poppins',
  //     textTheme: AppTextTheme.textTheme.apply(
  //       bodyColor: AppColorScheme.darkColorScheme.onBackground,
  //       displayColor: AppColorScheme.darkColorScheme.onBackground,
  //     ),
  //     iconTheme: const IconThemeData(
  //       color: AppColors.whitetext,
  //       size: 24,
  //     ),
  //     colorScheme: AppColorScheme.darkColorScheme,
  //     elevatedButtonTheme: AppElevatedButtonTheme.dark(context),
  //     outlinedButtonTheme: AppOutlineButtonTheme.dark(context),
  //     inputDecorationTheme: AppFormFieldTheme.dark(context),
  //   );
  // }
}
