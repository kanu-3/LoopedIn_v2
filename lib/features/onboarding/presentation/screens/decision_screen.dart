import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_outline_button.dart';

class DecisionScreen extends StatelessWidget {
  const DecisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
              child: Padding(
                padding: context.padAllM,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: context.logoWidth,
                      child: Image.asset(
                        AssetPaths.logo,
                      ),
                    ),
        
                    context.gapL,
        
                    Image.asset(
                      AssetPaths.bg04,
                      height: context.scaleH(380),
                    ),
        
                    context.gapL,
        
                    AppButton(
                      width: double.infinity,
                      text: 'Sign Up',
                      onPressed: () {
                        context.go(
                          RoutePaths.signup,
                        );
                      },
                    ),
        
                    context.gapS,
        
                    AppOutlinedButton(
                      width: double.infinity,
                      text: 'Log In',
                      onPressed: () {
                        context.go(
                          RoutePaths.login,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}