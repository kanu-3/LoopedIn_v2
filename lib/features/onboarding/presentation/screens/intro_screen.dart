
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/features/onboarding/data/datasource/onboarding_data.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showNextButton: false,
      showDoneButton: false,

      pages: onboardingPages.map(
            (page) {
          final isLastPage =
              page == onboardingPages.last;

          return PageViewModel(
            title: '',

            bodyWidget: Column(
              children: [

                SizedBox(
                  width: context.logoWidth,
                  child: Image.asset(
                    AssetPaths.logo,
                  ),
                ),

                context.gapS,

                Image.asset(
                  page.image,
                  height: context.scaleH(380),
                ),

                context.gapS,

                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                if (page.subtitle != null) ...[
                  context.gapS,

                  Text(
                    page.subtitle!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),
                ],

                if (isLastPage) ...[
                  context.gapS,

                  AppButton(
                    width: double.infinity,
                    text: 'Join Now',
                    onPressed: () {
                      context.go(
                        RoutePaths.decision,
                      );
                    },
                  ),
                ],
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}