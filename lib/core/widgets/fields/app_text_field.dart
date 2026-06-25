import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    this.onChanged,
    this.textColor = AppColors.blacktext,
    this.labelColor = AppColors.blacktext,
    this.focusLabelColor = AppColors.whitetext,
    this.borderColor = AppColors.main,
    this.fillColor = AppColors.whitetext,
    this.focusFillColor,
    this.suffixIconColor,
    this.inputFormatters,
  });

  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool readOnly;
  final int maxLines;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Color textColor;
  final Color labelColor;
  final Color focusLabelColor;
  final Color borderColor;
  final Color fillColor;
  final Color? focusFillColor;
  final Color? suffixIconColor;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscureText = true;
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    final effectiveFocusFill =
        widget.focusFillColor ?? Colors.white.withOpacity(0.09);

    return Focus(
      onFocusChange: (value) {
        setState(() {
          isFocused = value;
        });
      },
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        onChanged: widget.onChanged,

        style: TextStyle(
          color: widget.textColor,
        ),

        maxLines: widget.isPassword ? 1 : widget.maxLines,
        obscureText: widget.isPassword ? obscureText : false,

        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,

          labelStyle: TextStyle(
            color: isFocused ? widget.focusLabelColor : widget.labelColor,
            fontSize: context.scaledFont(16),
          ),

          floatingLabelStyle: TextStyle(
            color: widget.focusLabelColor,
            fontWeight: FontWeight.w500,
          ),

          hintStyle: TextStyle(
            color: widget.labelColor.withOpacity(.6),
            fontSize: context.scaledFont(14),
          ),

          prefixIcon: widget.prefixIcon,

          suffixIcon: widget.isPassword
              ? IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText
                  ? AssetPaths.eye_close
                  : AssetPaths.eye_visible,
              color: widget.suffixIconColor ?? widget.labelColor,
            ),
          )
              : widget.suffixIcon,

          filled: true,
          fillColor:
          isFocused ? effectiveFocusFill : widget.fillColor.withOpacity(0.05),

          contentPadding: EdgeInsets.symmetric(
            horizontal: context.spacingS,
            vertical: context.spacingS,
          ),

          border: OutlineInputBorder(
            borderRadius: context.borderRadiusS,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: context.borderRadiusS,
            borderSide: BorderSide(
              color: widget.borderColor.withOpacity(0.5),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: context.borderRadiusS,
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 2,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: context.borderRadiusS,
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: context.borderRadiusS,
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}