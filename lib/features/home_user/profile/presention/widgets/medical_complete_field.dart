import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class MedicalTextField extends StatelessWidget {
  final String label;
  const MedicalTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.medium16.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintStyle: AppTextStyles.regular14.copyWith(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}
