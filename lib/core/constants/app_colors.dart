import 'dart:ui';

import 'package:loopedin_v2/core/constants/core_colors.dart';

class AppColors {
  AppColors._();
  static final appbar = CoreColors.main.withOpacity(0.43);

  static const Color blacktext= CoreColors.black;
  static const Color whitetext= CoreColors.white;

  static const Color bg= CoreColors.bg;
  static const Color main= CoreColors.main;
  static const Color sucess= CoreColors.four;

  static const disabled = CoreColors.grey400;
  static const onError= CoreColors.red;
  static const dislike= CoreColors.orange;
}