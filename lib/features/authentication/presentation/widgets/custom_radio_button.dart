import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class GenderRadioButtons extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String> onChanged;

  const GenderRadioButtons({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildRadioOption('male', 'ذكر')),
        Expanded(child: _buildRadioOption('female', 'أنثى')),
      ],
    );
  }

  Widget _buildRadioOption(String value, String label) {
    final isSelected = selectedGender == value;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.darkBlue : Colors.grey,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.medium16.copyWith(
              color: isSelected ? AppColors.darkBlue : AppColors.jetBlack,
            ),
          ),
        ],
      ),
    );
  }
}
