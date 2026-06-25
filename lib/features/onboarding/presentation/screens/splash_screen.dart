import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/features/auth/providers/auth_provider.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 3));

    final isLoggedIn = await ref
        .read(authProvider.notifier)
        .checkAuthStatus();

    if (!mounted) return;

    context.go(
      isLoggedIn ? RoutePaths.home : RoutePaths.onboarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.logoWidth*1.5,
                child: Image.asset(
                  AssetPaths.logo,
                ),
              ),

              SizedBox(height: context.spacingXL*3),

              Image.asset(
                'assets/images/loader.gif',
                height: context.scaleH(80),
              )
            ],
          ),
        )

      ),
    );
  }
}