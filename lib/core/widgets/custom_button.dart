import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    required this.text,
    this.style,
    this.defaultSize,
    this.child,
  });

  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String text;
  final TextStyle? style;
  final bool? defaultSize;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: defaultSize ?? false ? null : Size(double.infinity, 0),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.015,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        foregroundColor: foregroundColor ?? AppColors.white,
        backgroundColor: backgroundColor ?? AppColors.darkBlue,
      ),
      child: child ?? Text(text, style: style ?? AppTextStyles.semiBold18),
    );
  }
}
