import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';

class SuccessResetPasswordPage extends StatelessWidget {
  const SuccessResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.celebration, size: 80, color: Color(0xFF1E3A8A)),
              const SizedBox(height: 20),

              Text(
                AppStrings.congratulations,
                style: AppTextStyles.bold24.copyWith(
                  color: const Color(0xFF1E3A8A),
                ),
              ),
              const SizedBox(height: 12),

              Text(
                AppStrings.passwordResetSuccessDescription,
                style: AppTextStyles.regular14.copyWith(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              CustomButton(
                onPressed: () => context.go(Routes.login),
                text: AppStrings.loginNow,
              ),
              const SizedBox(height: 20),
              Text(
                AppStrings.browseUsageAndPrivacyPolicies,
                style: AppTextStyles.regular14.copyWith(
                  fontSize: 13,
                  color: Colors.black87,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
