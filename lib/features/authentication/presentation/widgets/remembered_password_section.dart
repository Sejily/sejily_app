import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/features/authentication/presentation/widgets/authentication_button.dart';

class RememberedPasswordSection extends StatelessWidget {
  const RememberedPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.forgotPassword,
          style: AppTextStyles.regular14.copyWith(color: AppColors.black54),
        ),
        AuthenticationButton(
          onTap: () => context.go(Routes.login),
          label: AppStrings.login,
        ),
      ],
    );
  }
}
