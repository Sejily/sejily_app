import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/features/authentication/presentation/widgets/authentication_button.dart';

import '../../../../core/routes/routes.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: AppColors.lightGray, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppStrings.orLoginWith,
                style: AppTextStyles.regular14.copyWith(color: AppColors.gray),
              ),
            ),
            Expanded(child: Divider(color: AppColors.lightGray, thickness: 1)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: AuthenticationButton(
                onTap: () => context.go(Routes.home),
                label: AppStrings.google,
                icon: Image.asset(Assets.google),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AuthenticationButton(
                onTap: () {
                  //TODO: Handle iCloud login
                },
                label: AppStrings.icloud,
                icon: Image.asset(Assets.apple),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
