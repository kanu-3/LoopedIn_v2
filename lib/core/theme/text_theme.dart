import 'dart:ui';
import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextStyle _style({
    required double size,
    required FontWeight weight
  }){
    return TextStyle(fontSize: size, fontWeight: weight, fontFamily: 'Poppins');
  }

  static TextTheme textTheme= TextTheme(
    headlineLarge: _style(size: 32, weight: FontWeight.w700),
    headlineMedium: _style(size: 24, weight: FontWeight.w500),
    headlineSmall: _style(size: 16, weight: FontWeight.w500),

    titleLarge: _style(size: 20, weight: FontWeight.w500),
    // titleMedium: _style(size: 16, weight: FontWeight.w500),
    titleSmall: _style(size: 14, weight: FontWeight.w500),

    bodyLarge: _style(size: 16, weight: FontWeight.w300),
    bodyMedium: _style(size: 14, weight: FontWeight.w300),
    bodySmall: _style(size: 12, weight: FontWeight.w300),

    labelMedium: _style(size: 20, weight: FontWeight.w200),

  );
}