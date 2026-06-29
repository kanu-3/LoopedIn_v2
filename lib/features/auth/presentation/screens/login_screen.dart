import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/utils/validators.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/fields/app_text_field.dart';
import 'package:loopedin_v2/features/auth/providers/auth_provider.dart';
import 'package:loopedin_v2/features/auth/providers/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    try {
      final success = await ref
          .read(authProvider.notifier)
          .login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        AppSnackBar.show(
          context,
          message: "Login successful",
          isError: false,
        );

        context.go(RoutePaths.home);
      } else {
        AppSnackBar.show(
          context,
          message: "Login failed",
          isError: true,
        );
      }
    } catch (e) {
      if (!mounted) return;

      AppSnackBar.show(
        context,
        message: e.toString(),
        isError: true,
      );
    }
  }

  @override
  void dispose() {

    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(
      authProvider,
          (previous, next) {
        if (next.error != null &&
            next.error != previous?.error) {

          AppSnackBar.show(
            context,
            message: next.error!,
            isError: true,
          );
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.main
          ),
          child: Column(
            children: [
              SizedBox(
                height: context.screenHeight * .45,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(context.spacingXL),
                    bottomRight: Radius.circular(context.spacingXL),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whitetext
                        ),
                      ),
                      Image.asset(
                        AssetPaths.bg05,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  color: AppColors.main,
                  child: SingleChildScrollView(
                    padding: context.padAllM,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          context.gapS,

                          Text(
                            'Welcome Back!',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.whitetext,
                            ),
                          ),

                          context.gapXXS,

                          Text(
                            'Log In to continue', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whitetext,
                            ),
                          ),

                          context.gapL,

                          AppTextField(
                            focusLabelColor: AppColors.whitetext,
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textColor: AppColors.blacktext,
                            labelColor: AppColors.blacktext,
                            borderColor: AppColors.disabled,
                            fillColor: AppColors.disabled,
                            prefixIcon: const Icon(
                              AssetPaths.mail,
                              color: AppColors.blacktext,
                            ),
                            validator: AppValidators.email,
                          ),

                          context.gapM,

                          AppTextField(
                            focusLabelColor: AppColors.whitetext,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            controller: _passwordController,
                            textColor: AppColors.blacktext,
                            labelColor: AppColors.blacktext,
                            borderColor: AppColors.disabled,
                            fillColor: AppColors.whitetext.withOpacity(0.8),
                            isPassword: true,
                            prefixIcon: const Icon(
                              AssetPaths.lock,
                              color: AppColors.blacktext,
                            ),
                            validator: AppValidators.password,
                          ),

                          context.gapS,

                          Row(
                            children: [

                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                                activeColor: AppColors.main,
                                fillColor: MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return AppColors.whitetext;
                                  }
                                  return AppColors.whitetext;
                                }),
                                checkColor: AppColors.main,
                                side: const BorderSide(
                                  color: AppColors.whitetext,
                                ),
                              ),

                              Text(
                                'Remember Me',
                                style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(color:
                                AppColors.whitetext,
                                ),
                              ),

                              const Spacer(),

                              TextButton(
                                onPressed: () {

                                },
                                child: const Text(
                                  'Forgot Password?', style: TextStyle(color: AppColors.whitetext, fontWeight: FontWeight.w200),
                                ),
                              ),
                            ],
                          ),

                          context.gapM,

                          AppButton(
                            width: double.infinity,
                            text: 'Log In',
                            variant: ButtonVariant.white,
                            isLoading: authState.isLoading,
                            onPressed: authState.isLoading ? null : _login,
                          ),

                          context.gapL,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?", style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whitetext,
                                ),
                              ),

                              TextButton(
                                onPressed: () {
                                  context.go(RoutePaths.signup,);
                                },
                                child: const Text('SIGN UP',style: TextStyle(color: AppColors.whitetext),),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
