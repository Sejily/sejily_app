import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            controller.text.isEmpty ? '1990-01-01' : controller.text,
            style: controller.text.isEmpty
                ? AppTextStyles.regular16.copyWith(
                    color: AppColors.grayShade500,
                  )
                : AppTextStyles.medium16.copyWith(color: AppColors.jetBlack),
          ),
        ),
      ),
    );
  }
}

class DatePickerHelper {
  static Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
    Function(String) onDateSelected,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2004, 11, 20),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.darkBlue,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.jetBlack,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      controller.text = formattedDate;
      onDateSelected(formattedDate);
    }
  }
}
