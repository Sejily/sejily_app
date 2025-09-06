import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_button.dart';

class DataReviewPage extends StatelessWidget {
  const DataReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _dataReviewHeader(),

              const SizedBox(height: 40),

              CustomButton(
                onPressed: () {
                  //TODO: Navigate to home page
                },
                text: AppStrings.browseMainPage,
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  //TODO: Add privacy policies later
                },
                child: Text(
                  AppStrings.browseUsageAndPrivacyPolicies,
                  style: AppTextStyles.medium14.copyWith(
                    color: AppColors.darkBlue,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Column _dataReviewHeader() {
    return Column(
      children: [
        Icon(Icons.access_time_rounded, size: 70, color: AppColors.darkBlue),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            AppStrings.dataUnderReview,
            style: AppTextStyles.bold24.copyWith(color: AppColors.jetBlack),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          AppStrings.reviewDataDescription,
          style: AppTextStyles.regular14.copyWith(color: AppColors.gray),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
