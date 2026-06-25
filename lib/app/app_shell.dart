import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/navigation/app_bottom_nav.dart';

class AppShell extends StatefulWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final NotchBottomBarController _controller = NotchBottomBarController();

  int getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/categories')) return 1;
    if (location.startsWith('/store')) return 2;
    if (location.startsWith('/chat')) return 3;
    if (location.startsWith('/profile')) return 4;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = getIndex(context);
    _controller.index = index;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          Expanded(
            child: widget.child,
          ),

          SizedBox(
            height: context.scaleH(132),
            width: double.infinity,
            child: AppBottomNavbar(
              controller: _controller,
              currentIndex: index,
              onTap: (i) {
                switch (i) {
                  case 0:
                    context.go('/home');
                    break;
                  case 1:
                    context.go('/categories');
                    break;
                  case 2:
                    context.go('/store');
                    break;
                  case 3:
                    context.go('/chat');
                    break;
                  case 4:
                    context.go('/profile');
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
