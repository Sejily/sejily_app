import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class OtpInputField extends StatelessWidget {
  const OtpInputField({super.key, required this.controller, this.length = 6});

  final TextEditingController controller;
  final int length;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: AppTextStyles.medium18,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGray, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.darkBlue, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.darkBlue, width: 2),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightRed, width: 2),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr, // Force left-to-right direction
      child: Pinput(
        controller: controller,
        length: length,
        defaultPinTheme: defaultPinTheme,
        submittedPinTheme: submittedPinTheme,
        focusedPinTheme: focusedPinTheme,
        errorPinTheme: errorPinTheme,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        cursor: Container(width: 2, height: 20, color: AppColors.darkBlue),
        autofocus: true,
        showCursor: true,
        hapticFeedbackType: HapticFeedbackType.lightImpact,
      ),
    );
  }
}
