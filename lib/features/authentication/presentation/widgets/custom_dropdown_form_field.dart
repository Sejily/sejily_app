import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? value;
  final List<String> options;
  final String hintText;
  final ValueChanged<String?> onChanged;

  const CustomDropdownFormField({
    super.key,
    required this.value,
    required this.options,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: AppColors.white,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.regular14.copyWith(color: AppColors.gray),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.jetBlack,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: AppValidators.requiredFieldValidator,
      ),
    );
  }
}
