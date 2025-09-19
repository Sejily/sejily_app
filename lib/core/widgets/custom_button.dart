import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.loadingText,
    this.style,
    this.defaultSize,
    this.isLoading,
    this.forgroundColor,
  });

  final VoidCallback? onPressed;
  final String text;
  final String? loadingText;
  final TextStyle? style;
  final bool? defaultSize;
  final bool? isLoading;
  final Color? forgroundColor;

  @override
  Widget build(BuildContext context) {
    final isLoading = this.isLoading ?? false;
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: defaultSize ?? false ? null : Size(double.infinity, 0),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.015,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        foregroundColor:
            forgroundColor ??
            (isLoading ? AppColors.grayShade500 : AppColors.white),
        backgroundColor: isLoading ? AppColors.gray : AppColors.darkBlue,
      ),
      child: Text(
        isLoading ? loadingText ?? AppStrings.loading : text,
        style: style ?? AppTextStyles.semiBold18,
      ),
    );
  }
}
