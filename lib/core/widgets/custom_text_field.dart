import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.isObscured,
    this.keyboardType,
    this.validator,
    this.hintText,
    this.onChanged,
    this.canChange,
  });

  final TextEditingController? controller;
  final bool? isObscured;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final void Function(String)? onChanged;
  final bool? canChange;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.canChange,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      style: AppTextStyles.regular14,
      obscureText: widget.isObscured == true ? _obscureText : false,
      decoration: InputDecoration(
        hint: widget.hintText != null
            ? Text(
                widget.hintText!,
                style: AppTextStyles.regular14.copyWith(color: AppColors.gray),
              )
            : null,
        isDense: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.lightGray),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.lightGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.darkBlue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.lightRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.lightRed),
        ),
        suffixIcon: widget.isObscured ?? false
            ? IconButton(
                onPressed: () => setState(() => _obscureText = !_obscureText),
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.lightGray,
                ),
              )
            : null,
      ),
      cursorColor: AppColors.darkBlue,
    );
  }
}
