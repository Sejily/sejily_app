import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';
import '../manager/providers/progress_provider.dart';

class SuccessResetPasswordPage extends ConsumerWidget {
  const SuccessResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.celebrationIcon, height: 80),
              const SizedBox(height: 20),

              Text(
                AppStrings.congratulations,
                style: AppTextStyles.bold24.copyWith(
                  color: AppColors.blackBlue,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                AppStrings.passwordResetSuccessDescription,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              CustomButton(
                text: AppStrings.loginNow,
                onPressed: () {
                  ref.read(progressProvider.notifier).reset();
                  context.go(Routes.login);
                },
              ),
              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  //TODO: Add privacy policies later
                },
                child: Text(
                  AppStrings.browseUsageAndPrivacyPolicies,
                  style: AppTextStyles.medium14.copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
