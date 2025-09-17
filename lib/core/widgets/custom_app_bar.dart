import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: GestureDetector(
        onTap: () => context.pop(),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios, color: AppColors.grayShade500, size: 12),
            const SizedBox(width: 12),
            Text(
              AppStrings.back,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.grayShade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
