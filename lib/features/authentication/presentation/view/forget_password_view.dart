import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';
import '../manager/providers/forgot_password_notifier.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  void _sendOtp() {
    final email = _emailController.text.trim();
    ref.read(forgotPasswordNotifierProvider.notifier).sendOtp(email);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordNotifierProvider);

    ref.listen<ForgotPasswordState>(forgotPasswordNotifierProvider, (
      prev,
      next,
    ) {
      if (next.result != null) {
        next.result!.when(
          onSuccess: (data) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم إرسال رمز التحقق بنجاح")),
            );

            context.push(
              Routes.otpVerification,
              extra: {
                'email': _emailController.text.trim(),
                'route': Routes.resetPassword,
              },
            );
          },
          onFailure: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message ?? AppStrings.unexpectedError),
                backgroundColor: AppColors.red,
              ),
            );
          },
        );
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 30),
                    BuildFieldWithLabel(
                      label: AppStrings.email,
                      required: true,
                      child: CustomTextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 60),
                    CustomButton(
                      isLoading: state.isLoading,
                      text: AppStrings.sendVerificationCode,
                      onPressed: _sendOtp,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.forgotPassword,
                    style: AppTextStyles.medium14,
                  ),
                  GestureDetector(
                    onTap: () => context.go(Routes.login),
                    child: Text(
                      AppStrings.loginNow,
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.lightGray.withValues(alpha: 0.1),
          ),
          padding: const EdgeInsets.all(15),
          child: Image.asset(Assets.validationCode, height: 30, width: 30),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.passwordResetTitle,
          style: AppTextStyles.bold24.copyWith(color: AppColors.black87),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.passwordResetDescription,
          style: AppTextStyles.regular14.copyWith(
            color: AppColors.grayShade500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
