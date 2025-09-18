import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({
    super.key,
    required this.textColor,
    required this.bgColor,
    required this.borderColor,
    required this.description,
  });
  final Color textColor;
  final Color bgColor;
  final Color borderColor;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        border: Border(right: BorderSide(color: borderColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: borderColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.warning,
                  style: AppTextStyles.semiBold18.copyWith(color: textColor),
                ),
                Text(
                  description,
                  style: AppTextStyles.regular14.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
