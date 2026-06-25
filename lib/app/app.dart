import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/app/router.dart';
import 'package:loopedin_v2/core/theme/app_theme.dart';

class LoopedInApp extends ConsumerWidget {
  const LoopedInApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'LoopedIn',

      theme: AppTheme.lightTheme(context),

      routerConfig: router,
    );
  }
}