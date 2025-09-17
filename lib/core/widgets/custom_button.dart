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
    this.icon,
    this.isLoading,
  });

  final VoidCallback? onPressed;
  final String text;
  final String? loadingText;
  final TextStyle? style;
  final bool? defaultSize;
  final Widget? icon;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ?? false ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: defaultSize ?? false ? null : Size(double.infinity, 0),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.015,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        foregroundColor: isLoading ?? false
            ? AppColors.grayShade500
            : AppColors.white,
        backgroundColor: isLoading ?? false
            ? AppColors.gray
            : AppColors.darkBlue,
      ),
      child: icon == null
          ? Text(
              isLoading ?? false ? loadingText ?? AppStrings.loading : text,
              style: style ?? AppTextStyles.semiBold18,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!,
                const SizedBox(width: 8),
                Text(
                  text,
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
    );
  }
}
