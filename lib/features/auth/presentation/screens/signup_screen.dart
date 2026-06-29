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

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmpasswordController= TextEditingController();

  Future<void> _signup() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final phone = _phoneController.text.trim();
    final username = _usernameController.text.trim();

    try {
      final success = await ref.read(authProvider.notifier).signup(
        username: username,
        phone: phone,
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text,
      );

      if (!mounted) return;

      if (success) {
        AppSnackBar.show(
          context,
          message: "Signup successful",
        );

        context.go(RoutePaths.login);
      } else {
        AppSnackBar.show(
          context,
          message: "Signup failed",
          isError: true,
        );
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.show(
        context,
        message: (e.toString()),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmpasswordController.dispose();
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
          color: AppColors.main,
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
                      Container(color: AppColors.whitetext),
                      Image.asset(
                        AssetPaths.bg05,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          context.gapS,

                          Text(
                            'Welcome!',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.whitetext,
                            ),
                          ),

                          context.gapXXS,

                          Text(
                            'Create your account', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whitetext,
                          ),
                          ),

                          context.gapL,

                          AppTextField(
                            focusLabelColor: AppColors.whitetext,
                            labelText: 'Name',
                            hintText: 'Enter your name',
                            controller: _nameController,
                            textColor: AppColors.blacktext,
                            labelColor: AppColors.blacktext,
                            borderColor: AppColors.disabled,
                            fillColor: AppColors.disabled,
                            prefixIcon: const Icon(
                                AssetPaths.person,
                                color: AppColors.blacktext),
                            validator: AppValidators.name,
                          ),

                          context.gapM,

                          AppTextField(
                            focusLabelColor: AppColors.whitetext,
                            labelText: 'Username',
                            hintText: 'Enter username',
                            controller: _usernameController,
                            textColor: AppColors.blacktext,
                            labelColor: AppColors.blacktext,
                            borderColor: AppColors.disabled,
                            fillColor: AppColors.disabled,
                            prefixIcon: const Icon(
                                AssetPaths.person,
                                color: AppColors.blacktext),
                            validator: AppValidators.username,
                          ),

                          context.gapM,

                          AppTextField(
                            focusLabelColor: AppColors.whitetext,
                            labelText: 'Phone',
                            hintText: 'Enter phone number',
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            textColor: AppColors.blacktext,
                            labelColor: AppColors.blacktext,
                            borderColor: AppColors.disabled,
                            fillColor: AppColors.disabled,
                            prefixIcon: const Icon(
                                AssetPaths.mobile,
                                color: AppColors.blacktext),
                            validator: AppValidators.phone,
                          ),

                          context.gapM,

                          AppTextField(
                            focusLabelColor: AppColors.whitetext,
                            labelText: 'Email',
                            hintText: 'Enter email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textColor: AppColors.blacktext,
                            labelColor: AppColors.blacktext,
                            borderColor: AppColors.disabled,
                            fillColor: AppColors.disabled,
                            prefixIcon: const Icon(
                                AssetPaths.mail,
                                color: AppColors.blacktext),
                            validator: AppValidators.email,
                          ),

                          context.gapM,

                          AppTextField(
                            focusLabelColor: AppColors.whitetext,
                            labelText: 'Password',
                            hintText: 'Enter password',
                            controller: _passwordController,
                            isPassword: true,
                            textColor: AppColors.blacktext,
                            labelColor: AppColors.blacktext,
                            borderColor: AppColors.disabled,
                            fillColor:
                            AppColors.whitetext.withOpacity(0.8),
                            prefixIcon: const Icon(
                                AssetPaths.lock,
                                color: AppColors.blacktext),
                            validator: AppValidators.password,
                          ),

                          context.gapM,

                          AppTextField(
                            focusLabelColor: AppColors.whitetext,
                            labelText: 'Confirm Password',
                            hintText: 'Re-enter password',
                            controller: _confirmpasswordController,
                            isPassword: true,
                            textColor: AppColors.blacktext,
                            labelColor: AppColors.blacktext,
                            borderColor: AppColors.disabled,
                            fillColor:
                            AppColors.whitetext.withOpacity(0.8),
                            prefixIcon: const Icon(
                                AssetPaths.lock,
                                color: AppColors.blacktext),
                            validator: (value) => AppValidators.confirmPassword(
                              value,
                              _passwordController.text,
                            ),
                          ),

                          context.gapL,

                          AppButton(
                            width: double.infinity,
                            text: 'Sign Up',
                            variant: ButtonVariant.white,
                            isLoading: authState.isLoading,
                            onPressed: authState.isLoading ? null : _signup,
                          ),

                          context.gapL,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?", style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whitetext,
                              ),),
                              TextButton(
                                onPressed: () {
                                  context.go(RoutePaths.login,);
                                },
                                child: const Text('LOG IN',style: TextStyle(color: AppColors.whitetext),),
                              ),
                            ],
                          ),
                          context.gapXS,
                          Center(child: Text("By creating an account, you agree to the LoopedIN ", style: TextStyle(
                            color: AppColors.blacktext.withOpacity(0.8)
                          ),)),
                          Center(child: Text("Conditions of Use and Privacy Policy.", style: TextStyle(
                            color: AppColors.blacktext.withOpacity(0.8)
                          ),)),

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
