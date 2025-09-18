import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_button.dart';

class BuildLoadingState extends StatelessWidget {
  const BuildLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.darkBlue, strokeWidth: 3),
          const SizedBox(height: 16),
          Text(
            'جاري تحليل المستند الطبي...',
            style: AppTextStyles.medium16.copyWith(
              color: AppColors.grayShade600,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildErrorState extends StatelessWidget {
  const BuildErrorState({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: AppColors.redShade400,
          ),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ أثناء تحليل المستند',
            style: AppTextStyles.medium18.copyWith(
              color: AppColors.grayShade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'يرجى المحاولة مرة أخرى',
            style: AppTextStyles.medium14.copyWith(
              color: AppColors.grayShade500,
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'إعادة المحاولة',
            icon: const Icon(Icons.refresh_rounded, size: 20),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class BuildEmptyState extends StatelessWidget {
  const BuildEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description_outlined, size: 64, color: AppColors.darkBlue),
          const SizedBox(height: 16),
          Text(
            'لا توجد بيانات طبية للعرض',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.grayShade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'المستند لا يحتوي على معلومات طبية قابلة للاستخراج',
            style: TextStyle(fontSize: 14, color: AppColors.grayShade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
